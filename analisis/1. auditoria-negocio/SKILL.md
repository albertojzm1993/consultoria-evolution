---
name: auditoria-negocio
description: Realiza una auditoría profesional del estado digital de una empresa. Es el paso 1 del análisis, JUSTO DESPUÉS del Perfil Maestro (Descubrimiento) y ANTES del Diagnóstico y el Briefing. Úsala cuando el usuario pida auditar un negocio, analizar una empresa, preparar un informe para un cliente, o cuando sea necesario descubrir problemas y oportunidades reales. Evalúa la madurez digital, prioriza acciones por impacto y genera un informe ejecutivo listo para entregar.
---

# Skill — Auditoría Integral de Negocio

## Objetivo

Esta Skill realiza una auditoría profesional del estado digital de una empresa.

Su función no es únicamente describir la presencia online del negocio, sino evaluar objetivamente su madurez digital, identificar oportunidades de mejora, priorizar acciones según su impacto y generar un informe ejecutivo listo para presentar al cliente.

Debe comportarse como una consultora especializada en transformación digital.

El resultado de esta Skill constituye la base para la propuesta comercial y el plan de acción.

---

# Cuándo utilizar esta Skill

Activa esta Skill cuando:

- El usuario solicite una auditoría de un negocio.
- El usuario quiera analizar una empresa.
- El usuario quiera preparar un informe para un cliente.
- Se disponga del Perfil Maestro del Negocio (Descubrimiento), que es su entrada.
- Sea necesario descubrir problemas y oportunidades reales.

---

# Información necesaria

Solicita únicamente la información que falte.

Información deseable:

- Nombre de la empresa
- Sector
- Ciudad y país
- Página web
- Redes sociales
- Perfil de Google Business
- Público objetivo
- Información interna proporcionada por el cliente
- Objetivos del negocio

Si falta información, continúa igualmente indicando las limitaciones del análisis.

Nunca inventes datos.

---

# Metodología

La auditoría debe distinguir claramente entre:

## Evidencias

Datos objetivos encontrados.

Ejemplos:

- La empresa dispone de página web.
- Tiene 73 reseñas en Google.
- Publica una vez al mes en Instagram.
- No existe formulario de contacto.

Nunca interpretar en esta sección.

---

## Hallazgos

Conclusiones obtenidas a partir de las evidencias.

Ejemplo:

"La frecuencia de publicación es insuficiente para mantener una comunidad activa."

---

## Impacto

Explicar cómo afecta ese hallazgo al negocio.

Ejemplo:

"Puede reducir la captación de clientes procedentes de redes sociales."

---

## Recomendación

Acción concreta para resolver el problema.

Debe ser específica.

Nunca escribir:

"Mejorar la web."

Escribir:

"Rediseñar la página de inicio incorporando una propuesta de valor clara, testimonios y un formulario de captación."

---

# Áreas de auditoría

## 1. Presencia digital

> Para analizar la web del cliente, **scrapéala con Firecrawl** (`firecrawl_scrape`)
> en vez de suponer su contenido. Usa formato `branding` para extraer colores,
> tipografías y estilo (útil para el Manual de Marca), y `markdown`/`json` para
> contenido, CTAs y contacto. Si `scrape` viene vacío, usa `firecrawl_map` para
> encontrar la página correcta.

Analizar:

- Página web
- Dominio
- Seguridad HTTPS
- Responsive
- Diseño
- Navegación
- UX
- CTAs
- Formularios
- Información de contacto
- Página Sobre Nosotros
- Servicios
- Blog
- Velocidad de carga (si puede estimarse)
- Accesibilidad

Asignar una puntuación.

---

## 2. SEO

Evaluar:

- Indexación
- Títulos
- Meta descripciones
- Encabezados
- Contenido
- SEO Local
- Google Business Profile
- Palabras clave
- Autoridad aparente
- Oportunidades de posicionamiento

Asignar puntuación.

---

