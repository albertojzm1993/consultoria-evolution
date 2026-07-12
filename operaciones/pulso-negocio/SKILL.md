---
name: pulso-negocio
description: Genera el "pulso" semanal del negocio de un cliente — una foto de una página con caja (cash), ventas de la semana, cobros pendientes, agenda/pipeline y las 3 cosas que mover esta semana. Trabaja sobre datos que el cliente aporta (CSV, export del banco/Excel o una tabla pegada); no se conecta a ningún banco ni CRM y no inventa cifras. Lee brand-tokens.json para escribir con la voz de la marca. Úsala cuando el usuario pida el pulso/brief semanal, un resumen del lunes, un snapshot del estado del negocio, un cuadro de mando semanal o "cómo va el negocio esta semana".
---

# Pulso semanal del negocio

Una página. Cinco minutos de lectura. La foto con la que el dueño arranca la semana
sabiendo **cómo va la caja, qué entró, qué le deben y qué mover**. El equivalente
micro-pyme del "Monday Brief": sin cuadros de mando caros ni integraciones, a
partir de los datos que el cliente ya tiene.

> Regla de oro: **este documento no inventa un solo número.** Todo sale de lo que
> el cliente aporta. Lo que falte se pide o se marca `[falta el dato]` — nunca se
> estima a ojo un dato de negocio.

## Contexto (léelo antes)
- **`clientes/<cliente>/marca/brand-tokens.json`** — `tono`, `glosario`,
  `palabras_prohibidas`, `contacto`. El brief suena a la marca del cliente.
- **Perfil Maestro** (`00-descubrimiento/`) — servicios, ticket medio,
  estacionalidad, objetivos. Para interpretar los números con criterio, no en seco.
- **Pulso de la semana anterior** (`operaciones/pulso/`) si existe — para comparar
  y ver la tendencia (↑/↓), no dar cifras sueltas.

## Datos de entrada (el cliente aporta; tú no los inventas)
Acepta cualquiera de estos, en el formato en que el cliente los tenga:
- **Caja / banco:** saldo actual + movimientos de la semana (export CSV del banco,
  captura, o tabla pegada). Mínimo viable: saldo hoy.
- **Ventas de la semana:** lista de cobros/ventas (fecha, concepto, importe). Puede
  ser el TPV, facturas emitidas, o una simple lista.
- **Pendiente de cobro:** facturas emitidas y no pagadas (cliente, importe,
  vencimiento) — si el cliente usa la skill `cobro-facturas`, se lee de ahí.
- **Agenda / pipeline:** reservas de la semana, presupuestos enviados, leads
  abiertos. Lo que aplique al negocio.
- **Formatos:** CSV, Excel, export bancario, o texto pegado. Ver
  `references/entrada-datos.md` para cómo normalizar cada uno.

Si el cliente solo aporta parte, se hace el pulso con lo que hay y se listan los
huecos al final (§ "Qué falta para un pulso completo").

---

## FASE 1 — Cálculo (no se muestra al cliente, es tu trabajo)
1. **Normaliza** los datos de entrada a números limpios (ver `references/entrada-datos.md`).
2. **Calcula solo lo que los datos permiten**, sin extrapolar:
   - Caja hoy y variación vs la semana pasada (si hay dato previo).
   - Ventas de la semana (suma) y comparación con la anterior.
   - Total pendiente de cobro y cuánto está **vencido**.
   - Nº de reservas/presupuestos/leads abiertos.
3. **Semáforo de caja** con criterio, no alarmista: verde / ámbar / rojo según
   caja frente a los gastos fijos conocidos (si el cliente los dio). Si no hay dato
   de gastos, no se pone semáforo: se dice "sin dato de gastos fijos, no se valora".
4. **Detecta las señales que importan:** una factura vencida grande, una semana de
   ventas por debajo de lo normal, un presupuesto enviado sin respuesta. De ahí
   salen las 3 acciones.

## FASE 2 — El brief (`operaciones/pulso/pulso-AAAA-SS.md` + PDF de marca)
Una sola página con la voz de la marca, usando `templates/pulso-semanal.md`:

1. **Titular de la semana** — una frase honesta del estado (p. ej. "Semana estable:
   caja al alza y dos cobros que cerrar").
2. **Caja** — saldo hoy, variación vs semana pasada, semáforo (si procede).
3. **Ventas** — total de la semana, vs semana anterior, y de dónde vino lo grande.
4. **Te deben** — total pendiente y, en rojo, lo **vencido** (enlaza a `cobro-facturas`).
5. **Agenda / pipeline** — reservas, presupuestos abiertos, lo que aplique.
6. **Las 3 de esta semana** — exactamente tres acciones concretas, priorizadas por
   impacto, cada una con el porqué en una línea. Ni más ni menos: si hay diez cosas,
   se eligen las tres que mueven la aguja.
7. **Qué falta para un pulso completo** — los datos que el cliente no aportó, para
   que el próximo salga más fino.

Tono: directo, tranquilo, de socio que te cuenta cómo va — no de hoja de Excel.
Cero relleno. Números en negrita, prosa mínima.

---

## Validación (antes de entregar)
- [ ] Cada cifra tiene origen en un dato aportado; nada estimado a ojo.
- [ ] Las comparativas (↑/↓) solo aparecen si existe el dato de la semana previa.
- [ ] El semáforo de caja solo se pone si hay dato de gastos fijos.
- [ ] Son **exactamente 3** acciones, priorizadas y con porqué.
- [ ] Suena a la marca (tono, glosario, palabras prohibidas respetados).
- [ ] Cabe en una página. Si no cabe, sobra texto.
- [ ] Los huecos de datos están listados, no ocultados.

## Salida
```
clientes/<cliente>/operaciones/pulso/
├─ pulso-AAAA-SS.md      ← el brief (AAAA-SS = año-semana ISO)
└─ pulso-AAAA-SS.pdf     ← PDF de marca (sistema plantillas/informe + generar-pdf.ps1)
```

## Restricciones
- No inventar cifras, tendencias ni previsiones sin dato que las sostenga.
- No conectar con bancos, TPV ni CRM: solo datos que el cliente aporta.
- No dar consejo fiscal ni contable formal (eso es de la gestoría); sí señalar
  "esto conviene mirarlo con tu gestor".
- Un pulso = una semana = un cliente. Nunca mezclar datos entre clientes.
