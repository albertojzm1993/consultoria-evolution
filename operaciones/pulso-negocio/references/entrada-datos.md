# Entrada de datos — cómo normalizar lo que aporta el cliente

El cliente no tiene un sistema unificado: tiene el export de su banco, una hoja de
Excel, tickets del TPV o una lista escrita a mano. Esta referencia explica cómo
convertir cada fuente en números limpios **sin pedirle que cambie sus herramientas**.

## Principio
Aceptamos el dato en el formato en que ya existe. El trabajo de normalizar es
nuestro, no del cliente. Nunca se le pide "pásalo a tal formato" si podemos leerlo
como está.

## Fuentes típicas y cómo tratarlas

### 1. Export bancario (CSV o Excel)
- Columnas habituales: fecha, concepto, importe (a veces cargo/abono separados).
- **Saldo hoy** = saldo final de la última fila, o el que indique el cliente.
- **Ventas de la semana** ≠ todos los abonos: filtra devoluciones, traspasos entre
  cuentas propias y aportaciones del socio. Ante la duda, pregunta, no asumas.
- Cuidado con el signo: cargos negativos, abonos positivos (varía por banco).

### 2. TPV / ventas
- Suma de tickets/cobros de la semana. Si el TPV da un total, úsalo directamente.
- Distingue **cobrado** (entró el dinero) de **facturado** (emitido, aún no pagado).
  El pulso separa las dos cosas.

### 3. Facturas pendientes
- Si el cliente usa la skill `cobro-facturas`, lee el estado desde
  `operaciones/cobros/`. Si no, pide: cliente, importe, fecha de vencimiento.
- **Vencido** = fecha de vencimiento anterior a hoy.

### 4. Tabla pegada o lista a mano
- Interprétala con sentido común, pero **confirma los totales** antes de usarlos.
- Si un importe es ambiguo (¿con IVA?, ¿bruto o neto?), pregúntalo; no lo decidas tú.

## Gastos fijos (para el semáforo de caja)
El semáforo solo tiene sentido con los gastos fijos mensuales conocidos (alquiler,
cuotas, suministros, nóminas si las hay). Pídelos una vez y guárdalos en el Perfil
Maestro o en `operaciones/finanzas/`; no hace falta repetir la pregunta cada semana.
- **Verde:** caja ≥ ~1 mes de gastos fijos.
- **Ámbar:** caja entre ~2 semanas y ~1 mes.
- **Rojo:** caja < ~2 semanas de gastos fijos.
(Umbrales orientativos; ajústalos al negocio y su estacionalidad.)

## Reglas de higiene de datos
- Un dato sin fuente clara no entra: se marca `[falta el dato]`.
- No mezclar cuenta personal y de empresa si el cliente las tiene separadas.
- Redondeo solo en la presentación, nunca en el cálculo.
- Todo importe en la moneda del cliente (por defecto €), con separador de miles.
