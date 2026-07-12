<#
.SYNOPSIS
  Valida la maquetación de una presentación/informe HTML paginado (secciones .page
  de tamaño A4) midiendo, por página, DOS cosas objetivas:
    · OVERFLOW  → el contenido se sale de la página (queda CORTADO por overflow:hidden).
                  Es un fallo duro: hay que reducir contenido o espaciado.
    · HUECO     → cuánto espacio vertical vacío queda sin usar en la página.
                  Es la señal objetiva del feedback "rellena el whitespace", para no
                  tener que juzgarlo a ojo con capturas (el bucle que costó ~25 nudges
                  manuales el 9-jul).

.PORQUE
  Sustituye el ciclo screenshot→nudge→screenshot por un veredicto medible. No opina de
  estética; da números: qué páginas se salen y qué páginas están demasiado vacías.

.USO
  ./scripts/validar-maquetacion.ps1 -Html "../Evolution/producto/pdf-comercial.html"
  ./scripts/validar-maquetacion.ps1 -Html "..." -PageSelector ".page" -HuecoMaxPct 14

.SALIDA
  Tabla por página + resumen. Exit code 0 si todo OK; 1 si hay overflow o hueco excesivo.
#>
param(
  [Parameter(Mandatory)] [string] $Html,
  [string] $PageSelector = ".page",   # selector de cada "hoja" A4
  [double] $HuecoMaxPct = 15.0,        # % de hueco vertical tolerado antes de avisar
  [int] $OverflowTolPx = 2             # margen de redondeo para el overflow
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "pdf-tools.ps1")

$htmlPath = (Resolve-Path $Html).Path

# --- Script de medición que se inyecta en una copia temporal del HTML --------------
# Mide cada .page: overflow (scrollHeight-clientHeight) y hueco (alto útil menos la
# extensión real del contenido en flujo). Detalles que lo hacen fiable:
#  · Se mide en el handler "load" (layout ya resuelto), NO en setTimeout: --dump-dom
#    serializa tras load y un timer podría no haber disparado todavía.
#  · El resultado va en un ATRIBUTO (data-r) de <pre id="mtx">, no en el texto: así el
#    marcador que buscamos no colisiona con el propio código fuente del <script>.
$measure = @'
<script>
window.addEventListener("load", function(){
  var sel = "__PAGESEL__";
  var pages = Array.prototype.slice.call(document.querySelectorAll(sel));
  var out = pages.map(function(p, i){
    var overflow = p.scrollHeight - p.clientHeight;
    var cs = getComputedStyle(p);
    var padTop = parseFloat(cs.paddingTop), padBottom = parseFloat(cs.paddingBottom);
    var usable = p.clientHeight - padTop - padBottom;
    // extensión real del contenido = del hijo más alto al más bajo (ignora absolutos y decorativos)
    var top = Infinity, bot = -Infinity, pr = p.getBoundingClientRect();
    Array.prototype.slice.call(p.children).forEach(function(c){
      var st = getComputedStyle(c);
      if (st.position === "absolute" || c.getAttribute("aria-hidden") === "true") return;
      var r = c.getBoundingClientRect();
      var t = r.top - pr.top - padTop, b = r.bottom - pr.top - padTop;
      if (t < top) top = t; if (b > bot) bot = b;
    });
    var content = (bot > top) ? (bot - top) : 0;
    var hueco = Math.max(0, usable - content);
    var huecoPct = usable > 0 ? (hueco / usable * 100) : 0;
    return { i: i+1, overflow: Math.round(overflow), huecoPct: Math.round(huecoPct*10)/10 };
  });
  var pre = document.createElement("pre");
  pre.id = "mtx";
  pre.setAttribute("data-r", JSON.stringify(out));
  document.body.appendChild(pre);
});
</script>
'@
$measure = $measure.Replace("__PAGESEL__", $PageSelector)

