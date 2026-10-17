export async function onRequestGet({env}) {return Response.json({ok:true,service:"Open Minha Finanças",database:!!env.DB});}
