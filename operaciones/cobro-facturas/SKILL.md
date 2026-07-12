---
name: cobro-facturas
description: Ayuda a un cliente a cobrar lo que le deben. A partir de su lista de facturas emitidas (CSV, Excel o tabla pegada), detecta lo pendiente y lo vencido, lo prioriza por importe y antigüedad, y redacta la secuencia de recordatorios (amable → firme → formal) con la voz de la marca, lista para que el dueño la revise y envíe. No se conecta a ningún banco ni pasarela de pago y no inventa importes. Lee brand-tokens.json para el tono y el contacto. Úsala cuando el usuario pida perseguir/cobrar facturas, recordatorios de pago, gestión de morosidad, facturas vencidas o "quién me debe dinero".
---

# Cobro de facturas

Convierte "tengo facturas sin cobrar y me da pereza reclamar" en un **plan de cobro
ordenado y unos mensajes listos para enviar**. El equivalente sin fricción del
*Invoice Chaser*: sin conectar con la pasarela de pago, a partir de la lista que el
cliente ya tiene, y siempre con el dueño aprobando antes de que salga nada.

> Regla de oro: **el humano envía, nosotros redactamos.** Esta skill nunca da un
> pago por reclamado ni un mensaje por enviado: produce el texto y el plan; el
> cliente decide y manda. Y **no inventa importes ni fechas**: si un dato falta, se
> pide.

## Contexto (léelo antes)
- **`clientes/<cliente>/marca/brand-tokens.json`** — `tono`, `glosario`,
  `palabras_prohibidas`, `contacto` (firma, teléfono, email). Los recordatorios
  suenan a la marca, no a plantilla genérica.
- **Perfil Maestro** — relación con cada cliente (recurrente vs puntual), forma de
  pago habitual, condiciones acordadas. Un cliente fiel de años no se trata igual
  que un moroso de una vez.

## Datos de entrada (el cliente aporta; tú no los inventas)
Lista de facturas emitidas, en el formato que tenga. Mínimo por factura:
- **Cliente/deudor**, **importe**, **fecha de emisión** y **fecha de vencimiento**
  (o los días de pago acordados: 30, 60…).
- Opcional: nº de factura, si ya se envió algún aviso y cuándo, forma de pago.
- **Formatos:** CSV/Excel exportado de su facturación, o tabla pegada. Si solo dice
  "me deben unos 3.000", se le pide el desglose: no se reclama a ciegas.

---

## FASE 1 — Radiografía del pendiente (`operaciones/cobros/estado-cobros.md`)
1. **Clasifica cada factura** por estado:
   - **Al día** — aún no vencida.
   - **Vencida reciente** — 1 a 15 días de retraso.
   - **Vencida** — 16 a 45 días.
   - **Morosa** — más de 45 días.
2. **Prioriza** por impacto = importe × antigüedad. Lo gordo y viejo, primero.
3. **Cuadro resumen:** total pendiente, total vencido, nº de facturas por tramo, y
   el "top 3 a cobrar ya". Ese total vencido es el que alimenta el pulso semanal.
4. **Marca los casos delicados:** cliente recurrente al que no conviene tensar,
   importes pequeños que no compensan el esfuerzo, disputas conocidas. El tono de
   la reclamación se ajusta a eso (ver `references/tono-y-escalado.md`).

## FASE 2 — Secuencia de recordatorios (`operaciones/cobros/<deudor>/`)
Por cada factura a reclamar, redacta la **escalera de cobro** con la voz de la
marca, usando `templates/recordatorio.md`. Tres peldaños, se sube solo si no hay
respuesta:

1. **Aviso amable** (al vencer o pocos días después) — se asume el olvido, tono
   cordial, se lo pones fácil (importe, nº de factura, cómo pagar).
2. **Recordatorio firme** (~15 días) — claro y directo, sin dramatismo, pide fecha
   concreta de pago.
3. **Requerimiento formal** (~30-45 días) — serio, deja constancia, menciona los
   siguientes pasos sin amenazar. Aquí es donde conviene el "revísalo con tu gestor".

Cada mensaje: canal sugerido (email/WhatsApp/llamada), asunto, cuerpo listo para
copiar, y **cuándo enviarlo**. Todo con los datos reales de la factura, cero
placeholders sin rellenar.

---

## Validación (antes de entregar)
- [ ] Cada importe y fecha viene de un dato aportado; nada inventado.
- [ ] La priorización es por importe × antigüedad, no por orden de la lista.
- [ ] Los tres peldaños existen y **suben en firmeza**, no en agresividad.
- [ ] El tono respeta la relación con cada deudor (recurrente ≠ puntual).
- [ ] Suena a la marca (tono, glosario, palabras prohibidas, firma/contacto reales).
- [ ] Ningún mensaje amenaza ni da asesoría legal; el paso formal remite a la gestoría.
- [ ] El "top 3 a cobrar ya" está claro y es accionable hoy.

## Salida
```
clientes/<cliente>/operaciones/cobros/
├─ estado-cobros.md          ← radiografía + prioridades (+ PDF de marca si se entrega)
└─ <deudor>/
   └─ recordatorios.md       ← la secuencia lista para enviar
```

## Restricciones
- No inventar importes, fechas ni condiciones; ante la duda, preguntar.
- No conectar con bancos ni pasarelas: solo la lista que aporta el cliente.
- No redactar amenazas ni dar asesoría jurídica: el paso formal remite al gestor/abogado.
- No reclamar a un cliente ajeno ni mezclar deudores entre clientes de la consultoría.
- El dueño siempre revisa y envía; la skill no "manda" nada.
