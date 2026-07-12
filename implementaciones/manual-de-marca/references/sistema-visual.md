# Referencia — Sistema visual

Decisiones visuales pensadas para acabar en CSS y ser accesibles. Esto no es
"gusto": es un sistema que otras skills traducirán a variables.

## 1. Color

### Estructura mínima
- **Primary**: color de acción/marca (botones, enlaces, acentos fuertes).
- **Secondary**: apoyo (fondos de sección, elementos secundarios).
- **Accent**: contraste puntual (destacados, CTA de alta prioridad).
- **Neutros**: escala de grises para texto/fondos/bordes (ver schema).
- **Estados**: success / warning / danger.

### Contraste (OBLIGATORIO, WCAG)
- Texto normal: contraste ≥ **4.5:1** con su fondo (AA).
- Texto grande (≥24px o ≥19px bold) y componentes UI: ≥ **3:1**.
- Para cada color de marca define `on` = color de texto legible encima.
- Regla práctica: si un color de marca es medio/claro, su `on` será oscuro
  (#0A0A0A) y viceversa. Verifica, no adivines.

Cómo estimar contraste sin herramienta: usa luminancia relativa. Si dudas entre
dos, elige el de MAYOR contraste. Un botón ilegible arruina la conversión.

### Psicología de color por sector (guía, no dogma)
- Salud/bienestar: azules/verdes (confianza, calma).
- Legal/finanzas: azul marino, grafito (autoridad).
- Gastronomía/belleza: cálidos, tierra, rojo/coral (apetito, cercanía).
- Tech/innovación: azul eléctrico, violeta, alto contraste.
- Ecológico/natural: verdes, ocres, beige.
Diferénciate del líder del sector si todos usan lo mismo.

### Modo oscuro
Define `dark`: no es invertir. Fondos casi negros (#0A0A0A–#161616), texto no
blanco puro (#FAFAFA), y baja la saturación de acentos si deslumbran.

## 2. Tipografía

- **Pareja recomendada**: 1 fuente de titulares con carácter + 1 de cuerpo muy
  legible. O una superfamilia con varios pesos (más barato y coherente).
- **Prioriza Google Fonts** (gratis, rápidas en web). Buenas combinaciones:
  - Poppins (títulos) + Inter (cuerpo) — moderno, versátil.
  - Fraunces (títulos) + Inter (cuerpo) — editorial, premium.
  - Space Grotesk + Inter — tech.
  - Playfair Display + Source Sans — elegante, clásico.
- **Escala tipográfica** (base 16px, ratio ~1.25–1.333): define h1…small.
- **Line-height**: titulares ~1.1–1.2; cuerpo ~1.5–1.65.
- **Letter-spacing**: titulares grandes ligeramente negativo (-0.02em).
- Legibilidad > originalidad en el cuerpo. Nunca una display para párrafos.

## 3. Geometría y espaciado
- **Espaciado**: sistema de múltiplos de 8px (4/8/16/24/32/48/64…). Da ritmo.
- **Radios**: coherentes (p. ej. sm 6 / md 12 / lg 20 / pill). Radios grandes =
  amable/moderno; radios 0 = serio/editorial.
- **Sombras**: 3 niveles (sm/md/lg). Sutiles; nada de sombras duras.
- **Contenedor**: ancho máx ~1120–1280px para lectura cómoda.

## 4. Imagen e iconografía
- **Foto**: define un estilo (luminoso/real vs editorial/oscuro). Evita stock
  genérico y sonrisas falsas. Personas reales > ilustración impersonal cuando
  el negocio es de servicios/confianza.
- **Iconos**: un solo set coherente. Recomendado: Lucide (outline, 1.5px),
  gratis y con web. No mezclar estilos de icono.
- **Prompt base de IA**: redacta una frase reutilizable que fije estética,
  iluminación, paleta y encuadre, para anteponerla a cada generación de imagen.
  Ej.: "fotografía luminosa y natural, luz de día suave, tonos cálidos acordes a
  la paleta de marca, personas reales, composición limpia con espacio negativo".

## 5. Logo
- Define **usos incorrectos** (deformar, rotar, sombras, cambiar color, sobre
  fondos sin contraste), **área de respeto** y **tamaño mínimo**.
- Versiones: principal, isotipo (solo símbolo), monocromo, y favicon.
- Si no hay logo: propón un logotipo tipográfico provisional con la fuente de
  titulares, y márcalo como provisional en el JSON.

## 6. Checklist de accesibilidad visual
- [ ] Todos los pares texto/fondo cumplen AA.
- [ ] No se transmite información SOLO por color.
- [ ] Tamaño de cuerpo ≥16px en web.
- [ ] Foco visible previsto para elementos interactivos.
