# Referencia — Aprendizajes de diseño fino (espaciado, tipografía, jerarquía)

Lecciones **validadas en producción** sobre las landings reales (Evolution y M8): lo que
funciona en espaciado, tamaños, títulos y qué usar / qué evitar. Complementa
`patrones-landing.md` (que cubre estructura y maquetación) con el **detalle de acabado** —
lo que separa una landing "de plantilla" de una que parece hecha por un diseñador.

> **Sirve para landings Y para web-corporativa.** Los principios de aire, tipografía y
> jerarquía se aplican a cualquier página. Los cambian solo los tokens de marca.
>
> **Regla de oro:** los **valores** de aquí son defaults probados, punto de partida, no
> dogma. Los **colores y tipografías SIEMPRE** salen de `brand-tokens.json` — nunca
> hardcodees color ni fuente. Lo que se hereda es la *proporción y el ritmo*, no el hex.

---

## 1. Espaciado y aire (el error nº1: demasiado hueco vertical)

El fallo más repetido es dejar **demasiado aire entre secciones**, que desconecta la página
y obliga a scrollear en vacío. Ajusta el ritmo vertical:

- **Padding vertical de sección:** `~74px` arriba/abajo en desktop, `~54px` en móvil
  (`@media max-width:720px`). Ese es el punto donde las secciones respiran sin sentirse
  sueltas. Más de ~90px empieza a parecer desconectado.
- **Cabecera de sección con poco margen inferior:** el eyebrow, el `h2` y el párrafo de
  intro van juntos (`h2` con `margin-top:16px` respecto al eyebrow). No metas 40px entre
  el título y su contenido.
- **Padding lateral del contenedor:** generoso pero no exagerado — `~40px` desktop /
  `~22px` móvil. **Nada pegado a los bordes ni a las esquinas.**
- **Aire ≠ vacío.** El aire va *dentro* de los bloques (padding de tarjetas, interlineado),
  no *entre* secciones enormes. Si dudas, quita hueco vertical entre secciones antes que
  añadirlo.
- **No amontones contra un separador animado.** Si hay una línea/separador en movimiento
  (p. ej. la línea verde rotatoria), deja margen real alrededor; los textos apretados
  contra ella se ven mal y compiten con el movimiento.

## 2. Tipografía y jerarquía

- **Una fuente por rol, no más de tres familias:**
  - *Display / títulos / eyebrows / etiquetas cortas* → la tipografía de marca con
    carácter (en Evolution: **Onest**, pesos 700–800).
  - *Cuerpo* → una sans legible a 16px, `line-height:1.6–1.65` (en Evolution: **Inter**).
  - *Etiquetas técnicas / cifras / código* → monoespaciada solo cuando aporta
    (JetBrains Mono). No la uses para texto normal.
- **Escala fluida con `clamp()`**, no tamaños fijos que rompen en móvil:
  - Hero `h1`: `clamp(2.7rem, 5.8vw, 4.6rem)` con `letter-spacing:-.035em` (los titulares
    grandes necesitan tracking negativo para no verse sueltos).
  - `h2` de sección: `clamp(2rem, 4vw, 3rem)`.
  - Lead del hero: `clamp(1.08rem, 2vw, 1.25rem)`.
- **Longitud de línea controlada:** limita el ancho del texto con `max-width` en `ch`
  (p. ej. `46ch` para el lead). Los párrafos a todo el ancho cansan y bajan la lectura.
- **Calidad tipográfica en las secciones clave.** Si una sección importante "se ve con mala
  fuente", casi siempre es: tamaño demasiado pequeño, peso insuficiente, o mono usada donde
  no toca. Súbele tamaño/peso y pásala a la fuente display.
- **Párrafos justificados** (`text-align:justify; hyphens:auto`); **titulares no**.

## 3. Títulos, eyebrows y separadores — qué usar en vez de "//"

- **Prohibido usar comentarios de código como decoración** (`// sección`, `/* ... */`,
  `<!-- -->` a la vista). Quedan de "página de programador", no de marca. **Rechazado
  explícitamente.**
- **Patrón de eyebrow que sí funciona** (rótulo sobre cada `h2`):
  - Texto corto en **mayúsculas**, fuente display 700, `font-size:~.84rem`,
    `letter-spacing:.1em`, en **color de acento**.
  - Opcional: un **badge numerado** (`01`, `02`…) con fondo de acento + una línea corta
    (`26×2px`) como adorno. Da estructura y sensación de "método", sin recurrir a `//`.
- **Numera los pasos de forma explícita.** En bloques de proceso, "Paso 1 / Paso 2…" como
  etiqueta principal comunica progresión mejor que un texto suelto. La secuencia debe leerse
  de un vistazo.
  - **⚠️ Matiz (validado en feedback):** numerar está bien **solo cuando hay secuencia real**
    (pasos de un método, fases). **No** salpiques `01/02/03/04/05` sobre tarjetas de
    características **no secuenciales** (features, ventajas, "qué incluye"): ahí el número es
    puro andamiaje editorial de IA y **delata** que lo hizo una máquina. Si el orden no
    importa, quita el número. Ver §10.
- **Resalta lo que importa** con negrita o color de acento (etiquetas "Sí es / No es",
  cifras de prueba social, garantías). Nunca en texto plano gris.
- **Rótulos cortos de nodos/chips: capitaliza la palabra clave, no los dejes en minúscula.**
  El sustantivo relevante en mayúscula: "Respuestas + **W**eb", "+150 **V**ariables",
  "10 **P**ilares", "**P**aso a **P**aso". Frases corridas más largas sí van en sentence case
  ("Cuello de botella"). Consistencia en todos los rótulos pequeños.

## 4. Qué usar / qué evitar (chequeo rápido)

**USA:**
- Color de acento reservado para lo accionable (CTA, enlaces, datos clave, iconos).
- Estados `:focus-visible` con `outline` de acento (2px, `offset:3px`) — accesibilidad real.
- Fondos con capas sutiles (`radial-gradient` tenue tras la sección hero/glow) para dar
  profundidad sin ruido.
- Iconos **distintos por concepto** (uno por ítem; nunca repetir icono).
- Contraste AA vigilado, **sobre todo texto sobre fondos de color** (los `<strong>` heredan
  color: sobre oscuro fuérzalos a blanco).

**EVITA:**
- `//` y comentarios de código como adorno (ver §3).
- Exceso de aire vertical entre secciones (ver §1).
- Elementos **recortados** por su contenedor (ver §5).
- Amontonar contra separadores animados (ver §1).
- Repetir el mismo icono; dos logos juntos; wordmark inventado en vez del logo real.
- Abusar de marcos orgánicos (blob) en TODAS las fotos — varía formas.
- Tamaños fijos de fuente; mono para texto de lectura; texto a todo el ancho sin `max-width`.

## 5. Componentes visuales y animaciones

