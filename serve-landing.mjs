import http from 'node:http';
import { readFile } from 'node:fs/promises';
import { extname, join, normalize } from 'node:path';
const ROOT = 'Consultoria/clientes/m8/entregables/landings/clase-prueba/deploy';
const TYPES = {'.html':'text/html; charset=utf-8','.css':'text/css; charset=utf-8','.js':'text/javascript; charset=utf-8','.svg':'image/svg+xml','.jpg':'image/jpeg','.jpeg':'image/jpeg','.png':'image/png','.webp':'image/webp'};
http.createServer(async (req,res)=>{
  let p = decodeURIComponent(req.url.split('?')[0]);
  if(p==='/'||p==='') p='/index.html';
  const file = normalize(join(ROOT, p));
  try{
    const data = await readFile(file);
    res.writeHead(200, {'Content-Type': TYPES[extname(file)]||'application/octet-stream'});
    res.end(data);
  }catch{ res.writeHead(404); res.end('404'); }
}).listen(5599, ()=>console.log('serving on 5599'));
