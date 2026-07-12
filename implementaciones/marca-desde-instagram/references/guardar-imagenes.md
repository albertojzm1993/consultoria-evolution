# Guardar las imágenes a disco (procedimiento)

Problema: las URLs del CDN de Instagram (`*.fbcdn.net`) suelen dar **403** si las
descargas fuera del navegador (van firmadas y atadas a sesión/referer). Por eso el
método fiable es **descargar dentro del navegador** (que ya tiene la sesión) y
volcar los bytes a disco a través del helper.

## Método A — base64 desde el navegador (recomendado)
1. Ten la lista de imágenes seleccionadas (cada una: `src`, nombre destino).
2. En el navegador, para un **lote de 3-4** (no todas de golpe: la respuesta de
   `javascript_exec` se serializa a JSON y se trunca si es enorme), ejecuta:
   ```js
   // Devuelve [{name, b64}] para las src dadas
   await (async (items) => {
     const out = [];
     for (const it of items) {
       try {
         const r = await fetch(it.src);
         const b = await r.blob();
         const b64 = await new Promise(res => {
           const fr = new FileReader();
           fr.onloadend = () => res(fr.result.split(',')[1]);
           fr.readAsDataURL(b);
         });
         out.push({ name: it.name, b64 });
       } catch (e) { out.push({ name: it.name, error: String(e) }); }
     }
     return out;
   })(/* pega aquí el array [{src, name}] del lote */);
   ```
3. Guarda ese JSON (los `{name, b64}`) en un fichero temporal, p. ej.
   `scratchpad/ig-lote.json`, y pásaselo al helper:
   ```powershell
   ./scripts/guardar-imagenes.ps1 -JsonPath "<scratchpad>/ig-lote.json" `
       -DestDir "clientes/<slug>/marca/assets/instagram"
   ```
   El helper escribe cada `name` con sus bytes. Repite por lotes.

## Método B — descarga directa (VERIFICADO en la red de Alberto, jul-2026)
En el entorno de Alberto el CDN de Instagram **sí** deja descargar directo, y es el
método más barato (no pasa base64 por el contexto). Ojo: la red hace MITM de HTTPS,
así que hay que **saltar la comprobación de revocación** (`--ssl-no-revoke`), o
`curl` falla con `CRYPT_E_NO_REVOCATION_CHECK`. Comando probado:
```bash
curl -sS -L --ssl-no-revoke --max-time 40 \
     -H 'Referer: https://www.instagram.com/' -H 'User-Agent: Mozilla/5.0' \
     -o "$DEST/nombre.jpg" "$SRC"
```
Descarga las miniaturas 640px de la parrilla (JPEG, ~50-120 KB). Si un día devuelve
403 o un HTML de login (URLs `oh`/`oe` caducadas, o perfil que fuerza sesión),
vuelve al **Método A** (base64 desde el navegador).

## Alternativa — captura de pantalla
Si por lo que sea no puedes leer los bytes (perfil muy pesado, JS bloqueado),
entra en cada post y usa `computer { action: "screenshot" }` o `zoom` sobre la
imagen y guarda el recorte. Pierdes resolución pero sirve para leer la marca.

## Nota de permisos / confidencialidad
Estas imágenes son del **propio cliente** y se guardan **solo** en su carpeta para
construir sus entregables. No se suben a ningún host externo. Guardar aquí = uso
local autorizado por el encargo; aun así, si el volumen es grande o hay dudas,
confírmalo con Alberto antes de un volcado masivo.
