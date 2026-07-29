# Blog de Evolution 360

Blog estático dentro del repo de la landing. **0 €**: vive en GitHub Pages, mismo dominio
que la web (`https://evolution360ai.github.io/consultoria-evolution/blog/`). Sin dominio
propio hasta que el negocio gane su primer euro.

## Qué hay montado

| Archivo | Para qué |
|---|---|
| `index.html` | Portada del blog. Lee `posts.json` y pinta las tarjetas sola. |
| `posts.json` | **Fuente única.** La lista de artículos (título, fecha, tags, resumen). |
| `_PLANTILLA-post.html` | Plantilla para cada artículo nuevo (SEO + JSON-LD ya puestos). |
| `que-es-una-empresa-agentica.html` | Primer artículo (semilla, editable). |
| `generar.mjs` | Regenera `sitemap.xml` (raíz) y `feed.xml` (RSS) desde `posts.json`. |
| `../robots.txt`, `../sitemap.xml`, `feed.xml` | SEO: buscadores encuentran e indexan todo. |

SEO ya incluido en cada artículo: `<title>`/description optimizados, canonical, Open Graph
+ Twitter Card (para que se vea bien al compartir en redes), datos estructurados
`BlogPosting` + `BreadcrumbList` (rich results de Google), sitemap y RSS.

## Publicar un artículo nuevo (5 min)

1. **Copia** `_PLANTILLA-post.html` → `blog/<slug>.html` (`<slug>` = título en minúsculas con guiones).
2. **Reemplaza** todos los `{{...}}` y escribe el cuerpo dentro de `<article>`.
3. **Añade** su entrada en `posts.json` (copia un bloque de `"posts"` y edítalo).
4. **Regenera** sitemap + RSS:
   ```bash
   node blog/generar.mjs
   ```
5. **Sube** a GitHub Pages:
   ```bash
   git add . && git commit -m "Blog: nuevo artículo <slug>" && git push
   ```
6. (1ª vez) En Google Search Console, envía el sitemap:
   `https://evolution360ai.github.io/consultoria-evolution/sitemap.xml`

## El circuito completo: conocimiento → blog → Instagram → LinkedIn

El plan que abre esto: **un artículo del blog es la pieza madre**, y de ahí salen las redes.

1. **Conocimiento → artículo** (blog): coges un tema de tu conocimiento real (soluciones
   agénticas, presentaciones) y lo conviertes en un artículo con la plantilla.
2. **Artículo → Instagram + LinkedIn**: dispara la skill **`remix`** sobre el artículo
   → te saca el carrusel de Instagram y el post de LinkedIn con la voz de marca.
   Las imágenes/portada, con **`evolution-asset`** (deriva del brand-tokens real).
3. **Instagram Ads**: el mismo carrusel/creatividad se promociona; el enlace de la bio
   o del anuncio apunta al artículo del blog → tráfico a la web → diagnóstico gratis.

> Regla de marca: la IA es el **motor**, no el producto. Se vende transformación del
> negocio, no herramientas. (ver `marca/brand-tokens.json` y `marca/posicionamiento.md`)

## Ver el blog en local

```bash
node serve-evolution.mjs
```
y abre `http://localhost:PUERTO/blog/`.
