# Revisión Fable de la metodología — 11-jul-2026

> Bloque 2 del plan de despedida de Fable 5. Método: diseñé la consultoría desde
> cero, desde primeros principios y para tus restricciones reales (un consultor,
> tiempo parcial, 1 cliente, coste marginal ~0 con Claude, piloto en El Prat),
> y luego la comparé con la tuya. Lo que sigue es el diff — incluidas las partes
> donde tu sistema es mejor que mi diseño.

## Mi diseño desde cero, en 10 líneas

Un negocio así vive o muere por la **captación**, no por la capacidad de entrega.
Mi sistema tendría: (1) un motor de captación como pieza central — el resto orbita
alrededor; (2) un proceso de entrega de **3 documentos** para el cliente (te he
entendido → esto es lo que te pasa y por qué → esto haría yo, en este orden, por
este precio), aunque por dentro se trabaje con más rigor; (3) una regla de fábrica:
**ninguna skill se construye hasta que un cliente real la compra**; (4) una fase
final de **medición a 30/90 días** con 3 KPIs pactados — porque sin números no hay
casos, sin casos no hay benchmarks y sin benchmarks no existe el foso que describe
tu propio canvas; (5) una sola fuente de verdad por cosa: un motor de puntuación,
un formulario de datos del cliente, un contrato de marca.

## Donde tu sistema le gana a mi diseño (no tocar)

1. **Las puertas de decisión del cliente** (motor y plan director no avanzan sin
   que el cliente elija). Pocas consultoras grandes lo hacen tan limpio.
2. **Separar auditoría (qué) de diagnóstico (por qué)** como disciplina interna.
   Aunque al cliente se le entregue fusionado, pensar en dos pasos evita el salto
   síntoma→solución, que es el error nº1 del gremio.
3. **brand-tokens.json como contrato** que consumen todas las skills. Single
   source of truth real, con schema. Impecable.
4. **La puerta verify + security-review** antes de desplegar. La mayoría de
   agencias no la tiene.
5. **"No inventamos cifras" + `[falta el dato]`** en operaciones. Es la regla que
   más confianza construye con una micro-pyme.
6. **El humanizer con reglas de español** (raya-inciso vs raya-definición, no
   aplanar fichas). Detalle de oficio.
7. **Scaffolder idempotente** y correspondencia skill→carpeta. Orden operativo.

La calidad de la fábrica no es el problema. El diff está en la **secuencia de
inversión**: qué se construye antes de qué.

## Las 6 diferencias que importan

### 1. El proceso no mide resultados — y tu moat depende de eso
El flujo termina en Fase 6 (ejecución). No existe fase de **seguimiento**: nadie
pacta KPIs en la propuesta ni vuelve a los 30/90 días a medir. Consecuencias en
cadena: sin números → sin casos con nombre → sin benchmarks por sector/zona → el
data moat del canvas (horizonte 3-5 años) no se está alimentando desde el caso 1.
Además es la puerta natural al **retainer** (la relación continua que el canvas
quiere). **Cambio concreto:** añadir Fase 7 — Resultados: 3 KPIs pactados en la
propuesta (§7 Fase 5), carpeta `06-resultados/` en el scaffolder, revisión a 30 y
90 días, y de ahí salen los residuos 2 y 3 (benchmark + caso). Es LA pieza que
falta; lo demás son ajustes.

### 2. Nueve skills ⏳ = inventario muerto potencial
Google Business, SEO local, newsletter, presentaciones, optimización de textos,
traducción, triaje de leads, revisión de contratos, prep fiscal. Ninguna la ha
comprado nadie. Cada una consumirá horas de construcción y mantenimiento (drift
con el contrato de marca, con las plantillas PDF...). **Cambio concreto:** regla
de fábrica bajo demanda — una skill ⏳ se construye la semana en que un cliente la
contrata (con Claude eso es viable), no antes. Las 9 filas se quedan como catálogo
comercial (se pueden VENDER ya), pero no se productizan en vacío. Corolario: WIP
límite 1 — una sola pieza de fábrica en construcción a la vez.

