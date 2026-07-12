# Business Maturity Framework — Índice de Evolución™

> **Documento interno de gobierno.** Es el **motor de puntuación** de la consultora:
> convierte los hallazgos del [`business-scan-framework.md`](business-scan-framework.md)
> en una medida de madurez por pilar, un índice global (el **Índice de Evolución™**)
> fácil de entender por el cliente, y una lista de prioridades ponderada por sector.
>
> El **Índice de Evolución™** es el lenguaje propio de la metodología: en lugar de
> "tienes un 42 sobre 100" sin más, se entrega un índice con **nivel (N1-N5),
> fortalezas, oportunidades y próximo objetivo**.
>
> *Nomenclatura: "Índice de Evolución™" es el nombre oficial de cara al cliente.
> Sustituye al antiguo "IME / Índice de Madurez Empresarial", ya jubilado; si aparece
> en documentos viejos, es lo mismo.*

---

## 1. Idea central

> **Una empresa solo puede crecer al ritmo de su pilar más débil.**

De ahí el método:

```
  Se analiza siempre desde los mismos pilares
        ↓
  Cada pilar recibe un nivel de madurez (0-5)
        ↓
  Cada nivel genera acciones
        ↓
  Cada acción alimenta el Plan Director
```

El pilar más débil (con peso alto en su sector) es el **cuello de botella**: marca el
techo de crecimiento y, por tanto, dónde atacar primero.

---

## 2. Los 10 pilares

Pensados para servir igual a una peluquería que a una empresa de ingeniería.

| # | Pilar | Pregunta clave | Qué analizamos |
|---|-------|----------------|----------------|
| 1 | **Estrategia y Dirección** | ¿La empresa sabe hacia dónde va? | Objetivos · Propuesta de valor · Diferenciación · Público objetivo · Modelo de negocio · Plan estratégico · Toma de decisiones |
| 2 | **Marca y Posicionamiento** | ¿Cómo la percibe el mercado? | Identidad · Imagen · Mensaje · Confianza · Diferenciación · Reputación · Google Business · Reseñas |
| 3 | **Captación y Marketing** | ¿Cómo llegan nuevos clientes? | Web · SEO · Redes · Publicidad · Contenidos · Email · Conversión · Embudos |
| 4 | **Ventas** | ¿Cómo convierten oportunidades en clientes? | Proceso comercial · Seguimiento · Presupuestos · CRM · Conversión · Objeciones · Fidelización |
| 5 | **Experiencia del Cliente** | ¿Qué ocurre después de vender? | Atención · Comunicación · Seguimiento · Fidelización · Encuestas · Recompra · Recomendaciones |
| 6 | **Operaciones y Procesos** | ¿El negocio funciona con orden? | Procesos documentados · Cuellos de botella · Duplicidades · Trabajo manual · Organización · Responsabilidades · Tiempo perdido |
| 7 | **Tecnología e IA** | ¿Qué madurez tecnológica tiene? | Software · Integraciones · Automatización · IA · Seguridad · Digitalización *(madurez, no herramientas sueltas)* |
| 8 | **Datos y KPIs** | ¿Deciden con datos? | Qué miden · Qué deciden con ello · Dashboards · Informes · Indicadores · Rentabilidad · Márgenes |
| 9 | **Personas y Organización** | ¿La organización sostiene el negocio? | Roles · Comunicación · Delegación · Dependencias · Formación · Cultura · Motivación |
| 10 | **Crecimiento** | ¿Está preparada para crecer? | Escalabilidad · Innovación · Nuevos servicios · Nuevos mercados · Capacidad de crecimiento · Riesgos · Oportunidades |

> El pilar 10 resume a los demás: una empresa solo puntúa alto en Crecimiento si los
> otros nueve la sostienen.

---

## 3. Escala de madurez por pilar (0-5)

**No usamos "nota de 1 a 10". Usamos niveles de madurez** con nombre. Cada pilar se
sitúa en uno:

| Nivel | Nombre | Qué significa |
|:---:|--------|---------------|
| **0** | Inexistente | No existe. Todo depende de personas. Sin procesos ni estrategia. |
| **1** | Reactivo | Todo se hace cuando surge el problema. Sin planificación. Mucha improvisación. |
| **2** | Básico | Hay cosas funcionando, pero sin metodología. Mucha dependencia de personas. |
| **3** | Estructurado | Empiezan a existir procesos. Se mide. Se documenta. Hay orden. |
| **4** | Optimizado | Trabaja con indicadores, automatizaciones y procesos definidos. Mejora continua. |
| **5** | Escalable | Preparada para crecer: documentada, automatizada, medible, con IA, procesos, estrategia y datos. |

Visualmente (una barra por pilar):

```
  ESTRATEGIA    ○──○──●──○──○──○   Nivel 2
  MARKETING     ○──○──○──●──○──○   Nivel 3
  OPERACIONES   ○──●──○──○──○──○   Nivel 1
  …
```

> Esta escala **por pilar** (0-5) es la mecánica interna. Los nombres de los niveles
> 1-5 (Reactivo → Escalable) son los mismos que los del **Índice de Evolución global
> (N1-N5)** de la sección 5, para que todo el sistema hable el mismo idioma.

---

## 4. El algoritmo: peso por sector

No todos los pilares pesan igual en cada negocio. Ahí está el diferencial: **el
análisis se adapta automáticamente al tipo de empresa.**

```
  Pilar → Madurez (0-5) → Peso según el sector → Impacto → Prioridad
```

### Fórmula del Índice de Evolución

