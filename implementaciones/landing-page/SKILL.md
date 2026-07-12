---
name: landing-page
description: Diseña Y construye una landing page de alta conversión (página real en HTML/CSS/JS, no solo un documento) enfocada en un único objetivo de conversión. Trabaja en dos fases — estrategia CRO + construcción — leyendo brand-tokens.json y el Manual de Marca para heredar el look & feel de la web, y usando un vocabulario curado de las mejores landings del mundo para producir diseños originales y persuasivos. Úsala cuando el usuario pida una landing, página de captación, página de campaña, página de aterrizaje, o una página para convertir tráfico de anuncios.
---

# Generador de Landing Pages de Alta Conversión

Construye una experiencia orientada a **transformar visitantes en clientes**, no
solo una página bonita. No entrega un documento: entrega la **landing real**.
Cada decisión maximiza la conversión sin sacrificar claridad, confianza ni UX.

## Actúa como un equipo
Consultor de Marketing · Especialista en **CRO** · **Copywriter** Senior ·
Especialista en **UX** · Especialista en **SEO** · Estratega de **Ventas**.

## Contexto obligatorio (léelo antes de nada)
- **`<cliente>/marca/brand-tokens.json`** — colores, tipografías, geometría, tono,
  contacto. Look & feel. **Si no existe, ejecuta antes `manual-de-marca`.**
- **`<cliente>/marca/BRAND.md`** y **`resumen-marca.md`** — voz, público, objeciones.
- **`<cliente>/web/`** — si existe la web, la landing debe verse hermana (mismo
  `styles.css`) pero **más enfocada**.
- **Perfil Maestro del Negocio**, el servicio/producto a promocionar, la oferta,
  el público y el objetivo de campaña. **El anuncio** de origen si lo hay (para
  *message match*).

**No inventes testimonios ni estadísticas.** Si no hay datos reales de prueba
social, indica qué convendría incorporar y usa placeholders marcados.

---

> **Referencias de esta skill:** `references/cro.md` (conversión),
> `references/copywriting-persuasivo.md` (copy), `references/patrones-landing.md`
> (estructura y maquetación validada) y `references/aprendizajes-diseno.md` (acabado
> fino: espaciado, tipografía, jerarquía, animaciones — lecciones de Evolution y M8).

## FASE 1 — Estrategia CRO (produce `landings/<nombre>/proyecto-landing.md`)
Usa `templates/proyecto-landing.md`, `references/cro.md` y
`references/copywriting-persuasivo.md`.

1. **Objetivo de conversión (UNO solo)**: presupuesto / cita / lead / descarga /
   compra / registro / demo / contacto. Si hay varios, **prioriza uno** y
   construye TODA la landing alrededor de él (attention ratio 1:1).
2. **Comprensión del visitante**: quién llega (y desde qué anuncio/canal), qué
   problema tiene, qué desea, qué objeciones trae, qué necesita para confiar y qué
   información requiere antes de decidir.
3. **Message match**: el titular y la oferta deben continuar la promesa del
   anuncio/canal de origen (misma keyword, misma promesa) — mantiene el "scent".
4. **Propuesta de valor** (entendible en <5 s): qué ofrece · para quién · qué
   beneficio · por qué esta empresa.
5. **Arquitectura**: define el orden de bloques (referencia abajo). Modifícalo si
   hay mejor alternativa y **justifícalo**. Elige patrones de
   `references/patrones-landing.md` según objetivo y temperatura del tráfico.
6. **Wireframe textual**: esquema de bloques de arriba abajo.
7. **Copywriting completo** (con `copywriting-persuasivo.md`): titulares,
   subtítulos, beneficios, explicaciones, botones, formulario, garantías, FAQ y
   CTAs. Claro, persuasivo, natural, desde el beneficio del cliente, con la voz de
   la marca. Cero frases vacías; nada de lenguaje excesivamente comercial.
8. **Características → Beneficios → Transformación**: vende la **transformación**,
   no las características.
9. **Objeciones**: lista las principales y **resuélvelas dentro de la landing**
   (en copy, FAQ, garantías o prueba social).
10. **Prueba social**: qué incluir (opiniones, casos, estadísticas, clientes,
    certificaciones, premios, garantías). Marca lo que falte por conseguir.
