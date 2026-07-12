---
name: contenido-redes
description: Genera contenido profesional y continuo para redes sociales con mínimo esfuerzo del cliente. Investiga contenido real que funciona en el sector (benchmark), lo adapta de forma original con la voz de la marca y entrega posts listos para publicar — copy, hashtags, imágenes IA, guiones de Reel y carruseles — organizados en un calendario editorial por etapas del embudo. Tiene además un MODO CAMPAÑA: dada una meta concreta (llenar plazas, promocionar un servicio, un lanzamiento, una fecha), monta una campaña de principio a fin (objetivo medible → ángulo → calendario con cuenta atrás → piezas y assets → medición). Lee brand-tokens.json y el Manual de Marca. Úsala cuando el usuario pida contenido para redes, calendario editorial, publicaciones para Instagram/LinkedIn/TikTok/Facebook, Reels, carruseles, stories, una estrategia de social media, o una campaña/promoción/lanzamiento con fecha y objetivo.
---

# Generador de Contenido para Redes Sociales

Produce contenido continuo y profesional **ahorrando tiempo al cliente**: la IA
investiga lo que ya funciona en el sector, lo **adapta de forma original** a la
marca y entrega **piezas listas para publicar**. El dueño del negocio no tiene que
crear nada desde cero: revisa y aprueba.

> Línea roja: **inspirar y adaptar, nunca copiar.** Prohibido reutilizar textos,
> imágenes o guiones de terceros tal cual. Toda pieza final es original y con la
> voz de la marca.

## Contexto obligatorio (léelo antes de nada)
- **`<cliente>/marca/brand-tokens.json`** — tono, voz, público, palabras
  prohibidas, glosario, `imagery.prompt_ia_base`, colores, redes activas.
  **Si no existe, ejecuta antes `manual-de-marca`.**
- **`<cliente>/marca/BRAND.md`** y **`resumen-marca.md`** — para escribir con la voz.
- **`<cliente>/web/` y `<cliente>/blog/`** — para reutilizar contenido y enlazar.
- **Perfil Maestro del Negocio**, servicios, oferta, objetivos y **plataformas**
  donde el cliente está (o debería estar) presente.

Entrega por semanas o meses (producción por lotes). No inventes datos ni cifras
del negocio.

## Dos modos de uso
- **Modo continuo** (por defecto) → calendario editorial sostenido. Es todo lo que
  sigue, de la Fase 1 a la Fase 2.
- **Modo campaña** → un empujón con **objetivo y fecha** (llenar un taller,
  promocionar un servicio, un lanzamiento, una rebaja de temporada). Si el usuario
  pide una campaña/promoción/lanzamiento, salta al bloque **MODO CAMPAÑA** de abajo.

---

## FASE 1 — Estrategia editorial (produce `redes/plan-redes.md`)

### 1. Benchmark de contenidos del sector
Analiza contenido publicado por empresas del mismo sector (Instagram, LinkedIn,
Facebook, TikTok, YouTube, blogs). Si hay acceso web, búscalo; si no, trabaja con
las referencias que aporte el cliente. Ver `references/benchmark-sector.md`.
Por cada referencia identifica: temas frecuentes, formatos, estilo, nivel técnico,
frecuencia, tipo de imágenes/vídeos, interacción aparente y mezcla
educativo/comercial/marca. Luego responde:
- ¿Qué hacen especialmente bien? ¿Qué oportunidades **no** aprovechan?
- ¿Qué contenidos/formatos generan más interés? ¿Qué temas apenas se tratan (hueco)?

### 2. Adaptación a la marca (filtro de ideas)
Cada idea del benchmark pasa el filtro: ¿coherente con el Manual de Marca?
¿aporta valor al público? ¿encaja con los objetivos? ¿puede adaptarse de forma
original? Clasifícala: **Recomendable / Adaptable / No recomendable** y justifica.