1. Nivel de cada pilar → puntuación 0-100: **`P = nivel / 5 × 100`**
   (Nivel 0→0, 1→20, 2→40, 3→60, 4→80, 5→100).
2. Cada pilar tiene un **peso** según el sector; los 10 pesos **suman 100**.
3. **Índice de Evolución™:**

   ```
   Índice de Evolución = Σ (peso_pilar × P_pilar) / 100
   ```

   (media ponderada → resultado 0-100).

### Perfiles de peso por sector (por defecto, ajustables)

Peso base = 10 por pilar (todos iguales, suma 100). Cada sector redistribuye subiendo
sus pilares clave y bajando los menos críticos:

| Pilar | Base | Gimnasio / servicio local | Fábrica / industria | Despacho profesional | E-commerce |
|-------|:--:|:--:|:--:|:--:|:--:|
| 1 Estrategia | 10 | 10 | 10 | 12 | 10 |
| 2 Marca | 10 | 14 | 6 | 10 | 12 |
| 3 Captación/Marketing | 10 | 18 | 6 | 8 | 20 |
| 4 Ventas | 10 | 10 | 10 | 14 | 10 |
| 5 Experiencia cliente | 10 | 14 | 6 | 14 | 10 |
| 6 Operaciones | 10 | 8 | 22 | 12 | 10 |
| 7 Tecnología/IA | 10 | 6 | 14 | 8 | 16 |
| 8 Datos/KPIs | 10 | 8 | 12 | 10 | 10 |
| 9 Personas | 10 | 6 | 10 | 8 | 4 |
| 10 Crecimiento | 10 | 6 | 4 | 4 | 8 |
| **Total** | **100** | **100** | **100** | **100** | **100** |

> Estos perfiles son la **base editable**. Para un cliente concreto se parte del perfil
> de su sector y se afina con lo que se descubre en el Business Scan. El peso × la
> distancia a Nivel 5 de cada pilar da el **Impacto** (dónde mover primero la aguja) y,
> con la decisión del cliente, la **Prioridad**. Cuando el sector tiene **playbook**
> (`playbooks/`), el reponderado de pesos parte de ahí.

### Regla del cuello de botella

El **próximo objetivo** no se fija subiendo el pilar ya fuerte, sino **levantando el
pilar más débil de mayor peso**. Es la traducción operativa de "la empresa crece al
ritmo de su pilar más débil".

---

## 5. El entregable: Índice de Evolución™

El resultado que ve el cliente no es una nota fría, es una tarjeta con lenguaje propio:

```
  ÍNDICE DE EVOLUCIÓN™

        72 / 100
  Nivel: N4 · OPTIMIZADO

  ── Fortalezas ────────────────
   ✓ Dirección
   ✓ Clientes
   ✓ Marca

  ── Oportunidades ─────────────
   ⚠ Procesos
   ⚠ IA
   ⚠ Datos

  ── Próximo objetivo ──────────
   Alcanzar N5 · Escalable
```

### Bandas del Índice de Evolución (N1-N5)

Misma escala que el diagnóstico inicial de captación, para que el número signifique lo
mismo en toda la casa (5 niveles, bandas de 20):

| Índice | Nivel | Etiqueta para el cliente | Próximo objetivo |
|:---:|:---:|-----------------|-----------------|
| 0-20 | **N1** | Reactivo | Llegar a N2 |
| 21-40 | **N2** | Básico | Llegar a N3 |
| 41-60 | **N3** | Estructurado | Llegar a N4 |
| 61-80 | **N4** | **Optimizado** | Llegar a N5 |
| 81-100 | **N5** | Escalable | Mantener y expandir |

*(Ejemplo: Índice de Evolución 72 → "N4 · Optimizado", próximo objetivo N5.)*

- **Fortalezas** = pilares en Nivel 4-5.
- **Oportunidades** = pilares en Nivel 0-2 (empezando por el de mayor peso = cuello de
  botella).

---

## 6. Cómo se conecta con el resto del sistema

- **Business Scan** aporta las evidencias (visión externa Firecrawl + 10 preguntas
  internas). Este framework las **puntúa por pilar**.
- **`auditoria-negocio`** pasa a expresar su valoración en **niveles de madurez (0-5)
  por pilar** y el **Índice de Evolución /100** como puntuación global, en lugar del
  0-10 por área. Las 8 áreas digitales actuales de la auditoría alimentan sobre todo
  los pilares 2 (Marca) y 3 (Captación); los pilares 1, 4-10 amplían la mirada al
  negocio completo.
- **`diagnostico-estrategico`** explica el *por qué* detrás de los pilares bajos.
- **`plan-director-transformacion`** ordena las acciones para subir de nivel,
  empezando por el cuello de botella.
- **Encaje con la marca (Evolution):** el Índice de Evolución es el resultado visible
  del *Business Scan / Business Blueprint*; el plan para subir de nivel es el *Business
  Build*; la reevaluación periódica del Índice es el *Business Evolution*.

---

## 7. Reglas del framework

- **Siempre los mismos 10 pilares y la misma escala 0-5.** Repetible y comparable.
- **El peso lo decide el sector, no el capricho.** Parte del perfil del sector (y del
  playbook si existe) y justifícalo con lo hallado; nunca inventes pesos a ojo.
- **Nivel = evidencia, no impresión.** Cada nivel de pilar se apoya en evidencias del
  Scan (hechos), no en intuición.
- **Ataca el cuello de botella.** El próximo objetivo levanta el pilar débil de mayor
  peso; ahí está el mayor retorno.
- **Lenguaje de negocio, no de máquina.** Al cliente se le habla de niveles (N1-N5) y
  del Índice de Evolución, no de fórmulas ni de "42/100".
