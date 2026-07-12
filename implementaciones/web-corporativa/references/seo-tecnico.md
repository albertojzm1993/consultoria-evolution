# Referencia — SEO técnico e integraciones

SEO básico bien hecho a nivel de código (no auditoría completa). Datos reales
desde `brand-tokens.json` (`contacto`, `social`, `meta`).

## Por página (`<head>`)
- `<title>` único, ~50–60 caracteres, con keyword principal + marca.
- `<meta name="description">` ~150–160 caracteres, persuasiva.
- `<link rel="canonical">`.
- Un solo `<h1>` por página con la keyword.
- URLs amigables (`/servicios`, `/sobre-nosotros`).
- `<html lang="es">` (o el idioma principal del JSON).

## Social / Open Graph
- `og:title`, `og:description`, `og:image` (imagen 1200×630), `og:type`, `og:url`.
- `twitter:card = summary_large_image`.
- Favicon (usa `logo.favicon` del JSON) y `theme-color` con `--color-primary`.

## Datos estructurados (schema.org, JSON-LD)
- **LocalBusiness** (o el tipo específico: Dentist, Restaurant…) con NAP:
  `name`, `address`, `telephone`, `openingHours`, `geo`, `url`, `sameAs`
  (redes del JSON), `image`, `priceRange` si aplica.
- **Organization** con `logo` y `sameAs` si no es negocio local.
- **BreadcrumbList** en páginas internas.
- **FAQPage** si hay bloque de FAQ.
Rellena solo con datos reales; nunca inventes dirección/teléfono.

## Ficheros de sitio
- `sitemap.xml` con todas las URLs.
- `robots.txt` permitiendo el rastreo y apuntando al sitemap.

## Integraciones habituales
- **Google Maps** embebido (iframe) en contacto/footer usando la dirección real.
- **WhatsApp**: enlace `https://wa.me/<numero>` si el negocio lo usa.
- **Redes**: enlaces desde `social` del JSON (abrir en pestaña nueva, `rel`).
- **Formulario de contacto**: acción a definir (email, Formspree, backend). Deja
  claro el destino; valida en cliente y marca campos requeridos.
- **Analítica**: dejar preparado el hueco (GA4/Plausible) si el cliente lo pide;
  no incrustar IDs inventados.

## Rendimiento (impacta SEO)
- Imágenes optimizadas y lazy, fuentes con `swap`, CSS/JS mínimos.
- Evita CLS con `width/height` en imágenes y reserva de espacio.
