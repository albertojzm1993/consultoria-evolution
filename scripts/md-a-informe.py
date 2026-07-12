#!/usr/bin/env python
"""
Convierte un entregable en Markdown al HTML de la plantilla de informe de marca,
listo para pasar por scripts/generar-pdf.ps1.

Qué hace, además de un md->HTML normal (tablas, listas, atributos):
- Quita el PRIMER título de nivel 1 (se usa como título de portada); los "# PARTE x"
  posteriores se conservan como divisores del cuerpo.
- Convierte los bloques ```flow en DIAGRAMAS DE CAJAS (una caja por línea, conectadas
  por flechas; primera caja = inicio, última = resultado). Ideal para las cadenas de
  causa-efecto del diagnóstico. Las líneas de flecha sueltas (↓, ->, →) se ignoran.
- Respeta el atributo {: .nueva-pagina } en un encabezado para forzar salto de página
  antes de él (útil en "# PARTE 2 ..." y "# PARTE 3 ..." del diagnóstico).
- Deja SIN rellenar los marcadores de marca ({{tokens_css}}, {{google_fonts_url}},
  {{logo_html}}, {{logo_header_html}}): los inyecta generar-pdf.ps1 desde brand-tokens.json.

Uso:
  python scripts/md-a-informe.py <md> <html_salida> <css> <plantilla_html> \
      --cliente "M8" --titulo "..." --subtitulo "..." --fase "..." --sector "..." \
      --proyecto "..." --fecha "..." --version "1.0" --consultora "Evolution S.L" [--contacto "..."]

Requisitos: pip install markdown  (ver [[entorno-windows-usuario]]).
"""
import argparse
import html as _html
import pathlib
import re

import markdown


def build_flow(m):
    """Convierte el texto de un bloque ```flow en cajas conectadas por flechas."""
    raw = _html.unescape(m.group(1))
    steps = [s.strip() for s in raw.split("\n")]
    steps = [s for s in steps if s and s not in ("↓", "->", "→", "|", "v", "V", "▼")]
    parts, n = [], len(steps)
    for i, step in enumerate(steps):
        cls = "flow__node"
        if i == 0:
            cls += " flow__node--start"
        if i == n - 1:
            cls += " flow__node--end"
        parts.append(f'<div class="{cls}">{_html.escape(step)}</div>')
        if i < n - 1:
            parts.append('<div class="flow__arrow"></div>')
    return '<div class="flow">' + "".join(parts) + "</div>"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("md")
    ap.add_argument("html_out")
    ap.add_argument("css")
    ap.add_argument("tmpl")
    for opt in ("cliente", "titulo", "subtitulo", "fase", "sector",
                "proyecto", "fecha", "version", "consultora", "contacto"):
        ap.add_argument(f"--{opt}", default="")
    a = ap.parse_args()

    md_text = pathlib.Path(a.md).read_text(encoding="utf-8")

    # Quitar solo el primer "# Título" (portada); conservar los "# PARTE x".
    lines, out, stripped = md_text.splitlines(), [], False
    for ln in lines:
        if not stripped and ln.startswith("# "):
            stripped = True
            continue
        out.append(ln)
    body_md = "\n".join(out)

    html_body = markdown.markdown(
        body_md,
        extensions=["tables", "attr_list", "sane_lists", "md_in_html", "fenced_code"],
    )
    html_body = re.sub(
        r'<pre><code class="language-flow">(.*?)</code></pre>',
        build_flow, html_body, flags=re.DOTALL,
    )

    tmpl = pathlib.Path(a.tmpl).read_text(encoding="utf-8")
    css_uri = pathlib.Path(a.css).resolve().as_uri()
    tmpl = tmpl.replace('href="informe.css"', f'href="{css_uri}"')

    repl = {
        "{{titulo}}": a.titulo, "{{subtitulo}}": a.subtitulo, "{{fase}}": a.fase,
        "{{cliente}}": a.cliente, "{{sector}}": a.sector, "{{proyecto}}": a.proyecto,
        "{{fecha}}": a.fecha, "{{version}}": a.version, "{{consultora}}": a.consultora,
        "{{contacto}}": a.contacto, "{{contenido_html}}": html_body,
    }
    for k, v in repl.items():
        tmpl = tmpl.replace(k, v)

    pathlib.Path(a.html_out).write_text(tmpl, encoding="utf-8")
    print("HTML escrito:", a.html_out)


if __name__ == "__main__":
    main()
