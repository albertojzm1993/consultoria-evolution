---
name: fabrica-de-skills
description: Convierte los hallazgos de una auditoría o diagnóstico en skills de ejecución generadas automáticamente, y las ejecuta tras la aprobación del usuario. Úsala cuando ya existe una lista de hallazgos, recomendaciones o peticiones del cliente (SEO, copywriting, web, redes, automatización, reputación, analítica…) y se quiere pasar a la fase de ejecución sin crear cada skill a mano. Genera las skills, las presenta para revisión y produce los entregables de las aprobadas.
---

# Skill — Fábrica de Skills de Ejecución

## Objetivo

Esta Skill industrializa la fase de ejecución de la consultoría.

En lugar de crear una skill a mano por cada tema que surge (SEO, copy, velocidad web, redes, automatizaciones…), toma la **lista de hallazgos** de la auditoría o el diagnóstico y, para cada uno, **genera automáticamente una skill de ejecución bien construida** a partir de plantillas de dominio de calidad.

Después presenta todas las skills generadas para que el usuario **decida cuáles ejecutar**, y produce los entregables de las aprobadas.

Se comporta como el jefe de proyecto que reparte el trabajo entre especialistas.

---

# Cuándo utilizar esta Skill

Actívala cuando:

- Ya existe una auditoría, diagnóstico o lista de recomendaciones con varios puntos de mejora.
- El cliente ha pedido abordar varias cosas a la vez.
- Se quiere pasar de "qué hay que hacer" a "hacerlo", sin crear skills manualmente.

No la uses para descubrir problemas (eso lo hacen las skills de auditoría/diagnóstico). Esta skill **ejecuta**, no diagnostica.

---

# Entrada: los hallazgos

La fábrica trabaja sobre un archivo de hallazgos del cliente:

```
clientes/<cliente>/hallazgos.json
```

El esquema está en `referencias/esquema-hallazgos.json`. Cada hallazgo incluye:
`id, area, titulo, evidencia, impacto, recomendacion, prioridad, dificultad, tipo_servicio, entregable_esperado`.

## Si el archivo no existe

Ofrece **tres formas** de obtener los hallazgos, en este orden de preferencia:

1. **Extraerlos de un informe existente** — si hay `auditoria.md` o `diagnostico.md` del cliente, léelo y conviértelo al esquema `hallazgos.json` (secciones "Recomendaciones", "Quick Wins", "Proyectos estratégicos" → hallazgos).
2. **Lista pegada por el usuario** — el usuario pega los puntos; tú los estructuras al esquema.
3. **Manual** — construir los hallazgos preguntando lo mínimo imprescindible.

Guarda siempre el resultado en `clientes/<cliente>/hallazgos.json` antes de continuar. Nunca inventes hallazgos que no estén respaldados por una evidencia.

---

# Proceso (3 fases)

## FASE A — Generación de skills

Para cada hallazgo:

1. Mapea `tipo_servicio` a una receta del `referencias/catalogo-plantillas.md`. Si no hay receta específica, usa `generico`.
2. Genera una skill de ejecución en:
   `clientes/<cliente>/skills-generadas/<id>-<slug>/SKILL.md`
3. La skill generada debe:
   - Tener frontmatter válido (`name`, `description`).
   - Incluir el contexto concreto del hallazgo (evidencia, impacto, recomendación) — no una plantilla vacía.
   - Seguir la receta de su dominio: qué hace, qué preguntar si falta info, qué entregable produce, reglas de calidad.
   - Heredar las reglas del `CLAUDE.md` (nivel profesional, sin relleno, orientado a negocio, datos confidenciales, nunca inventar).
   - Indicar la ruta exacta del entregable: `clientes/<cliente>/entregables/<id>-<slug>.md`.

La calidad no se improvisa: sale de la receta de dominio + el contexto del hallazgo. Así todas las skills salen consistentes.

## FASE B — Punto de revisión (obligatorio)

⚠️ **Nunca ejecutes sin aprobación.** Tras generar todas las skills, presenta una tabla resumen y espera la decisión del usuario:

| # | ID | Área | Qué resolverá | Prioridad | Dificultad | Entregable |
|---|----|------|---------------|-----------|------------|------------|

Debajo, propón un **orden de ejecución recomendado** (primero lo pedido por el cliente y lo crítico/baja dificultad = quick wins) y pregunta, en una sola pregunta:

> ¿Cuáles ejecuto? (todas / solo críticas / una selección por ID / ninguna)

## FASE C — Ejecución de las aprobadas

Para cada skill aprobada, en el orden acordado:

1. Sigue las instrucciones de su `SKILL.md` generada.
2. Si falta información imprescindible, pregúntala una vez; si no llega, produce el entregable indicando las limitaciones (nunca inventes datos del cliente).
3. Guarda el entregable en `clientes/<cliente>/entregables/<id>-<slug>.md`.
4. Marca el hallazgo como `ejecutado` en `hallazgos.json`.

Al terminar, muestra un resumen (máx. 3 líneas): qué se ejecutó, qué quedó pendiente y dónde están los entregables.

---

# Estructura resultante

```
clientes/<cliente>/
    hallazgos.json              ← entrada (fuente de verdad)
    skills-generadas/           ← skills creadas por la fábrica
        SEO-01-meta-descripciones/SKILL.md
        AUTO-02-reservas/SKILL.md
    entregables/                ← salida de la ejecución
        SEO-01-meta-descripciones.md
```

---

# Reglas

- **Nunca ejecutes sin el visto bueno del usuario** (Fase B es obligatoria).
- Una skill generada por hallazgo; nada de skills-cajón que mezclan temas.
- Las skills generadas van en la carpeta del cliente, **nunca** en las skills globales del proyecto (son específicas de ese cliente y confidenciales).
- Reutiliza: si ya existe una skill generada para ese hallazgo, actualízala en vez de duplicar.
- Cada entregable debe poder presentarse al cliente tal cual.
- Prioriza el impacto para el negocio, no el volumen de skills generadas.
- Si un hallazgo no tiene evidencia detrás, no generes skill: márcalo para revisión manual.

---

# Relación con otras Skills

- **Entra después de** `auditoria-negocio` y `diagnostico-estrategico` (de ahí salen los hallazgos).
- **Complementa a** `motor-estrategia-empresarial` y `plan-director-transformacion`: mientras esas planifican, esta ejecuta cada punto concreto.
---

## Entregable en PDF de marca (obligatorio)

Al terminar el documento `.md`, genera también su **PDF de marca** (portada con
logo, índice automático y buen diseño), siguiendo `../plantilla-informes-pdf.md`:

1. Vuelca el contenido en `../../plantillas/informe/plantilla-informe.html`
   (rellena título, fase, cliente, sector, fecha, versión y `{{contenido_html}}`
   como HTML; el índice se genera solo desde los `<h2>`/`<h3>`).
2. Aplica la marca: si existe `clientes/<cliente>/marca/brand-tokens.json`, inyecta
   sus colores/tipografías (`{{tokens_css}}`) y el logo (`{{logo_html}}`); si aún
   no hay marca, deja los defaults (diseño profesional neutro) y el nombre en texto.
3. Convierte con Edge/Chrome headless:
   `./scripts/generar-pdf.ps1 -Html "<ruta>/<archivo>.html" -Out "<ruta>/<archivo>.pdf"`
4. Guarda el `.pdf` junto al `.md` en la carpeta del cliente y menciónalo al usuario.
