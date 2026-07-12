---
name: marca-desde-instagram
description: Entra en el Instagram público de un cliente con el navegador controlable, captura sus mejores fotos y las guarda en marca/assets/, y produce una lectura de marca en bruto (paleta de color dominante, estilo fotográfico, tono de los textos) lista para alimentar manual-de-marca y para nutrir landings y diagnósticos. Úsala cuando el usuario diga "saca las fotos de su Instagram", "captura el Instagram de X", "extrae la marca del Instagram", "necesito los assets del cliente", "qué fotos suyas usamos en la landing", o al arrancar un cliente cuya única presencia visible es Instagram. Es un ALIMENTADOR, no sustituye a manual-de-marca: le entrega materia prima.
---

# Marca desde Instagram

## Misión de la skill
Convertir el Instagram público de un cliente en **materia prima de marca usable**:
un puñado de sus mejores fotos guardadas en disco + una lectura honesta de su
identidad visual (color, estilo fotográfico, tono). Resuelve el hueco de tener un
cliente cuya única presencia cuidada vive en Instagram y no poder aprovecharla
porque el scraping clásico (WebFetch/Firecrawl) contra Instagram falla.

Es el paso "conseguir el material visual" que va **antes o dentro** de
`manual-de-marca`. No define la marca (eso lo hace `manual-de-marca`): le da los
ojos.

## Qué produce en `clientes/<cliente>/marca/`
1. **`assets/instagram/`** — las fotos seleccionadas, guardadas como `.jpg`, con
   nombre legible (`01-mechas-verano.jpg`), tamaño de origen.
2. **`assets/instagram/_captura.md`** — el índice de lo capturado: por cada foto,
   URL del post, caption, métricas si se vieron, y por qué entró (o por qué se
   descartó una).
3. **`lectura-marca-instagram.md`** — la lectura de marca en bruto: paleta de
   color dominante (con HEX), estilo fotográfico recurrente, temas, y tono/voz
   sacado de los captions. **Con nivel de confianza en cada afirmación.**
4. Opcional: un **borrador/actualización de `brand-tokens.json`** (solo la parte
   visual: `color` e `imagery`), marcado como provisional, para que
   `manual-de-marca` lo tome y lo cierre.

## Reglas de rigor (no negociables)
- **Solo lo que se ve.** No inventes colores, métricas, captions ni fechas. Lo que
  no se pueda leer en la captura se deja vacío o se marca `[no visible]`.
- **Confianza explícita** en la lectura: `[V]` comprobado en la captura,
  `[I]` inferido de indicios, `[H]` hipótesis a validar con el cliente. (Mismo
  código que usan los informes de la consultoría.)
- **Local y confidencial.** Las fotos se guardan **solo en la carpeta del cliente**.
  Nunca se suben a un host externo (claude.ai/Artifacts, web). Respeta la regla de
  no publicar datos de cliente.
- **Reels y vídeos**: la miniatura (portada) sirve como imagen; no intentes
  descargar el vídeo. Si un post es carrusel, la portada representa el post.
- **Fotos de personas**: son clientas reales. Se usan para leer estilo y como
  posible asset de la landing del propio cliente, nunca fuera de su proyecto.

## Entradas
- El **handle** de Instagram del cliente (p. ej. `munay_hairsalon`). Si no lo
  tienes, míralo en `marca/brand-tokens.json` → `social.instagram`, en el Perfil
  Maestro, o pídeselo al usuario.
- El **slug del cliente** para saber dónde escribir.
- Requisito técnico: **navegador controlable disponible** (el Browser de la app,
  `mcp__Claude_Browser__*`). Si no está disponible, dilo — no simules capturas.

---

## Flujo de trabajo

### Paso 0 — Preparar
Confirma cliente + handle. Crea `clientes/<cliente>/marca/assets/instagram/`.
Comprueba si ya existe `_captura.md` de una pasada anterior (para no repetir).

### Paso 1 — Abrir el perfil y comprobar acceso
Abre `https://www.instagram.com/<handle>/` con `preview_start` (in-app Browser).
Verifica con `get_page_text` que carga el perfil (título con el nombre, bio,
nº de publicaciones/seguidores). El perfil **público** se ve sin login.