$doc = Get-Content $htmlPath -Raw -Encoding UTF8
if ($doc -match "</body>") { $doc = $doc -replace "</body>", "$measure</body>" }
else { $doc = $doc + $measure }
$tmp = Join-Path $env:TEMP ("valida-" + [guid]::NewGuid().ToString("N") + ".html")
Set-Content -Path $tmp -Value $doc -Encoding UTF8

# --- Render headless con --dump-dom (ejecuta el JS y devuelve el DOM serializado) ---
$browser = Get-ChromiumPath
$fileUri = ([System.Uri]$tmp).AbsoluteUri
$profileDir = Join-Path $env:TEMP ("valida-p-" + [guid]::NewGuid().ToString("N"))
$dumpFile = Join-Path $env:TEMP ("valida-dom-" + [guid]::NewGuid().ToString("N") + ".html")

try {
  $a = @(
    "--headless=new","--disable-gpu","--disable-crash-reporter",
    "--no-first-run","--no-default-browser-check","--user-data-dir=$profileDir",
    "--allow-file-access-from-files","--virtual-time-budget=6000",
    "--dump-dom",$fileUri
  )
  # --dump-dom escribe el DOM serializado por stdout. Lo capturamos con
  # -RedirectStandardOutput (fiable en Windows; el operador & no siempre recoge la
  # salida del navegador). El ruido de Crashpad va a stderr y se ignora.
  Start-Process -FilePath $browser -ArgumentList $a -Wait -NoNewWindow -RedirectStandardOutput $dumpFile | Out-Null
} finally {
  if (Test-Path $profileDir) { Remove-Item $profileDir -Recurse -Force -ErrorAction SilentlyContinue }
  if (Test-Path $tmp) { Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
}

$domText = Get-Content $dumpFile -Raw -Encoding UTF8
Remove-Item $dumpFile -Force -ErrorAction SilentlyContinue

# Leemos el JSON del atributo data-r de <pre id="mtx"> (no del texto, para no chocar
# con el propio código del script inyectado).
if ($domText -notmatch '<pre id="mtx" data-r="([^"]*)"') {
  throw "No se pudieron leer las metricas (el selector '$PageSelector' no encontro paginas, o el render fallo)."
}
$json = $Matches[1]
# El atributo serializado escapa comillas/símbolos como entidades HTML; deshacer.
$json = $json.Replace("&quot;",'"').Replace("&amp;","&").Replace("&lt;","<").Replace("&gt;",">")
$metrics = $json | ConvertFrom-Json

# --- Informe ----------------------------------------------------------------------
Write-Host ""
Write-Host "Validación de maquetación — $([System.IO.Path]::GetFileName($htmlPath))" -ForegroundColor Cyan
Write-Host ("{0,-8}{1,-14}{2,-14}{3}" -f "Página","Overflow","Hueco %","Veredicto")
Write-Host ("-" * 52)

$problemas = 0
foreach ($m in $metrics) {
  $veredicto = "OK"; $color = "Green"
  if ($m.overflow -gt $OverflowTolPx) { $veredicto = "OVERFLOW " + $m.overflow + "px cortados"; $color = "Red"; $problemas++ }
  elseif ($m.huecoPct -gt $HuecoMaxPct) { $veredicto = "HUECO - rellenar"; $color = "Yellow"; $problemas++ }
  Write-Host ("{0,-8}{1,-14}{2,-14}{3}" -f $m.i, "$($m.overflow)px", "$($m.huecoPct)%", $veredicto) -ForegroundColor $color
}

Write-Host ("-" * 52)
if ($problemas -eq 0) {
  Write-Host "OK - $($metrics.Count) páginas, ninguna se sale ni queda demasiado vacía." -ForegroundColor Green
  exit 0
} else {
  Write-Host ("$problemas pagina(s) con problema: overflow o hueco mayor que " + $HuecoMaxPct + " por ciento.") -ForegroundColor Yellow
  exit 1
}