## 3. Google Business Profile

Analizar:

- Información completa
- Categorías
- Fotografías
- Horarios
- Publicaciones
- Preguntas y respuestas
- Reseñas
- Respuestas a reseñas

Asignar puntuación.

---

## 4. Reputación online

Analizar:

- Valoración media
- Número de reseñas
- Tendencia
- Opiniones repetidas
- Puntos fuertes
- Debilidades
- Gestión de reclamaciones

Asignar puntuación.

---

## 5. Redes sociales

Para cada red encontrada:

Evaluar:

- Actividad
- Frecuencia
- Calidad
- Branding
- Interacción
- Uso de vídeo
- Coherencia visual
- Llamadas a la acción
- Calidad del contenido

Detectar redes que deberían existir.

Asignar puntuación.

---

## 6. Captación de clientes

Evaluar:

- Formularios
- WhatsApp
- Reservas
- Landing Pages
- Lead Magnets
- Embudos
- Newsletter
- Conversión

Asignar puntuación.

---

## 7. Automatización

Si existe información suficiente analizar:

- Reservas
- Atención al cliente
- CRM
- Facturación
- Procesos internos
- IA
- Automatizaciones

Identificar procesos repetitivos.

---

## 8. Competencia

Seleccionar entre 3 y 5 competidores relevantes.

**Cómo obtener los datos (obligatorio): usar Firecrawl (MCP).** No trabajes de
memoria ni inventes competidores; localízalos y scrapéalos con las herramientas
`firecrawl_*`:

1. **Localizar competidores** → `firecrawl_search` con el sector + la ciudad del
   cliente (p. ej. *"centro movimiento consciente yoga pilates El Prat de Llobregat"*).
   Filtra por `location` y quédate con 3-5 rivales reales con web propia.
2. **Extraer datos estructurados de cada uno** → `firecrawl_scrape` con formato
   `json` (un `prompt` que pida: nombre, servicios/clases, tarifas o precios,
   horarios, dirección, teléfono, email, redes). Para varias URLs de golpe puedes
   usar `firecrawl_extract` con un `schema` común.
3. **Web más grande** → si necesitas recorrer varias páginas de un competidor
   (tarifas, servicios, blog), usa `firecrawl_map` para descubrir URLs y luego
   `firecrawl_scrape`; deja `firecrawl_crawl` solo para sitios pequeños.

Vuelca lo extraído en una **tabla comparativa** (una fila por competidor) antes de
interpretar. Marca como "no disponible" lo que no aparezca; **nunca lo rellenes a
ojo**.

> Notas operativas de Firecrawl: es un servicio cloud (no le afecta el MITM/SSL de
> la red). Si la herramienta MCP devolviera 401, la API key está mal cargada — ver
> ficha del Maestro `[[firecrawl]]`. Las páginas gastan créditos, así que scrapea
> solo lo necesario.

Comparar:

- Web
- SEO
- Redes
- Reputación
- Diferenciación
- Posicionamiento
- Propuesta de valor

Identificar ventajas competitivas y oportunidades. Presta atención a lo que **casi
ningún competidor hace bien** (precios ocultos, contacto invisible, webs
desactualizadas): suele ser la vía de diferenciación más barata para el cliente.

**Nivel de detalle esperado (obligatorio):** localiza **3-5 competidores reales** con web
propia y extrae con Firecrawl datos concretos: enfoque, actividad diferencial, si tienen web
y en qué estado (CMS, última actualización), **precios visibles y cuáles**, primer paso de
captación (clase de prueba, reserva online), horarios, redes activas y autoridad de marca.
Vuélcalo en una **tabla comparativa ancha** (una columna por competidor, con el cliente en la
primera) y **añade un párrafo corto por competidor** interpretando su fuerza y su debilidad.
Cierra con un breve "resto del mapa" (cadenas, negocios emergentes, rangos de precio del
sector) para dar contexto. Los precios reales del sector alimentan además la Estimación
económica.

