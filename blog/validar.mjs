// validar.mjs · Evolution 360
// Comprueba que cada post listado en posts.json tiene su <slug>.html en disco
// (y su portada, si es un fichero local). Si falta algo, sale con código 1 y
// la Action falla avisando — así no se publica una referencia a un post fantasma.
// Uso:  node blog/validar.mjs        (desde la carpeta landing/)

import { readFileSync, existsSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

const here = dirname(fileURLToPath(import.meta.url)); // .../landing/blog
const data = JSON.parse(readFileSync(join(here, "posts.json"), "utf8"));
const posts = data.posts || [];

const fallos = [];
for (const p of posts) {
  if (!p.slug) { fallos.push(`Post sin 'slug': ${JSON.stringify(p)}`); continue; }
  const htmlPath = join(here, `${p.slug}.html`);
  if (!existsSync(htmlPath)) fallos.push(`Falta el HTML del post: blog/${p.slug}.html`);
  // La portada solo se valida si es una ruta local (no http)
  if (p.portada && !/^https?:\/\//.test(p.portada) && !existsSync(join(here, p.portada))) {
    fallos.push(`Falta la portada de '${p.slug}': blog/${p.portada}`);
  }
}

if (fallos.length) {
  console.error(`\n✗ Validación fallida · ${fallos.length} problema(s):`);
  for (const f of fallos) console.error(`  - ${f}`);
  console.error("\nAñade el fichero que falta o quita la entrada de posts.json.");
  process.exit(1);
}

console.log(`OK · ${posts.length} post(s) validados · todos tienen su .html y su portada.`);