- **Que el elemento no se recorte.** Un visual (orbe, diagrama, círculo) que aparece
  "cortado por arriba" es casi siempre falta de espacio del contenedor o `transform-origin`
  mal puesto. Dale al `stage` altura/`min-height` y margen suficientes, revisa `overflow`.
- **Que la animación llene su contenedor.** Las animaciones pequeñas dentro de una caja
  grande se ven pobres. Sube el `min-height` del escenario (p. ej. 420→500px) y escala los
  diagramas (`transform:scale(1.08–1.12)`) hasta que ocupen el espacio. **Desactiva esos
  `scale` en móvil** para que no desborden.
- **Etiqueta los nodos.** Un diagrama/circuito con los nodos rotulados (Web, CRM, IA,
  Datos…) comunica; sin etiquetas es decoración vacía.
- **Un elemento en movimiento basta.** Normalmente un carrusel de fotos o un diagrama
  animado. Auto-avance pausable al pasar el ratón y **respeta `prefers-reduced-motion`**.
- **Tarjetas expandibles** para el detalle: muestra lo esencial y despliega al hacer clic
  (`role="button"`, `tabIndex=0`, Enter/Espacio). No vuelques todo el texto de golpe.

## 6. Visualizaciones de diagnóstico / dashboards (patrón Evolution)

Cuando la landing muestra un "resultado de análisis" (madurez, scoring, radiografía):

- **Muestra variabilidad y contraste en los datos de ejemplo.** Si todos los niveles salen
  parecidos (todo "medio"), el gráfico no dice nada. Marca **picos** claros (fortalezas) y
  **valles** claros (debilidades) para que se lea de un vistazo dónde actuar.
- **Codifica la madurez por color** (escala **N1–N5**: rojo→naranja→amarillo→verde→azul).
  El color hace el trabajo de lectura rápida. **Notación `N1`…`N5`, no "Nivel X" ni `N0`**
  (rechazados en producción). Las **pills de la escala en negrita**.
- **Resume fortalezas y debilidades** en una caja a dos columnas (verde "Fortalezas" /
  naranja "A mejorar"). El usuario quiere el titular, no solo la tabla.
- **Señala el cuello de botella** ("N1 · prioridad") con un texto **extenso** que llene su
  caja y explique por qué ese freno arrastra al resto — el dato accionable concreto.
- Demuestra el **resultado**, no la lista de servicios: "esto es lo que te llevas", no
  "estos son nuestros servicios".

## 7. Logo e identidad

- **Un solo logotipo** en cabecera y en pie (nunca isotipo + el mismo nombre en texto al
  lado). Verifícalo antes de entregar.
- **Logo real del cliente** (PNG/SVG con transparencia), no un wordmark dibujado con una
  fuente al azar. Si no lo han dado, pídelo.
- Truco de marca válido: **isotipo/forma corta por defecto**, y el nombre completo se revela
  al `hover`/`focus-within` con transición de opacidad suave (~0.25s). Da vida sin ensuciar.
- Sin `drop-shadow` gratuito sobre el isotipo si emborrona; limpieza > efecto.

## 8. Segunda ronda (feedback intensivo Evolution) — consistencia, diagramas y alineación fina

Lecciones de una iteración larga sobre la landing de Evolution. Son las que más separan un
diseño "correcto" de uno que convence.

### Consistencia de "pills" y etiquetas
- Las etiquetas tipo pill (chips, badges, rótulos) deben **verse iguales entre sí**: mismo
  tamaño de letra, mismo relleno, mismo estilo. Si una lleva efecto (p. ej. una **burbuja
  parpadeante** `.pd`), reutilízalo en las hermanas para que se lean como familia.
- **Cuidado con `transform:scale()` en un ancestro:** si una pill vive dentro de un contenedor
  escalado (p. ej. un orbe con `scale(1.12)`), su fuente/tamaño se renderizan multiplicados y
  **deja de coincidir** con una pill gemela de fuera. **Contra-escálala** (`scale(1/1.12)`)
  para igualar el tamaño real. Para alinear dos pills: iguala alturas (`height` + `line-height:1`)
  y alinéalas por el **centro**.

### Índice / menú lateral (side-nav de puntos)
- Nada de **cápsula redondeada de fondo** (se ve "de notas al pie"): puntos flotantes limpios.
- Agrupa en **secciones principales** (bola grande, anillo con punto central) y **subsecciones**
  (bola pequeña), con separación entre grupos.
- **Todos los puntos deben compartir el mismo eje vertical.** Puntos de distinto tamaño
  alineados a un lado descuadran los centros; compénsalo (p. ej. `margin` en los pequeños)
  hasta que todos los centros x coincidan. Scroll-spy con `IntersectionObserver`; etiqueta al hover.

### Diagramas y visualizaciones (lo que más costó)
- **Mete el núcleo dentro del propio SVG.** Si el centro (icono/rayo, halos, "ondas") es un
  `<div>` superpuesto y el resto es SVG, al agrandar o mover el diagrama se **descuadran**. Con
  todo dentro del SVG, escala y se mueve **como una sola pieza** y queda siempre concéntrico.
- **Vocabulario del público, no jerga.** Para pymes: *Web, Visitas, SEO, Contenido, Redes,
  Visibilidad, Ventas, Clientes* — no *CRM, IA, Automatización, Chatbot, Datos*. Etiquetas
  legibles (blancas), **sin subrayar**.
- **Deja hueco entre el anillo exterior y las etiquetas.** Coloca los nodos en un **círculo
  uniforme y compacto** para que todas las etiquetas queden por dentro del anillo con aire; el
  anillo (la "línea de puntos") va por fuera de todo.
- **Las ondas/pings deben llegar hasta el anillo** (escala del ping ≈ radio anillo ÷ radio base).
  Ondas pequeñas dentro de un diagrama grande se ven pobres.
- Núcleo con un **rayo** (estilo n8n) mejor que un "sparkle" que parece spinner de carga.
- **Para agrandar el diagrama en pantalla hay que ensanchar su columna**, no solo el radio: el
  anillo no puede superar el ancho del contenedor. Con `preserveAspectRatio="xMidYMid meet"`
  vigila si ajusta por ancho o por alto (según aspecto de viewBox vs contenedor): ampliar el
  viewBox baja la escala y el elemento **no crece**. Para bajar/subir el diagrama como pieza,
  un `translateY` sobre el SVG y sube el `min-height` del contenedor para que no se recorte.

### Fondo animado (aurora) del hero
- Una "aurora" de blobs difuminados (`filter:blur`, colores de marca) que **se desplaza** por
  detrás del hero da vida. Bucle **continuo** (keyframes multi-parada 0→100%), **no `alternate`**,
  con recorridos amplios. Respeta `prefers-reduced-motion`.

### Alineación fina (los detalles que delatan)
- **El check/icono en línea con SU texto**, no flotando arriba-izquierda de un bloque de 2
  líneas. Si el texto va en varias líneas, mete el icono en la primera línea (inline-flex).
