# Sistema de Informes PDF de Marca

Contrato compartido: **cada documento destinado a un cliente se entrega también
como un PDF corporativo completamente adaptado a su identidad de marca.** El
cliente debe sentir que el documento ha sido diseñado específicamente para su
empresa y que forma parte de su imagen corporativa.

> Regla maestra: **nunca un diseño genérico.** Si alguien quitara el texto y solo
> viera el diseño, debería reconocer la marca por su logo, colores, tipografía,
> imágenes y estilo. El PDF debe poder confundirse con material oficial del cliente.

No se duplica lógica: todas las skills usan el mismo sistema.

## Piezas del sistema
- `plantillas/informe/plantilla-informe.html` — esqueleto (portada + índice + contenido).
- `plantillas/informe/informe.css` — diseño print-ready A4 dirigido por tokens.
- `scripts/generar-pdf.ps1` — convierte HTML→PDF (WeasyPrint si está; si no, Edge/Chrome).
- `plantillas/informe/ejemplo-informe.{html,pdf}` — muestra de referencia.

---

## Paso 0 — Analizar la identidad visual (antes de maquetar)
Antes de nada, estudia la identidad del cliente con TODO lo disponible: logotipo,
colores corporativos, tipografía, web, redes, material gráfico, fotografías, estilo
de comunicación, público objetivo, valores y personalidad de marca. La fuente
principal es `clientes/<cliente>/marca/brand-tokens.json` (y `BRAND.md`); en fases
tempranas, lo que haya recogido el Descubrimiento.

**Adapta el documento a la personalidad de la marca:**
- Marca moderna → documento moderno. Elegante → elegante. Minimalista → minimalista.
- Deportiva → dinamismo. Premium → exclusividad y aire.
El tono visual (espaciados, formas, contraste, uso de foto) debe reflejar esa
personalidad, no solo cambiar el color primario.

## Paso 1 — Escribir el entregable en `.md`
El documento de trabajo, como siempre.

## Paso 1.5 — Humanizar el texto (obligatorio antes de maquetar)
Pasa el cuerpo del documento por la skill **`humanizer`** para que los textos suenen
a persona: quita rayas usadas como inciso, tríadas forzadas, relleno, gerundios de
adorno y lenguaje promocional. Condiciones (ver también §11 del `CLAUDE.md`):
- **La voz de marca (`brand-tokens.json`: `tono`, `glosario`, `palabras_prohibidas`)
  manda sobre el humanizer.** No metas palabras prohibidas ni rompas el glosario.
- Es español: quita la raya-inciso (tell IA), pero conserva la raya de las listas de
  definición (`**Término** — descripción`) y las etiquetas `[V]/[I]/[?]`.
- No aplanes las fichas a párrafos; humaniza la prosa, respeta la estructura.
- No cambia datos, solo la forma. El `.md` humanizado es la fuente del HTML.

## Paso 2 — Volcar en la plantilla HTML (con la identidad del cliente)

