// Autenticação de demonstração, usuário único. Configure OMF_APP_PASSWORD e
// OMF_COOKIE_SECRET como secrets distintos no Cloudflare Pages.
const enc=new TextEncoder();
const hex=b=>[...new Uint8Array(b)].map(n=>n.toString(16).padStart(2,"0")).join("");
async function signature(secret,payload){const key=await crypto.subtle.importKey("raw",enc.encode(secret),{name:"HMAC",hash:"SHA-256"},false,["sign"]);return hex(await crypto.subtle.sign("HMAC",key,enc.encode(payload)))}
function equal(a,b){if(!a||!b||a.length!==b.length)return false;let diff=0;for(let i=0;i<a.length;i++)diff|=a.charCodeAt(i)^b.charCodeAt(i);return diff===0}
export const configured=env=>!!(env.DB&&env.OMF_APP_PASSWORD&&env.OMF_COOKIE_SECRET);
export const noStore={"Content-Type":"application/json","Cache-Control":"no-store","X-Content-Type-Options":"nosniff"};
export const json=(obj,status=200,headers={})=>new Response(JSON.stringify(obj),{status,headers:{...noStore,...headers}});
export async function makeCookie(env){const exp=Math.floor(Date.now()/1000)+7200;const raw="v1."+exp,mac=await signature(env.OMF_COOKIE_SECRET,raw);return "omf_session="+raw+"."+mac+"; HttpOnly; Secure; SameSite=Strict; Path=/api; Max-Age=7200"}
export async function valid(request,env){if(!configured(env))return false;const cookie=request.headers.get("cookie")||"",token=cookie.match(/(?:^|;\s*)omf_session=([^;]+)/)?.[1];if(!token)return false;const parts=token.split(".");if(parts.length!==3||parts[0]!=="v1"||!Number.isSafeInteger(+parts[1])||+parts[1]<Math.floor(Date.now()/1000))return false;return equal(parts[2],await signature(env.OMF_COOKIE_SECRET,parts[0]+"."+parts[1]))}
export async function passwordMatches(input,secret){const a=hex(await crypto.subtle.digest("SHA-256",enc.encode(String(input)))),b=hex(await crypto.subtle.digest("SHA-256",enc.encode(secret)));return equal(a,b)}
export function sameOrigin(request){const origin=request.headers.get("origin");if(!origin)return false;return new URL(origin).host===new URL(request.url).host&&new URL(origin).protocol==="https:"}
