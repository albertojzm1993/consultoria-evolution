---
name: manual-de-marca
description: Construye el Manual Integral de Marca de una empresa (identidad verbal, visual, personalidad, posicionamiento y esencia) como un brand book profesional de 20 secciones, y genera además brand-tokens.json — la fuente de verdad que el resto de servicios (web, landing, blog, redes, newsletter) consumen para un look & feel unificado. Úsala como PRIMER paso de cualquier proyecto de cliente, o cuando el usuario pida definir marca, identidad, branding, tono de voz, arquetipo, paleta de colores, tipografías, misión/visión/valores, storytelling o guía de estilo.
---

# Manual Integral de Marca

## Misión de la skill
Construir un documento que defina **completamente** la identidad de una marca —no
solo lo visual, también personalidad, comunicación, posicionamiento y esencia— de
modo que cualquier diseñador, redactor, empleado o IA pueda representar la empresa
con total coherencia en cualquier canal.

## Qué produce (3 entregables acoplados) en `<cliente>/marca/`

1. **`BRAND.md`** — el **brand book profesional** de 20 secciones (entregable
   principal para el cliente, exportable a PDF). Redactado como lo haría una
   consultora de estrategia de marca: claro, ejecutivo, práctico.
2. **`brand-tokens.json`** — fuente de verdad *machine-readable* (schema en
   `../../CONTRATO-MARCA.md`). Es lo que permite que web, landing, blog, RRSS y
   newsletter salgan coherentes sin reinventar colores ni tono.
3. **`resumen-marca.md`** — copia suelta del bloque reutilizable de 300-500
   palabras (sección 20). Sirve como contexto para pegar en cualquier otra skill
   o prompt.

`BRAND.md` y `brand-tokens.json` deben quedar SIEMPRE sincronizados: cada dato del
manual sale del JSON y viceversa.

## Principio rector
> El Manual de Marca es el cimiento. Todo lo demás se construye encima. Cada
> decisión (un color, un rasgo, una palabra prohibida) tendrá consecuencias en
> decenas de piezas posteriores. Decide con criterio estratégico, no estético.

## Reglas de rigor (no negociables)
- **Nunca inventar hechos.** Si una historia o dato no está documentado, se
  construye como *propuesta* y se marca como tal.
- **Marca las inferencias con nivel de confianza**: `[Confianza: alta/media/baja]`.
  Alta = está en las fuentes. Media = deducido de indicios. Baja = propuesta a
  validar.
- **No inventes** datos de contacto, redes ni teléfonos: pídelos o déjalos vacíos.
- **Test anti-genérico**: si un valor/rasgo/mensaje sirve igual para cualquier
  empresa ("compromiso", "calidad"), está mal. Concrétalo con un comportamiento
  observable del negocio.

## Entradas
Fuente principal: **Perfil Maestro del Negocio** (si existe). Además, cualquier
material aportado: web, redes, logos, presentaciones, catálogos, fotografías,
material gráfico, entrevistas e información del usuario. Si no hay Perfil Maestro
ni material suficiente, usa `templates/entrevista-descubrimiento.md` para obtener
lo mínimo imprescindible. Si el usuario no sabe algo, propón tú una opción
razonada (marcada como propuesta) y pide validación; no bloquees el trabajo.

---

## Flujo de trabajo

### Paso 0 — Preparar el espacio
Pregunta el **nombre del cliente/negocio** y crea `<cliente>/marca/assets/`.
Reúne todas las entradas disponibles (empezando por el Perfil Maestro).

### Paso 1 — Análisis y descubrimiento
Extrae de las fuentes todo lo aprovechable antes de preguntar. Rellena huecos con
la entrevista solo donde falte información para decidir. Lee
`references/estrategia-marca.md` (frameworks verbales) y
`references/sistema-visual.md` (sistema visual y accesibilidad).

### Paso 2 — Redactar el brand book (las 20 secciones)
Redacta `BRAND.md` desde `templates/BRAND.md`. Contenido de cada sección:

1. **Resumen ejecutivo** — descripción breve de la empresa y su identidad.
2. **Esencia de marca** — qué representa, qué la hace única, qué transformación
   ofrece, qué promete (pocas líneas, potentes).
3. **Misión** — por qué existe (accionable, específica del negocio).
4. **Visión** — a dónde va.
5. **Valores** — 3-5, **explicando cada uno** con un comportamiento observable
   (no listas de palabras sueltas).
6. **Posicionamiento** — por qué elegir esta empresa frente a otra; qué espacio
   ocupa en la mente del cliente. Usa la plantilla de posicionamiento del
   reference.
7. **Público objetivo** — cliente ideal: necesidades, problemas, motivaciones,
   expectativas y objeciones.
8. **Personalidad de marca** — la marca como persona: carácter, forma de hablar,
   actitud, formalidad, nivel técnico, estilo, comportamiento.
