# Salud financiera — {{NEGOCIO}}
Foto a {{FECHA_HOY}} · datos aportados por el cliente

> {{TITULAR}}   <!-- estado en una frase honesta -->

---

## 1. ¿Llego a fin de mes? — Caja a 30/90 días
- **Saldo hoy: {{SALDO_HOY}}**
- **Punto de tensión:** {{SEMANA_O_MES_TENSION}} → la caja baja a {{MINIMO}} {{SEMAFORO}}
  <!-- o "sin punto de tensión en el horizonte con los datos actuales" -->

| Periodo | Ingresos prev. | Gastos prev. | Caja al final |
|---|---|---|---|
| {{P1}} | {{ING_1}} | {{GAS_1}} | {{CAJA_1}} |
| {{P2}} | {{ING_2}} | {{GAS_2}} | {{CAJA_2}} |
| … | | | |

**Escenarios**
- Base: {{ESCENARIO_BASE}}
- Si un cobro grande se retrasa: {{ESCENARIO_RETRASO}}
- Si cae la temporada: {{ESCENARIO_TEMPORADA}}

## 2. ¿Qué es rentable? — Márgenes

| Servicio/producto | Precio | Coste directo | Margen | Margen % | Volumen | Tipo |
|---|---|---|---|---|---|---|
| {{S1}} | {{PV1}} | {{CD1}} | {{M1}} | {{MP1}} | {{V1}} | {{TIPO1}} |
| … | | | | | | |

- 💎 **Joyas** (mucho margen + mucho volumen): {{JOYAS}}
- ⚠️ **Trampas** (poco margen + mucho volumen, comen tiempo): {{TRAMPAS}}
- 🗑️ **A revisar** (ni margen ni volumen): {{A_REVISAR}}

---

## 3. Las palancas ({{N}} acciones)
1. **{{PALANCA_1}}** — {{NUMERO_1}} · {{PORQUE_1}}
2. **{{PALANCA_2}}** — {{NUMERO_2}} · {{PORQUE_2}}
3. **{{PALANCA_3}}** — {{NUMERO_3}} · {{PORQUE_3}}
<!-- hasta 5, priorizadas por impacto, cada una con su número detrás -->

## 4. Para mirar con tu gestor
- {{TEMA_FISCAL_1}}

## 5. Qué falta para afinar
- {{HUECO_1}}

<!--
NOTAS DE USO (borrar al generar):
- Rellena SOLO con datos aportados. Lo incierto, márcalo ("estimado", "pendiente de confirmar").
- {{SEMAFORO}} y escenarios solo si hay datos que los sostengan.
- Lenguaje de negocio. Cero jerga contable. Números en negrita.
- Esto NO es contabilidad oficial: es una estimación para decidir. Recuérdalo.
-->
