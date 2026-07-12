---
name: web-corporativa
description: Diseña Y construye una web corporativa profesional (sitio real en HTML/CSS/JS, no solo un documento), alineada con la identidad del cliente y orientada a convertir. Trabaja en dos fases — estrategia + construcción — leyendo brand-tokens.json y el Manual de Marca para heredar el look & feel, y usando un vocabulario curado de patrones de las mejores webs del mundo para producir diseños originales, limpios e inspiradores con fotografía real. Úsala cuando el usuario pida una web, página corporativa, sitio web, o rediseñar/crear la presencia web de un negocio.
---

# Generador de Web Corporativa

Diseña y **construye** una web corporativa que transmite confianza, explica con
claridad qué hace la empresa, la diferencia de la competencia y convierte
visitantes en clientes. No entrega solo un documento: entrega el **sitio real**.

## Contexto obligatorio (léelo antes de nada)
- **`<cliente>/marca/brand-tokens.json`** — colores, tipografías, geometría, tono,
  contacto. Es la fuente de verdad del look & feel. **Si no existe, ejecuta antes
  la skill `manual-de-marca`.**
- **`<cliente>/marca/BRAND.md`** y **`resumen-marca.md`** — voz, mensajes,
  público, palabras prohibidas.
- **Perfil Maestro del Negocio** y material aportado (servicios, fotos, URL
  actual, objetivos).

Si falta información, **no la inventes**: indícalo y propón una estructura
coherente basada en buenas prácticas, marcando lo pendiente de validar.

## El listón de calidad (importante)
El objetivo visual es nivel **awwwards / los mejores ejemplos de diseño web**:
limpio, original, con jerarquía impecable, mucho aire, tipografía cuidada,
micro-interacciones sutiles y **fotografía real** protagonista. **Inspiración, no
copia**: usa `references/patrones-web.md` como vocabulario de patrones probados y
como listón; compón algo **original** con la marca del cliente. Nunca clones un
sitio concreto ni su contenido. Nada de plantillas recargadas ni efectos
extravagantes: elegancia y claridad.

---

## Flujo de trabajo

### FASE 1 — Estrategia (produce `web/proyecto-web.md`)
Documento previo que dirige la construcción. Usa `templates/proyecto-web.md`.

1. **Enfoque estratégico**: determina el propósito principal de la web (y uno
   secundario si aplica) analizando negocio, marca y objetivos. Opciones:
   captación · confianza · venta · reservas/citas · posicionamiento · portfolio.
   **Justifícalo** y explica cómo influye en arquitectura, orden de secciones,
   tono, CTAs, UX, elementos de confianza y tipo de contenido.
2. **Objetivos priorizados** de la web (lista ordenada).
3. **Arquitectura del sitio**: páginas necesarias. Mínimo Inicio · Servicios ·
   Sobre nosotros · Contacto. Añade otras (blog, casos de éxito, FAQ, equipo,
   testimonios, galería, reservas) **solo si aportan valor**, justificando cada una.
4. **Estructura por página**: objetivo + orden de bloques recomendado.
5. **Textos completos** de cada sección: claros, naturales, persuasivos,
   centrados en el cliente y en la voz de la marca (`BRAND.md`). Cero frases
   vacías. Respeta glosario y palabras prohibidas.
6. **CTAs** por página (verbo + beneficio, coherentes con el enfoque).
7. **SEO básico por página**: title, meta description, H1, URL amigable, keyword
   principal. (No auditoría SEO completa.)
8. **Elementos de confianza**: testimonios, certificaciones, casos, años de
   experiencia, fotos reales, equipo, logos de clientes, garantías, FAQ.
9. **Plan visual y de imágenes**: qué foto/ilustración va en cada bloque (ver
   `references/imagenes.md`).

Valida la Fase 1 antes de construir: identidad reflejada, tono uniforme, CTA
clara, navegación simple, sin redundancias, estructura coherente.

### FASE 2 — Construcción del sitio (produce el código en `web/`)
Ahora se materializa. Salida por defecto: **sitio estático** (HTML semántico +
CSS + JS mínimo), autocontenido y portable. (Next.js solo si el proyecto lo pide.)

