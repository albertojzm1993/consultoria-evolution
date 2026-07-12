# Referencia — Estrategia de imágenes

Las fotos son lo que hace que una web se vea "cara" y transmita confianza. Deben
ser reales, coherentes con la marca y estar optimizadas.

## Prioridad de origen (de mejor a peor)
1. **Fotos reales del cliente** (equipo, local, trabajos, producto). Son las que
   más confianza generan. Pídelas siempre primero.
2. **Generadas por IA** con el `imagery.prompt_ia_base` del `brand-tokens.json`,
   para mantener estética coherente. Útil para escenas conceptuales o cuando no
   hay foto real. Nunca para simular resultados/clientes reales que no existen
   (líneas rojas éticas y de sector).
3. **Stock gratuito curado** (Unsplash, Pexels — licencia libre para uso
   comercial). Elige con criterio: nada de clichés ("gente dándose la mano"),
   coherente con la paleta y el `estilo_foto` de la marca. Guarda el crédito/URL.

> Nunca uses imágenes con copyright de terceros ni fotos de la competencia.

## Coherencia visual (que parezcan del mismo mundo)
- Mismo **tratamiento**: temperatura de color, contraste y, si la marca lo pide,
  un overlay/duotono sutil con el color de marca.
- Misma **lógica de encuadre** y nivel de realismo en todo el sitio.
- Respeta `imagery.estilo_foto` e `imagery.prompt_ia_base` del JSON.

## Uso por sección
- **Hero**: imagen grande de alto impacto (real, del negocio). Con overlay si va
  texto encima (garantiza contraste AA del texto).
- **Servicios/beneficios**: iconos coherentes (Lucide) mejor que fotos pequeñas.
- **Feature zig-zag**: fotos reales de proceso/producto.
- **Equipo/testimonios**: retratos reales (mucho mejor que avatares genéricos).
- **Casos/galería**: trabajos reales del cliente.

## Optimización técnica (obligatoria)
- Formato moderno (WebP/AVIF) con fallback si hace falta.
- Redimensiona a la medida real de uso (no sirvas 4000px para un thumbnail).
- `loading="lazy"` en todo lo que no sea el hero; el hero puede `preload`.
- Define `width` y `height` (evita saltos de layout / CLS).
- `alt` descriptivo y útil siempre (accesibilidad + SEO). Vacío solo si es
  decorativa.
- Comprime. Objetivo: hero < ~200–300KB, resto mucho menos.

## Iconografía
- Un solo set coherente (Lucide, outline 1.5px). SVG inline o sprite.
- Tamaño y grosor uniformes; color desde `currentColor`/tokens.
