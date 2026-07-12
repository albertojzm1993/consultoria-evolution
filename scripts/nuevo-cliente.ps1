<#
.SYNOPSIS
    Genera la carpeta de un cliente nuevo con toda la estructura y recursos
    del proceso de consultoría.

.DESCRIPTION
    Crea clientes/<slug>/ con las fases (descubrimiento, briefing, auditoría,
    propuesta, estrategia), la carpeta de marca (fuente de verdad brand-tokens.json),
    entregables, recursos y gestión. Rellena cada archivo con su plantilla.

    Es idempotente: si el cliente ya existe, NO sobreescribe archivos con contenido;
    solo crea lo que falte. Usa -Force para regenerar plantillas vacías.

.EXAMPLE
    ./nuevo-cliente.ps1 -Nombre "Clínica Dental Sonríe"
    ./nuevo-cliente.ps1 -Nombre "Panadería La Espiga" -Sector "panadería artesanal"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Nombre,

    [string]$Sector = "",

    # Raíz del proyecto de consultoría. Por defecto, la carpeta padre de /scripts.
    [string]$RaizProyecto = (Split-Path -Parent $PSScriptRoot),

    [switch]$Force
)

$ErrorActionPreference = "Stop"

# --- Slug ---------------------------------------------------------------
# Usa normalización Unicode (FormD) para separar los diacríticos del carácter
# base y eliminarlos. Es robusto ante la codificación del archivo (á->a, ñ->n).
function Get-Slug([string]$texto) {
    $norm = $texto.ToLowerInvariant().Normalize([Text.NormalizationForm]::FormD)
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $norm.ToCharArray()) {
        if ([Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch) -ne
            [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$sb.Append($ch)
        }
    }
    $t = $sb.ToString().Normalize([Text.NormalizationForm]::FormC)
    $t = $t -replace '[^a-z0-9]+', '-' -replace '(^-+|-+$)', ''
    return $t
}

$slug   = Get-Slug $Nombre
$fecha  = Get-Date -Format "yyyy-MM-dd"
$raiz   = Join-Path $RaizProyecto "clientes"
$base   = Join-Path $raiz $slug

if (-not $slug) { throw "El nombre del cliente no produce un slug válido." }

# --- Estructura de carpetas --------------------------------------------
$carpetas = @(
    "00-descubrimiento",
    "01-auditoria",
    "02-diagnostico",
    "03-briefing",
    "04-estrategia",
    "05-propuesta",
    "marca/assets",
    "entregables/web",
    "entregables/landings",
    "entregables/blog",
    "entregables/redes",
    "recursos",
    "gestion"
)
foreach ($c in $carpetas) {
    $ruta = Join-Path $base $c
    if (-not (Test-Path $ruta)) { New-Item -ItemType Directory -Path $ruta -Force | Out-Null }
}

# --- Helper: escribe un archivo solo si no existe (o si -Force) ---------
function Write-Plantilla([string]$rutaRel, [string]$contenido) {
    $ruta = Join-Path $base $rutaRel
    if ((Test-Path $ruta) -and -not $Force) {
        Write-Host "  = ya existe, se conserva: $rutaRel"
        return
    }
    $dir = Split-Path -Parent $ruta
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Set-Content -Path $ruta -Value $contenido -Encoding utf8
    Write-Host "  + $rutaRel"
}

$H = "# " + $Nombre  # encabezado reutilizable

# --- README índice del cliente -----------------------------------------
Write-Plantilla "README.md" @"
$H

> Ficha de cliente. Estado global del proceso de consultoría.
> Cliente creado el $fecha.

## Estado del proceso

| Fase | Documento | Estado |
|---|---|---|
| 0 · Descubrimiento | ``00-descubrimiento/perfil-maestro-$slug.md`` | ⬜ Pendiente |
| 1 · Auditoría | ``01-auditoria/auditoria.md`` | ⬜ Pendiente |
| 2 · Diagnóstico | ``02-diagnostico/diagnostico.md`` | ⬜ Pendiente |
| 3 · Briefing estratégico | ``03-briefing/briefing.md`` | ⬜ Pendiente |
| 4 · Estrategia (motor + plan director) | ``04-estrategia/`` | ⬜ Pendiente |
| 5 · Propuesta comercial | ``05-propuesta/propuesta.md`` | ⬜ Pendiente |
| Marca (fuente de verdad) | ``marca/brand-tokens.json`` | ⬜ Pendiente |

