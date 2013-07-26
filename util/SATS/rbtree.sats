datatype color = Black | Red

datatype treemap (a:t@ype, b: t@ype) =
  EmptyMap(a, b) of ()
  | TreeMap(a,b) of (color, treemap(a, b), a, b, treemap(a, b))

datatype treeset (a:t@ype) =
  EmptySet(a) of ()
  | TreeSet(a) of (color, treeset a , a, treeset a )

fun{a:t@ype} member_set (x:a, s: treeset a ): bool
fun{a:t@ype} balance_set (t: @(color, treeset a, a, treeset a)): treeset a
fun{a:t@ype} insert_set (x:a, s: treeset a): treeset a
fun{a:t@ype} size_set(s: treeset a): int

fun{a, b:t@ype} member_map (x:a, s: treemap(a,b)): bool
fun{a, b:t@ype} balance_map (t: @(color, treemap(a,b), a, b, treemap(a,b))): treemap(a,b)
fun{a, b:t@ype} insert_map (x:a, y:b, s: treemap(a,b)): treemap(a,b)
fun{a, b:t@ype} size_map(s: treemap(a,b)): int
fun{a, b:t@ype} get_value_map(s: treemap(a, b), k: a): Option b