- **CTAs dentro de tarjetas** ("Ver detalle") van **centrados**, no pegados a la izquierda.
- **Botón dentro de una card flex-column:** una card con `display:flex;flex-direction:column`
  y `align-items:stretch` (por defecto) **estira** un botón `inline-flex` a todo el ancho, y su
  contenido (icono+texto) queda a la izquierda → parece "descentrado en la pill". Pon
  **`justify-content:center`** en el botón (centra el contenido en el pill a todo el ancho) o
  `align-self:center` (pill compacto centrado). Se nota sobre todo en móvil.
- **Dos columnas alineadas por abajo:** reparte las filas de la columna más corta con
  `justify-content:space-between` para que ambas terminen a la misma altura.
- Da **aire** a un botón respecto al elemento de encima (no lo pegues). Microcopys de confianza
  en **dos líneas** legibles, no una línea larga que se parte fea.

### Verificación cuando hay animación continua
- Los **screenshots del preview se cuelgan** si la página tiene animaciones CSS/SVG infinitas.
  Verifica con **medidas del DOM** (`getBoundingClientRect`, `getComputedStyle`) vía `eval`:
  posiciones, tamaños, alineaciones, recortes y colores. Más fiable para "¿está
  alineado/centrado/recortado?" que una captura.

---

## 9. Colateral impreso / dossier comercial (PDF) — mismo sistema que la landing

Aprendido montando el **dossier comercial de 10→13 páginas de Evolution**. Un PDF de ventas
**no es un documento aparte**: es un miembro más del sistema visual de marca. Si la landing y
el PDF no "hablan igual", el cliente lo nota.

> ### ✅ Checklist rápido — dossier comercial (aplícalo SIEMPRE; esto destila 7 rondas de feedback de Alberto)
> Debajo está el detalle por rondas; **esto es el resumen accionable, léelo primero.**
> 1. **Mismo sistema visual que la landing** (fondo oscuro + aurora, Onest+Inter, eyebrow con chip
>    verde, `.kw` de acento). **Porta los diagramas REALES de la landing** (orbe, etc.), no dibujes
>    versiones pobres a ojo.
> 2. **CERO espacios en blanco, en NINGUNA página** (regla nº1 de Alberto, repetida 6 veces). Cuando
>    sobre hueco, en este orden: **(a) sube el tamaño de tipografía → (b) pon la frase clave en negrita
>    → (c) añade contenido** (mini-tarjetas de beneficio, más chips, línea de remate). Toolkit por bloque:
>    - Tarjeta alta hueca → **línea de remate `.feel`** abajo (`margin-top:auto`, borde arriba, acento) + contenido anclado arriba (`justify-content:flex-start`). ⭐ el truco más efectivo.
>    - Rejilla → prefiere **g2** (2 col) a g3; listas de texto → **filas con borde**; "montaña de dolores" → dolores compactos arriba + **panel de solución `flex:1`** que absorbe el resto.
>    - Filas con chips → **6-7 chips** para cubrir el ancho, no 4 sueltos. En general, **fila horizontal** (icono+texto+chips) llena mejor que tarjeta alta.
> 3. **Verifica overflow tras CADA tanda:** ninguna `.page` con `scrollHeight > clientHeight`. Subir
>    tamaños/añadir contenido desborda la A4 fácil; compacta la que se pase.
> 4. **Negrita, NO subrayado** en el punto clave de TODO texto de 2-3 líneas (leads, pasos, tarjetas,
>    diferenciadores). El subrayado solo en el titular del hero de portada.
> 5. **Portada:** logo + frase-posicionamiento + titular como **UN bloque centrado** (`flex:1;justify-content:center`),
>    no pegado arriba; pills de beneficio en **grid 2×2** con icono; línea de público objetivo **abajo junto al footer**.
> 6. **Copy = RESULTADO, no herramienta** (acelerar, tiempo, tranquilidad, clientes; la IA de fondo).
>    Para pymes **vende emoción** (tiempo/tranquilidad/menos líos → página "Lo que ganas"). **Declara el
>    alcance** ("cualquier negocio: tienda, pyme, grande"). **Método por pasos numerados** (paso 0 + 4).
>    **Última card de ejemplos = genérica** ("¿Y tu negocio?"). Mensaje ancla: "tú dices a dónde ir, nosotros el plan".
> 7. **Componentes premium:** ecosistema/proceso = **timeline en zigzag** (tarjetas alternando izq/der
>    colgando de una línea central punteada con conector + nodo); línea conectora entre cajas **centrada**
>    (`::before` a `left:calc(50% - 1px)`); contacto en **pills legibles** (icono acento + texto blanco), nunca gris apagado.
> 8. **⚠️ Gotchas que rompen el render:** (a) `<b>` inline dentro de un flex con `gap` se vuelve flex-item
>    y mete espacios raros → **envuelve el texto en `<span>`**; (b) una regla `.x b{display:block}` (para el
>    título) captura también los `<b>` del cuerpo y los rompe a línea aparte → apunta el título con **hijo
>    directo** `.x>div>b` y deja el bold inline aparte.
> 9. **Build:** Chrome/Edge headless `--headless=new --no-pdf-header-footer --print-to-pdf` **+ `--virtual-time-budget=12000`** (si no, las webfonts no cargan y los titulares caen a serif). Verifica por página con servidor local + Playwright (`file://` está bloqueado).

- **Reutiliza el lenguaje de la landing, no reinventes uno "de PDF".** Mismo fondo (oscuro +
  **aurora/nebulosa** difuminada), mismo **eyebrow** (chip de acento numerado + línea; **nunca**
  el uppercase con mucho tracking en fuente display: se ve viejo y "de plantilla"), mismos
  `.kw` de acento y mismas tarjetas. La fuente display de marca debe salir también en el PDF
  (ver nota de render): si los titulares caen a serif de sistema, todo el documento se abarata.
- **Portada:** fondo con nebulosa; logotipo grande (wordmark + isotipo con la **bola redonda,
  no aplastada** → viewBox cuadrado y `overflow:visible` para que el círculo no se recorte);
  titular con las **palabras importantes en color de acento y subrayadas**, el resto en ink.
- **Explicar, no rellenar ni resumir de más.** El error opuesto a "demasiado texto" es
  "demasiado poco": una página casi en blanco con solo un título **confunde** (¿falta algo?,
  ¿va aquí un diagrama?). Cada sección explica **cómo funciona** con copy real + su propio
  patrón visual. **Varía los patrones, no repitas 4 diagramas iguales:** radial (negocio al
  centro), flujo vertical de pasos, rejilla de categorías con checks, lista de dolores → caja
  de solución, tarjetas de servicios, timeline, casos por sector, diferenciadores, ecosistema.
- **Contraste del bloque de contacto/pie (error real):** email, teléfono, redes van en **pills
  legibles** (icono de acento + texto en ink/blanco), **nunca** en gris apagado sobre oscuro.
  Si no se leen, no sirven.