## Datos rápidos

- **Sector:** $Sector
- **Slug:** ``$slug``
- **Confidencial:** los datos de este cliente NO se mezclan con los de otros.

## Mapa de la carpeta

- ``00-descubrimiento/`` — Perfil Maestro del Negocio (base de conocimiento).
- ``01-auditoria/`` — hallazgos clasificados (crítico / importante / recomendable): qué ocurre.
- ``02-diagnostico/`` — causas raíz, mapa de causalidad y efecto dominó: por qué ocurre.
- ``03-briefing/`` — oportunidades y servicios: qué se puede hacer.
- ``04-estrategia/`` — motor de estrategia + plan director de transformación.
- ``05-propuesta/`` — propuesta profesional para presentar.
- ``marca/`` — ``brand-tokens.json`` (fuente de verdad) + brand book.
- ``entregables/`` — web, landings, blog, redes… producidos por las skills.
- ``recursos/`` — material de apoyo (assets, exports, datos, referencias).
- ``gestion/`` — reuniones y tareas.
"@

# --- Fase 1: Perfil maestro (placeholder) ------------------------------
# El documento se nombra SIEMPRE perfil-maestro-<slug-cliente> (convención del proyecto).
Write-Plantilla "00-descubrimiento/perfil-maestro-$slug.md" @"
# PERFIL MAESTRO DEL NEGOCIO — $Nombre

> Fase 1 — Descubrimiento. Base de conocimiento para todas las fases posteriores.
> Rellenar con la skill ``perfil-maestro-negocio``. Solo hechos y síntesis; nunca
> recomendaciones ni auditoría.

## 1. Resumen ejecutivo

## 2. Información general
- Nombre: $Nombre
- Sector: $Sector
- Actividad:
- Ubicación / cobertura:

## 3. Qué ofrece
## 4. Misión
## 5. Visión
## 6. Valores
## 7. Propuesta de valor
## 8. Posicionamiento
## 9. Identidad de marca
## 10. Cliente ideal
## 11. Experiencia que pretende ofrecer
## 12. Modelo de negocio
## 13. Activos digitales
## 14. Ecosistema digital
## 15. Competidores identificados
## 16. Resumen de identidad
## 17. ADN del negocio (Knowledge Core)
"@

# --- Fase 0: Formulario de descubrimiento (para enviar al cliente) ------
# Copia el PDF de marca del formulario a la carpeta del cliente, listo para mandar.
$formPdf = Join-Path $RaizProyecto "analisis/0. descubrimiento/templates/formulario-descubrimiento.pdf"
$formDst = Join-Path $base "00-descubrimiento/formulario-descubrimiento.pdf"
if ((Test-Path $formPdf) -and ((-not (Test-Path $formDst)) -or $Force)) {
    Copy-Item $formPdf $formDst -Force
    Write-Host "  + 00-descubrimiento/formulario-descubrimiento.pdf (listo para enviar)"
}
elseif (-not (Test-Path $formPdf)) {
    Write-Host "  ! Falta la plantilla del formulario; genérala en 'analisis/0. descubrimiento/templates/'." -ForegroundColor Yellow
}

# Respuestas del cliente (se pegan verbatim) — misma idea que el briefing de M8.
Write-Plantilla "00-descubrimiento/briefing-cliente-fuente.md" @"
# Respuestas del cliente — $Nombre (fuente)

> Pega aquí, VERBATIM, lo que el cliente responda al Formulario de Descubrimiento
> (``formulario-descubrimiento.pdf``). No edites sus palabras: es material de
> descubrimiento literal. La interpretación va en ``perfil-maestro-$slug.md``.
> Si el cliente no lo devuelve, este archivo queda vacío y se reconstruye online.
"@

# Captura interna de la visión interna (pain points) del formulario.
Write-Plantilla "00-descubrimiento/_business-scan.md" @"
# Business Scan (interno) — $Nombre

