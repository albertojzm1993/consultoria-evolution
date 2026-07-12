# Catálogo de plantillas de ejecución

Cada `tipo_servicio` tiene una **receta**: qué debe hacer la skill generada, qué preguntar,
qué entregable produce y qué reglas de calidad respetar.

La fábrica usa estas recetas para rellenar la plantilla base. Si un `tipo_servicio`
no está en esta lista, usa la receta **generico**.

> Todas las skills generadas heredan las reglas del `CLAUDE.md` del proyecto:
> nivel profesional, sin relleno, orientado a negocio, nunca inventar datos,
> datos de cliente confidenciales.

---

## seo
- **Hace:** analiza y reescribe elementos on-page (títulos, meta descripciones, encabezados, enlazado interno, contenido) para las URLs del hallazgo.
- **Pregunta si falta:** URLs afectadas, palabra clave objetivo por página, ubicación (si es local).
- **Entregable:** tabla por URL con `title` (≤60c), `meta description` (150-160c), H1 y sugerencias de contenido, lista para pegar.
- **Calidad:** una intención de búsqueda por página; nada de keyword stuffing; incluir marca al final del title.

## seo-local
- **Hace:** optimiza Google Business Profile y señales locales (NAP, categorías, reseñas, contenido geolocalizado).
- **Pregunta si falta:** ciudad, dirección, categorías actuales, enlace GBP.
- **Entregable:** checklist de GBP + textos de publicaciones + plan de reseñas.
- **Calidad:** NAP idéntico en todas las fuentes; categorías reales, no aspiracionales.

## copywriting
- **Hace:** reescribe textos (home, servicios, landing, emails) con propuesta de valor clara y CTA.
- **Pregunta si falta:** público objetivo, tono de marca, oferta/beneficio principal, textos actuales.
- **Entregable:** documento con los textos finales por sección, listos para publicar.
- **Calidad:** beneficio antes que característica; una idea por bloque; CTA explícito.

## rendimiento-web
- **Hace:** plan de mejora de velocidad y Core Web Vitals.
- **Pregunta si falta:** plataforma (WordPress, Shopify…), acceso o informe de PageSpeed.
- **Entregable:** lista priorizada de acciones técnicas con impacto estimado y dificultad.
- **Calidad:** acciones concretas (no "optimizar imágenes" sino "convertir a WebP y lazy-load en home").

## ux-conversion
- **Hace:** mejoras de experiencia y conversión (estructura, formularios, CTAs, fricción).
- **Pregunta si falta:** objetivo de conversión, embudo actual, analítica disponible.
- **Entregable:** informe de mejoras UX priorizadas + wireframe textual de la página clave.

## redes-sociales
- **Hace:** estrategia y calendario de contenidos por red.
- **Pregunta si falta:** redes activas, público, frecuencia deseada, tono.
- **Entregable:** plan editorial de 4 semanas con temáticas, formatos y ejemplos de copy.

## publicidad
- **Hace:** estructura de campañas (Meta/Google Ads): públicos, mensajes, presupuesto orientativo.
- **Pregunta si falta:** objetivo, presupuesto, oferta, público.
- **Entregable:** plan de campaña con públicos, creatividades sugeridas y KPIs.

## email-marketing
- **Hace:** secuencias y newsletters.
- **Entregable:** secuencia de emails (asunto + cuerpo) con objetivo por email.

## reputacion
- **Hace:** gestión de reseñas e imagen online.
- **Entregable:** plan de captación de reseñas + plantillas de respuesta (positiva/negativa/neutra).

## automatizacion
- **Hace:** diseña una automatización de un proceso repetitivo.
- **Pregunta si falta:** herramientas actuales, proceso a automatizar, volumen.
- **Entregable:** diagrama textual del flujo (disparador → pasos → resultado) + herramientas recomendadas + estimación de ahorro.

## chatbot
- **Hace:** diseña un chatbot/agente de atención.
- **Entregable:** guion de conversación, intenciones, respuestas y puntos de escalado a humano.

## analitica
- **Hace:** define KPIs, embudos y cuadro de mando.
- **Entregable:** lista de KPIs con fórmula y fuente + estructura del dashboard.

## branding
- **Hace:** guía de identidad básica (tono, mensajes clave, do/don't).
- **Entregable:** mini guía de marca.

## captacion
- **Hace:** diseño de embudo de captación (lead magnet → landing → seguimiento).
- **Entregable:** esquema del embudo + textos de cada paso.

## generico
- **Hace:** cualquier hallazgo sin plantilla específica.
- **Pregunta si falta:** contexto mínimo para producir un entregable útil.
- **Entregable:** documento profesional que resuelve el hallazgo: diagnóstico breve → solución → pasos → resultado esperado.
- **Calidad:** aplicar la lógica de un consultor senior; nunca genérico, siempre accionable.
