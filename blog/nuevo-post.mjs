// nuevo-post.mjs · Evolution 360
// Crea un artículo del blog desde la plantilla EN UN COMANDO: rellena el SEO,
// inyecta el cuerpo, lo añade a posts.json y regenera sitemap.xml + feed.xml.
// El artículo es la PIEZA MADRE del circuito (blog → redes).
//
// Uso:
//   node blog/nuevo-post.mjs blog/_ejemplo-campana.json     (desde landing/)
//   node nuevo-post.mjs _ejemplo-campana.json               (desde landing/blog/)
//
// El JSON de entrada usa el bloque "articulo" (ver _ejemplo-campana.json). Campos:
//   slug, titulo, titulo_corto, seccion, descripcion, tags[], lectura, fecha,
//   fecha_legible, entradilla, cuerpo_html, [portada_img], [destacado]
//
// NO hace git push: crear el .html es local; publicar (git push) es el gate humano.

import { readFileSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join, resolve } from "node:path";
import { execSync } from "node:child_process";

const here = dirname(fileURLToPath(import.meta.url)); // .../landing/blog

const entradaPath = process.argv[2];
if (!entradaPath) {
  console.error("Falta el JSON de campaña. Uso: node nuevo-post.mjs <campana.json>");
  process.exit(1);
}
const campana = JSON.parse(readFileSync(resolve(entradaPath), "utf8"));
const a = campana.articulo || campana; // acepta el fichero de campaña o solo el artículo

const req = ["slug", "titulo", "descripcion", "cuerpo_html"];
for (const k of req) if (!a[k]) { console.error(`Falta el campo obligatorio: ${k}`); process.exit(1); }

// Valores por defecto sensatos
a.titulo_corto ||= a.titulo.slice(0, 48);
a.seccion ||= "IA para pymes";
a.tags ||= [];
a.lectura ||= Math.max(3, Math.round(a.cuerpo_html.split(/\s+/).length / 200));
a.fecha ||= new Date().toISOString().slice(0, 10);
a.fecha_legible ||= new Date(a.fecha + "T12:00:00Z").toLocaleDateString("es-ES",
  { day: "numeric", month: "long", year: "numeric" });
a.entradilla ||= a.descripcion;

// ---------- 1. Construir el .html desde la plantilla ----------
let html = readFileSync(join(here, "_PLANTILLA-post.html"), "utf8");

// Quitar TODOS los comentarios HTML de la plantilla (son notas de autor con {{...}})
html = html.replace(/<!--[\s\S]*?-->\n?/g, "");

const meta = {
  "{{TITULO}}": a.titulo,
  "{{TITULO_CORTO}}": a.titulo_corto,
  "{{DESCRIPCION_150_CARACTERES}}": a.descripcion,
  "{{SLUG}}": a.slug,
  "{{FECHA}}": a.fecha,
  "{{FECHA_LEGIBLE}}": a.fecha_legible,
  "{{LECTURA}}": String(a.lectura),
  "{{SECCION}}": a.seccion,
  "{{TAG_PRINCIPAL}}": a.tags[0] || a.seccion,
};
for (const [k, v] of Object.entries(meta)) html = html.split(k).join(v);

// Imagen de cabecera: si hay foto, cambia el <svg> por <img>
if (a.portada_img) {
  html = html.replace(/<svg viewBox="0 0 760 230"[\s\S]*?<\/svg>/,
    `<img src="${a.portada_img}" alt="${(a.descripcion || "").replace(/"/g, "&quot;")}">`);
}
html = html.replace("{{descripción de la imagen}}", (a.descripcion || "").replace(/"/g, "&quot;"));

// Reemplazar el cuerpo de ejemplo (de <p class="lead"> hasta antes del CTA) por el real
const cuerpo = `<p class="lead">${a.entradilla}</p>\n\n${a.cuerpo_html}\n`;
html = html.replace(/<p class="lead">[\s\S]*?(?=\s*<div class="cta-box">)/, cuerpo);

// Gancho del CTA final (default de marca, sobreescribible con a.cta_titulo)
html = html.replace("{{Gancho de llamada a la acción}}",
  a.cta_titulo || "¿Y si tu negocio pudiera hacer esto solo?");

const destino = join(here, `${a.slug}.html`);
writeFileSync(destino, html, "utf8");

// ---------- 2. Añadir/actualizar en posts.json ----------
const postsPath = join(here, "posts.json");
const data = JSON.parse(readFileSync(postsPath, "utf8"));
const entrada = {
  slug: a.slug,
  titulo: a.titulo,
  descripcion: a.descripcion,
  fecha: a.fecha,
  actualizado: a.fecha,
  tags: a.tags,
  lectura_min: a.lectura,
  portada: a.portada || "img/empresa-agentica.svg",
  destacado: a.destacado ?? false,
};
const i = data.posts.findIndex((p) => p.slug === a.slug);
if (i >= 0) data.posts[i] = { ...data.posts[i], ...entrada };
else data.posts.push(entrada);
writeFileSync(postsPath, JSON.stringify(data, null, 2) + "\n", "utf8");

// ---------- 3. Regenerar sitemap.xml + feed.xml ----------
execSync(`node "${join(here, "generar.mjs")}"`, { stdio: "inherit" });

console.log(`\nOK · artículo creado: blog/${a.slug}.html`);
console.log("Revísalo, y cuando lo apruebes publícalo:");
console.log(`  git add . && git commit -m "Blog: ${a.slug}" && git push`);
