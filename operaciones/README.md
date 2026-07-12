# Operaciones — Skills para operar el negocio

Bloque hermano de `implementaciones/`. Mientras `implementaciones/` construye la
**presencia** del cliente (que te vean: web, landing, blog, redes), este bloque
opera el negocio **por dentro**: finanzas, cobros, ventas y ritmo semanal.

> Inspirado en el paquete *Claude for Small Business* de Anthropic (nóminas,
> cash-flow, cierre de mes, cobro de facturas, pulso semanal…), pero **adaptado a
> micro-pyme española y sin integraciones de terceros**. Aquí no conectamos con
> PayPal, HubSpot, QuickBooks ni Holded: el cliente **aporta sus datos** (un CSV,
> un export de su banco o gestoría, una tabla pegada) y la skill trabaja sobre eso.
> Más simple, más realista y sin depender de APIs de pago.

## Principios de diseño (comunes a todo el bloque)

1. **Sin integraciones.** La entrada son datos que el cliente ya tiene: CSV, export
   bancario, Excel, o una tabla pegada. Formatos aceptados y ejemplo en cada skill.
2. **No inventamos cifras.** Si falta un dato, se pide o se marca `[no disponible]`.
   Jamás se rellena un número de negocio a ojo.
3. **Voz de marca, también aquí.** Un recordatorio de cobro o un brief semanal
   suenan a la marca del cliente: se lee `brand-tokens.json` (`tono`, `glosario`,
   `palabras_prohibidas`, `contacto`) igual que en el resto del sistema.
4. **El cliente aprueba antes de que salga nada.** Ningún email, recordatorio o
   mensaje se da por "enviado": se entrega listo para que el dueño lo revise y
   mande. La skill produce el texto; el humano decide.
5. **Dos fases.** Método (cómo se calcula/decide) → entregable (el documento real),
   igual que las skills de `implementaciones/`.
6. **Adaptado a micro-negocio.** Un negocio de 1-5 personas no necesita "cierre de
   mes" contable; necesita saber si llega a fin de mes, cobrar lo que le deben y
   arrancar la semana sabiendo qué hacer. Priorizamos eso.

## Catálogo (roadmap)

| # | Servicio | Skill (`name`) | Equivalente Anthropic | Estado |
|---|---|---|---|---|
| 1 | Pulso semanal del negocio | `pulso-negocio` | Business Pulse / Monday Brief | ✅ v1 |
| 2 | Cobro de facturas | `cobro-facturas` | Invoice Chaser | ✅ v1 |
| 3 | Salud financiera (cash-flow + márgenes) | `salud-financiera` | Cash-flow forecast + Margin analyzer | ✅ v1 |
| 4 | Triaje de leads | `triaje-leads` | Lead Triager | ⏳ |
| 5 | Revisión de contratos | `revision-contratos` | Contract Reviewer | ⏳ |
| 6 | Preparación fiscal (carpeta para la gestoría) | `prep-fiscal` | Tax-Season Organizer | ⏳ |

> Lo que **no** portamos (por ahora): nóminas y cierre de mes contable. En España eso
> lo lleva la gestoría del cliente; automatizarlo aportaría poco y añadiría riesgo.

## Contexto que leen todas
- **`clientes/<cliente>/marca/brand-tokens.json`** — tono, glosario, palabras
  prohibidas, contacto. Para que los textos suenen a la marca.
- **Perfil Maestro del Negocio** (`00-descubrimiento/`) — para entender el negocio
  (servicios, ticket medio, estacionalidad) sin volver a preguntarlo.

## Salida por cliente
```
clientes/<cliente>/operaciones/
├─ pulso/            ← briefs semanales (pulso-negocio)
├─ cobros/           ← estado de facturas + secuencias de recordatorio
└─ finanzas/         ← informes de salud financiera
```

## Instalación
Copia cada carpeta de skill a `~/.claude/skills/` (o al `.claude/skills/` del
proyecto). Se invocan por su `name` o se activan por su `description`.