- **Coherencia entre TODOS los documentos públicos:** misma notación de niveles (si la landing
  usa N1–N5 sin la palabra "Nivel", el PDF igual), mismo vocabulario **de negocio** (Web,
  Ventas, Clientes…), no técnico.
- **Estructura de dossier comercial que funciona** (13 secciones, reutilizable): portada ·
  filosofía · qué hacemos (radial) · cómo trabajamos (método por fases) · qué analizamos
  (rejilla) · problemas que resolvemos · servicios · cómo es un proyecto (timeline) · ejemplos
  de transformación por sector · qué nos diferencia · ecosistema · cómo empezamos · cierre.

**Nota de render (build):** para HTML→PDF usa Chrome/Edge headless
`--headless=new --no-pdf-header-footer --print-to-pdf`. **Añade
`--virtual-time-budget=~12000`** o las webfonts multi-peso no cargan a tiempo y los titulares
caen a serif. Para verificar páginas sueltas: servidor estático local + Playwright/preview
(bloquean `file://`) y captura por página con `scrollIntoView` de la `.page` n.

**2ª ronda de feedback (cómo llenar la página de verdad, aprendido en el dossier):**
- **"Que el contenido ocupe toda la página" tiene truco.** Hay dos formas MALAS de rellenar:
  (a) un bloque compacto **centrado** → deja hueco arriba y abajo (parece vacío); (b) una
  rejilla **estirada** con el contenido pegado arriba → tarjetas huecas por abajo. La forma
  BUENA: **estira la rejilla** (`flex:1`, filas iguales `grid-auto-rows:1fr`) **y centra el
  contenido dentro de cada tarjeta** (`justify-content:center`), y **añade una línea
  descriptora** a cada una para darle cuerpo. Llenar = contenido que ocupa, no aire repartido.
  En bloques de pasos, `justify-content:space-between` reparte los pasos por todo el alto.
- **Reutiliza el diagrama REAL de la landing, no dibujes uno peor.** Si la landing ya tiene un
  orbe/círculo bueno (nodos rotulados alrededor + núcleo con el dato clave), **pórtalo tal cual**
  (mismo SVG + CSS, estático para print). Un diagrama hecho a mano "a ojo" para el PDF se nota
  pobre al lado del de la landing.
- **El producto es el RESULTADO, no la herramienta.** El copy lidera con lo que gana el negocio
  (acelerar, quitar frenos, traer clientes, ganar visibilidad, ahorrar tiempo, vender más). La
  IA/tecnología es el **medio** y va de fondo, **nunca como titular ni como "el qué"**. Reencuadra
  cada sección hacia el ángulo de negocio, no hacia la tecnología.
- **Mensaje de agencia que convierte:** "**tú nos dices a dónde quieres ir, nosotros te damos el
  plan**". Colócalo visible (callout en filosofía, título de "cómo trabajamos", "cómo empezamos").

**3ª ronda (llenar con tipografía, vender emoción, alcance y pasos explícitos):**
- **"Que ocupe toda la página" = subir el TAMAÑO de tipografía, no repartir aire.** Cuando una
  página se ve vacía, la solución que pide Alberto NO es estirar/centrar, es **hacer el texto (o
  las palabras clave) más grande** hasta que llene con dignidad. Prohibido dejar espacios vacíos
  "bajo ningún concepto". Verifica con DOM que **ninguna `.page` desborda** (`scrollHeight >
  clientHeight`) tras subir tamaños.
- **Para pymes/comercios, vende EMOCIÓN, no solo resultados de negocio.** Además de acelerar/
  clientes/ventas, el pain point que más mueve a un pequeño negocio es humano: **tranquilidad,
  más tiempo para él, menos problemas, y quitarle de encima lo que hoy se le hace una montaña**
  (responder, seguir, publicar…). Dedica una página entera a "Lo que ganas" (tiempo,
  tranquilidad, menos líos, todo automatizado) y cierra: "lo que te llevas no es tecnología, es
  tiempo y tranquilidad".