> Visión interna del formulario, para que las fases siguientes la consuman sin volver
> a preguntar. NO se enseña al cliente.

## Pain points
- Mejorar 3 cosas:
- Qué consume más tiempo:
- Qué hace perder dinero:
- Tareas repetidas / dependencia de una persona / semana fuera / botón:

## Percepción de marca elegida (5)
-

## Contenido en bruto (preguntas diarias, mitos, errores, frases)
-

## La pregunta mágica
-
"@

# --- Fase 1: Auditoría --------------------------------------------------
Write-Plantilla "01-auditoria/auditoria.md" @"
# AUDITORÍA — $Nombre

> Fase 1 — Qué ocurre. Analizar web, SEO, velocidad, Google, redes, reputación,
> competencia, UX y embudo. Clasificar cada hallazgo. Usar la skill ``auditoria-negocio``.

## Hallazgos

### 🔴 Críticos (resolver inmediatamente)
### 🟠 Importantes (primeras semanas)
### 🟡 Recomendables (mejora opcional pero valiosa)
"@

# --- Fase 2: Diagnóstico ------------------------------------------------
Write-Plantilla "02-diagnostico/diagnostico.md" @"
# DIAGNÓSTICO ESTRATÉGICO — $Nombre

> Fase 2 — Por qué ocurre. Interpreta la auditoría: causas raíz, mapa de causalidad
> y Efecto Dominó. No propone soluciones. Usar la skill ``diagnostico-estrategico``.

## Parte 1 — Diagnóstico
## Parte 2 — Mapa de causalidad
## Parte 3 — Índice de Efecto Dominó
"@

# --- Fase 3: Briefing ---------------------------------------------------
Write-Plantilla "03-briefing/briefing.md" @"
# BRIEFING ESTRATÉGICO — $Nombre

> Fase 3 — Qué oportunidades hay. Con la auditoría y el diagnóstico ya hechos, mapear
> TODAS las oportunidades/servicios. Base de la propuesta comercial.

## Oportunidades detectadas
| # | Oportunidad | Área | Impacto potencial | Prioridad |
|---|---|---|---|---|
| 1 |  |  |  |  |
"@

# --- Fase 4: Estrategia (motor + plan director) -------------------------
Write-Plantilla "04-estrategia/motor-estrategia.md" @"
# MOTOR DE ESTRATEGIA EMPRESARIAL — $Nombre

> Fase 4 — Qué hacer. Traduce los objetivos que elige el cliente en iniciativas
> (objetivo → capacidad → iniciativa). Sin fechas ni presupuestos.

## Objetivos elegidos por el cliente
## Iniciativas
"@

Write-Plantilla "04-estrategia/plan-director.md" @"
# PLAN DIRECTOR DE TRANSFORMACIÓN — $Nombre

> Fase 4 — En qué orden. Ordena las iniciativas elegidas en fases de madurez (el
> camino, no el cronograma).

## Fases de madurez
| Fase | Iniciativas | Qué desbloquea | Estado |
|---|---|---|---|
| 1 |  |  | ⬜ |
"@

# --- Fase 5: Propuesta comercial ----------------------------------------
Write-Plantilla "05-propuesta/propuesta.md" @"
# PROPUESTA — $Nombre

> Fase 5 — Lista para presentar al cliente tal cual.

## Propuestas
### Propuesta 1 — {título}
- **Problema detectado:**
- **Impacto en el negocio:**
- **Solución propuesta:**
- **Dificultad:** fácil / media / alta
- **Beneficio esperado:**
- **Prioridad:**
- **Precio orientativo:**
"@

