---
name: salud-financiera
description: Da a un cliente una foto clara de su salud financiera sin jerga contable — previsión de caja a 30/90 días y márgenes por servicio/producto — a partir de sus datos (CSV/Excel del banco, ingresos y gastos, o tabla pegada). Detecta el mes en que la caja aprieta, qué servicios dejan dinero y cuáles no, y traduce todo en 3-5 palancas concretas. No se conecta a bancos ni contabilidad y no inventa cifras. Lee brand-tokens.json para la voz. Úsala cuando el usuario pida previsión de tesorería, cash-flow, si llega a fin de mes, análisis de márgenes/rentabilidad, qué servicio es más rentable o "cómo va la salud del negocio".
---

# Salud financiera

Responde a las dos preguntas que quitan el sueño a un dueño de negocio: **"¿llego a
fin de mes?"** (caja) y **"¿esto que hago es rentable?"** (márgenes). Sin cuenta de
resultados de 40 líneas ni contabilidad analítica: una foto clara, en lenguaje de
negocio, a partir de los datos que el cliente ya tiene. Fusiona en una sola pieza el
*Cash-flow forecast* y el *Margin analyzer* de Anthropic, dimensionada a micro-pyme.

> Regla de oro: **es una foto y una previsión con los datos que hay, no contabilidad
> oficial.** No inventamos ni un número. Y siempre que un tema roce lo fiscal/legal,
> se remite a la gestoría: esto orienta decisiones, no sustituye al contable.

## Contexto (léelo antes)
- **`clientes/<cliente>/marca/brand-tokens.json`** — `tono`, `glosario`,
  `palabras_prohibidas`. El informe suena a la marca.
- **Perfil Maestro** — servicios/productos, ticket medio, estacionalidad. Sin esto,
  los márgenes no se interpretan bien.
- **Gastos fijos** guardados por `pulso-negocio` o aquí — se comparten, no se piden
  dos veces.

## Datos de entrada (el cliente aporta; tú no los inventas)
Según lo que quiera mirar:
- **Para caja (cash-flow):** saldo actual, ingresos previstos (reservas, contratos,
  facturas por cobrar con su fecha) y gastos previstos (fijos + puntuales conocidos)
  de las próximas semanas.
- **Para márgenes:** por cada servicio/producto → precio de venta y coste directo
  (material, horas, comisiones). Si no sabe el coste por hora, se estima **con él**,
  no por él.
- **Formatos:** CSV/Excel del banco o de facturación, o tabla pegada. Ver
  `references/metodo.md` para el mínimo viable de cada análisis.

Si faltan datos, se hace la parte que se pueda y se listan los huecos. Nunca se
completa una previsión con cifras inventadas.

---

## FASE 1 — Cálculo (tu trabajo, no se muestra en crudo)

### A) Previsión de caja 30/90 días
1. Parte del **saldo hoy**.
2. Semana a semana (o mes a mes): + ingresos previstos con su fecha − gastos
   previstos. Solo lo que tiene fecha razonable; lo incierto se marca como tal.
3. Dibuja la **curva de caja** y localiza el **punto de tensión**: la semana/mes en
   que la caja baja de un colchón mínimo (o de cero). Ese es el hallazgo clave.
4. Escenarios simples si aporta datos: **base** / **si un cobro grande se retrasa** /
   **si cae la temporada baja**. Sin florituras: 2-3 líneas.

### B) Márgenes por servicio/producto
1. Margen unitario = precio − coste directo. Margen % = margen / precio.
2. Ordena de más a menos rentable. Cruza con **volumen** (lo que más se vende):
   un margen alto en algo que no se vende importa menos que uno medio en el
   caballo de batalla.
3. Señala los **tres cuadrantes que importan:** joyas (alto margen + alto volumen),
   trampas (bajo margen + alto volumen, comen tiempo y no dan), y lo que sobra.

## FASE 2 — Informe (`operaciones/finanzas/salud-financiera.md` + PDF de marca)
Usa `templates/informe-salud.md`. En lenguaje de negocio:
1. **Titular** — el estado en una frase honesta.
2. **¿Llego a fin de mes?** — curva de caja, punto de tensión, escenarios.
3. **¿Qué es rentable?** — ranking de márgenes, joyas y trampas.
4. **3-5 palancas** — acciones concretas priorizadas por impacto (subir precio de X,
   dejar de ofrecer Y, adelantar el cobro de Z, recortar gasto W). Cada una con el
   número que la respalda.
5. **Qué mirar con tu gestor** — lo que roza lo fiscal/contable y no nos toca decidir.
6. **Qué falta** — datos que afinarían el análisis.

Tono: claro, de negocio, sin tecnicismos. Un dueño sin formación financiera tiene
que entenderlo entero.

---

## Validación (antes de entregar)
- [ ] Toda cifra procede de datos aportados; lo incierto está marcado como incierto.
- [ ] La previsión de caja tiene un punto de tensión identificado (o se dice que no lo hay).
- [ ] Los márgenes se cruzan con volumen, no se ranquean en el vacío.
- [ ] Hay 3-5 palancas, cada una con un número detrás y priorizada por impacto.
- [ ] Nada de asesoría fiscal formal; lo delicado se remite a la gestoría.
- [ ] Lenguaje de negocio, sin jerga contable. Lo entiende alguien sin formación.
- [ ] Suena a la marca (tono, glosario, palabras prohibidas).

## Salida
```
clientes/<cliente>/operaciones/finanzas/
├─ salud-financiera.md       ← informe (+ PDF de marca)
└─ gastos-fijos.md           ← gastos fijos guardados (compartidos con pulso-negocio)
```

## Restricciones
- No inventar ingresos, gastos, costes ni previsiones sin dato que los sostenga.
- No conectar con bancos ni software contable: solo datos que aporta el cliente.
- No dar asesoría fiscal/contable formal; remitir a la gestoría lo que corresponda.
- No presentar la previsión como cifra oficial: es una estimación con los datos dados.
- Un análisis = un cliente. Nunca mezclar datos financieros entre clientes.
