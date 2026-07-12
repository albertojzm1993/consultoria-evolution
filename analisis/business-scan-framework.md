# Business Scan Framework

> **Documento interno de gobierno. NO es para el cliente.** Es el método que usa
> Claude para hacer SIEMPRE el mismo trabajo al arrancar con una empresa: obtener la
> información, clasificarla, proponer prioridades, construir el roadmap y alimentar
> con todo ello la cadena de documentos de la consultora.
>
> Complementa al [`CLAUDE.md`](CLAUDE.md) (sistema operativo) explicando **la puerta
> de entrada** de todo el proceso. La marca comercial de este método es
> **Business Scan** (ver `../Evolution/`); aquí se define su mecánica interna.

---

## 1. Qué es el Business Scan (y qué NO es)

El Business Scan **no es un informe ni una auditoría**. Es el **mecanismo de
obtención y estructuración de información** que alimenta todo lo demás.

> El Business Scan NO termina en la auditoría. Es la materia prima de todos los
> documentos posteriores.

**Regla de oro (idéntica a la filosofía de la casa):** nunca se empieza
implementando; siempre se empieza entendiendo. El Scan debe permitir responder a
cuatro preguntas fundamentales antes de proponer nada:

1. ¿Cómo funciona realmente la empresa?
2. ¿Qué está limitando su crecimiento?
3. ¿Qué oportunidades existen?
4. ¿Qué acciones generarán mayor impacto?

---

## 2. Arquitectura: los tres niveles

El producto de la consultora no es un PDF. Es una **metodología** con tres niveles:

```
┌──────────────────────────────────────────────────────────┐
│  NIVEL 1 — BUSINESS SCAN                                   │
│  Obtención y estructuración de la información              │
│  (visión externa + visión interna / pain points)          │
└──────────────────────────────────────────────────────────┘
                              │  alimenta
                              ▼
┌──────────────────────────────────────────────────────────┐
│  NIVEL 2 — SISTEMA DE CONSULTORÍA  (carpeta analisis/)     │
│  Descubrimiento · Auditoría · Diagnóstico · Briefing ·     │
│  Motor Estratégico · Plan Director                         │
└──────────────────────────────────────────────────────────┘
                              │  decide
                              ▼
┌──────────────────────────────────────────────────────────┐
│  NIVEL 3 — IMPLEMENTACIÓN  (carpeta implementaciones/)     │
│  Web · SEO · Contenido · IA · CRM · Automatizaciones ·     │
│  Procesos · Dashboards…                                    │
└──────────────────────────────────────────────────────────┘
```

El flujo, visto como cadena de valor:

```
        EMPRESA
           │
           ▼
     BUSINESS SCAN        →  Obtención de información (fuera + dentro)
           │
           ▼
      AUDITORÍA           →  Qué ocurre
           │
           ▼
     DIAGNÓSTICO          →  Por qué ocurre
           │
           ▼
   MOTOR ESTRATÉGICO      →  Qué deberíamos hacer
           │
           ▼
     PLAN DIRECTOR        →  En qué orden hacerlo
           │
           ▼
    IMPLEMENTACIÓN        →  Ejecución de lo priorizado
```

---

## 3. FASE 1 — Obtención de información

La información proviene de **dos fuentes**. Las dos juntas son el diferencial: casi
nadie hace los dos diagnósticos.

### A) Visión externa — *lo que analizamos sin preguntar*

Todo lo observable desde fuera. **Se obtiene con Firecrawl (MCP), nunca de memoria**
(ver `Inventario/fichas/firecrawl.md`); esta es la misma materia prima que consume
`auditoria-negocio`:

- Página web · Experiencia digital · UX · Velocidad
- SEO · SEO local · Google Business
- Redes sociales · Contenido · Publicidad
- Reputación · Reseñas · Posicionamiento
- Captación · Embudos · Presencia online
- Branding · Comunicación
- Procesos, herramientas, automatizaciones e IA visibles
- Competencia (3-5 rivales reales del sector y ciudad)

### B) Visión interna — *los pain points del empresario*

Aquí descubrimos lo que **no se ve desde fuera**: lo que preocupa al dueño, los
cuellos de botella, lo que hace perder tiempo, dinero u oportunidades. No es una
entrevista eterna: **máximo 10 preguntas, siempre las mismas** (fijas = método
repetible y comparable entre clientes).

> **Instrumento propio del Scan.** Este cuestionario es distinto del
> `perfil-maestro-negocio` (Fase 0), que por diseño **solo recoge hechos y no detecta
> problemas**. Las respuestas a estas preguntas son la entrada principal del
> `briefing-estrategico-servicios`, la `auditoria-negocio` y, sobre todo, el
> `diagnostico-estrategico`.

**Las 10 preguntas del Business Scan**

1. Si pudieras mejorar tres cosas del negocio mañana mismo, ¿cuáles serían?
2. ¿Qué parte del negocio os consume más tiempo?
3. ¿Qué tareas repetís continuamente?
4. ¿Qué sabes que deberías hacer pero nunca tienes tiempo?
5. ¿Qué proceso te genera más frustración?
6. ¿Qué parte del negocio depende demasiado de una sola persona?
7. ¿Qué crees que os está haciendo perder dinero?
8. Si desaparecieras una semana, ¿qué dejaría de funcionar?
9. ¿Qué tarea eliminarías si pudieras pulsar un botón?
10. ¿Qué objetivo te gustaría conseguir en los próximos 12 meses?

> Con estas diez respuestas + la visión externa se tiene media consultoría hecha.

**Dónde se guardan.** Las respuestas de la visión interna se registran en la carpeta
del cliente, en `00-descubrimiento/_business-scan.md` (archivo interno), para que
las fases siguientes las consuman sin volver a preguntar.

