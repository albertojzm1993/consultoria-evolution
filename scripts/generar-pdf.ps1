<#
.SYNOPSIS
  Convierte un informe HTML de marca en PDF usando Edge o Chrome en modo headless.
  No requiere instalar nada: Microsoft Edge viene con Windows 10/11.

.EXEMPLO
  ./scripts/generar-pdf.ps1 -Html "clientes/acme/00-descubrimiento/perfil-maestro.html" `
                            -Out  "clientes/acme/00-descubrimiento/perfil-maestro.pdf"

.NOTAS
  El diseño (portada, índice, cabecera/pie) lo aporta plantillas/informe/informe.css.
  El HTML debe generarse desde plantillas/informe/plantilla-informe.html.
#>
param(
  [Parameter(Mandatory = $true)] [string] $Html,
  [Parameter(Mandatory = $false)] [string] $Out,
  [Parameter(Mandatory = $false)] [string] $Brand,   # ruta a brand-tokens.json (inyecta marca)
  [Parameter(Mandatory = $false)] [string] $Cliente  # nombre para el logo de texto de respaldo
)

$ErrorActionPreference = "Stop"

# Utilidades robustas (verificación por tamaño, copia segura, capturas fiables).
. (Join-Path $PSScriptRoot "pdf-tools.ps1")

$htmlPath = (Resolve-Path $Html).Path
if (-not $Out) { $Out = [System.IO.Path]::ChangeExtension($htmlPath, ".pdf") }
$outPath = [System.IO.Path]::GetFullPath($Out)

# --- Inyección automática de la marca desde brand-tokens.json (garantiza que el
#     PDF use SIEMPRE los colores, tipografías y logo del cliente) ---
if ($Brand -and (Test-Path $Brand)) {
  $b = Get-Content $Brand -Raw -Encoding UTF8 | ConvertFrom-Json
  function Val($o,$d){ if ($null -ne $o -and "$o" -ne "") { "$o" } else { $d } }
  $primary = Val $b.color.primary.hex "#0E7C86"
  $onPrim  = Val $b.color.primary.on  "#FFFFFF"
  $second  = Val $b.color.secondary.hex "#0A2A3B"
  $onSec   = Val $b.color.secondary.on  "#FFFFFF"
  $accent  = Val $b.color.accent.hex "#F4A259"
  $ink     = Val $b.color.neutral.ink  "#0F1A1D"
  $bodyc   = Val $b.color.neutral.body "#33424A"
  $muted   = Val $b.color.neutral.muted "#6B7A80"
  $line    = Val $b.color.neutral.line "#E2E8EA"
  $soft    = Val $b.color.neutral.bg   "#F5F9F9"
  $fh      = Val $b.typography.heading.family "Poppins"
  $fb      = Val $b.typography.body.family "Inter"

  # Foto de portada del cliente si existe (marca/assets/portada.*) → --cover-img
  $marcaDirEarly = Split-Path $Brand -Parent
  $coverVar = ""
  foreach ($ext in @("jpg","jpeg","png","webp")) {
    $cand = Join-Path $marcaDirEarly "assets/portada.$ext"
    if (Test-Path $cand) {
      $coverUri = ([System.Uri]((Resolve-Path $cand).Path)).AbsoluteUri
      $coverVar = "--cover-img:url('$coverUri');"
      break
    }
  }

  $tokensCss = ":root{" +
    "--color-primary:$primary;--color-on-primary:$onPrim;" +
    "--color-secondary:$second;--color-on-secondary:$onSec;" +
    "--color-accent:$accent;--ink:$ink;--body:$bodyc;--muted:$muted;" +
    "--line:$line;--soft:$soft;$coverVar" +
    "--font-heading:'$fh','Segoe UI',sans-serif;--font-body:'$fb','Segoe UI',sans-serif;}"

  # Usa los pesos declarados en el brand-tokens (evita pedir pesos que la fuente no
  # tiene, p. ej. Calistoga solo existe en 400, y romper la URL de Google Fonts).
  $fhW = ($b.typography.heading.weights -join ';'); if (-not $fhW) { $fhW = '600;700' }
  $fbW = ($b.typography.body.weights -join ';');    if (-not $fbW) { $fbW = '400;500;600' }
  $fontsUrl = "https://fonts.googleapis.com/css2?family=" +
    ($fh -replace ' ','+') + ":wght@$fhW&family=" +
    ($fb -replace ' ','+') + ":wght@$fbW&display=swap"

  # Logo: usa el del cliente si existe junto al brand-tokens (marca/assets/…).
  # La PORTADA es oscura (overlay de marca) → prioriza el logo INVERSO/blanco
  # (logo.inverso). La cabecera (fondo claro) usa el logo principal.
  $marcaDir = Split-Path $Brand -Parent
  $fallbackName = if ($Cliente) { $Cliente } else { $b.meta.cliente }

  function LogoImg($rel) {
    if ($rel -and (Test-Path (Join-Path $marcaDir $rel))) {
      $uri = ([System.Uri]((Resolve-Path (Join-Path $marcaDir $rel)).Path)).AbsoluteUri
      return "<img class='cover__logo' src='$uri' alt='$($b.meta.cliente)'>"
    }
    return $null
  }

  $textLogo   = "<span class='cover__logo cover__logo--text'>$fallbackName</span>"
  $logoPrinc  = Val $b.logo.principal ""
  $logoInv    = Val $b.logo.inverso ""
  # Portada (oscura): inverso > principal > texto
  $coverLogo  = (LogoImg $logoInv); if (-not $coverLogo) { $coverLogo = (LogoImg $logoPrinc) }; if (-not $coverLogo) { $coverLogo = $textLogo }
  # Cabecera (clara): principal > inverso > texto
  $headerLogo = (LogoImg $logoPrinc); if (-not $headerLogo) { $headerLogo = (LogoImg $logoInv) }; if (-not $headerLogo) { $headerLogo = $textLogo }

  $doc = Get-Content $htmlPath -Raw -Encoding UTF8
  $doc = $doc.Replace("{{tokens_css}}", $tokensCss).
              Replace("{{google_fonts_url}}", $fontsUrl).
              Replace("{{logo_html}}", $coverLogo).
              Replace("{{logo_header_html}}", $headerLogo)
  $tmpHtml = [System.IO.Path]::ChangeExtension($htmlPath, ".brand.html")
  Set-Content -Path $tmpHtml -Value $doc -Encoding UTF8
  $htmlPath = $tmpHtml
  Write-Host "Marca aplicada desde: $Brand"
}

# --- Opción preferida: WeasyPrint (números de página reales + mejor tipografía) ---
$weasy = Get-Command weasyprint -ErrorAction SilentlyContinue
if ($weasy) {
  Write-Host "Motor     : WeasyPrint"
  Write-Host "HTML      : $htmlPath"
  Write-Host "PDF       : $outPath"
  & weasyprint $htmlPath $outPath
  if (Test-Rendered -Path $outPath -MinBytes 2048) {
    $kb = [int]((Get-Item $outPath).Length / 1KB)
    Write-Host "OK - PDF generado (WeasyPrint): $outPath (${kb} KB)" -ForegroundColor Green
    return
  }
  Write-Warning "WeasyPrint no produjo un PDF válido; se intenta con Edge/Chrome."
}

# --- Respaldo: navegador Chromium en modo headless ---
$candidates = @(
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$browser = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $browser) {
  throw "No se encontró Edge ni Chrome. Instala uno o genera el PDF con otro método (WeasyPrint/Prince)."
}

$fileUri = ([System.Uri]$htmlPath).AbsoluteUri

# Perfil temporal propio: evita "engancharse" a un Edge/Chrome ya abierto
# (causa habitual de que no se genere el PDF).
$profileDir = Join-Path $env:TEMP ("pdfgen-" + [guid]::NewGuid().ToString("N"))

function Invoke-Print([string]$headlessFlag) {
  $a = @(
    $headlessFlag,
    "--disable-gpu",
    "--no-first-run",
    "--no-default-browser-check",
    "--user-data-dir=$profileDir",
    "--no-pdf-header-footer",              # usamos nuestra cabecera/pie por CSS
    "--allow-file-access-from-files",      # permite cargar el logo local
    "--virtual-time-budget=8000",          # espera a fuentes/índice JS
    "--print-to-pdf=$outPath",
    $fileUri
  )
  Start-Process -FilePath $browser -ArgumentList $a -Wait -NoNewWindow
}

Write-Host "Navegador : $browser"
Write-Host "HTML      : $htmlPath"
Write-Host "PDF       : $outPath"

try {
  Invoke-Print "--headless=new"
  # Verificamos por tamaño (no solo existencia): un render a medias deja un PDF vacío.
  if (-not (Test-Rendered -Path $outPath -MinBytes 2048)) { Invoke-Print "--headless" }  # sintaxis antigua
} finally {
  if (Test-Path $profileDir) { Remove-Item $profileDir -Recurse -Force -ErrorAction SilentlyContinue }
}

if (Test-Rendered -Path $outPath -MinBytes 2048) {
  $kb = [int]((Get-Item $outPath).Length / 1KB)
  Write-Host "OK - PDF generado: $outPath (${kb} KB)" -ForegroundColor Green
} else {
  throw "No se pudo generar un PDF válido en '$outPath' (el navegador no produjo salida o quedó vacía)."
}
