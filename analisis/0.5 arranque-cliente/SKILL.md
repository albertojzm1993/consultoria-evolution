---
name: arranque-cliente
description: Crea la carpeta de trabajo de un cliente nuevo con TODA la estructura y los recursos del proceso de consultoría (fases, marca/brand-tokens.json, entregables, recursos, gestión). Se ejecuta justo DESPUÉS del descubrimiento (Fase 0), cuando ya se ha cargado y comprendido la información del cliente. Úsala cuando el usuario diga cosas como "arranca el proceso con este cliente", "crea la carpeta del cliente", "lanza el proceso de consultoría", "ya tengo toda la info, monta la carpeta", o cuando se acaba de generar el Perfil Maestro y hay que dejar preparada la carpeta clientes/<nombre> para empezar a producir entregables. Es el puente entre Fase 0 (descubrimiento) y el resto del proceso.
---

# Skill — Arranque de cliente (scaffolding)

Deja lista la carpeta `clientes/<slug>/` con toda la estructura del proceso de
consultoría, para que cada fase posterior tenga dónde escribir y las skills de
`implementaciones/` encuentren su `marca/brand-tokens.json`.

## Cuándo se dispara

Justo **después** de la Fase 0 (Descubrimiento), cuando ya se ha comprendido el
negocio. No antes: primero se entiende al cliente, luego se monta su carpeta.

Señales típicas: "ya tengo toda la información del cliente", "arranca el proceso",
"monta la carpeta", o acabas de producir el Perfil Maestro del Negocio.

## Cómo ejecutarla

1. Determina el **nombre** del cliente (y el sector si se conoce).
2. Ejecuta el scaffolder:

   ```powershell
   ./scripts/nuevo-cliente.ps1 -Nombre "Nombre del Cliente" -Sector "sector"
   ```

   - Es **idempotente**: si la carpeta ya existe, conserva los archivos con
     contenido y solo crea lo que falte. No pierde trabajo.
   - Slugifica el nombre (acentos, ñ, espacios) para la carpeta.

3. Si ya has producido el **Perfil Maestro** en esta sesión, escríbelo en
   `clientes/<slug>/00-descubrimiento/perfil-maestro-<slug>.md` (sustituyendo la
   plantilla). El nombre lleva SIEMPRE el sufijo del cliente (p. ej.
   `perfil-maestro-m8.md`). No dejes el conocimiento fuera de la carpeta del cliente.

4. Actualiza el `README.md` del cliente marcando la Fase 0 como completada.

## Qué genera

```
clientes/<slug>/
├─ README.md                     ← índice y estado del proceso
├─ 00-descubrimiento/perfil-maestro-<slug>.md
├─ 01-auditoria/auditoria.md
├─ 02-diagnostico/diagnostico.md
├─ 03-briefing/briefing.md
├─ 04-estrategia/{motor-estrategia.md, plan-director.md}
├─ 05-propuesta/propuesta.md
├─ marca/
│  ├─ brand-tokens.json          ← fuente de verdad (provisional hasta manual-de-marca)
│  ├─ BRAND.md
│  ├─ resumen-marca.md
│  └─ assets/
├─ entregables/{web,landings,blog,redes}/
├─ recursos/
└─ gestion/{reuniones.md,tareas.md}
```

## Reglas

- **Confidencialidad:** nunca mezclar información entre clientes. Cada cliente vive
  solo dentro de su carpeta.
- **No sobreescribir:** el script conserva lo que ya tiene contenido. Usa `-Force`
  solo si quieres regenerar plantillas vacías.
- El `brand-tokens.json` nace como **provisional** (`0.1.0-provisional`). La skill
  `manual-de-marca` lo convierte en la fuente de verdad definitiva.

## Relación con otras skills

- **Antes:** `perfil-maestro-negocio` (Fase 0). Este arranque consume su resultado.
- **Después (orden canónico):** `auditoria-negocio` → `diagnostico-estrategico` →
  `briefing-estrategico-servicios` → `motor-estrategia-empresarial` →
  `plan-director-transformacion`, y luego las skills de `implementaciones/` (manual-de-marca,
  web, landing, blog, redes), que escriben dentro de la carpeta creada aquí.
