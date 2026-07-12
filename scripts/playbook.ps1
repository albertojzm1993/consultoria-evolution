<#
.SYNOPSIS
  Gobierna los playbooks de sector (playbooks/README.md): crea uno nuevo con la
  estructura canónica y verifica (lint) que uno existente la cumple.

.PORQUE
  La gobernanza (13 secciones obligatorias + 10 preguntas litmus + taxonomía) estaba
  escrita pero se aplicaba a mano. Esto la convierte en herramienta: ni un playbook
  nuevo nace incompleto, ni uno viejo se desvía sin que salte el aviso.

.USO
  # Crear un playbook nuevo (idempotente: no sobreescribe uno existente)
  ./scripts/playbook.ps1 -Accion nuevo -Sector "Clínicas y salud" -Archivo "salud-clinicas.md"

  # Verificar la estructura de uno existente
  ./scripts/playbook.ps1 -Accion lint -Archivo "bienestar-fitness.md"

.SALIDA
  nuevo → crea playbooks/<archivo>.
  lint  → informe de secciones presentes/ausentes/vacías + checklist de las 10 preguntas.
          Exit code 0 si la estructura está completa; 1 si falta o está vacía alguna sección.
#>
param(
  [Parameter(Mandatory)] [ValidateSet("nuevo","lint")] [string] $Accion,
  [string] $Archivo,
  [string] $Sector,
  [int] $MinContenido = 40   # nº mínimo de caracteres de contenido para no considerar "vacía" una sección
)

$ErrorActionPreference = "Stop"
$playbooksDir = Join-Path (Split-Path $PSScriptRoot -Parent) "playbooks"

# --- Estructura canónica (espejo de playbooks/README.md) ---------------------------
$secciones = @(
  @{ n=1;  t="Qué negocios cubre";                                   g="Descripción del sector y variantes que agrupa." }
  @{ n=2;  t="Cómo gana dinero (el modelo mental)";                  g="El modelo económico y el modelo mental del sector." }
  @{ n=3;  t="Tipos de cliente y qué esperan";                       g="A quién sirve el negocio y qué valora." }
  @{ n=4;  t="La mayor palanca del sector";                          g="La obsesión aplicada: dónde está casi siempre el crecimiento." }
  @{ n=5;  t="Madurez típica del sector (N1-N5)";                    g="Cómo se ve el sector en cada nivel del Índice de Evolución." }
  @{ n=6;  t="Dónde está el cuello de botella (mapa a los 10 pilares)"; g="Mapa síntoma→causa a los 10 pilares y qué pilares pesan más." }
  @{ n=7;  t="KPIs y benchmarks del sector";                         g="Los indicadores del sector y sus valores de referencia." }
  @{ n=8;  t="Señales de alerta (red flags)";                        g="Red flags que, si aparecen, casi seguro esconden un problema." }
  @{ n=9;  t="Oportunidades y palancas";                             g="Menú clasificado (verde/amarillo/rojo/negro) + ranking de impacto (estrellas)." }
  @{ n=10; t="Automatizaciones e IA típicas";                        g="Qué automatizar y qué IA aporta más valor en el sector." }
  @{ n=11; t="Marketing del sector";                                 g="Contenido que funciona, SEO habitual, cómo es la competencia." }
  @{ n=12; t="Preguntas de descubrimiento específicas del sector";   g="Preguntas propias del sector, sobre las 10 del Business Scan." }
  @{ n=13; t="Casos que lo alimentan (memoria viva)";                g="Aprendizajes por cliente (patrones de sector, nunca datos confidenciales)." }
)

$litmus = @(
  "¿Cómo funciona este tipo de negocio?",
  "¿Cómo gana dinero?",
  "¿Qué espera el cliente final?",
  "¿Qué diferencia a los mejores del sector?",
  "¿Cuáles son los errores más habituales?",
  "¿Qué oportunidades aparecen una y otra vez?",
  "¿Qué automatizaciones suelen aportar más valor?",
  "¿Qué IA tiene mayor impacto?",
  "¿Qué indicadores determinan el éxito?",
  "¿Cuál suele ser el orden correcto de implantación?"
)

if (-not $Archivo) { throw "Falta -Archivo (nombre del playbook, p. ej. 'salud-clinicas.md')." }
if ($Archivo -notmatch '\.md$') { $Archivo = "$Archivo.md" }
$rutaPlaybook = Join-Path $playbooksDir $Archivo

