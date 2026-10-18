#!/usr/bin/env python3
"""Auditoria reprodutível do APK autorizado: DEX, SQLite e SQL.

Uso: python scripts/analyze_apk.py "Minhas Finanças_7.2.3.apk"
Somente leitura; não requer JADX. Os corpos de método NÃO são decompilados.
"""
import collections, hashlib, json, sqlite3, struct, sys, tempfile, zipfile
from pathlib import Path
def uleb(data,offset):
    value=0
    for i in range(5):
        b=data[offset];offset+=1;value|=(b&127)<<(7*i)
        if b<128:return value,offset
    raise ValueError("ULEB128 inválido")
def count_dex(data):
    n,off=struct.unpack_from("<II",data,56)
    strings=[]
    for i in range(n):
        pos=struct.unpack_from("<I",data,off+i*4)[0]
        _,pos=uleb(data,pos)
        end=data.find(b"\x00",pos)
        strings.append(data[pos:end].decode("utf-8","replace"))
    types_count,types_off=struct.unpack_from("<II",data,64)
    types=[strings[struct.unpack_from("<I",data,types_off+4*i)[0]] for i in range(types_count)]
    method_count,method_off=struct.unpack_from("<II",data,88)
    methods=[(types[struct.unpack_from("<H",data,method_off+8*i)[0]],strings[struct.unpack_from("<I",data,method_off+8*i+4)[0]]) for i in range(method_count)]
    count,coff=struct.unpack_from("<II",data,96)
    classes=[];code_count=0
    for i in range(count):
        idx,flags,superclass,interfaces,source,anno,code,static=struct.unpack_from("<8I",data,coff+32*i)
        name=types[idx]
        if not name.startswith("Lcicero/minhasfinancas/"):continue
        classes.append(name)
        if not code:continue
        pos=code;static_fields,pos=uleb(data,pos);instance_fields,pos=uleb(data,pos);direct,pos=uleb(data,pos);virtual,pos=uleb(data,pos)
        for j in range(static_fields+instance_fields):_,pos=uleb(data,pos);_,pos=uleb(data,pos)
        method_index=0
        for j in range(direct+virtual):
            diff,pos=uleb(data,pos);method_index+=diff
            _,pos=uleb(data,pos);offset,pos=uleb(data,pos)
            if offset:code_count+=1
            if j+1==direct:method_index=0
    return classes,code_count
def main(apk):
    raw=Path(apk).read_bytes()
    with zipfile.ZipFile(apk) as z:
        entries=z.namelist()
        dex_files=[n for n in entries if n.endswith(".dex")]
        classes=[];body_count=0
        for f in dex_files:
            rows,count=count_dex(z.read(f));classes.extend(rows);body_count+=count
        with tempfile.NamedTemporaryFile(suffix=".db") as dbfile:
            dbfile.write(z.read("assets/databases/minhasfinancas.db"));dbfile.flush()
            db=sqlite3.connect(dbfile.name)
            schema={r[0]:[{"name":c[1],"type":c[2],"primary":bool(c[5])} for c in db.execute('PRAGMA table_info("'+r[0]+'")')] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}
            db.close()
        result={"sha256":hashlib.sha256(raw).hexdigest(),"apk_files":len(entries),"dex_files":len(dex_files),"defined_app_classes":len(classes),"dex_methods_with_code":body_count,"activity_signatures":len([n for n in classes if "/activity/" in n and "Activity;" in n]),"sql_files":len([n for n in entries if n.startswith("assets/SQL/") and n.endswith(".sql")]),"sqlite_tables":len(schema),"sqlite_columns":sum(map(len,schema.values())),"tables":schema}
        print(json.dumps(result,indent=2,ensure_ascii=False))
if __name__=="__main__":
    if len(sys.argv)!=2:raise SystemExit("Uso: python scripts/analyze_apk.py caminho/do/arquivo.apk")
    main(sys.argv[1])
