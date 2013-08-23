#define BLACK 0
#define RED 1
sortdef color = {c:nat | c <= 1}

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

dataviewtype treeset_vt (a:t@ype, int(*color*)) =
  EmptySet(a, BLACK) of ()
  | {c, cl, cr: color} TreeSet(a, c) of (int c, treeset_vt(a, cl) , a, treeset_vt(a, cr))

datatype treemap_vt (a:t@ype, b: t@ype, int(*color*)) =
  EmptyMap(a, b, BLACK) of ()
  | {c, cl, cr: color} TreeMap(a,b,c) of (int c, treemap_vt(a, b, cl), a, b, treemap_vt(a, b, cr))

fun{a:t@ype} member_set{c: color} (x:a, s: !treeset_vt(a,c)): bool
fun{a:t@ype} balance_set{c, cl, cr: color} (col: int c, l: treeset_vt(a,cl), x: a, r: treeset_vt(a,cr)): [c: color] treeset_vt(a,c)
fun{a:t@ype} insert_set{c: color} (x:a, s: treeset_vt(a,c)): [c: color] treeset_vt(a,c)
fun{a:t@ype} size_set{c: color} (s: !treeset_vt(a,c)): int

fun{a, b:t@ype} member_map{c: color} (x:a, s: !treemap_vt(a,b,c)): bool
fun{a, b:t@ype} balance_map{c, cl, cr: color} (col: int c, l: treemap_vt(a,b,cl), k: a, v: b, r: treemap_vt(a,b,cr)): [c: color] treemap_vt(a,b,c)
fun{a, b:t@ype} insert_map{c: color} (x:a, y:b, s: treemap_vt(a,b,c)): [c: color] treemap_vt(a,b,c)
fun{a, b:t@ype} size_map{c: color} (s: !treemap_vt(a,b,c)): int
fun{a, b:t@ype} get_value_map{c: color} (s: !treemap_vt(a, b,c), k: a): Option b