---

# Sistema de puntuación

Cada área debe puntuarse de 0 a 10.

La nota debe estar justificada.

Calcular también una puntuación global.

Interpretación:

9–10 → Excelente

7–8 → Buena

5–6 → Aceptable

3–4 → Deficiente

0–2 → Crítica

---

# Clasificación de problemas

Cada hallazgo debe clasificarse según:

## Impacto

- Muy Alto
- Alto
- Medio
- Bajo

## Urgencia

- Inmediata
- Corto plazo
- Medio plazo
- Largo plazo

## Dificultad

- Baja
- Media
- Alta

---

# Quick Wins

Detectar acciones que:

- puedan ejecutarse rápidamente,
- tengan bajo coste,
- produzcan resultados visibles.

---

# Oportunidades estratégicas

Detectar proyectos de mayor alcance:

- nueva web,
- automatizaciones,
- estrategia SEO,
- CRM,
- agentes IA,
- captación,
- branding,
- procesos internos.

---

# Formato del informe

# AUDITORÍA INTEGRAL DEL NEGOCIO

## Información analizada

Resumen de las fuentes utilizadas y de la información disponible.

Indicar también las limitaciones del análisis.

---

# Resumen ejecutivo

- Estado general del negocio.
- Nivel de madurez digital.
- Principales fortalezas.
- Principales debilidades.
- Oportunidad de mayor impacto.

---

# Cuadro de puntuaciones

| Área | Nota |
|------|------|
| Presencia Digital | |
| SEO | |
| Google Business | |
| Reputación | |
| Redes Sociales | |
| Captación | |
| Automatización | |
| Competencia | |

Puntuación global.

---

# Hallazgos

Para cada área:

## Estado actual

Descripción objetiva.

### Evidencias

Lista de hechos observados.

### Hallazgos

Conclusiones obtenidas.

### Impacto

Cómo afecta al negocio.

### Recomendaciones

Acciones concretas.

---

# Principales fortalezas

Lista priorizada.

---

# Principales debilidades

Lista priorizada.

---

# Quick Wins

Acciones rápidas de alto impacto.

---

# Proyectos estratégicos

Lista priorizada.

---

# Roadmap recomendado por prioridades

Ordena las acciones **por prioridad, NO por fechas ni plazos**. No pongas "primeras 2
semanas", "2 meses", etc. (el cliente decide los tiempos; nosotros ordenamos por
importancia). Usa exactamente estos tres niveles, cada uno con un subtítulo que diga qué
consigue:

## Prioridad 1

Lo que enciende el motor principal del negocio (normalmente la captación). El resto se
construye encima.

## Prioridad 2

Lo que da coherencia, voz y ritmo una vez el motor está en marcha.

## Prioridad 3

Crecimiento y escalado, cuando ya hay flujo que justifique el esfuerzo.

---

# Estimación económica

Para cada proyecto indicar, en una tabla:

- Valor para el negocio (por qué importa, no solo "alto/medio")
- Complejidad
- **Precio de mercado orientativo (con cifras reales)**

**Pon cifras de precio de mercado**, no símbolos vagos (€/€€/€€€). Es el precio que suele
valer cada cosa en el mercado del país del cliente (para una pyme/autónomo), NO
necesariamente lo que le cobraremos nosotros; acláralo así en una frase. Da rangos
(p. ej. "600 - 1.500 €", "300 - 600 €/mes") y, cuando sea útil, un dato de contexto que
ancle la inversión (p. ej. lo que cuesta un servicio equivalente del sector, tomado de la
competencia analizada con Firecrawl). No elaborar presupuestos cerrados.

---

# Próximos pasos recomendados

Es la sección que convierte el análisis en decisiones, y debe ser **extensa**, no un par de
líneas. Estructúrala así:

1. **Narrativa de priorización** (varios párrafos): qué hacer primero y por qué, qué va
   después, qué llega más adelante y qué puede esperar sin frenar el crecimiento. Encadena
   el razonamiento (lo primero enciende la captación, luego coherencia y voz, etc.).
