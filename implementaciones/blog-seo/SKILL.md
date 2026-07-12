---
name: blog-seo
description: Crea y hace crecer un blog SEO — monta la arquitectura del blog (categorías, clusters de contenido, calendario editorial) y redacta artículos optimizados listos para publicar, alineados con la identidad del cliente. Lee brand-tokens.json y el Manual de Marca para mantener la voz, e integra CTAs y enlaces internos hacia la web. Cada artículo sale people-first (útil, con E-E-A-T) y con SEO on-page natural. Úsala cuando el usuario pida un blog, artículos, contenido SEO, estrategia de contenidos, calendario editorial o posicionar en Google con contenido.
---

# Generador de Blog SEO

Crea contenido que atrae tráfico cualificado, posiciona la marca como referente y
convierte lectores en clientes. **Primero el usuario, no el buscador**: contenido
útil y con experiencia real (E-E-A-T), con SEO natural. Cada artículo sale listo
para publicar sin reescritura.

## Contexto obligatorio (léelo antes de nada)
- **`<cliente>/marca/brand-tokens.json`** — tono, voz, público, palabras
  prohibidas, glosario, contacto. Fuente de verdad de la identidad. **Si no
  existe, ejecuta antes `manual-de-marca`.**
- **`<cliente>/marca/BRAND.md`** y **`resumen-marca.md`** — para escribir con la voz.
- **`<cliente>/web/proyecto-web.md`** y las páginas de `web/` — para conocer los
  servicios y a qué URLs enlazar internamente.
- **Perfil Maestro del Negocio** y objetivos de contenido.

Si falta un dato técnico, **no lo inventes**: márcalo o pídelo. No hagas
afirmaciones que no puedan justificarse.

## Actúa como
Editor SEO Senior + Copywriter especializado. Transmite experiencia, confianza y
utilidad, respetando siempre el Manual de Marca.

---

## FASE A — Montaje del blog (una vez por cliente → `blog/plan-blog.md`)
Solo la primera vez, o al replantear el blog. Usa `templates/plan-blog.md` y
`references/estrategia-contenidos.md`.

1. **Comprensión del negocio**: qué hace, a quién se dirige, qué problemas
   resuelve, qué servicios ofrece, qué tono usa, qué quiere conseguir.
2. **Arquitectura del blog**: estructura de URLs, portada de blog, página de
   categoría, plantilla de artículo.
3. **Categorías**: 3-6 temáticas alineadas con los servicios y las búsquedas del
   público. Justifica cada una.
4. **Mapa de clusters (pilar + cluster)**: por cada servicio clave, un artículo
   **pilar** amplio + varios artículos **cluster** que lo enlazan. Es lo que de
   verdad posiciona. Define keyword e intención de cada nodo.
5. **Estrategia de contenidos y calendario editorial**: prioriza temas por
   oportunidad (demanda + facilidad + valor de negocio) y repártelos en un
   calendario (p. ej. 3 meses). Marca cuáles son pilares.
6. **Primeros artículos**: recomienda con cuáles empezar (normalmente 1 pilar +
   2-3 clusters que lo apoyen).

---

## FASE B — Redactar un artículo (repetible → `blog/<slug>/`)
Usa `templates/articulo.md`, `references/seo-onpage.md` y `references/redaccion.md`.

1. **Tema**: si el usuario no lo da, propón varias opciones del mapa de clusters y
   deja que elija (o elige la de mayor oportunidad y justifícalo).
2. **Objetivo del artículo**: atraer tráfico / educar / resolver dudas / demostrar
   experiencia / generar confianza / apoyar venta / posicionar servicio / captar
   leads. Explica por qué es el adecuado.
3. **Intención de búsqueda**: informativa / comercial / comparativa / transaccional
   / navegacional. Justifícala — determina formato y CTA.
4. **Tipo de artículo (OBLIGATORIO)**: antes de escribir, decide el **formato** de
   contenido (guía completa, tutorial paso a paso, comparativa, lista, errores
   frecuentes, caso de éxito, FAQ, tendencias, opinión, mitos y realidades,
   checklist, glosario…). Elígelo **en función del objetivo y la intención de
   búsqueda** y justifícalo. El tipo condiciona la estructura, el tono y el CTA.
   Consulta el catálogo y el mapa tipo↔intención en `references/tipos-articulo.md`.