- **Declara el alcance de público explícitamente.** Que quede claro que sirve para **todo tipo de
  negocio: comercios, tiendas, pymes y empresas grandes** (pill en portada + "da igual tu sector
  o tu tamaño" en los ejemplos). No lo des por supuesto.
- **Haz explícitos y numerados los pasos del método.** Si el servicio tiene fases, enséñalas
  como pasos claros y numerados (en Evolution: paso 0 **Conectar** + 4 pasos **Análisis ·
  Consultoría · Implementación · Mantenimiento**). El paso 0 se distingue visualmente (nodo en
  gris, no verde). Debe leerse de un vistazo cuántos pasos hay.

**4ª ronda (rellenar de verdad, portada por zonas, subrayado y conexión):**
- **Rellenar una página = 3 palancas combinadas:** (1) subir tamaño de tipografía, (2) poner
  las **palabras clave en negrita** dentro del texto, y (3) **añadir mini-tarjetas de beneficio**
  (una fila de 3: "+ Clientes / + Tiempo / + Tranquilidad") para dar cuerpo sin aire. Si tras eso
  aún sobra hueco, sube más el tamaño. "Cero espacios en blanco bajo ningún concepto."
- **Portada por 3 zonas (`justify-content:space-between`):** arriba logo + kicker grande
  (la frase-posicionamiento "Consultoría para acelerar tu negocio" en tamaño display, no en
  eyebrow diminuto); en medio el titular grande; **abajo, junto al footer**, las pills de
  beneficio (3) + la línea de público objetivo. No amontones todo arriba centrado.
- **Subraya SIEMPRE las palabras clave** (verde + underline) en títulos y leads, no solo en la
  portada. Regla CSS global: `.title .kw, .lead .kw { text-decoration:underline }`.
- **"Todo conectado" = línea de puntos entre los boxes.** Para un ecosistema/flujo, una **spine
  vertical punteada** (`border-left:2px dotted acento` en `::before`, detrás de nodos con fondo
  sólido) que une los badges numerados comunica la conexión mejor que una rejilla suelta.
- **Más ejemplos por sector = más se imagina el lector dentro.** Amplía a 6 sectores (gimnasio,
  restaurante, clínica, comercio, peluquería/estética, servicios/taller) con viñetas apiladas.

**5ª ronda (rellenar cajas de verdad + gotchas):**
- **Rejilla de tarjetas altas que dejan hueco interior → conviértela en FILAS horizontales.**
  Una tarjeta estirada con poco texto siempre deja hueco arriba/abajo por más que centres. La
  solución que sí llena: **filas horizontales** (icono + título/subtítulo a la izquierda + los
  ítems como **chips** a la derecha), apiladas y repartidas con `space-between`. Llena por
  contenido real, no por aire. (Se aplicó a "Qué analizamos": de 6 tarjetas huecas → 5 filas.)
- **Listas sueltas → filas con borde (mini-cards).** Convertir una lista de texto plano (los
  "dolores") en **filas con borde/relleno** en 2 columnas les da cuerpo y llena la página; el
  texto plano flotando se ve vacío.
- **Subrayado NO por defecto.** Alberto NO quiere subrayados en el texto normal, solo **negrita**
  (y el color de acento para la keyword). Reserva el subrayado para donde lo pida explícitamente
  (p. ej. el titular del hero de portada). Regla: `.lead .kw { font-weight:600 }`, sin underline.
- **⚠️ Gotcha flex + `gap` + `<b>` inline:** en un contenedor `display:flex; gap:Npx`, un `<b>`
  (o cualquier inline) dentro del texto se convierte en **flex-item independiente** y el `gap`
  mete espacios raros alrededor de la palabra ("Poco⎵tiempo⎵para todo"). **Envuelve el texto en
  un `<span>`** para que el flex solo vea [icono, span].
- **Portada por zonas, pills en rejilla 2×2.** Baja el logo + kicker con `margin-top` (no pegado
  al borde). Las pills de beneficio en **grid de 2 columnas** (pares equilibrados, no 2+1
  descuadrado), con icono cada una. El público objetivo, abajo junto al footer.

**6ª ronda (el truco definitivo para llenar tarjetas + negrita sistemática):**
- **⭐ Truco de la línea de remate (`.feel`) para llenar tarjetas altas sin hueco.** Cuando una
  tarjeta en rejilla `tall` se estira y deja hueco interior: NO centres el contenido; ancla el
  bloque icono+título+texto **arriba** (`justify-content:flex-start`) y añade una **línea de
  remate** abajo (`.feel` con `margin-top:auto` + `border-top`, en color de acento, tipo "→ El
  punto de partida de todo"). Así la tarjeta se llena de arriba (contenido) a abajo (remate) sin
  aire en medio. Es la solución más limpia al recurrente "las cajas tienen hueco".
- **Tarjetas: prefiere 2 columnas (g2) a 3 (g3)** para que cada tarjeta sea más baja y se llene
  con menos contenido. 6 tarjetas → 2×3 mejor que 3×2.
- **Página "montaña de dolores": dolores compactos arriba + panel de solución grande (`flex:1`)
  abajo.** Una lista de 10 ítems repartida con `space-between` deja huecos horribles (fue "la
  peor slide"). Solución: dolores en filas con borde a gap fijo (natural, arriba) + un **panel
  de solución que ocupa el resto** (`flex:1`) con mensaje + 3 mini-tarjetas de beneficio. Llena
  sin huecos porque el panel absorbe todo el espacio sobrante.
- **Negrita sistemática en TODO texto largo (2-3 líneas).** Alberto quiere el punto clave en
  **negrita** en cada lead, cada descripción de paso, cada tarjeta y cada diferenciador. No es
  opcional: repasa el PDF entero y marca una frase-ancla por párrafo. (Sigue sin subrayar.)
- **Rellena con chips hasta cubrir la caja.** En filas con chips (áreas/servicios), pon **los
  suficientes chips** para que ocupen casi todo el ancho de la fila; 4 sueltos dejan la caja
  medio vacía, 6-7 la llenan.
- **⚠️ Gotcha de overflow al añadir contenido:** subir tamaños/añadir tarjetas puede desbordar
  la A4. Tras cada tanda, mide `scrollHeight > clientHeight` por `.page` y compacta la que
  desborde (menos padding, `line-height`, o menos ítems) hasta 0 desbordes.

**7ª ronda (portada centrada, rellenar paneles, card genérica, gotcha `b` y línea centrada):**
- **⚠️ Gotcha `display:block` en selector de `b` por clase:** una regla como `.diffs li b{display:block}`
  (pensada para el TÍTULO) también captura los `<b>` que metes DENTRO del texto → rompen a línea
  aparte y dejan el punto/resto solo (se ve fatal). Apunta el título con **hijo directo**
  (`.diffs li>div>b`) y define aparte el bold inline (`.diffs li span b{font-weight:600}`). Vale
  para cualquier componente con `b` estilizado a bloque (`.mini b`, `.eco .n b`, `.solve2 .row3 b`…).
- **Portada: centra el grupo logo+kicker+título como UNO** (`.cover .mid{flex:1;justify-content:center}`),
  no lo claves arriba. Alberto lo quiere bajado y centrado en la mitad superior, con las pills abajo.
- **Rellenar un panel = estira la rejilla interior, no centres un bloque pequeño.** El panel de
  solución dejaba hueco con `justify-content:center`. Fix: cabecera arriba (fija) + la fila de
  tarjetas con `flex:1` (estira a lo alto) y su contenido centrado. El panel se llena entero.
- **Última card de "ejemplos por sector" = GENÉRICA.** Pon N-1 sectores concretos y **la última
  card genérica y destacada** ("¿Y tu negocio? Sea cual sea tu sector…", fondo de acento) para que
  se entienda que sirve para cualquier negocio.
- **Línea de conexión CENTRADA entre cajas full-width:** `::before` con `left:calc(50% - 1px)`
  muestra los segmentos punteados en el **centro** de cada hueco entre cajas. Funciona con nodos
  **horizontales compactos** (badge izq + texto); un timeline **vertical** de 9 nodos NO cabe en
  A4 (desborda y choca con el pie) — no lo uses para 9 ítems.
- **Espacio antes del cierre.** La última caja de una lista no debe quedar pegada a la frase/quote
  de resumen: dale `margin-top` a la frase para que respire.
- **Una lista de cajas + línea recta se ve floja → súbela a TIMELINE EN ZIGZAG.** Para un
  ecosistema/proceso, alterna las tarjetas izquierda/derecha (`nth-child(odd/even)` con
  `align-self` + `flex-direction:row-reverse` en las pares para que el icono mire al centro),
  cada una colgando de la **línea central punteada** con un **conector horizontal** (`::before`)
  y un **nodo/punto verde** (`::after`) sobre la línea. Añade icono + número (`01`…) a cada
  tarjeta. Queda premium y la línea centrada por fin tiene sentido. `width:calc(50% - 30px)` por
  tarjeta y conector de 30px cuadran el nodo justo en el centro.

## 9. Móvil — probar y arreglar SIEMPRE (no solo mirar en escritorio)

**Regla (petición explícita del cliente):** toda landing se prueba en **móvil (~375px)** y
**tablet (~768px)** y se **arregla** antes de darla por buena. No basta con que se vea bien en
desktop. Verifica que **no hay scroll horizontal real**: `window.scrollTo(300,0)` y comprueba
que `window.scrollX` vuelve a 0 (`body{overflow-x:hidden}` **esconde el síntoma** pero el
contenido se sigue cortando; hay que arreglar la causa).

Fallos típicos de móvil (todos vistos en Evolution) y su arreglo:
- **Grid que "revienta" el ancho:** un `1fr` es `minmax(auto,1fr)` y su mínimo es el
  min-content del hijo más ancho (un orbe de 560px, un titular largo) → empuja la página. Usa
  **`grid-template-columns:minmax(0,1fr)`** y **`min-width:0`** en los items para que encojan.
- **Flexbox encoge un elemento de tamaño fijo:** un visual con `width:560px` dentro de un
  `display:flex` se **encoge** (flex-shrink:1) por debajo de su tamaño y, si por dentro tiene
  nodos posicionados en px, **se descolocan**. Ponle **`flex:none`** y controla el tamaño con
  `transform:scale()`.
- **`transform:scale()` no reduce el footprint de layout:** el elemento sigue ocupando su
  tamaño original y desborda. Recórtalo con **`overflow:hidden`** en el contenedor y colapsa el
  hueco sobrante con **márgenes negativos** (`margin:-Npx 0`). Escala más en móvil (p. ej.
  orbe: `scale(.74)` tablet, `scale(.56)` teléfono).
- **Paneles `position:absolute` (carruseles) se cortan:** en móvil su contenido apilado es más
  alto que el `min-height` de escritorio → **sube el `min-height` en la media query móvil**
  hasta que el panel más alto quepa, y reduce el padding lateral.
- **Chips/pills de texto largo con `height` fija** se salen: en móvil `height:auto;
  white-space:normal` para que envuelvan.
- **Filas tipo tabla (`1fr 96px 66px`)** se salen con textos largos: en móvil `minmax(0,1fr)`
  en la primera columna + `min-width:0` en el texto, y reduce las columnas fijas.
- **Flex que pasa de fila a columna en móvil — resetea TODAS las medidas de escritorio.** Un
  conector/divisor fino (`.fconn`) con `min-width:24px` puesto para la fila horizontal se
  queda en móvil como un **bloque gordo de 24px** en vez de una línea de 2px (la media query
  cambió `width` pero olvidó `min-width`). Pon `min-width:0`. Y cuando la fila se vuelve
  columna, cambia `align-items:flex-start` → **`align-items:center`**: si no, los conectores
  finos se van a un lado y **no coinciden con el centro de los nodos** (nodos anchos centrados,
  conector pegado a la izquierda = se ve roto).
- **Verificación:** con animaciones continuas los **screenshots se cuelgan**; mide con
  `getBoundingClientRect`/`offsetWidth` a 375 y 768 y comprueba el scroll real con `window.scrollX`.
  Para diagramas apilados en móvil, comprueba que **el centro x de nodos y conectores coincide**.

---

## 10. Que NO parezca hecha por IA (anti-convergencia)

> **Origen:** feedback de Alberto sobre una landing de prueba. Matiz clave (lo dijo él mismo):
> **"personalmente NO me gustó, pero reconozco que era distinta"**. Ese matiz ES la lección:
> el mercado converge en el **mismo look de IA**, y salir de ahí es valioso y raro — **pero
> "distinta" no equivale a "buena"**. Diferenciarse es **necesario, no suficiente**. La meta es
> distinta **Y** que guste; perseguir la originalidad a costa del atractivo (páginas frías,
> demasiado de coña, demasiado vacías, o "raras porque sí") falla igual. Aplica a TODA landing.
>
> **Regla operativa:** anti-convergencia primero (romper los defaults de IA), y **luego** el
> filtro de siempre — ¿es atractiva, cálida y da confianza para ESTE cliente y su público? Si
> una decisión distintiva resta atractivo o claridad, gana el atractivo. No confundas "no parece
> de IA" con "está terminada".
>
> **Caso concreto (qué falló en la de prueba):** Alberto la marcó como **fría/austera** y la
> **tipografía/estética no le convenció**. Diagnóstico: la búsqueda de "distinta" se fue al
> **minimalismo-lujo-serio** (crema apagado + serif elegante + mucho espacio vacío + círculo
> vacío + tono de coña deadpan), y eso se lee **soso y sin vida**, no premium. **Aprendizaje:
> diferénciate sin caer en lo frío/vacío.** Para el gusto de Alberto, una landing distintiva
> debe conservar **calidez, energía y densidad visual** (color vivo con criterio, movimiento,
> secciones con cuerpo). El minimalismo austero NO es su norte. "Distinta" tira hacia **cálida y
> con vida**, no hacia **elegante-y-vacía**.

**El problema:** cuando pides "haz una landing bonita", casi todas las IAs caen en el mismo
puñado de decisiones. El resultado se ve competente pero **genérico e intercambiable**. El
usuario lo detecta al instante ("esto lo ha hecho una IA"). La cura es una disciplina explícita
de anti-convergencia.

**Palancas para no parecer IA (todas se aplicaron en la landing que gustó):**

1. **Tipografía con carácter, no la fuente de turno.** Evita las caras sobreusadas que toda UI
   generada comparte: **Inter, Roboto, Arial, Open Sans, Geist, Manrope, Plus Jakarta Sans,
   Space Grotesk, Fraunces**. Elige una display con personalidad (p. ej. *Instrument Serif*,
   *Bricolage Grotesque*, una serif editorial) + una grotesca menos trillada para cuerpo (p. ej.
   *Hanken Grotesk*). **Siempre** salen de `brand-tokens.json`; lo que se hereda aquí es el
   criterio "distintiva > default".
2. **Nada de marcadores numéricos decorativos** `01/02/03` en tarjetas no secuenciales (ver §3).
   Es el andamiaje editorial de IA un nivel por debajo del eyebrow con tracking.
3. **Cadencia aforística: una vez vale, el patrón delata.** Frases-latiguillo de contraste
   fabricado ("No es X. Es Y.", "X. Just Y.", "No una función. Una plataforma.") en 3+ secciones
   suenan a IA, no a voz. Deja **una** como golpe de efecto y varía el resto.
4. **Paleta cálida/inesperada, no la de IA.** Huye del cian-sobre-oscuro, el degradado
   morado→azul y los neones. Un crema + tinta + un acento apagado (dorado, oliva, terracota)
   ya se lee "de diseñador", no "de plantilla".
5. **Layout intencional y asimétrico** (bento con celdas de distinto peso), no la rejilla
   centrada de icono + título + texto repetida 3-6 veces.
6. **Voz humana con opinión y ritmo variado.** Líneas cortas y secas mezcladas con otras más
   largas; detalles concretos; humor si encaja. Sin vocabulario-IA (§4 y `humanizer`).
7. **Iconos SVG por concepto**, nunca emojis como iconos; un icono distinto por ítem.

**Herramienta que lo automatiza (usarla siempre en landings):** el hook de diseño de
**`impeccable`** marca justo estos tells — `overused-font`, `numbered-section-markers`,
`aphoristic-cadence`, paletas y cadencias de IA — mientras editas. Trátalo como el **checklist
anti-convergencia**: cada finding es un "esto huele a IA, cámbialo" salvo que sea intencional y
lo confirmes. La skill `frontend-design` (regla del *AI Slop Test*: "si alguien diría al instante
'esto lo hizo una IA', rediséñalo") va en la misma dirección. Corre `/impeccable audit` antes de
dar por buena una landing, además de la puerta `verify` + `security-review`.

---

## 11. Estructura y copy para el lector frío (pyme pequeña) — ronda jul-2026

> **Origen:** revisión completa de la landing de Evolution pedida por Alberto ("no sé si
> atacamos los pain points para alguien que lo lee la primera vez"). El diagnóstico se
> confirmó y la reestructuración se aplicó. Estas reglas van ANTES que el acabado fino:
> son de arquitectura de la página, no de píxeles.

### Ordena por las preguntas del lector, no por tu proceso
El error de fondo: la página estaba organizada según el proceso del consultor (fases →
cómo trabajo → qué analizo → el motor) y el dolor reconocible llegaba en la sección 5.
El lector frío trae estas preguntas **en este orden**: *¿esto qué es? → ¿me reconozco en
el dolor? → ¿qué hacéis? → ¿cómo? → ¿qué me llevo? → ¿me fío de ti? → ¿qué me cuesta?*
- **La sección de reconocimiento del dolor va justo después del hero** (en Evolution:
  las 4 tarjetas de negocios reales con "¿Te suena alguno de estos?"). Es la sección
  que mejor convierte curiosidad en lectura.
- **Máximo 2 secciones de proceso.** Si dos secciones cuentan la misma historia desde
  ángulos distintos ("cómo funciona" vs "el motor por dentro"), sobra una: quédate con
  la mejor y transplanta sus frases buenas.
- **El "yo" aparece después de presentarte.** Si la página habla en "nosotros" (método)
  y en "yo" (compromiso personal), ordena las secciones para que todo "yo" quede
  DESPUÉS de "Quién está detrás". La mezcla antes de la presentación huele a fachada.

### El hero responde "¿esto qué es?" en 3 segundos
- **El chip del hero dice la categoría** ("Consultoría para pymes y pequeños negocios"),
  no repite el H1. Chip = qué es; H1 = el dolor; lead = qué te llevas; micro = miedos
  fuera ("sin coste, sin llamadas, en 5 minutos").
- **H1 con el dolor en palabras del lector**, no metáforas de consultor ("acelerar" ✗).
  El patrón que quedó: *"Tu negocio da para más. Descubre qué lo frena."* — conecta con
  el hook "eres bueno pero no le sacas partido".
- **La frase más potente de la página debe ser un título, no un subtítulo.** ("Tu
  negocio solo crece al ritmo de su área más débil" estaba escondida bajo un h2 flojo.)

### Títulos que afirman el mensaje de su sección
- El título dice **lo que el lector gana**, no el nombre del concepto: "Empiezas gratis
  y avanzas solo si te compensa" ✓ vs "Del diagnóstico a una evolución continua" ✗.
- **Ni defensivos ni condescendientes:** "No es humo" plantea la duda que quiere negar;
  "Para que lo entiendas" suena a hablarle a un niño. Reformula en positivo.
- Los nombres propios de programa se explican en una línea ("Se llama Programa
  Fundadores porque tú eres de los primeros") o el lector los malinterpreta.

### Glosario prohibido para público pyme (sustituciones validadas)
| ✗ No | ✓ Sí |
|---|---|
| quick wins | mejoras rápidas |
| KPIs | métricas / datos claros |
| proceso algorítmico | nuestro método (prosa) · nuestro algoritmo (respuesta instantánea) |
| agregadores | plataformas (o el nombre: Glovo, TheFork…) |
| tu empresa (micro-negocio) | tu negocio |
La palabra **IA** solo donde construye confianza explicando la supervisión humana ("la
IA es la herramienta; el criterio y las decisiones son humanas"); nunca como reclamo.

### No devalúes el gancho gratuito
Si el embudo es "gratis → de pago", el copy del de pago **multiplica** al gratuito, no
lo anula: *"el inicial ya te da valor real; el profundo lo multiplica"* ✓ vs *"el
profundo es el que de verdad aporta valor"* ✗ (le dice al lector que lo que va a hacer
ahora no vale nada).

### Mecánica de reestructuración (para la próxima vez)
- Mover secciones enteras a mano con Edit es frágil; un **script que corta por los
  comentarios marcadores** (`<!-- N · NOMBRE -->` → `</section>`) y reinserta es fiable
  y permite verificar el orden final por programa.
- Tras reordenar: renumerar eyebrows y comentarios, regenerar el índice lateral (si el
  TOC móvil se clona del sidenav por JS, basta tocar el sidenav), comprobar **anclas
  rotas** (`a[href^="#"]` sin destino) y que el JS de la sección eliminada se
  auto-desactive (guard `if(!nodes.length) return`).

## Apéndice — valores probados de Evolution (punto de partida, no ley)

Sistema de la landing de Evolution tras todas las rondas de feedback. Úsalo como *plantilla
de proporciones*; **sustituye colores y fuentes por los de `brand-tokens.json` del cliente.**

```
/* Ritmo y aire */
.sec        { padding: 74px 0 }              /* móvil (≤720px): 54px 0 */
contenedor  { padding-inline: 40px }          /* móvil: 22px */
.head h2    { margin-top: 16px }              /* poco margen bajo el eyebrow */

/* Tipografía (roles, no hex) */
display  → fuente de marca con carácter, 700–800   (Evolution: Onest)
cuerpo   → sans legible 16px / line-height 1.65     (Evolution: Inter)
mono     → solo cifras/etiquetas técnicas           (JetBrains Mono)
hero h1  → clamp(2.7rem, 5.8vw, 4.6rem); letter-spacing:-.035em
sec  h2  → clamp(2rem, 4vw, 3rem)
lead     → clamp(1.08rem, 2vw, 1.25rem); max-width:46ch

/* Eyebrow (en vez de "//") */
.eyebrow  { font:700 .84rem Onest; text-transform:uppercase; letter-spacing:.1em; color:acento }
.eyebrow .num { badge acento, 800 .82rem, border-radius:7px, padding:2px 9px }
.eyebrow .ln  { width:26px; height:2px; background:acento }

/* Accesibilidad */
:focus-visible { outline:2px solid acento; outline-offset:3px }

/* Escenario de animación */
.stage    { min-height:500px }                /* que la animación lo llene */
diagramas { transform:scale(1.08–1.12) }      /* desactivar en móvil */
```

> Estos valores nacieron del feedback iterativo real; parten de un buen sitio. Ajústalos al
> caso, pero si empiezas de cero, empieza de aquí.

---

## 13. Aprendizajes técnicos — Munay (jul-2026)

Lecciones operativas de la primera landing para negocio local con fotos de Instagram.

### Imágenes desde Instagram
- **Perfil de IG para logo**: 803 bytes no es un logo válido. Playwright con `deviceScaleFactor: 3`,
  navegar al post del cliente, localizar el `img[alt*="<marca>"][alt*="profile"]`, y hacer
  `element.screenshot()` desde la página de IG (same-origin). El resultado (~18KB) es válido.
- **Foto de post para hero**: `element.screenshot()` del `<img>` en la página de IG captura
  también el borde oscuro del contenedor (~3px). Recortar con PIL después.
- **Cross-origen CDN**: Instagram bloquea `canvas.toDataURL()` (TaintedCanvas). No se puede
  descargar vía `fetch` desde la página. Usar `element.screenshot()` de Playwright.
- **Fotos del cliente**: pueden estar en `marca/assets/` con alta resolución (1086×1448), no solo
  en `entregables/landings/assets/`. Buscar en TODAS las carpetas del cliente antes de
  conformarse con una versión pequeña.

### Hero con crossfade
- Múltiples imágenes apiladas con `position:absolute; inset:0; object-fit:cover` dentro de un
  contenedor `.cf`. CSS `@keyframes cf` con opacidad: 0%→6.25% fade in, 18.75%→25% fade out,
  duración total 16s para 4 imágenes (4s cada una, staggered con `animation-delay`).
- Las imágenes IG (640×1138) se ven bien en hero con `object-fit:cover` y aspect-ratio 4:5.
- No mezclar `<img>` directo con las del crossfade: el `z-index` de ambos compite.

### Cache y servidor
- **Cache busting**: cambiar `?v2`→`?v3` en src para forzar recarga del navegador.
- **Python http.server en Windows**: usar `Start-Process` con `-WorkingDirectory` para lanzarlo
  desde la carpeta correcta. El primer intento con `Start-Job` falla porque hereda el CWD.
- Si el servidor deja de responder (TIME_WAIT), matar el proceso y esperar.

### CSS y layout
- **Óvalo hero**: `aspect-ratio:4/5` con `border-radius` irregular animado (blob).
- **Grid hero para óvalo grande**: `.9fr 1.1fr` da más espacio a la foto que al texto.
- **Micro con Instagram debajo**: separar teléfono e Instagram en dos divs apilados, no en línea.
- **Iconos SVG inline**: WhatsApp (auricular), Instagram (cámara/cuadro). Pegar el SVG directo
  en el HTML, no como archivo externo.
- **Quitar etiquetas del hero**: `.glyph` y `.ph-label` compiten visualmente con la transición.
  Si el hero es galería de fotos, solo fotos.

### Formato de archivo
- Copiar un `.jpg` como `.png` funciona (el navegador detecta el content-type del MIME real),
  pero es más limpio convertir explícitamente o mantener la extensión correcta.

---

## 12. Fidelidad a la marca REAL del cliente (peluquería Munay, jul-2026)

> **Origen:** Alberto rechazó dos veces la landing de Munay. La 1ª por inventarse una estética
> (malva + dorado) que no era la del cliente; la 2ª ("mejor pero aún le falta") por quedarse en
> reconstrucción y placeholders en vez de usar los activos reales. Es la lección que **más sube**
> una landing de negocio local. Va ANTES que el acabado fino.

- **Antes de diseñar, ABSORBE la marca real del cliente de su IG/web.** Mira su logo, sus fotos,
  su tipografía y su color EXACTOS, y su voz. No inventes una estética "de peluquería genérica".
  El fallo nº1 de Munay fue una paleta inventada; se ve cutre al instante.
- **Usa el LOGO REAL, no una reconstrucción "parecida".** Consíguelo (perfil de IG, web, o pídelo)
  y úsalo tal cual (PNG/SVG con transparencia). Reconstruirlo en SVG "a ojo" se nota. Munay: disco
  con textura de pelo + "munay" en serif + "HAIR SALON" en caja pequeña.
- **Clona SU tipografía y SU color aunque la fuente esté en la lista "de IA" (§10).** La regla
  anti-convergencia **cede ante la fidelidad**: si la marca del cliente ES un serif Didone bold
  sobre crema, úsalo — es su identidad real, no un default de IA. Munay: **crema/beige (~#f4efe3)
  + negro**, **serif editorial** (Didone bold para titulares al estilo de sus posts "Don't text
  him. Text me your inspo pic" + serif elegante para el logo/citas). Sans fino solo para labels.
- **Fotos reales de sus trabajos Y de las personas.** Una landing de servicio local con
  placeholders grises siempre "le falta". Coge de su IG público / web: trabajos (antes/después)
  y **fotos del equipo real**. Deja `<img>` con `onerror` que caiga a un placeholder elegante,
  para que la página quede lista y baste **soltar los ficheros** en `assets/`.
- **Cuenta su historia con nombres y cara — sección "Nosotras".** La gente contrata a personas.
  En Munay son **Ruth y Sabrina**: su foto + su historia genera más confianza que cualquier copy.
  Un negocio local sin las caras detrás se lee frío.
- **Recoge su voz de marca, no la aplanes.** Munay habla juvenil/femenino y directo ("Don't text
  him. Text me your inspo pic", "energía bonita y pelazo"). Esa voz es un activo; úsala.
- **Cómo conseguir las imágenes (gotcha):** Instagram y muchas PWA de reserva (ViDay) **bloquean
  el scraping automático** — Firecrawl rechaza IG y WebFetch no ve el contenido JS. Vías reales:
  (a) pedir los archivos al cliente/Alberto (lo más rápido), (b) navegador con sesión iniciada
  (claude-in-chrome), (c) dejar la página preparada con `onerror` y que suelte los ficheros.

### Reglas "SIEMPRE" para negocio local (Munay, 2ª ronda de feedback)
- **Reseñas SIEMPRE reales de Google, con su autor.** Nunca inventes testimonios ni pegues los de
  otro negocio con nombre parecido (había un "Saló Munay" de Sant Cugat y otro de México: NO son
  el cliente). Busca la ficha de Google y trae las reseñas reales con su comentario y nombre, más
  la nota media y el nº de reseñas (Munay El Prat: **5,0 ★ · 13 reseñas**), y un enlace "Ver todas
  en Google". **⚠️ Prueba variantes exactas del nombre:** buscar "Munay Hair Salon" (con espacio)
  NO devolvió la ficha; "Munay HairSalon" (junto, como lo escriben ellos) sí. Firecrawl `scrape`
  de la SERP de Google con `proxy:stealth` + `jsonOptions` extrae autor/estrella/texto. Solo si de
  verdad no hay reseñas, deja slots marcados y avisa de activar su Google Business Profile.
- **Localización SIEMPRE con mapa embebido real**, no una tarjeta decorativa. Iframe de Google
  Maps sin API key: `https://www.google.com/maps?q=<dirección+urlencoded>&output=embed`
  (`loading="lazy"`, `referrerpolicy`, `border:0`). Mantén al lado el botón "Cómo llegar".
- **Carrusel de fotos = patrón fuerte para negocios visuales** (peluquería, restaurante, estética).
  Un carrusel horizontal con scroll-snap (auto-avance pausable al hover/focus, respeta
  `prefers-reduced-motion`, swipe en móvil) luce mucho más que una rejilla estática de trabajos.
