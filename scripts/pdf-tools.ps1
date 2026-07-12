<#
.SYNOPSIS
  Utilidades robustas para la generación/distribución de PDF y capturas.
  Se carga con dot-sourcing:  . "$PSScriptRoot/pdf-tools.ps1"

.PORQUE
  El 9-jul se perdieron ciclos por tres fallos evitables del pipeline:
    · Copy-Item "Acceso denegado" cuando el PDF destino estaba abierto en un visor
      (era un file-lock, no permisos) → aquí: Copy-Safe con reintento + -Force.
    · Capturas headless de Edge que "fallaban" pero SÍ se generaban: el ruido de
      Crashpad ('settings.dat', 'path not found') se interpretó como fallo dos veces
      → aquí: la señal de éxito es SIEMPRE el artefacto (existe + pesa), no el stdout.
    · PDFs verificados solo por Test-Path: un render a medias deja un fichero de 0 KB
      que pasaba como bueno → aquí: Test-Rendered exige un tamaño mínimo.

  Regla transversal: el éxito se comprueba por el ARCHIVO (existe y pesa lo esperado),
  nunca por los mensajes que escupe el navegador headless.
#>

Set-StrictMode -Version Latest

# --- Localiza un navegador Chromium (Edge preferido; viene con Windows) -----------
function Get-ChromiumPath {
  $candidates = @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
  )
  $b = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
  if (-not $b) { throw "No se encontró Edge ni Chrome instalados." }
  return $b
}

# --- Verifica un artefacto por EXISTENCIA + TAMAÑO --------------------------------
# Devuelve $true solo si el fichero existe y pesa al menos $MinBytes (por defecto 1 KB,
# suficiente para descartar un render vacío/corrupto). Devuelve $false sin lanzar,
# para poder usarlo en condicionales.
function Test-Rendered {
  param(
    [Parameter(Mandatory)] [string] $Path,
    [int] $MinBytes = 1024
  )
  if (-not (Test-Path -LiteralPath $Path)) { return $false }
  $len = (Get-Item -LiteralPath $Path).Length
  return ($len -ge $MinBytes)
}

# --- Copia robusta ante ficheros bloqueados por un visor/editor abierto -----------
# Reintenta con backoff; usa -Force para sobrescribir un destino de solo-lectura.
# Si tras los reintentos sigue bloqueado, lanza un error CLARO indicando que hay que
# cerrar el visor (la causa real que vimos, no un permiso NTFS).
function Copy-Safe {
  param(
    [Parameter(Mandatory)] [string] $Source,
    [Parameter(Mandatory)] [string] $Destination,
    [int] $Retries = 4,
    [int] $DelayMs = 400
  )
  if (-not (Test-Path -LiteralPath $Source)) { throw "Copy-Safe: no existe el origen '$Source'." }
  $destDir = Split-Path -Parent $Destination
  if ($destDir -and -not (Test-Path -LiteralPath $destDir)) {
    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
  }
  for ($i = 1; $i -le $Retries; $i++) {
    try {
      Copy-Item -LiteralPath $Source -Destination $Destination -Force -ErrorAction Stop
      return $true
    } catch [System.IO.IOException], [System.UnauthorizedAccessException] {
      if ($i -eq $Retries) {
        throw "Copy-Safe: '$Destination' está bloqueado tras $Retries intentos. " +
              "Cierra el PDF/visor que lo tenga abierto y reintenta. (Detalle: $($_.Exception.Message))"
      }
      Start-Sleep -Milliseconds ($DelayMs * $i)
    }
  }
}

# --- Captura de una página (o HTML local) a PNG, verificada por artefacto ----------
# Silencia el ruido de Crashpad de Edge (--disable-crash-reporter, perfil temporal) y
# NO se fía del exit code ni del stdout: el veredicto es Test-Rendered sobre el PNG.
function Save-Screenshot {
  param(
    [Parameter(Mandatory)] [string] $Url,      # URL http(s) o ruta a un .html local
    [Parameter(Mandatory)] [string] $Out,      # ruta del .png de salida
    [int] $Width = 1200,
    [int] $MinBytes = 3072                       # un PNG real pesa > 3 KB
  )
  $browser = Get-ChromiumPath
  $outPath = [System.IO.Path]::GetFullPath($Out)
  if (Test-Path -LiteralPath $outPath) { Remove-Item -LiteralPath $outPath -Force -ErrorAction SilentlyContinue }

  # Acepta ruta local o URL
  $target = $Url
  if (Test-Path -LiteralPath $Url) { $target = ([System.Uri]((Resolve-Path $Url).Path)).AbsoluteUri }

  $profileDir = Join-Path $env:TEMP ("shot-" + [guid]::NewGuid().ToString("N"))
  $args = @(
    "--headless=new",
    "--disable-gpu",
    "--hide-scrollbars",
    "--disable-crash-reporter",          # calla el ruido de Crashpad que confundía
    "--no-first-run",
    "--no-default-browser-check",
    "--user-data-dir=$profileDir",
    "--window-size=$Width,1000",
    "--allow-file-access-from-files",
    "--virtual-time-budget=6000",
    "--screenshot=$outPath",
    $target
  )
  try {
    Start-Process -FilePath $browser -ArgumentList $args -Wait -NoNewWindow -ErrorAction Stop
  } finally {
    if (Test-Path -LiteralPath $profileDir) { Remove-Item $profileDir -Recurse -Force -ErrorAction SilentlyContinue }
  }

  if (Test-Rendered -Path $outPath -MinBytes $MinBytes) {
    $kb = [int]((Get-Item -LiteralPath $outPath).Length / 1KB)
    Write-Host "OK - captura generada: $outPath (${kb} KB)" -ForegroundColor Green
    return $outPath
  }
  throw "Save-Screenshot: no se generó un PNG válido en '$outPath' (revisa la URL/HTML)."
}