### 3. Inspiración editorial (banco de ideas)
Lista de ideas inspiradas en el análisis. Cada una: tema · objetivo · por qué
funciona · **cómo adaptarla a la marca** (original) · formato recomendado ·
prioridad. Nunca copiar literalmente.
Cierra con una **matriz de priorización (vista rápida para el cliente)** ordenada
por prioridad, con columnas: Prioridad · Idea · Formato · Objetivo · Público ·
Reutilizable (ver ejemplo en `templates/plan-redes.md`). La columna Reutilizable
enlaza con el plan de reutilización (§6) y la biblioteca (§7).

### 4. Matriz estratégica por etapa del embudo
Reparte el contenido según el nivel de conciencia del cliente
(`references/estrategia-editorial.md`). No concentrar todo en la venta:
- **Etapa 1 — Inconsciente del problema** → generar interés (curiosidades,
  errores frecuentes, mitos, datos sorprendentes).
- **Etapa 2 — Consciente del problema** → educar (consejos, explicaciones, buenas
  prácticas, comparativas).
- **Etapa 3 — Buscando solución** → generar confianza (casos de éxito, opiniones,
  demostraciones, metodología, antes/después).
- **Etapa 4 — Listo para decidir** → convertir (promociones, garantías, FAQ,
  proceso de contratación, CTA).
Mix recomendado: mayoría etapas 1-2, refuerzo 3, minoría 4 (regla ~ educar >
confiar > vender).

### 5. Pilares de contenido y plataformas
Define 3-5 **pilares** temáticos (ligados a servicios y al benchmark) y a qué
plataformas se adapta cada uno (specs y estilo en `references/formatos-plataforma.md`).

### 6. Plan de reutilización inteligente
Por cada contenido base, define su cadena de reaprovechamiento. Ej.:
artículo de blog → carrusel IG → post LinkedIn → newsletter → story → Reel →
vídeo corto → pregunta para stories → fragmento para Google Business → FAQ web.
Maximiza el rendimiento de cada pieza (1 idea = muchos formatos).

### 7. Biblioteca de contenidos reutilizables
Marca las piezas de mayor potencial como **Evergreen / Estacional / Promocional /
Tendencia** e indica cuándo republicar o actualizar.

### 8. Calendario editorial
Reparte pilares, etapas y formatos en un calendario realista (usa
`templates/calendario-editorial.csv`). Cadencia sostenible por plataforma; equilibra
educar/confiar/vender; incluye huecos para tendencias y contenido estacional.

---

## FASE 2 — Producción de contenido listo para publicar
Convierte el calendario en **piezas terminadas**. Por cada publicación usa la
plantilla adecuada:
- **Post** (`templates/post.md`): copy final con la voz de marca, **gancho** en la
  primera línea, cuerpo, **CTA**, **hashtags** (mezcla de alcance y nicho, sin
  spam), etapa del embudo y objetivo. Incluye la **especificación de imagen**
  (qué muestra, estilo según `imagery`) o **genera la imagen IA** con el
  `imagery.prompt_ia_base` para coherencia visual.
- **Carrusel** (`templates/carrusel.md`): idea por diapositiva (portada con gancho
  → desarrollo → cierre con CTA), texto de cada slide y nota de diseño (usa colores
  y tipografías de la marca).
- **Reel / vídeo corto** (`templates/guion-reel.md`): gancho (primeros 3 s), guion
  por escenas, texto en pantalla, audio/tendencia sugerida, duración y CTA.
- **Stories**: secuencia con encuestas/preguntas/enlaces; interacción.
Respeta siempre glosario y palabras prohibidas. Cero relleno; cada pieza con un
objetivo claro.

### Imágenes
Sigue la estrategia de `../web-corporativa/references/imagenes.md`: reales del
cliente → IA con `imagery.prompt_ia_base` (coherencia visual entre todas las
piezas) → stock curado. Nunca imágenes de terceros con copyright ni de la
competencia. Formato correcto por red (ver `formatos-plataforma.md`).

---

---

