# Referencia — Del brand-tokens.json al CSS

Cómo traducir la marca a un sistema de diseño en código. Regla: **ningún valor
visual se hardcodea**; todo sale de variables CSS pobladas desde `brand-tokens.json`.

## 1. Variables raíz (`:root`)
Mapea cada token a una variable. Ejemplo de correspondencia:

| brand-tokens.json | Variable CSS |
|---|---|
| `color.primary.hex` / `.on` | `--color-primary` / `--color-on-primary` |
| `color.secondary`, `color.accent` | `--color-secondary`, `--color-accent` |
| `color.neutral.*` | `--ink`, `--body`, `--muted`, `--line`, `--surface`, `--bg` |
| `color.state.*` | `--success`, `--warning`, `--danger` |
| `typography.heading.family` | `--font-heading` (con fallback) |
| `typography.body.family` | `--font-body` |
| `typography.scale.*` | `--fs-h1 … --fs-small` (en rem) |
| `geometry.radius.*` | `--radius-sm/md/lg/pill` |
| `geometry.spacing_base` | `--space` (base para la escala) |
| `geometry.shadow.*` | `--shadow-sm/md/lg` |
| `geometry.container_max` | `--container` |

## 2. Modo oscuro
Usa `color.dark` en `@media (prefers-color-scheme: dark)` y/o
`:root[data-theme="dark"]`. Redefine `--bg`, `--surface`, `--ink`, `--body`,
`--line`. Ofrece un toggle si el cliente lo quiere.

## 3. Escala de espaciado (base 8)
Deriva utilidades del `--space` (8px): `--space-1:8px … --space-16:128px`.
Úsalas para paddings de sección y gaps. Da ritmo consistente.

## 4. Tipografía
- Cargar Google Fonts con `preconnect` + `display=swap`.
- `--fs-*` en `rem`; usa `clamp()` para fluidez (p. ej.
  `h1: clamp(2.25rem, 5vw, 4.5rem)`).
- `line-height` de `typography.line_height`; `letter-spacing` negativo en
  titulares grandes.

## 5. Componentes base (todos con tokens)
- **Botones**: `.btn` (primario), `.btn--ghost` (secundario/outline). Alto ~48px,
  padding con `--space`, `--radius`, transición, estados `:hover/:active/:focus-visible`.
  Texto siempre con el `on` correspondiente (contraste AA garantizado).
- **Contenedor**: `.container { max-width: var(--container); margin-inline:auto;
  padding-inline: clamp(20px, 5vw, 40px); }`.
- **Sección**: `.section { padding-block: clamp(56px, 9vw, 128px); }`.
- **Tarjeta**: `--surface`, `--line`, `--radius-lg`, `--shadow-sm`, hover eleva a
  `--shadow-md`.
- **Grid**: utilidades `.grid-2 / .grid-3` con `gap: var(--space-4)` y colapso a
  1 columna en móvil.

## 6. Responsive (mobile-first)
Breakpoints: ~640 / 768 / 1024 / 1280. Diseña primero móvil y amplía. Nada de
anchos fijos; usa `%`, `fr`, `clamp`, `min()/max()`. Imágenes `max-width:100%`.

## 7. Movimiento
- Transiciones de 150–250ms en hover/focus.
- Revelado al scroll con `IntersectionObserver` (añade clase `.in`), opacidad +
  translateY corto.
- **Siempre** envuelto en `@media (prefers-reduced-motion: no-preference)`.

## 8. Accesibilidad (recordatorio)
- Contraste AA (ya viene de los tokens con su `on`).
- `:focus-visible` con outline claro (usa `--color-primary`).
- Landmarks (`header/nav/main/footer`), headings jerárquicos, `alt` en imágenes,
  labels en formularios, `aria-expanded` en acordeones/menú.

## 9. Rendimiento
- CSS en un solo archivo, mobile-first, sin frameworks pesados.
- `preconnect`/`preload` de fuentes; `font-display: swap`.
- Imágenes `loading="lazy"`, `width`/`height` para evitar CLS, formato moderno.
- JS mínimo y `defer`.

> El archivo `templates/starter/styles.css` ya implementa esta base con variables.
> Parte de ahí y sustituye los valores por los del `brand-tokens.json` del cliente.
