# Método — cash-flow y márgenes para micro-pyme

Cómo calcular bien las dos cosas sin montar un ERP y sin pedirle al cliente datos
que no tiene.

## Previsión de caja (cash-flow)

### Mínimo viable
- Saldo actual.
- Ingresos previstos **con fecha** (facturas por cobrar, reservas, contratos).
- Gastos previstos: fijos mensuales + puntuales conocidos (impuestos trimestrales,
  compras planificadas).

### Cómo se hace
Es aritmética honesta, no un modelo:
```
caja_fin_periodo = caja_inicio + ingresos_con_fecha − gastos_previstos
```
Se encadena periodo a periodo (semanas para 30 días, meses para 90).

### Lo que marca la diferencia
- **Fecha, no ilusión.** Un ingreso entra el día que probablemente se cobre, no
  cuando se factura. Los clientes pagan tarde: si el histórico dice 45 días, se usan 45.
- **El punto de tensión es el entregable.** No importa tanto el número final como
  *en qué semana* la caja se acerca a cero. Ahí es donde hay que actuar antes.
- **Colchón mínimo.** Define con el cliente cuánto necesita tener siempre disponible
  (p. ej. un mes de gastos fijos). El semáforo mide contra ese colchón, no contra cero.
- **Estacionalidad.** Un negocio con temporada (el caso de muchos servicios) no tiene
  caja plana. Si el Perfil Maestro dice que agosto cae, la previsión lo refleja.

### Escenarios (simples)
Con los mismos datos, mueve una palanca cada vez:
- **Base:** todo llega según lo previsto.
- **Cobro retrasado:** la factura grande entra 30 días más tarde.
- **Temporada floja:** los ingresos variables caen un % que indique el cliente.
No hace falta Montecarlo: tres líneas que enseñen la sensibilidad bastan.

## Márgenes

### Mínimo viable
Por cada servicio/producto: **precio de venta** y **coste directo** (lo que cuesta
entregar esa unidad: material, comisiones, y horas × coste/hora).

### Coste por hora (el dato que casi nadie tiene)
Muchos micro-negocios no saben cuánto les cuesta una hora. Se estima **con** el
cliente, no por él:
```
coste_hora ≈ (gastos fijos mensuales + sueldo que quiere sacar) / horas facturables al mes
```
Es una estimación, y se dice que lo es. Pero cambia por completo la lectura de qué
es rentable.

### Cruce margen × volumen (la matriz)
Ranquear por margen a secas engaña. Se cruza con lo que de verdad se vende:
- **💎 Joya:** margen alto + volumen alto → protéjalo y potencie.
- **⚠️ Trampa:** margen bajo + volumen alto → come tiempo y aporta poco. Subir precio,
  optimizar coste, o soltar.
- **Nicho:** margen alto + volumen bajo → ¿se puede vender más?
- **🗑️ Lastre:** margen bajo + volumen bajo → probablemente sobra.

## Higiene
- Todo importe, con o sin IVA declarado explícitamente (no mezclar).
- Coste **directo**, no repartir gastos fijos en cada unidad salvo que se haga bien.
- Lo estimado se marca "estimado". Lo que falta, `[falta el dato]`.
- Esto orienta decisiones; **no es la contabilidad oficial**. Lo fiscal, a la gestoría.