5. **Análisis de la SERP** (si es posible): qué formato y ángulos rankean, qué
   cubrir para ser mejor (profundidad, ejemplos, datos, estructura). No copiar.
6. **Títulos**: genera 5-10 optimizados (coherentes con el tipo elegido); elige el
   mejor y justifica.
7. **Esquema**: intro, secciones (H2), subapartados (H3), conclusión y CTA, en
   orden lógico y **acorde al tipo de artículo**. Cubre la intención por completo.
8. **Redacción**: útil, clara, natural, con la voz de la marca. Ejemplos cuando
   aporten. Explica lo complejo de forma sencilla. **Cero relleno**. Demuestra
   experiencia real (E-E-A-T). Respeta glosario y palabras prohibidas.
9. **Legibilidad**: párrafos cortos, listas, tablas cuando sean útiles, negritas
   con criterio, destacados.
10. **SEO on-page**: title, meta description, URL, H1, H2/H3, keyword principal,
    secundarias y variaciones semánticas — integradas con naturalidad, sin stuffing.
11. **Enlaces**: internos hacia páginas/servicios y otros artículos del cluster
    (con anchor natural); externos a fuentes fiables cuando aporten credibilidad.
12. **Conversión**: 1-2 CTAs en el momento natural, coherentes con el objetivo y
    la marca. No tono excesivamente comercial.
13. **Imágenes**: indica dónde van y, por cada una, qué debe mostrar, su objetivo
    y estilo (según `imagery` del brand-tokens). Genera `alt` descriptivo.
14. **FAQ**: bloque de preguntas frecuentes del tema (candidato a rich snippet).
15. **Resumen**, **extracto** (150-200 caracteres) y **propuesta para redes**.
16. **Potencial de Negocio del Artículo (OBLIGATORIO)**: cierra el trabajo con un
    apartado estratégico que conecta el contenido con la venta. Responde:
    - ¿Qué **servicio** de la empresa se beneficia más de este contenido?
    - ¿Qué **tipo de cliente** atraerá?
    - ¿En qué **fase del proceso de compra** (TOFU/MOFU/BOFU) está ese lector?
    - ¿Qué **siguiente contenido** le convendría leer?
    - ¿Cuál sería la **mejor llamada a la acción** para este lector?
    - ¿Qué **artículo escribir después** para reforzar el clúster temático?
    Este apartado alimenta el calendario editorial (Fase A) y el enlazado interno.

### Salida publicable
Además del documento de trabajo (`articulo.md` con los 14 puntos), genera el
artículo **listo para publicar**:
- **Markdown** (`<slug>.md`) para CMS/WordPress — formato por defecto, portable.
- **HTML** (`<slug>.html` desde `templates/post.html`) cuando el sitio es la web
  estática que construimos: hereda `web/assets/css/styles.css` (mismo look & feel)
  e incluye JSON-LD `Article` + `FAQPage`.

---

## Validación (antes de entregar)
- [ ] Responde de verdad a la intención de búsqueda y la cubre mejor que la SERP.
- [ ] **Tipo de artículo** elegido y justificado; la estructura lo respeta.
- [ ] Aporta valor real y demuestra conocimiento (E-E-A-T); nada genérico.
- [ ] Tono 100% alineado con la marca; sin palabras prohibidas.
- [ ] SEO natural, sin keyword stuffing; metadatos completos.
- [ ] Enlaces internos coherentes; CTA claro y no agresivo.
- [ ] Bien estructurado y legible; sin repeticiones.
- [ ] Datos verificables; ninguna afirmación sin respaldo.
- [ ] **Potencial de Negocio** completo (servicio, cliente, fase, siguiente
      contenido, mejor CTA, artículo siguiente del clúster).

## Restricciones
- No copiar contenido existente ni inventar datos técnicos.
- No keyword stuffing; no escribir para buscadores.
- No tono excesivamente comercial.
- Escribir **siempre pensando primero en el usuario**.