1. **Sistema de diseño desde tokens** — lee `references/sistema-diseno-web.md`.
   Genera `web/assets/css/styles.css` a partir de `templates/starter/styles.css`,
   inyectando las variables desde `brand-tokens.json` (colores + `on`, fuentes,
   escala, radios, espaciado base 8, sombras, contenedor, modo oscuro). **Todo el
   sitio usa variables CSS; ningún color/tamaño hardcodeado.**
2. **Elige patrones** de `references/patrones-web.md` según el enfoque de la Fase 1
   (tipo de hero, retícula de servicios, prueba social, etc.) y compón cada página
   de forma original.
3. **Maqueta cada página** con HTML semántico y accesible (landmarks, jerarquía de
   headings, alt en imágenes, foco visible, contraste AA ya garantizado por los
   tokens). Mobile-first y totalmente responsive.
4. **Imágenes** — sigue `references/imagenes.md`: reales del cliente → IA con
   `imagery.prompt_ia_base` → stock curado (Unsplash/Pexels). Optimiza (formato
   moderno, tamaños correctos, `loading="lazy"`, `width/height`), tratamiento
   coherente con la marca, y `alt` descriptivo siempre.
5. **Interacción y movimiento**: micro-interacciones sutiles (hover, revelado al
   hacer scroll, header que se compacta). Respeta `prefers-reduced-motion`. Nada
   estridente.
6. **Componentes funcionales**: navegación (con versión móvil), **formularios**
   con validación y estados, botones/CTA, tarjetas, FAQ (acordeón), footer con
   contacto y redes desde el JSON, **Google Maps** embebido, enlaces a RRSS,
   WhatsApp si procede.
7. **SEO técnico e integraciones** — `references/seo-tecnico.md`: `<title>` y meta
   por página, Open Graph, favicon, `lang`, datos estructurados schema.org
   (LocalBusiness/Organization con NAP del JSON), sitemap y robots básicos.
8. **Rendimiento**: preconnect a Google Fonts, CSS crítico, imágenes lazy, JS
   diferido, sin librerías innecesarias. Objetivo: ligero y rápido.

### FASE 3 — Verificación y entrega
- **Previsualiza el sitio** (levántalo y compruébalo, incl. móvil) antes de decir
  que está listo. No afirmes que funciona sin haberlo visto.
- Checklist final:
  - [ ] Look & feel coincide con `brand-tokens.json` (colores, fuentes, formas).
  - [ ] Tono uniforme en todas las páginas; sin palabras prohibidas.
  - [ ] CTA clara en cada página; contacto fácil.
  - [ ] Responsive real (360px → 1440px) sin roturas.
  - [ ] Contraste AA; navegable por teclado; alt en imágenes.
  - [ ] SEO por página + schema.org con datos reales del JSON.
  - [ ] Imágenes optimizadas y coherentes con la marca.
  - [ ] En 5 segundos se entiende qué hace la empresa.
- Entrega: estructura de `web/` lista para subir a cualquier hosting, más el
  `proyecto-web.md` como memoria del proyecto.

---

## Estructura de salida
```
<cliente>/web/
├─ proyecto-web.md            ← Fase 1 (estrategia, textos, SEO, plan visual)
├─ index.html                 ← Inicio
├─ servicios.html, sobre-nosotros.html, contacto.html, ...
├─ assets/
│  ├─ css/styles.css          ← sistema de diseño desde brand-tokens.json
│  ├─ js/main.js              ← interacciones + validación de formularios
│  └─ img/                    ← imágenes optimizadas
├─ sitemap.xml, robots.txt, favicon
```

## Qué NO hacer
- No inventar datos de la empresa (servicios, cifras, testimonios, contacto).
- No clonar un sitio concreto ni usar textos/imágenes de terceros con copyright.
- No hardcodear colores/tipografías: todo desde tokens.
- No diseños recargados ni efectos extravagantes; prioriza claridad y marca.
- No entregar sin previsualizar y pasar el checklist.
