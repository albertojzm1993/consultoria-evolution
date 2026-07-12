# Secuencia de cobro — {{DEUDOR}}
Factura **{{Nº_FACTURA}}** · importe **{{IMPORTE}}** · emitida {{FECHA_EMISION}} ·
vencía {{FECHA_VENCIMIENTO}} · **{{DIAS_RETRASO}} días de retraso**

Relación: {{RECURRENTE_O_PUNTUAL}} · Canal preferido: {{CANAL}}

---

## Peldaño 1 — Aviso amable
**Cuándo:** {{FECHA_ENVIO_1}} (al vencer o pocos días después)
**Canal:** {{CANAL_1}} · **Asunto:** {{ASUNTO_1}}

> {{CUERPO_1}}
<!-- Cordial. Se asume olvido. Recuerda importe, nº de factura y cómo pagar.
     Firma con el contacto real de brand-tokens.json. -->

---

## Peldaño 2 — Recordatorio firme (si no hay respuesta)
**Cuándo:** {{FECHA_ENVIO_2}} (~15 días de retraso)
**Canal:** {{CANAL_2}} · **Asunto:** {{ASUNTO_2}}

> {{CUERPO_2}}
<!-- Claro y directo, sin dramatismo. Pide una FECHA concreta de pago. -->

---

## Peldaño 3 — Requerimiento formal (si sigue sin respuesta)
**Cuándo:** {{FECHA_ENVIO_3}} (~30-45 días de retraso)
**Canal:** {{CANAL_3}} (email, para dejar constancia) · **Asunto:** {{ASUNTO_3}}

> {{CUERPO_3}}
<!-- Serio, deja constancia, menciona próximos pasos SIN amenazar.
     Incluye: "antes de dar más pasos, lo revisaré con mi gestor". -->

---

<!--
NOTAS DE USO (borrar al generar):
- Todos los datos de la cabecera son reales de la factura. Cero placeholders sueltos.
- La firmeza sube; la agresividad NO. Nunca amenazar ni insultar.
- Tono, glosario y palabras prohibidas de brand-tokens.json mandan.
- Si el deudor es un cliente recurrente valioso, suaviza los tres peldaños y alarga
  los plazos: cobrar sin quemar la relación.
-->