### 3. La fase que factura es la que menos tooling tiene
Todo el bloque análisis tiene skill; la **propuesta comercial** (Fase 5) — el único
documento que convierte trabajo en dinero — no tiene skill, ni plantilla rica, ni
guion de precios (M8 tiene su `05-propuesta/propuesta.md`, pero se hizo a pulso).
En mi diseño sería la skill MÁS pulida del sistema: 3 opciones de alcance
(bueno/mejor/mayor), precio orientativo por opción, la garantía "si no aporto
valor no cobras" en el centro, y los KPIs de la futura Fase 7 ya pactados.
**Cambio concreto:** crear `propuesta-comercial` como skill de primera clase en
`analisis/`, antes que cualquiera de las 9 ⏳.

### 4. Dos motores de puntuación que pueden divergir
El Índice de Evolución vive en `analisis/business-maturity-framework.md` (10
pilares, ponderación por sector) y OTRA VEZ en
`Evolution/captacion/prompt-ime-inicial.md` (subconjunto con su propia fórmula
"media ponderada × 10"). Hoy coinciden; en 3 meses de retoques, no. Y si un lead
captado con el IME inicial se convierte en cliente, su puntuación puede cambiar al
re-evaluarlo con el motor completo — incómodo de explicar. **Cambio concreto:**
declarar el framework de `analisis/` como única fuente; el prompt de captación
referencia sus bandas y pilares en vez de redefinirlos, y deja escrito "IME
inicial = outside-in, ±1 nivel de error esperado" para gestionar la conversión.

### 5. El /100 ponderado por sector es falsa precisión con n=1
Mismo pecado que castigas en el motor cuantitativo: calibrar parámetros
(ponderaciones sectoriales) sin muestra. Un "63/100" transmite una exactitud que
no existe todavía y te expone ante un cliente analítico ("¿por qué 63 y no 58?").
Los N1-N5 en cambio son honestos y comerciales. **Cambio concreto:** congelar las
ponderaciones por sector (una única ponderación genérica documentada) hasta ~10
casos reales; comunicar nivel y banda, no el número fino; el número queda interno.
Cuando haya datos, las ponderaciones se calibran con casos — y ESO sí es moat.

### 6. La regla de los 3 residuos está propuesta pero no cableada
El canvas la propone (skill afinada + benchmark anonimizado + caso documentado por
proyecto) y el proceso no la menciona. Las reglas que no están en el checklist de
cierre no ocurren. **Cambio concreto:** si la adoptas (en el Bloque 4 la
discutimos), va al final del §7 como "Cierre de proyecto" con checklist de 3
ítems, y la Fase 7 de resultados produce los residuos 2 y 3 casi gratis.

## Qué NO construiría (aunque apetezca)

- Más playbooks sectoriales especulativos: un playbook se escribe DESPUÉS del
  primer cliente del sector, como residuo, con datos reales (bienestar-fitness ✓
  porque M8 existe; el siguiente, cuando exista el cliente).
- Automatizar nóminas/cierre contable (ya bien descartado — gestoría).
- Integraciones (bancos, CRMs): tu "sin integraciones" es una ventaja de
  velocidad y honestidad para micro-pyme. Defenderla.
- Un CRM propio / dashboard de clientes: con <5 clientes, una tabla en el README
  del cliente sobra.

## Si solo haces 3 cosas

1. **Fase 7 — Resultados** (KPIs pactados + medición 30/90 + residuos). Alimenta
   moat, casos y retainer. Sin esto, el resto es cosmética.
2. **Skill `propuesta-comercial`** de primera clase. Es donde se gana el dinero.
3. **Regla de fábrica bajo demanda** (las ⏳ se construyen al venderse) + unificar
   el motor de puntuación (§4). Menos inventario, menos drift, más foco en captar.
