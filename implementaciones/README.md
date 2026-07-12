# Paquete de Servicios Mínimos — Skills

Colección de skills para producir, de forma rápida y **coherente en look & feel**,
el paquete de servicios de presencia digital para clientes de consultoría.

## Cómo funciona (la idea central)

Todo gira en torno a una **fuente de verdad de marca**: `brand-tokens.json`.

```
                 ┌─────────────────────┐
                 │  manual-de-marca    │  ← PASO 1 SIEMPRE
                 │  (define la marca)  │
                 └──────────┬──────────┘
                            │ produce
                   brand-tokens.json  +  BRAND.md
                            │ lo consumen ↓
   ┌──────────┬────────────┼────────────┬───────────┬──────────┐
   ▼          ▼            ▼            ▼           ▼          ▼
 web       landing      blog-seo     redes      newsletter  presentaciones
```

Cada skill **lee** `brand-tokens.json` de la carpeta del cliente y se autoconfigura
(colores, tipografías, tono, contacto). Resultado: un cliente = un sistema visual
y verbal único, replicado sin fisuras en todos los entregables.

Contrato del archivo: [`CONTRATO-MARCA.md`](CONTRATO-MARCA.md).

## Estructura de trabajo por cliente

```
<cliente>/
├─ marca/
│  ├─ brand-tokens.json      ← fuente de verdad
│  ├─ BRAND.md               ← manual entregable
│  └─ assets/                ← logo, favicon, fuentes, imágenes
├─ web/                      ← (skill web)
├─ landings/                 ← (skill landing)
├─ blog/                     ← (skill blog-seo)
└─ ...
```

## Catálogo de servicios (roadmap)

| # | Servicio | Skill | Estado |
|---|---|---|---|
| — | Fuente de verdad de marca | `manual-de-marca` | ✅ v2 |
| 1 | Web corporativa | `web-corporativa` | ✅ v1 |
| 2 | Landing page | `landing-page` | ✅ v1 |
| 3 | Blog SEO | `blog-seo` | ✅ v1 |
| 4 | Contenido para redes | `contenido-redes` | ✅ v1 |
| 5 | Google Business | `google-business` | ⏳ |
| 6 | SEO local básico | `seo-local` | ⏳ |
| 7 | Newsletter | `newsletter` | ⏳ |
| 8 | Presentaciones | `presentaciones` | ⏳ |
| 9 | Manual de marca | `manual-de-marca` | ✅ v2 |
| 10 | Optimización de textos | `optimizacion-textos` | ⏳ |
| 11 | Traducción profesional | `traduccion` | ⏳ |

> Nota: el servicio #9 (Manual de marca) es a la vez un entregable vendible y el
> cimiento técnico del que dependen los demás. Por eso se construyó primero.

## Instalación como skills de Claude Code
Copia cada carpeta de skill (blog-seo, landing-page, manual-de-marca, web-corporativa…)
a `~/.claude/skills/` (o al `.claude/skills/` del
proyecto). Se invocan por su `name` o se activan solas por su `description`.
