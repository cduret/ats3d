extern fun{a: t@ype} add(x: a, y: a): a
extern fun{a: t@ype} sub(x: a, y: a): a
extern fun{a: t@ype} mul(x: a, y: a): a
extern fun{a: t@ype} div(x: a, y: a): a
extern fun{a: t@ype} neg(x: a): a
extern fun{a: t@ype}{b: t@ype} lit(x: a): b
extern fun{a:t@ype} eq (x1: a, x2: a):<> bool
extern fun{a:t@ype} lt (x1: a, x2: a):<> bool

implement add<int>(x,y) = g0int_add(x, y)
implement add<float>(x,y) = g0float_add(x, y)
implement add<double>(x,y) = x + y//??

implement mul<int>(x,y) = g0int_mul(x, y)
implement mul<float>(x,y) = g0float_mul(x, y)
implement mul<double>(x,y) = x * y//??

implement sub<int>(x,y) = g0int_sub(x, y)
implement sub<float>(x,y) = g0float_sub(x, y)
implement sub<double>(x,y) = x - y//??

implement div<int>(x,y) = g0int_div(x, y)
implement div<float>(x,y) = g0float_div(x, y)
implement div<double>(x,y) = x - y//??

implement eq<int>(x,y) = g0int_eq(x,y)
implement eq<float>(x,y) = g0float_eq(x,y)
implement eq<double>(x,y) = (x = y)//??

implement neg<int>(x) = g0int_neg(x)
implement neg<float>(x) = g0float_neg(x)
implement neg<double>(x) = ~x//??

implement lit<int><float>(x) = g0int2float_int_float x
implement lit<int><double>(x) = g0int2float_int_double x

implement lit<double><float>(x) = g0float2float_double_float x
implement lit<double><double>(x) = x//??

implement lt<int>(x1,x2) = g0int_lt(x1, x2)
implement lt<float>(x1,x2) = g0float_lt(x1, x2)
implement lt<double>(x1,x2) = x1 < x2 //??