---

## 4. FASE 2 — Clasificación de hallazgos

Nada de listas caóticas. **Cada hallazgo** (venga de la visión externa o interna) se
registra siempre con la misma ficha. Esto es lo que hace la metodología escalable.

| Campo | Contenido | Valores |
|---|---|---|
| **Área** | Dónde cae | Marketing · Ventas · Web · SEO · Procesos · Atención al cliente · Marca · Datos · Tecnología · Organización… |
| **Hallazgo** | Qué ocurre (observado) | *p. ej. "No existe estrategia SEO"* |
| **Pain Point** | Cómo lo vive el negocio | *p. ej. "Depende casi solo del boca a boca"* |
| **Impacto** | Efecto en el negocio | Muy Alto · Alto · Medio · Bajo |
| **Esfuerzo** | Coste de resolverlo | Bajo · Medio · Alto |
| **Tipo** | Naturaleza de la acción | Quick Win · Proyecto · Automatización · Estratégico · Organizativo · Tecnológico |
| **Dependencias** | Qué necesita antes | *p. ej. "Requiere Manual de Marca"* |
| **Beneficio esperado** | Qué mejora | Más captación · Menos tiempo · Más ventas · Más organización… |

> **Alineación con `auditoria-negocio`:** su clasificación de Impacto/Urgencia/
> Dificultad y sus *Quick Wins* son la misma idea. Mapeo: **Esfuerzo ≈ Dificultad**;
> el **Tipo "Quick Win"** = alto impacto + bajo esfuerzo. Usa esta ficha como formato
> canónico.
>
> **Puntuación por pilar → ver [`business-maturity-framework.md`](business-maturity-framework.md).**
> Cada hallazgo se asocia a uno de los **10 pilares** y contribuye a su **nivel de
> madurez (0-5)**. La ponderación por sector de esos pilares produce el **Índice de
> Evolución™**, que sustituye a la nota 0-10 como puntuación global.

---

## 5. FASE 3 — Priorización

**No priorizamos nosotros: proponemos. El cliente decide.** El empresario sabe cosas
del negocio que nosotros no (temporadas, restricciones, planes futuros), así que la
prioridad final es suya.

| Acción | Impacto | Esfuerzo | Prioridad sugerida | Prioridad cliente |
|--------|---------|----------|--------------------|-------------------|
| … | Muy Alto | Medio | 1 | *(la marca el cliente)* |

La *Prioridad sugerida* sale de cruzar impacto × esfuerzo (los Quick Wins primero).
La *Prioridad cliente* es la columna que convierte el plan en algo suyo y no impuesto.

---

## 6. FASE 4 — Roadmap

Una vez priorizado, se construye el roadmap por horizontes. Es el mismo *Roadmap
recomendado* de la auditoría, ahora ordenado según la decisión del cliente:

```
  MES 1                 MES 2                 MES 3
  ─────                 ─────                 ─────
  Quick Wins            Proyectos             Proyectos grandes
  Correcciones          Automatizaciones      Estrategia continua
  de alto impacto       Contenido / SEO       Medición y ajuste
```

---

## 7. FASE 5 — Entregables (conexión con `analisis/`)

El Business Scan **no produce un documento único**: produce la información
estructurada que permite generar, en orden, los documentos del Nivel 2. Cada uno lo
crea su skill ya existente:

| # | Documento | Skill (`name`) | Responde a |
|---|-----------|----------------|------------|
| 0 | Perfil Maestro del Negocio | `perfil-maestro-negocio` | Cómo es la empresa (hechos) |
| 0.5 | Arranque del cliente | `arranque-cliente` | Estructura de trabajo |
| 1 | Auditoría del Negocio | `auditoria-negocio` | Qué ocurre |
| 2 | Diagnóstico Estratégico | `diagnostico-estrategico` | Por qué ocurre |
| 3 | Briefing Estratégico | `briefing-estrategico-servicios` | Qué oportunidades hay |
| 4 | Motor Estratégico Empresarial | `motor-estrategia-empresarial` | Qué deberíamos hacer |
| 5 | Plan Director de Transformación | `plan-director-transformacion` | En qué orden hacerlo |

> Regla: el Scan alimenta; las skills redactan. Ninguna skill vuelve a investigar la
> empresa desde cero — toda la materia prima ya está en `00-descubrimiento/`.

---

## 8. Encaje con el método de marca (Evolution)

Al cliente no le hablamos de "Fase 1, Fase 2…" internas, sino de las **4 fases de
marca**. Correspondencia:

| Método de marca (cliente) | Qué es internamente |
|---|---|
| **Business Scan** | Fases 1-2 de este framework: obtención + clasificación (visión externa + interna). |
| **Business Blueprint** | Fases 3-4 + documentos 1-5: priorización, roadmap y el plan. |
| **Business Build** | Nivel 3 — `implementaciones/`. |
| **Business Evolution** | Seguimiento, medición y nuevas oportunidades. |

---

## 9. Reglas del framework

- **Siempre el mismo método.** Las 10 preguntas son fijas; la ficha de hallazgo es
  fija. Repetible y comparable entre clientes.
- **Nunca inventar datos.** Visión externa con Firecrawl; lo no verificable se marca
  como "no disponible". Distinguir hechos de inferencias.
- **Proponer, no imponer.** La prioridad final la decide el cliente.
- **Resultado, no herramienta.** Cada hallazgo se justifica por su impacto en el
  negocio, nunca por el servicio que podría venderse.
- **No perder conocimiento.** Todo lo capturado vive en la carpeta del cliente y lo
  reutilizan las fases siguientes.