9. **Arquetipo** — principal (+ secundario si aplica), **justificado**, con
   `[Confianza: …]`.
10. **Voz y tono** — cómo habla, lenguaje, expresiones que usa/evita, cercanía,
    nivel técnico, nivel emocional, humor, formalidad. Formato **somos / no
    somos + reglas accionables**.
11. **Mensajes clave** — 5-10 ideas que deben repetirse en toda comunicación.
12. **Palabras clave** — términos que representan la marca.
13. **Palabras prohibidas** — expresiones que contradicen la identidad.
14. **Storytelling** — la historia de la marca. Si no hay historia documentada,
    construye una narrativa con lo disponible y márcala como propuesta.
15. **Identidad visual** — logotipo y versiones, paleta, tipografías, iconografía,
    ilustración, estilo gráfico, uso de espacios, botones, formas, elementos
    característicos. Indica claramente lo que NO se ha podido definir.
16. **Estilo fotográfico** — tipo de imágenes que mejor representan la marca.
17. **Estilo para imágenes IA** — iluminación, encuadres, colores, vestimenta,
    escenarios, expresiones, nivel de realismo. Debe cristalizar en el campo
    `imagery.prompt_ia_base` del JSON.
18. **Principios de comunicación** — reglas generales (p. ej. "siempre desde el
    beneficio para el cliente", "explicar lo complejo de forma sencilla").
19. **Guía para Inteligencias Artificiales** — instrucciones **reutilizables**
    sobre cómo debe comportarse, escribir, responder y dirigirse al cliente una
    IA que represente la marca, y qué debe evitar. Redáctalo como bloque de
    instrucciones que otras skills puedan cargar tal cual.
20. **Resumen ejecutivo para reutilización** — bloque de **300-500 palabras** que
    condensa toda la identidad y puede copiarse directamente a otros prompts.

### Paso 3 — Generar los archivos técnicos
1. Escribe `brand-tokens.json` siguiendo EXACTAMENTE el schema de
   `../../CONTRATO-MARCA.md`. En la parte visual aplica criterio de accesibilidad:
   - **Contraste WCAG AA obligatorio**: cada color de marca lleva su `on` (color
     de texto legible encima, ≥4.5:1 en texto normal). Verifica, no adivines.
   - Incluye la variante `dark` (modo oscuro).
   - Prioriza Google Fonts. Define escala tipográfica, radios, espaciado (base 8),
     sombras y contenedor.
   - Deja `""` los campos que desconozcas (contacto, redes); no inventes.
2. Extrae la sección 20 a `resumen-marca.md`.

### Paso 4 — Validación (checklist obligatorio antes de entregar)
- [ ] Coherencia entre misión, visión y valores.
- [ ] La personalidad coincide con el posicionamiento.
- [ ] El tono refleja la identidad de la empresa.
- [ ] Los mensajes clave son coherentes entre sí y con el resto.
- [ ] El manual es usable por un diseñador, por un copywriter y por una IA.
- [ ] Ningún valor/rasgo/mensaje es genérico intercambiable.
- [ ] Toda inferencia lleva su nivel de confianza.
- [ ] `brand-tokens.json` es JSON válido y conforme al schema.
- [ ] Cada color de marca con su `on` cumple contraste AA.
- [ ] `BRAND.md` y `brand-tokens.json` coinciden dato a dato.
- [ ] Existe `imagery.prompt_ia_base` reutilizable y sección 19 (Guía IA).

### Paso 5 — Handoff (nota para el consultor, no va en el manual)
Indica que la marca está lista y que ya pueden ejecutarse las demás skills (web,
landing, blog…), que leerán `brand-tokens.json` y `resumen-marca.md`
automáticamente. Ofrece exportar `BRAND.md` a PDF para entregar al cliente.

## Vista previa visual (recomendado)
Ofrece generar un **tablero de marca** de una página (HTML) con paleta,
tipografías, botones y muestras de tono, usando las variables del JSON. Es el
mejor "wow" para validar el look & feel con el cliente antes de construir la web.

---

## Alcance del entregable (restricciones del manual)
El **contenido de `BRAND.md`** es un brand book puro. Dentro del manual **NO**:
- inventes hechos (marca propuestas e inferencias),
- hagas recomendaciones comerciales, auditorías ni propuestas de mejora,
- hables de SEO, automatizaciones, herramientas ni ventas de servicios.

> Nota: `brand-tokens.json`, `resumen-marca.md` y el handoff del Paso 5 son
> plomería técnica del sistema de skills, no forman parte del brand book y por
> tanto no rompen estas restricciones.

## Estilo de redacción
Como un Brand Book profesional de una consultora especializada en estrategia de
marca: claro, ejecutivo y práctico. Referencia única para mantener la coherencia
de la marca en cualquier canal.