11. **Plan de conversión**: nº de CTAs y posiciones, tipo de formulario, campos
    mínimos imprescindibles, y elementos de confianza junto al formulario.
12. **SEO básico**: title, meta description, H1, URL, keyword principal (aunque sea
    para tráfico de pago, se mantiene optimizada).
13. **Plan visual**: estilo, imágenes, iconografía, colores, distribución y
    elementos visuales que refuercen la conversión (según marca).

Valida la Fase 1: objetivo evidente, **una** acción principal, beneficios claros,
objeciones resueltas, propuesta de valor inmediata, tono de marca, confianza.

### Arquitectura de referencia (ajústala al caso)
Hero → **¿Qué es este servicio?** → Problema → Solución → Beneficios → Cómo funciona →
Prueba social → Casos/Testimonios → FAQ → **Localización (si es negocio local)** → CTA →
Formulario → Garantías → Cierre.

> **Reglas de maquetación no negociables** (ver `references/patrones-landing.md` →
> "Reglas de maquetación"): sección "¿Qué es?" cerca del inicio · tarjetas siempre en filas
> de 3 o 6 (nunca 4/5 colgando) · textos de párrafo justificados · nada pegado a esquinas
> (hero con aire, no volcado a la izquierda) · contraste vigilado (nada de texto oscuro sobre
> fondos de color) · localización en bloque propio y vistoso.

---

## FASE 2 — Construcción de la landing (produce el código)
Salida por defecto: **página única** HTML semántico + CSS + JS mínimo,
autocontenida, rápida y responsive.

1. **Sistema de diseño desde tokens**: reutiliza el sistema de la web
   (`../web-corporativa/references/sistema-diseno-web.md`). Si existe
   `<cliente>/web/assets/css/styles.css`, **enlázalo** para heredar el look & feel;
   si no, genera uno desde `brand-tokens.json`. Nada hardcodeado.
2. **Compón desde patrones** (`references/patrones-landing.md`) de forma original,
   según el objetivo y el wireframe de la Fase 1. Aplica el **acabado fino**
   (espaciado, tipografía, jerarquía, títulos, animaciones) de
   `references/aprendizajes-diseno.md` — lecciones validadas en producción; evita el
   error nº1 (exceso de aire vertical) y nunca uses `//` como decoración de sección.
3. **Optimización CRO en el código** (`references/cro.md`):
   - **Above the fold**: propuesta de valor + CTA visibles sin hacer scroll.
   - **Attention ratio 1:1**: sin navegación completa ni enlaces que distraigan;
     solo el logo y el CTA. Todos los CTAs llevan a la MISMA conversión.
   - **Formulario optimizado**: mínimos campos, etiquetas claras, validación y
     estados, señales de confianza al lado (garantía, privacidad, prueba social).
   - **CTA destacado**: color de acento, contraste AA, texto orientado a beneficio,
     repetido en los puntos naturales de decisión.
   - **Fricción mínima**, señales direccionales hacia el CTA, urgencia/escasez
     **solo si es real y ética**.
4. **Fotos e imágenes**: sigue `../web-corporativa/references/imagenes.md`
   (reales → IA con `prompt_ia_base` → stock curado). Optimizadas, con `alt`.
5. **Interacción**: micro-interacciones sutiles, revelado al scroll, **barra/botón
   CTA fijo** en móvil. Respeta `prefers-reduced-motion`.
6. **SEO técnico e integraciones** (`../web-corporativa/references/seo-tecnico.md`):
   metadatos, Open Graph, favicon, `lang`, schema.org relevante; destino real del
   formulario (email/Formspree/backend — no inventar); hueco para píxel/analítica
   sin IDs inventados.
7. **Rendimiento**: ligera y muy rápida (la velocidad afecta directamente la
   conversión): fuentes con `swap`, imágenes lazy, JS diferido.

## FASE 3 — Verificación y entrega
- **Previsualiza y PRUEBA en móvil (~375px) y tablet (~768px), no solo escritorio** — regla
  obligatoria del cliente. **Arregla** lo que se vea mal en móvil antes de darla por lista:
  sin **scroll horizontal real** (compruébalo con `window.scrollX`, no basta con
  `overflow-x:hidden`), visuales que no se recorten ni se descoloquen, y texto que no se salga.
  Los fallos típicos de móvil y su arreglo están en `references/aprendizajes-diseno.md` §9.