# --- Marca: brand-tokens.json (fuente de verdad) -----------------------
Write-Plantilla "marca/brand-tokens.json" @"
{
  "meta": {
    "cliente": "$Nombre",
    "sector": "$Sector",
    "version": "0.1.0-provisional",
    "fecha": "$fecha",
    "idioma_principal": "es"
  },
  "verbal": {
    "mision": "", "vision": "", "valores": [],
    "propuesta_valor": "", "personalidad": [], "arquetipo": "",
    "tono": { "somos": [], "no_somos": [], "reglas": [] },
    "mensajes_clave": [], "tagline": "", "palabras_prohibidas": [], "glosario": {}
  },
  "color": {
    "primary":   { "hex": "#0B5FFF", "on": "#FFFFFF" },
    "secondary": { "hex": "#0A2540", "on": "#FFFFFF" },
    "accent":    { "hex": "#FF6B35", "on": "#FFFFFF" },
    "neutral": { "ink": "#0A0A0A", "body": "#3F3F46", "muted": "#71717A",
                 "line": "#E4E4E7", "surface": "#FFFFFF", "bg": "#F7F7F8" },
    "state": { "success": "#16A34A", "warning": "#D97706", "danger": "#DC2626" },
    "dark": { "bg": "#0A0A0A", "surface": "#161616", "ink": "#FAFAFA",
              "body": "#D4D4D8", "line": "#27272A" }
  },
  "typography": {
    "heading": { "family": "Poppins", "fallback": "system-ui, sans-serif", "weights": [600,700], "google_font": true },
    "body":    { "family": "Inter",   "fallback": "system-ui, sans-serif", "weights": [400,500], "google_font": true },
    "scale": { "h1": "3.0", "h2": "2.25", "h3": "1.75", "h4": "1.25", "body": "1.0", "small": "0.875" },
    "line_height": { "heading": 1.15, "body": 1.6 },
    "letter_spacing_headings": "-0.02em"
  },
  "geometry": {
    "radius": { "sm": "6px", "md": "12px", "lg": "20px", "pill": "9999px" },
    "spacing_base": "8px", "container_max": "1200px",
    "shadow": { "sm": "0 1px 2px rgba(0,0,0,.06)", "md": "0 8px 24px rgba(0,0,0,.10)", "lg": "0 24px 60px rgba(0,0,0,.16)" },
    "border_width": "1px"
  },
  "imagery": { "estilo_foto": "", "estilo_ilustracion": "", "iconos": "Lucide (outline, 1.5px)", "prompt_ia_base": "" },
  "logo": { "principal": "assets/logo.svg", "isotipo": "assets/isotipo.svg", "favicon": "assets/favicon.svg",
            "clearspace": "Altura de la X del logo", "min_size_px": 24, "usos_incorrectos": ["no deformar","no rotar","no sombras"] },
  "social": { "instagram": "", "facebook": "", "linkedin": "", "tiktok": "", "youtube": "", "whatsapp": "" },
  "contacto": { "empresa": "$Nombre", "telefono": "", "email": "", "direccion": "", "google_maps_place_id": "", "horario": "" }
}
"@

Write-Plantilla "marca/BRAND.md" @"
$H — Manual de marca (BRAND.md)

> Generar con la skill ``manual-de-marca`` a partir del Perfil Maestro.
> ``brand-tokens.json`` es la fuente de verdad; este documento es el entregable humano.
"@

Write-Plantilla "marca/resumen-marca.md" @"
# Resumen de marca — $Nombre

> Bloque portable (300-500 palabras) para pegar como contexto en otras skills/prompts.
> Lo produce la skill ``manual-de-marca``.
"@

# --- Gestión ------------------------------------------------------------
Write-Plantilla "gestion/reuniones.md" @"
# Reuniones — $Nombre

## $fecha — Onboarding
- Asistentes:
- Notas:
- Acuerdos:
- Próximos pasos:
"@

Write-Plantilla "gestion/tareas.md" @"
# Tareas — $Nombre

| # | Tarea | Prioridad | Estado | Fecha límite |
|---|---|---|---|---|
| 1 | Completar Perfil Maestro (Fase 1) | Alta | ⬜ |  |
"@

Write-Plantilla "recursos/README.md" @"
# Recursos — $Nombre

Material de apoyo del cliente: assets recibidos, exports, datos, capturas,
referencias y cualquier insumo para las fases del proceso.
"@

# --- Fin ----------------------------------------------------------------
Write-Host ""
Write-Host "✅ Cliente listo: clientes/$slug" -ForegroundColor Green
Write-Host "   Ruta: $base"
