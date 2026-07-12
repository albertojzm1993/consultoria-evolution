# Playbooks de sector

> **Documento interno de gobierno. NO es para el cliente.** Un playbook es la
> **base de conocimiento viva** de un sector: lo que un consultor que **ya ha visto 50
> negocios de ese tipo** sabe antes de mirar este en concreto. No es un documento
> muerto: crece con cada cliente.

---

## Qué es (y qué no es) un playbook

El motor de la consultora es **genérico a propósito**: el
[`business-scan-framework`](../analisis/business-scan-framework.md) y los **10 pilares** del
[`business-maturity-framework`](../analisis/business-maturity-framework.md) sirven igual a una
peluquería que a una ingeniería. Eso da consistencia, pero hace que cada análisis
arranque desde cero.

Un **playbook** carga el conocimiento del sector *encima* de ese motor:

```
  Business Scan + 10 pilares   ← método genérico (siempre igual)
              +
  Playbook del sector          ← lo que un experto en ese sector ya sabe
              ↓
  Análisis más afilado, más rápido y más consistente
```

- **Es** una base de conocimiento que las skills de `analisis/` **leen** cuando el
  negocio es de ese sector.
- **No es** una skill ni un procedimiento: no se ejecuta, se **consulta**.
- **No es** un análisis prehecho: no sustituye al Business Scan del negocio real. Es
  la hipótesis de partida experta, que el análisis confirma o descarta con datos.

> **Regla de oro:** el playbook **orienta la sospecha**, no dicta la conclusión.
> Nunca se copia una oportunidad, un benchmark ni un aprendizaje al cliente sin
> haberlo verificado en su Business Scan. Los datos concretos de cada cliente viven
> en su carpeta y no se mezclan jamás (confidencialidad, §14 del `CLAUDE.md`).

---

## Filosofía: un playbook nunca está terminado

Esto es lo que convierte la consultora en un **sistema vivo** y no en una carpeta de
plantillas:

- Cada cliente aporta conocimiento nuevo del sector.
- Cuando un patrón **se repite** en varios clientes, se incorpora al playbook.
- Cuando un patrón **deja de cumplirse**, se elimina o se corrige.
- El conocimiento siempre evoluciona: el sistema mejora solo con el uso.

Por eso cada playbook termina con una sección de **casos que lo alimentan**: cada
cliente deja su aprendizaje (patrón de sector, nunca dato confidencial) y el siguiente
arranca sabiendo más.

---

## Qué consume y qué produce un playbook

```
  INPUTS (lo que se cruza con el playbook)      OUTPUTS (lo que ayuda a producir)
  ─────────────────────────────────────         ──────────────────────────────────
  · Business Scan (externo + interno)            · Hipótesis de causa raíz
  · Perfil Maestro del negocio                   · Quick Wins verificables
  · Entrevista / pain points                     · Prioridades y palancas ordenadas
  · Web, Google Business, reseñas                · KPIs y benchmarks de referencia
  · Redes sociales                               · Checklist de señales de alerta
                                                 · Roadmap de madurez (N1→N5)
                                                 · Automatizaciones e IA sugeridas
```

El playbook es el **puente** que convierte datos genéricos del negocio en
conclusiones con criterio de sector.

---

## Las 10 preguntas que todo playbook debe responder (litmus)

Un playbook está bien hecho si, al leerlo, un consultor sabría responder a esto de ese
sector **sin haber visto el negocio todavía**:

1. ¿Cómo funciona este tipo de negocio?
2. ¿Cómo gana dinero?
3. ¿Qué espera el cliente final?
4. ¿Qué diferencia a los mejores del sector?
5. ¿Cuáles son los errores más habituales?
6. ¿Qué oportunidades aparecen una y otra vez?
7. ¿Qué automatizaciones suelen aportar más valor?
8. ¿Qué IA tiene mayor impacto?
9. ¿Qué indicadores determinan el éxito?
10. ¿Cuál suele ser el orden correcto de implantación?

Si el playbook no responde a alguna, está incompleto.

---

## Plantilla obligatoria (estructura canónica)

**Todos** los playbooks siguen esta estructura y este orden. Así ninguno se
desvía y todos son fáciles de mantener y comparar:

| # | Sección | Qué contiene |
|---|---|---|
| 1 | **Qué negocios cubre** | Descripción del sector y variantes que agrupa. |
| 2 | **Cómo gana dinero** | El modelo económico y el modelo mental del sector. |
| 3 | **Tipos de cliente y qué esperan** | A quién sirve el negocio y qué valora. |
| 4 | **La mayor palanca** | La obsesión aplicada: dónde está casi siempre el crecimiento. |
| 5 | **Madurez típica (N1-N5)** | Cómo se ve el sector en cada nivel del Índice de Evolución. |
| 6 | **Cuello de botella + reponderado del Índice** | Mapa síntoma→causa a los 10 pilares y qué pilares pesan más. |
| 7 | **KPIs y benchmarks** | Los indicadores del sector y sus valores de referencia. |
| 8 | **Señales de alerta** | Red flags que, si aparecen, casi seguro esconden un problema. |
| 9 | **Oportunidades y palancas** | Menú clasificado (🟢🟡🔴⚫) + ranking de impacto (★). |
| 10 | **Automatizaciones e IA** | Qué automatizar y qué IA aporta más valor en el sector. |
| 11 | **Marketing del sector** | Contenido que funciona · SEO habitual · cómo es la competencia. |
| 12 | **Preguntas de descubrimiento** | Preguntas propias del sector, sobre las 10 del Business Scan. |
| 13 | **Casos que lo alimentan** | Memoria viva: aprendizajes por cliente (patrones, no datos). |

---

## Taxonomía de oportunidades (común a todos los playbooks)

Para que todos los briefings hablen el mismo idioma, cada oportunidad se etiqueta por
**esfuerzo/horizonte** y, además, por **impacto** (las palancas ★):

| Etiqueta | Qué es | Horizonte |
|---|---|---|
| 🟢 **Quick Win** | Alto impacto, bajo esfuerzo. Genera resultado rápido y confianza. | Días / semanas |
| 🟡 **Mejora estratégica** | Impacto medio-alto, requiere trabajo sostenido. | Semanas / meses |
| 🔴 **Cambio estructural** | Cambia cómo funciona o gana dinero el negocio. | Meses |
| ⚫ **Futura oportunidad** | Tiene sentido cuando el negocio madure; hoy no toca. | Más adelante |

Las **palancas (★★★★★ … ★☆☆☆☆)** son un segundo eje: ordenan las oportunidades por
**impacto en el negocio**, para que el motor de estrategia priorice igual siempre.

---

## Índice de playbooks

| Sector | Archivo | Estado | Caso que lo valida |
|---|---|---|---|
| Bienestar, fitness y estudios de movimiento | [`bienestar-fitness.md`](bienestar-fitness.md) | ✅ v1 | M8 (movimiento consciente / salud postural) |
| Clínicas y salud | `salud-clinicas.md` | ⬜ pendiente | — |
| Restauración y hostelería | `restauracion.md` | ⬜ pendiente | — |
| Despachos y servicios profesionales | `servicios-profesionales.md` | ⬜ pendiente | — |
| Ecommerce y retail | `ecommerce-retail.md` | ⬜ pendiente | — |
| Industria y B2B | `industria-b2b.md` | ⬜ pendiente | — |

> Se crea un playbook nuevo cuando entra el **primer cliente** de un sector: ese
> cliente lo estrena y lo valida. A partir del segundo, ya arranca cargado — y cada
> cliente lo hace más listo.
