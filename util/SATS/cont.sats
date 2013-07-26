typedef cont (a:t@ype, b:t@ype) = (a -<cloref1> b) -<cloref1> b
typedef cloref_cont_1 (a:t@ype, b: t@ype) = a -<cloref1> cont(a,b)

fun{a,b:t@ype} 
return (value: a): cont(a,b)

fun{a,b:t@ype} 
run_cont (C: cont(a,b), f: a -<cloref1> b): b

fun{a,b:t@ype} 
bind (v: cont(a,b), f: cloref_cont_1(a, b)): cont(a,b)

fun{a,b:t@ype}
chain (conts: List(cloref_cont_1(a,b))): cont(a,b) -<cloref1> cont(a,b)
