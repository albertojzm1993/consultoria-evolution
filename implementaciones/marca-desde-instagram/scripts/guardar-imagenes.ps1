<#
.SYNOPSIS
  Escribe a disco imágenes recibidas como base64 desde el navegador.
.DESCRIPTION
  Lee un JSON con forma [{ "name": "01-foo.jpg", "b64": "<base64>" }, ...]
  (o un objeto con propiedad .items) y vuelca cada entrada a -DestDir.
  Pensado para la skill marca-desde-instagram (Método A de references/guardar-imagenes.md):
  el CDN de Instagram da 403 fuera del navegador, así que los bytes se obtienen
  dentro de la página (fetch->base64) y este script solo los persiste.
.PARAMETER JsonPath
  Ruta al fichero JSON con los pares name/b64.
.PARAMETER DestDir
  Carpeta destino (se crea si no existe). Normalmente clientes/<slug>/marca/assets/instagram.
.EXAMPLE
  ./guardar-imagenes.ps1 -JsonPath ".\ig-lote.json" -DestDir "..\..\..\clientes\munay\marca\assets\instagram"
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)][string]$JsonPath,
  [Parameter(Mandatory = $true)][string]$DestDir
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $JsonPath)) { throw "No existe el JSON: $JsonPath" }
if (-not (Test-Path -LiteralPath $DestDir)) { New-Item -ItemType Directory -Force -Path $DestDir | Out-Null }

$raw = Get-Content -LiteralPath $JsonPath -Raw -Encoding UTF8
$data = $raw | ConvertFrom-Json
# Acepta tanto un array como { items: [...] }
$items = if ($data.PSObject.Properties.Name -contains 'items') { $data.items } else { $data }

$ok = 0; $fail = 0
foreach ($it in $items) {
  if (-not $it.name) { Write-Warning "Entrada sin 'name', saltada."; $fail++; continue }
  if ($it.error)     { Write-Warning ("{0}: error de captura -> {1}" -f $it.name, $it.error); $fail++; continue }
  if (-not $it.b64)  { Write-Warning ("{0}: sin 'b64', saltada." -f $it.name); $fail++; continue }
  try {
    $bytes = [Convert]::FromBase64String($it.b64)
    $dest  = Join-Path $DestDir $it.name
    [IO.File]::WriteAllBytes($dest, $bytes)
    Write-Host ("  guardado  {0}  ({1:N0} KB)" -f $it.name, ($bytes.Length / 1KB))
    $ok++
  } catch {
    Write-Warning ("{0}: no se pudo escribir -> {1}" -f $it.name, $_.Exception.Message)
    $fail++
  }
}

Write-Host ""
Write-Host ("Hecho: {0} guardadas, {1} con problema. Destino: {2}" -f $ok, $fail, $DestDir)