2. **Oportunidades detectadas:** recopila TODAS las oportunidades que han ido saliendo a lo
   largo del informe y muéstralas como cajas `box--oportunidad` (con un título específico
   cada una). No las dejes enterradas en sus apartados: aquí se ven juntas.
3. **Riesgos si no se actúa:** igual, recopila TODOS los riesgos en cajas `box--riesgo`.

El objetivo es que dirección lea esta sección sola y entienda qué hacer, en qué orden, qué
gana y qué se juega. Cierra enlazando con el Diagnóstico Estratégico.

---

# Relación con otras Skills

Esta Skill parte del **Perfil Maestro del Negocio** (Descubrimiento). Sus hallazgos alimentan el
**Diagnóstico Estratégico** (2, por qué ocurre) y, después, el **Briefing Estratégico** (3, qué
oportunidades hay), que ya sí prepara la propuesta comercial.

---

# Reglas

- Nunca inventes datos.
- Si una información no puede verificarse, indícalo expresamente.
- Diferencia siempre entre hechos y opiniones.
- Todas las recomendaciones deben estar justificadas por una evidencia.
- Prioriza el impacto para el negocio, no el volumen de servicios que podrían venderse.
- Cuando una oportunidad se apoye en un servicio de la consultoría (p. ej. automatizar el
  contenido de redes para que el negocio publique sin depender de una persona y sin carga
  diaria), **dilo de forma explícita y explica el beneficio concreto** (menos dependencia,
  menos tiempo, más constancia), sin caer en venta agresiva ni promesas vacías.
- El informe debe tener un nivel profesional suficiente para entregarse directamente al cliente.
- Mantén un tono objetivo, consultivo y orientado al negocio.
- No exageres los problemas ni minimices las fortalezas.
- Cada recomendación debe ser específica, accionable y priorizada.
---

## Entregable en PDF de marca (obligatorio)

**Antes de maquetar: humanizar (OBLIGATORIO, no saltárselo).** Pasa TODO el cuerpo del
`.md` por la skill **`humanizer`** para que no parezca escrito por una IA. En la práctica:
fuera las rayas usadas como inciso (`texto —aparte— texto`) y los guiones largos en general
(usa dos puntos, comas, paréntesis o punto; en rangos numéricos usa "a" o guion normal),
fuera tríadas forzadas, relleno, gerundios de adorno y lenguaje promocional. Respeta el
glosario y las palabras prohibidas del `brand-tokens.json` (voz de marca manda) y no aplanes
las fichas ni las etiquetas `[V]/[I]/[?]`. El `.md` humanizado es la fuente del HTML.

Al terminar el documento `.md`, genera también su **PDF de marca** (portada con
logo, índice automático y buen diseño), siguiendo `../plantilla-informes-pdf.md`:

1. Vuelca el contenido con el conversor `../../scripts/md-a-informe.py` (md→HTML de
   `../../plantillas/informe/plantilla-informe.html`; monta cajas de los bloques ```flow y
   respeta `{: .nueva-pagina }`)
   (rellena título, fase, cliente, sector, fecha, versión y `{{contenido_html}}`
   como HTML; el índice se genera solo desde los `<h2>`/`<h3>`).
2. Aplica la marca: si existe `clientes/<cliente>/marca/brand-tokens.json`, inyecta
   sus colores/tipografías (`{{tokens_css}}`) y el logo (`{{logo_html}}`); si aún
   no hay marca, deja los defaults (diseño profesional neutro) y el nombre en texto.
3. Convierte con Edge/Chrome headless:
   `./scripts/generar-pdf.ps1 -Html "<ruta>/<archivo>.html" -Out "<ruta>/<archivo>.pdf"`
4. Guarda el `.pdf` junto al `.md` en la carpeta del cliente y menciónalo al usuario.