# ============================ ACCIÓN: NUEVO ========================================
if ($Accion -eq "nuevo") {
  if (-not $Sector) { throw "Falta -Sector (nombre del sector para la portada del playbook)." }
  if (Test-Path $rutaPlaybook) {
    Write-Host "Ya existe: $rutaPlaybook (no se sobreescribe). Usa -Accion lint para revisarlo." -ForegroundColor Yellow
    exit 0
  }

  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine("# Playbook — $Sector")
  [void]$sb.AppendLine("")
  [void]$sb.AppendLine("> **Documento interno de gobierno. NO es para el cliente.** Base de conocimiento viva del sector.")
  [void]$sb.AppendLine("> Orienta la sospecha; no dicta la conclusión. Nada se propone al cliente sin verificarlo en su Business Scan.")
  [void]$sb.AppendLine("")
  [void]$sb.AppendLine("<!-- LITMUS — este playbook está bien hecho si responde, sin haber visto el negocio: -->")
  foreach ($i in 0..($litmus.Count-1)) { [void]$sb.AppendLine("<!--   $($i+1). $($litmus[$i]) -->") }
  [void]$sb.AppendLine("")
  [void]$sb.AppendLine("---")
  [void]$sb.AppendLine("")
  foreach ($s in $secciones) {
    [void]$sb.AppendLine("## $($s.n). $($s.t)")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("> $($s.g)")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("_TODO: completar con el conocimiento del sector (se estrena y valida con el primer cliente)._")
    [void]$sb.AppendLine("")
  }

  Set-Content -Path $rutaPlaybook -Value $sb.ToString() -Encoding UTF8
  Write-Host "OK - playbook creado: $rutaPlaybook" -ForegroundColor Green
  Write-Host "Siguiente paso: complétalo con el primer cliente del sector y regístralo en playbooks/README.md (Índice)."
  exit 0
}

# ============================ ACCIÓN: LINT =========================================
if ($Accion -eq "lint") {
  if (-not (Test-Path $rutaPlaybook)) { throw "No existe: $rutaPlaybook" }
  $texto = Get-Content $rutaPlaybook -Raw -Encoding UTF8

  # Trocea por encabezados de sección "## N." para medir el contenido de cada una.
  $lineas = $texto -split "`r?`n"
  $indices = @{}
  for ($i=0; $i -lt $lineas.Count; $i++) {
    if ($lineas[$i] -match '^##\s+(\d{1,2})\.') { $indices[[int]$Matches[1]] = $i }
  }

  Write-Host ""
  Write-Host "Lint de playbook — $Archivo" -ForegroundColor Cyan
  Write-Host ("{0,-5}{1,-52}{2}" -f "Sec","Título canónico","Estado")
  Write-Host ("-" * 72)

  $faltan = 0; $vacias = 0
  foreach ($s in $secciones) {
    $estado = ""; $color = "Green"
    if (-not $indices.ContainsKey($s.n)) {
      $estado = "FALTA"; $color = "Red"; $faltan++
    } else {
      # contenido = texto hasta el siguiente "## " (cualquier sección)
      $start = $indices[$s.n] + 1
      $end = $lineas.Count
      for ($j=$start; $j -lt $lineas.Count; $j++) { if ($lineas[$j] -match '^##\s') { $end = $j; break } }
      # Mide contenido REAL: quita solo la línea-guía exacta del scaffold, los TODO y los
      # separadores. NO quita las citas en general (en un playbook lleno son contenido).
      $bodyLines = @($lineas[$start..($end-1)])
      $guia = [regex]::Escape("> " + $s.g)
      $bodyLines = $bodyLines | Where-Object {
        $_ -notmatch "^\s*$guia\s*$" -and $_ -notmatch '^\s*_TODO' -and $_ -notmatch '^\s*-{3,}\s*$'
      }
      $cuerpo = (($bodyLines -join " ") -replace '\s+',' ').Trim()
      if ($cuerpo.Length -lt $MinContenido) { $estado = "VACÍA / incompleta"; $color = "Yellow"; $vacias++ }
      else { $estado = "OK ($($cuerpo.Trim().Length) car.)" }
    }
    Write-Host ("{0,-5}{1,-52}{2}" -f $s.n, $s.t, $estado) -ForegroundColor $color
  }

  Write-Host ("-" * 72)
  Write-Host ("Estructura: {0}/13 secciones presentes, {1} vacía(s)." -f (13-$faltan), $vacias)
  Write-Host ""
  Write-Host "Checklist manual (10 preguntas litmus) — el lint verifica estructura, no semántica:" -ForegroundColor Cyan
  foreach ($i in 0..($litmus.Count-1)) { Write-Host ("  [ ] {0}. {1}" -f ($i+1), $litmus[$i]) }

  if ($faltan -eq 0 -and $vacias -eq 0) {
    Write-Host ""
    Write-Host "OK - estructura canónica completa." -ForegroundColor Green
    exit 0
  } else {
    Write-Host ""
    Write-Host ("Revisar: {0} sección(es) ausente(s), {1} vacía(s)." -f $faltan, $vacias) -ForegroundColor Yellow
    exit 1
  }
}