> Si en vez del perfil aparece un muro de inicio de sesión (texto tipo "Inicia
> sesión para ver"), es un perfil privado o Instagram está forzando login: pásate
> al navegador real con sesión (Chrome MCP, `mcp__claude-in-chrome__*`) o pide al
> usuario que lo abra él. No te quedes bloqueado en silencio: dilo.

### Paso 2 — Recorrer la parrilla y leer los posts
- `read_page` (filter `all`) para listar los `article` con: URL del post
  (`/p/…` o `/reel/…`), `image` (miniatura) y `heading`/`generic` (caption).
- Haz **scroll** (`computer` scroll down, o `javascript_exec` con
  `window.scrollBy`) para cargar más posts. La parrilla carga ~12 por tanda; con
  2-4 scrolls tienes 30-50, suficiente para elegir.
- Con JS recoge la lista limpia (evita depender de screenshots, que pueden
  colgarse en perfiles pesados):
  ```js
  [...document.querySelectorAll('main article a[href*="/p/"], main article a[href*="/reel/"]')]
    .map(a => { const img = a.querySelector('img');
      return { url: a.href, src: img?.currentSrc || img?.src || '',
               caption: (img?.alt||'').trim(), w: img?.naturalWidth, h: img?.naturalHeight }; })
    .filter(x => x.src);
  ```

### Paso 3 — Seleccionar las mejores (criterio: calidad + marca)
Lee `references/seleccion-fotos.md`. En resumen, quédate con las fotos que sean
**nítidas, bien compuestas y coherentes con la identidad** (las que un cliente
enseñaría con orgullo y sirven en una landing), descarta capturas borrosas, memes,
pantallazos de texto y ruido. Objetivo: **6-12 "hero assets"**, no un volcado.
Si el usuario pidió el criterio de popularidad, entra en cada post a leer likes;
por defecto NO hace falta (el criterio es calidad+marca y se juzga a ojo).

### Paso 4 — Guardar las fotos elegidas
Descarga cada imagen seleccionada a `assets/instagram/` con nombre legible. Método
robusto (usa la sesión del propio navegador, evita 403 del CDN): en la página,
convierte cada `src` a base64 y pásalo al helper que lo escribe a disco.
Ver `references/guardar-imagenes.md` para el procedimiento exacto y el script
`scripts/guardar-imagenes.ps1`. Escribe también `_captura.md` (índice + motivos).

### Paso 5 — Leer la marca
Lee `references/lectura-de-marca.md` y produce `lectura-marca-instagram.md`:
- **Paleta**: 3-6 colores dominantes del conjunto, con HEX aproximado y dónde
  aparecen (fondos, ropa, producto, gráficos). Distingue color de marca vs. color
  circunstancial.
- **Estilo fotográfico**: luz (natural/estudio), encuadre, fondo, edición/filtro,
  presencia de texto en imagen, protagonista (persona/producto/resultado).
- **Temas y formato**: qué publican (antes/después, resultados, tips, humor…) y
  reels vs. foto.
- **Tono/voz**: sácalo de los captions reales (cercano, con humor, técnico…),
  citando 2-3 captions como evidencia.
- Cada bloque con `[V]/[I]/[H]`.

### Paso 6 — Handoff a manual-de-marca
Nota para el consultor (no va al cliente): el material visual está listo. Si aún no
hay `brand-tokens.json`, ofrece arrancar `manual-de-marca`, que tomará esta lectura
y los assets. Si ya existe, ofrece **actualizar** su parte visual (`color`,
`imagery.prompt_ia_base`, estilo fotográfico) con lo hallado, marcando lo nuevo
como provisional hasta validar con el cliente. Nunca sobrescribas a ciegas un
brand-tokens ya validado: propone el diff.

### Paso 7 — Parar y reportar
Resumen corto: cuántas fotos capturadas y cuáles, paleta detectada, tono, y qué
falta por validar. No sigas a otra fase sin que el usuario lo pida.

---

## Antipatrones (no hagas esto)
- Volcar las 143 fotos "por si acaso". Selecciona.
- Inventar HEX exactos: son aproximados salvo que midas el píxel.
- Dar por confirmada la marca. Esta skill produce una **lectura**, la valida el
  cliente vía `manual-de-marca`.
- Subir las fotos del cliente a ningún sitio para "analizarlas mejor". Se leen en
  local.
- Bloquearte si Instagram pide login: cambia de navegador o avisa.