**Forma recomendada: usa el conversor `scripts/md-a-informe.py`** (md → HTML de la plantilla).
Hace el md→HTML, quita el primer `# Título` (va a portada), monta los diagramas de caja
(bloques ```flow), respeta los saltos de página (`{: .nueva-pagina }`) y rellena los datos,
dejando los marcadores de marca para el Paso 3:

```powershell
python scripts/md-a-informe.py "<ruta>/<archivo>.md" "<ruta>/<archivo>.html" `
  "plantillas/informe/informe.css" "plantillas/informe/plantilla-informe.html" `
  --cliente "M8" --titulo "..." --subtitulo "..." --fase "Fase 3 · ..." `
  --sector "..." --proyecto "..." --fecha "9 de julio de 2026" --version "1.0" `
  --consultora "Evolution S.L"
```

**Convenciones de Markdown que entiende el conversor:**
- **Diagramas de caja** (cadenas causa-efecto, flujos): bloque ```` ```flow ```` con **un paso
  por línea** (sin flechas; el conversor las pinta). La primera caja se marca como inicio y la
  última como resultado (relleno de color). Mucho mejor que dibujar flechas en texto.
- **Salto de página antes de un encabezado**: añade `{: .nueva-pagina }` al final del título
  (p. ej. los divisores `# PARTE 2 · …` y `# PARTE 3 · …` del diagnóstico, para que no arranquen
  a media página). Los `# PARTE x` salen en **negro** (no en color de marca).

Si lo montas a mano en vez de con el script, `plantilla-informe.html` y rellena:
- **Datos**: `{{titulo}}`, `{{subtitulo}}`, `{{fase}}`, `{{cliente}}`, `{{sector}}`,
  `{{proyecto}}`, `{{fecha}}`, `{{version}}`, `{{consultora}}`, `{{contacto}}`.
- **Contenido**: `{{contenido_html}}` = cuerpo en HTML semántico (`<h2>`, `<h3>`,
  `<p>`, `<ul>`, `<table>`, cajas de marca, diagramas `.flow`). El **índice se genera solo**.
- **Identidad** (`{{tokens_css}}`): inyecta un `:root{…}` con TODOS los tokens del
  `brand-tokens.json`: `--color-primary/-secondary/-accent`, `--ink`, `--soft`,
  `--font-heading`, `--font-body`, y si hay foto de portada `--cover-img`.
- **Fuentes** (`{{google_fonts_url}}`): la URL de Google Fonts más parecida a la
  tipografía de la marca (titulares + cuerpo).
- **Logo**: `{{logo_html}}` (portada) y `{{logo_header_html}}` (cabecera) con el
  logo del cliente; si no hay, el nombre en texto (`cover__logo--text`).

## Paso 3 — Convertir a PDF (con la marca aplicada automáticamente)
Deja los marcadores `{{tokens_css}}`, `{{google_fonts_url}}` y `{{logo_html}}` sin
rellenar y pásale el `brand-tokens.json`: el script **inyecta solo** los colores,
tipografías y logo del cliente (garantiza que el PDF use SIEMPRE su identidad).
```powershell
./scripts/generar-pdf.ps1 -Html "<ruta>/<archivo>.html" `
                          -Brand "clientes/<cliente>/marca/brand-tokens.json" `
                          -Out   "<ruta>/<archivo>.pdf"
```
Si aún no hay `brand-tokens.json` (fases tempranas), omite `-Brand` y opcionalmente
pasa `-Cliente "Nombre"` para el logo de texto; se usará el diseño neutro.
Guarda el `.pdf` junto al `.md`, menciónalo al usuario. El `.html` es intermedio.

---

## Identidad visual del documento (qué adaptar)
Colores principales, secundarios y de apoyo · tipografía similar · estilo gráfico ·
iconografía · espaciados · formas · bordes · separadores · cabeceras · fondos.
Todo coherente con la web del cliente. **Nunca mezcles estilos gráficos distintos.**

### Portada (por defecto: foto a pantalla completa)
La plantilla usa `class="cover--foto"`: **foto de portada a sangre completa** con
overlay del color de marca, logo, kicker de fase, título grande y ficha del
proyecto. La foto se toma de `clientes/<cliente>/marca/assets/portada.(jpg|png|webp)`
(el script la inyecta automáticamente en `--cover-img`). Usa fotos reales de sus
instalaciones/equipo/servicios, o del sector con el mismo estilo. **Si no hay foto,
cae a un degradado de la paleta** (sigue premium). Alternativas de estilo (bandas
de color, minimalista, lateral) disponibles cambiando la clase de `.cover`.

### Cabecera y pie (en cada página)
- **Cabecera**: logo del cliente + proyecto/título.
- **Pie**: número de página + nombre de la empresa + fecha + contacto (si procede).

### Contenido
Títulos con el color principal · subtítulos con el secundario · tablas con cabecera
en color principal y filas limpias · iconos del mismo estilo · separadores
coherentes · **mucho espacio en blanco**.

### Cajas destacadas (componentes de marca reutilizables)
Usa las clases del CSS, recoloreadas con la paleta del cliente:
- `box--insight` (Insight) · `box--oportunidad` (Oportunidad) · `box--riesgo`
  (Riesgo) · `box--accion` (Acción recomendada) · `box--prioridad` (Prioridad).
- Para hallazgos de auditoría: etiquetas `tag--critico/importante/recomendable`.
- Cifras clave: bloques `.kpi`.

### Imágenes y gráficos
- Prioriza fotos reales del cliente (instalaciones, equipo, productos, servicios);
  si no hay, imágenes del sector con el mismo estilo estético de la marca. Con `alt`.
- **Todos los gráficos usan EXCLUSIVAMENTE la paleta corporativa.** Nunca colores
  aleatorios.

---

## Consistencia (verificar antes de entregar)
- [ ] Toda la paleta pertenece a la identidad de la marca; sin elementos ajenos.
- [ ] Tipografía coherente en todo el documento.
- [ ] Imágenes e iconos respetan el tono visual de la empresa (un solo estilo).
- [ ] Portada, cabecera y pie reflejan la marca; hay logo y número de página.
- [ ] Índice generado y correcto; buen uso del espacio en blanco.
- [ ] El documento **podría confundirse con material oficial del cliente**.
- [ ] Coherencia con la voz de marca (glosario y palabras prohibidas del brand-tokens).

## Regla de marca según la fase
1. **Con `brand-tokens.json`** (tras `manual-de-marca`): identidad completa
   (logo, colores, tipografías, foto). Es lo ideal.
2. **Sin marca aún** (fases tempranas): usa el logo/colores del cliente si el
   Descubrimiento ya los recopiló en `marca/assets/`; si no, defaults profesionales
   neutros + nombre en texto, y el logo/colores de la **consultora** (Alberto) si
   están definidos. El diseño sigue siendo cuidado, nunca genérico-descuidado.

## Resultado esperado
Un informe de consultoría de alta calidad, integrado con la identidad visual del
cliente, listo para enviarse sin rediseño, que refuerza la percepción de
profesionalidad y valor. Debe parecer diseñado por un estudio de branding.

## Reglas aprendidas (feedback real de cliente)
- **Títulos sin número manual.** Los `<h2>` del contenido se numeran solos (número único, en
  color de marca) tanto en el índice como en el cuerpo. Si el `.md` numera a mano (`## 1. …`),
  el número sale **duplicado**. Escribe los títulos sin número.
- **Nunca nombres herramientas internas en el cuerpo del cliente.** No escribas "Firecrawl",
  "brand-tokens.json" ni nombres de scripts/skills. Di **"nuestro estudio de mercado"** o
  **"el análisis de la competencia"** en vez de la herramienta con que se obtuvo el dato.
- **Tablas largas parten entre páginas.** El CSS ya hace que una tabla empiece bajo su título y
  **continúe en la página siguiente** (partiendo entre filas, con la cabecera repetida), en vez
  de saltar entera y dejar hueco. No fuerces `page-break` en tablas.
- **Salto de página a voluntad:** añade `{: .nueva-pagina }` al final de **cualquier título**
  que deba empezar en página nueva (no solo los `# PARTE x`; p. ej. una sección larga que si no
  quedaría colgando a media página).
- **Logo, nunca texto, en portada.** Usa el logo real del cliente. La portada es oscura (overlay
  de marca) → el script prioriza el **logo inverso/blanco** (`logo.inverso` en brand-tokens; si
  no existe, crea uno recoloreando el logo a blanco conservando el alfa). La cabecera (fondo
  claro) usa `logo.principal`.
- **"Preparado por" = la consultora** (Evolution S.L), no el cliente.
- **Ficha de portada:** etiquetas (Cliente, Sector, Proyecto…) en **negrita**, poco espacio entre
  filas, y la línea de confidencialidad **pegada abajo**.
- **Paleta a la vista:** cuando el documento describa la identidad, incluye las muestras de color
  como **chips visuales** (bloque HTML con `background` en cada HEX), no como texto.
- **Contenido para el cliente, no para IA.** No incluyas en el PDF bloques internos ("Resumen
  ejecutivo para IA", "Etiquetas del negocio"): guárdalos aparte. Nada de anotaciones de
  trazabilidad ("declarado por el cliente…") ni de nombres de ficheros internos (`brand-tokens.json`).
- **Gotcha técnico:** pásale a `generar-pdf.ps1` el `-Out` (y `-Html`) como **ruta absoluta**; con
  rutas relativas, .NET (`GetFullPath`) las resuelve contra un directorio equivocado y el PDF falla.

## Requisitos técnicos
- **Números de página reales** e índice con máxima fidelidad: WeasyPrint o Prince
  (el script los usa si están instalados).
- **Sin instalar nada**: Microsoft Edge/Chrome headless (el script los detecta).
  Portada, índice, cabecera y pie de marca funcionan; el número de página vive en
  el pie por CSS `@page` (lo pintan WeasyPrint/Prince; con Edge se recomienda
  instalar WeasyPrint si se quiere el número impreso).
- Sin conexión, las fuentes de Google caen a los fallbacks del CSS (se ve bien).