- Checklist final:
  - [ ] La conversión es evidente y hay **una sola** acción principal.
  - [ ] Propuesta de valor entendible en <5 s, above the fold.
  - [ ] Todos los CTAs apuntan a la misma conversión; attention ratio 1:1.
  - [ ] Beneficios y transformación claros; objeciones resueltas.
  - [ ] Formulario mínimo, con confianza al lado; validación correcta.
  - [ ] Look & feel = marca (hereda styles.css); tono de marca; sin frases vacías.
  - [ ] Responsive real; contraste AA; navegable por teclado; alt en imágenes.
  - [ ] Sin testimonios/estadísticas inventados (placeholders marcados si faltan).
  - [ ] SEO básico presente; carga rápida.

## FASE 4 — Control de calidad y seguridad (obligatoria antes de entregar/desplegar)
**No se entrega ni se despliega una landing sin pasar esta puerta.** Tiene dos partes;
ambas deben quedar en **PASS**. Deja constancia del resultado (2-3 líneas) al terminar.

Ambas partes se hacen con **skills reales ya disponibles** (no reimplementar el control a
mano). Si en algún caso hiciera falta una skill más específica que no esté cargada, se busca
e instala con `find-skills` (regla del Maestro: [[regla-buscar-skills-faltantes]]).

### 4.1 — ¿Funciona todo? → skill `verify`
Ejecuta la skill **`verify`** para comprobar que la landing hace lo que debe, ejercitándola
end-to-end en el navegador (no basta con "se ve bien"). Debe confirmar:
- Carga **sin errores** de consola ni de red.
- El **formulario funciona**: valida campos vacíos/erróneos, muestra estados y, al enviar
  correcto, dispara el destino real (WhatsApp / email / Formspree / backend).
- **Todos los enlaces y CTAs** llevan a su destino (nada roto, nada a `#`).
- Se ve bien en **móvil, tablet y escritorio** (y modo oscuro si aplica); imágenes cargan con `alt`.

### 4.2 — ¿Es segura? → skill `security-review`
Ejecuta la skill **`security-review`** sobre el código de la landing para auditar
vulnerabilidades antes de publicar. Cubre, como mínimo:
- **Sin credenciales** (API keys, tokens, contraseñas, IDs privados) en el fuente; van en `.env`.
- **Formulario a prueba de inyección/XSS**: datos de usuario nunca sin escapar en `innerHTML`,
  `document.write`, `eval` ni en URLs sin `encodeURIComponent`.
- **Enlaces externos** `target="_blank"` con `rel="noopener noreferrer"` (anti-tabnabbing).
- **Sin datos personales** de terceros ni información confidencial del cliente en el fuente.
- **Recursos de terceros** (scripts/CDNs) solo los imprescindibles y de origen fiable.
- Si hay repo, el **`.gitignore`** excluye `.env` y archivos sensibles antes de subir.

> Complemento opcional: `code-review` para pillar además bugs de corrección/simplificación.

Regla: corrige lo que puedas sin romper funcionalidad; las **credenciales solo se reportan**,
nunca se tocan solas. Traduce el resultado a un veredicto **✅ SEGURA / ⚠️ RIESGOS MENORES /
❌ NO PUBLICAR**; si es **❌**, no se despliega hasta resolverlo.

## Estructura de salida
```
<cliente>/landings/<nombre>/
├─ proyecto-landing.md    ← Fase 1 (estrategia CRO, copy, wireframe)
├─ index.html             ← la landing
├─ assets/ (css/js/img)   ← css enlazado o propio; img optimizadas
```

## Restricciones
- No inventar testimonios ni estadísticas.
- No hardcodear estilos: todo desde tokens / styles.css.
- No clonar una landing concreta ni usar copy/imágenes de terceros.
- No lenguaje excesivamente comercial; no repetir información.
- No entregar sin previsualizar y pasar el checklist.
- **No entregar ni desplegar sin pasar la Fase 4** (control funcional + auditoría de seguridad).