## MODO CAMPAÑA — un empujón con objetivo y fecha
Cuando el cliente no quiere "más contenido" sino **un resultado concreto para una
fecha** (llenar un taller, promocionar un servicio, un lanzamiento, la campaña de
temporada). A diferencia del modo continuo, una campaña tiene principio, fin y una
métrica de éxito. Produce `redes/campanas/<nombre>/plan-campana.md` con
`templates/plan-campana.md`.

### C1 — Objetivo medible y hueco
Antes de crear nada, clava el **objetivo en número y fecha**: "20 plazas para el
taller del 15 de marzo", "10 reservas del bono nuevo este mes". Sin número no hay
campaña, hay ruido. Identifica el **hueco** que la justifica (plazas vacías, servicio
infrautilizado, temporada baja) — usando lo que el cliente aporte, sin inventar cifras.

### C2 — Ángulo y oferta
Un solo **ángulo** claro (el porqué te apuntas ahora) y, si aplica, una **oferta con
motivo** (early bird, plazas limitadas, fecha límite real — nunca urgencia falsa).
Coherente con la marca; nada de descuentazos que erosionen el posicionamiento.

### C3 — Arco de campaña (calendario con cuenta atrás)
Reparte las piezas en las fases clásicas, ancladas a la fecha objetivo:
- **Teaser** (se acerca algo) → **Anuncio** (ya está aquí, esto es) →
  **Prueba/valor** (por qué merece la pena, casos, contenido útil) →
  **Cuenta atrás / urgencia real** (últimas plazas, cierra el día X) →
  **Cierre** (última llamada) → **Post-campaña** (gracias / resultado / lista de espera).
Cada pieza reutiliza las plantillas de la Fase 2 (post, carrusel, guion-reel, stories)
y aprovecha el plan de reutilización (§6): 1 idea → muchos formatos.

### C4 — Assets y multicanal
Genera las piezas listas para publicar (copy + imagen IA con `imagery.prompt_ia_base`
+ specs por plataforma) y, si el cliente tiene otros canales activos, la versión para
**newsletter, Google Business y web** (mismo mensaje, formato nativo). Los banners de
la campaña se piden a la skill `banner-design`; el look sale de `brand-tokens.json`.

### C5 — Medición
Define de antemano **cómo se sabrá si funcionó** (inscritos, reservas, mensajes,
clics al enlace) y deja el hueco para anotar el resultado real al cerrar. Sin
integraciones: el cliente reporta el número; nosotros no inventamos métricas.

---

## Validación estratégica (antes de entregar)
- [ ] Coherencia total con la marca (tono, visual, palabras prohibidas).
- [ ] Equilibrio educación / confianza / venta (no todo vender).
- [ ] Se aprovechan las oportunidades detectadas en el benchmark.
- [ ] Todas las ideas adaptadas son **originales**; sin riesgo de copiar a terceros.
- [ ] Cada publicación tiene objetivo claro y etapa del embudo asignada.
- [ ] Existe plan de reutilización; el calendario cubre las 4 etapas.
- [ ] Specs correctas por plataforma; imágenes coherentes con la marca.
- [ ] **(Modo campaña)** Hay objetivo en número y fecha, un solo ángulo, arco con
      cuenta atrás anclado a la fecha, y métrica de éxito definida antes de arrancar.

## Estructura de salida
```
<cliente>/redes/
├─ plan-redes.md              ← Fase 1 (benchmark, matriz, pilares, reutilización)
├─ calendario-editorial.csv   ← calendario
├─ posts/                     ← piezas listas (post.md, carrusel.md, guion-reel.md)
├─ img/                       ← imágenes generadas/optimizadas por red
└─ campanas/<nombre>/         ← (modo campaña) plan-campana.md + piezas + assets
```

## Restricciones
- No copiar textos, imágenes ni guiones de terceros; todo original y adaptado.
- No inventar datos, cifras ni testimonios del negocio.
- No abusar de hashtags ni tono excesivamente comercial.
- Coherencia con la marca por encima de "lo que es tendencia".
