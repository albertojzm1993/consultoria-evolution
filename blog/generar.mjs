// generar.mjs · Evolution 360
// Regenera sitemap.xml (raíz del sitio) y feed.xml (RSS del blog) a partir de posts.json.
// Uso:  node blog/generar.mjs        (desde la carpeta landing/)
//   o:  node generar.mjs             (desde landing/blog/)
// No necesita dependencias. Ejecutar tras añadir o editar un post en posts.json.

import { readFileSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

const here = dirname(fileURLToPath(import.meta.url));      // .../landing/blog
const root = join(here, "..");                              // .../landing

const data = JSON.parse(readFileSync(join(here, "posts.json"), "utf8"));
const BASE = data.meta.base.replace(/\/$/, "");
const posts = [...data.posts].sort((a, b) => b.fecha.localeCompare(a.fecha));

// Páginas estáticas del sitio (además de los posts). Edita esta lista si añades páginas.
const estaticas = [
  { loc: `${BASE}/`,                         prio: "1.0", freq: "weekly" },
  { loc: `${BASE}/como-funciona.html`,       prio: "0.7", freq: "monthly" },
  { loc: `${BASE}/blog/`,                    prio: "0.9", freq: "weekly" },
];

const esc = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
const hoy = posts[0]?.actualizado || posts[0]?.fecha || data.meta.fecha || "2026-07-29";

// ---------- sitemap.xml ----------
const urls = [
  ...estaticas.map((p) => `  <url>\n    <loc>${p.loc}</loc>\n    <lastmod>${hoy}</lastmod>\n    <changefreq>${p.freq}</changefreq>\n    <priority>${p.prio}</priority>\n  </url>`),
  ...posts.map((p) => `  <url>\n    <loc>${BASE}/blog/${p.slug}.html</loc>\n    <lastmod>${p.actualizado || p.fecha}</lastmod>\n    <changefreq>monthly</changefreq>\n    <priority>0.8</priority>\n  </url>`),
];
const sitemap = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls.join("\n")}\n</urlset>\n`;
writeFileSync(join(root, "sitemap.xml"), sitemap, "utf8");

// ---------- feed.xml (RSS 2.0) ----------
const rssDate = (iso) => new Date(iso + "T09:00:00Z").toUTCString();
const items = posts.map((p) => `    <item>
      <title>${esc(p.titulo)}</title>
      <link>${BASE}/blog/${p.slug}.html</link>
      <guid isPermaLink="true">${BASE}/blog/${p.slug}.html</guid>
      <description>${esc(p.descripcion)}</description>
      <pubDate>${rssDate(p.fecha)}</pubDate>
${(p.tags || []).map((t) => `      <category>${esc(t)}</category>`).join("\n")}
    </item>`).join("\n");
const rss = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>${esc(data.meta.titulo_blog)}</title>
    <link>${BASE}/blog/</link>
    <atom:link href="${BASE}/blog/feed.xml" rel="self" type="application/rss+xml"/>
    <description>${esc(data.meta.descripcion_blog)}</description>
    <language>es</language>
    <lastBuildDate>${rssDate(hoy)}</lastBuildDate>
${items}
  </channel>
</rss>
`;
writeFileSync(join(here, "feed.xml"), rss, "utf8");

console.log(`OK · ${posts.length} post(s) · sitemap.xml y feed.xml regenerados.`);
