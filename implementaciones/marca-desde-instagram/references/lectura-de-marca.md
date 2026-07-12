# Lectura de marca desde el Instagram

Cómo convertir el conjunto de fotos + captions en una lectura de marca honesta que
`manual-de-marca` pueda cerrar. La regla madre: **describe lo que ves, marca la
confianza, no inventes.**

## 1. Paleta de color
- Mira el conjunto, no una foto: ¿qué 3-6 colores se repiten? Sepáralos en:
  - **Color de marca** (aparece a propósito: fondos de plantilla, logo, rótulos,
    decoración del local, uniformes) → candidato a `primary/secondary/accent`.
  - **Color circunstancial** (piel, pelo, ropa de clientas, cielo) → NO es marca,
    aunque domine el píxel. No lo metas en los tokens.
- Da HEX **aproximado** (`≈#A6805C`) salvo que midas el píxel real. Para medirlo:
  en el navegador, `javascript_exec` dibujando la imagen en un `<canvas>` y leyendo
  `getImageData`, o zoom + juicio. Di si es medido o estimado.
- Anota **dónde** aparece cada color (da credibilidad y ayuda a decidir jerarquía).

## 2. Estilo fotográfico
Responde con evidencia:
- **Luz**: natural / estudio / mixta; cálida o fría; alta o baja clave.
- **Encuadre**: primerísimos planos (detalle), plano medio (persona), ambiente.
- **Fondo**: neutro/estudio, el propio local, exteriores, superficies de color.
- **Edición**: saturado / desaturado / cálido / B&N; ¿filtro reconocible?
- **Texto en imagen**: ¿usan rótulos/tipografía sobre la foto? ¿cuál?
- **Protagonista dominante**: persona / resultado-producto / lugar / detalle.
Esto alimenta `imagery.prompt_ia_base` en los tokens y la sección 16-17 del
brand book (estilo fotográfico y estilo para imágenes IA).

## 3. Temas y formato
- ¿Qué publican? (resultados, antes/después, tips, promociones, humor, equipo,
  cliente-a-cliente…). Ordena por frecuencia aproximada.
- Reels vs. foto: ¿dónde está la energía? (indica dónde ya funcionan).

## 4. Tono y voz (de los captions reales)
- Lee 8-10 captions y describe el tono en 2-4 rasgos (cercano, con humor,
  femenino, experto, motivador…). **Cita 2-3 captions textuales** como prueba.
- Apunta muletillas o expresiones propias (emojis recurrentes, forma de tratar a
  la clienta, apodos) — materia prima para `glosario` y `voz` del brand book.
- Señala palabras que **no** encajarían (contradicen el tono) → candidatas a
  `palabras_prohibidas`.

## 5. Formato de salida (`lectura-marca-instagram.md`)
```
# Lectura de marca desde Instagram — <Cliente> (@handle)
Fecha: AAAA-MM-DD · Fuente: N posts vistos, M capturados · Provisional, a validar.

## Paleta
- ≈#RRGGBB — <rol> — <dónde aparece> [V/I/H]
...

## Estilo fotográfico
- Luz: ... [I]   Encuadre: ... [V]   Edición: ... [I]   ...

## Temas y formato
- ...

## Tono y voz
- Rasgos: ...
- Evidencia: "<caption 1>" · "<caption 2>"
- Posibles palabras prohibidas: ...

## Para brand-tokens (propuesta, no validado)
color.primary ≈ ...  · color.accent ≈ ...  · imagery.prompt_ia_base: "..."
```

## Nivel de confianza (obligatorio)
- `[V]` lo ves claramente y se repite (varias fotos/captions).
- `[I]` lo deduces de indicios (una o dos muestras, o inferencia).
- `[H]` hipótesis que hay que confirmar con el cliente.
Sin marca de confianza, la lectura no está terminada.
