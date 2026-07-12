# Contrato de Marca — `brand-tokens.json`

Este es el **contrato compartido** de todo el paquete de servicios. La skill
`manual-de-marca` **produce** este archivo. Todas las demás skills (web, landing,
blog, redes, newsletter, presentaciones…) lo **consumen** para garantizar que
todo lo que se entrega al cliente comparte el mismo *look & feel* y el mismo tono.

> Regla de oro: **ninguna skill inventa colores, tipografías ni tono.** Si falta
> `brand-tokens.json`, la skill debe pedir que se ejecute antes `manual-de-marca`
> (o generar un set provisional y avisar de que es provisional).

## Ubicación

Se guarda en la carpeta de trabajo del cliente:

```
<cliente>/marca/brand-tokens.json     ← fuente de verdad (machine-readable)
<cliente>/marca/BRAND.md              ← brand book de 20 secciones (human-readable)
<cliente>/marca/resumen-marca.md      ← bloque portable 300-500 palabras (para pegar en prompts)
<cliente>/marca/assets/               ← logo, favicon, fuentes, imágenes clave
```

La skill `manual-de-marca` toma como **entrada principal** el *Perfil Maestro del
Negocio* (si existe) más el material aportado (web, redes, logos, catálogos…), y
cae a una entrevista de descubrimiento cuando falta información.

## Schema (v1)

```jsonc
{
  "meta": {
    "cliente": "Nombre del negocio",
    "sector": "p. ej. clínica dental",
    "version": "1.0.0",
    "fecha": "2026-07-07",
    "idioma_principal": "es"
  },

  "verbal": {
    "mision": "…",
    "vision": "…",
    "valores": ["…", "…", "…"],
    "propuesta_valor": "Frase única de posicionamiento",
    "personalidad": ["cercana", "experta", "…"],   // 3-5 rasgos
    "arquetipo": "El Cuidador | El Sabio | …",       // arquetipo de marca
    "tono": {
      "somos": ["claro", "cálido", "directo"],
      "no_somos": ["frío", "técnico en exceso", "pomposo"],
      "reglas": [
        "Tuteamos al cliente.",
        "Frases cortas. Evitar jerga.",
        "Nunca prometer resultados médicos garantizados."
      ]
    },
    "mensajes_clave": ["…", "…", "…"],
    "tagline": "Lema corto",
    "palabras_prohibidas": ["barato", "…"],
    "glosario": { "término": "cómo lo llamamos siempre" }
  },

  "color": {
    "primary":   { "hex": "#0B5FFF", "on": "#FFFFFF" },  // "on" = color de texto encima
    "secondary": { "hex": "#0A2540", "on": "#FFFFFF" },
    "accent":    { "hex": "#FF6B35", "on": "#FFFFFF" },
    "neutral": {
      "ink":     "#0A0A0A",   // texto principal
      "body":    "#3F3F46",   // texto secundario
      "muted":   "#71717A",   // texto terciario
      "line":    "#E4E4E7",   // bordes / divisores
      "surface": "#FFFFFF",   // fondo tarjetas
      "bg":      "#F7F7F8"    // fondo página
    },
    "state": {
      "success": "#16A34A",
      "warning": "#D97706",
      "danger":  "#DC2626"
    },
    "dark": {                  // versión modo oscuro (opcional pero recomendada)
      "bg": "#0A0A0A", "surface": "#161616", "ink": "#FAFAFA",
      "body": "#D4D4D8", "line": "#27272A"
    }
  },

  "typography": {
    "heading": {
      "family": "Poppins",
      "fallback": "system-ui, sans-serif",
      "weights": [600, 700],
      "google_font": true
    },
    "body": {
      "family": "Inter",
      "fallback": "system-ui, sans-serif",
      "weights": [400, 500],
      "google_font": true
    },
    "scale": {                 // escala tipográfica (rem), base 16px
      "h1": "3.0", "h2": "2.25", "h3": "1.75", "h4": "1.25",
      "body": "1.0", "small": "0.875"
    },
    "line_height": { "heading": 1.15, "body": 1.6 },
    "letter_spacing_headings": "-0.02em"
  },

  "geometry": {
    "radius": { "sm": "6px", "md": "12px", "lg": "20px", "pill": "9999px" },
    "spacing_base": "8px",     // el sistema de espaciado es múltiplo de esto
    "container_max": "1200px",
    "shadow": {
      "sm": "0 1px 2px rgba(0,0,0,.06)",
      "md": "0 8px 24px rgba(0,0,0,.10)",
      "lg": "0 24px 60px rgba(0,0,0,.16)"
    },
    "border_width": "1px"
  },

  "imagery": {
    "estilo_foto": "luminoso, real, personas reales, nada de stock genérico",
    "estilo_ilustracion": "líneas finas, 2 colores de marca",
    "iconos": "Lucide (outline, 1.5px)",
    "prompt_ia_base": "Descripción reutilizable para generar imágenes IA coherentes"
  },

  "logo": {
    "principal": "assets/logo.svg",
    "isotipo": "assets/isotipo.svg",
    "favicon": "assets/favicon.svg",
    "clearspace": "Altura de la X del logo",
    "min_size_px": 24,
    "usos_incorrectos": ["no deformar", "no rotar", "no sombras"]
  },

  "social": {
    "instagram": "", "facebook": "", "linkedin": "",
    "tiktok": "", "youtube": "", "whatsapp": ""
  },

  "contacto": {
    "empresa": "", "telefono": "", "email": "",
    "direccion": "", "google_maps_place_id": "", "horario": ""
  }
}
```

## Cómo lo usan las skills

- **CSS**: se traduce a variables (`--color-primary`, `--font-heading`, `--radius-md`…).
- **Copy**: `verbal.tono`, `mensajes_clave` y `palabras_prohibidas` gobiernan TODA
  la redacción (web, blog, RRSS, emails).
- **Imagen IA**: `imagery.prompt_ia_base` se antepone a cada prompt de imagen.
- **Contacto/SEO local**: `contacto` y `social` alimentan footer, schema.org y GBP.
- **Contexto verbal reutilizable**: `resumen-marca.md` (sección 20 del brand book)
  y la sección 19 (*Guía para IAs*) se pegan como contexto en otras skills/prompts
  para que cualquier IA escriba con la voz de la marca.

> El brand book (`BRAND.md`) es un documento de marca puro: no habla de SEO,
> herramientas ni ventas. `brand-tokens.json` y `resumen-marca.md` son la plomería
> técnica que consumen las demás skills; no forman parte del entregable de marca.

## Versionado

`meta.version` sigue SemVer. Un cambio de color o tipografía = *minor*.
Un rebranding = *major*. Las skills deben tolerar `version` >= 1.0.0.
