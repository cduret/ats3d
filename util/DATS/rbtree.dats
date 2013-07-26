#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "util/SATS/rbtree.sats"
staload "prelude/SATS/number.sats"


// ----------------------------------------------------------------------------------
// ------------------------------ SET ------------------------------------------------
// ----------------------------------------------------------------------------------

implement{a} member_set(x, s) =
  case+ s of
  | EmptySet () => false
  | TreeSet (_, a, y, b) => if lt(x, y) then member_set(x, a)
                        else if eq(x, y) then true
                        else member_set(x, b)

implement{a} balance_set(t) =
  case+ t of
  | @(Black(), TreeSet(Red(), TreeSet(Red(), a, x, b), y, c), z, d) =>
    TreeSet(Red, TreeSet(Black, a, x, b), y, TreeSet(Black, c, z, d))
  | @(Black(), TreeSet(Red(), a, x, TreeSet(Red(), b, y, c)), z, d) =>
    TreeSet(Red, TreeSet(Black, a, x, b), y, TreeSet(Black, c, z, d))
  | @(Black(), a, x, TreeSet(Red(), TreeSet(Red(), b, y, c), z, d)) =>
    TreeSet(Red, TreeSet(Black, a, x, b), y, TreeSet(Black, c, z, d))
  | @(Black(), a, x, TreeSet(Red(), b, y, TreeSet(Red(), c, z, d))) =>
    TreeSet(Red, TreeSet(Black, a, x, b), y, TreeSet(Black, c, z, d))
  | @(color, a, y, b) => TreeSet(color, a, y, b)

implement{a} insert_set(x, s) = make_black(ins(x,s)) where {
    fun ins (v: a, s: treeset a): treeset a =
      case+ s of
      | EmptySet() => TreeSet(Red, EmptySet, v, EmptySet)
      | TreeSet(color, a, y, b) => if lt(v, y) then balance_set @(color, ins(v, a), y, b)
                                   else if eq(v, y) then TreeSet(color, a, y, b)
                                   else balance_set @(color, a, y, ins(v,b))
   fun make_black (s: treeset a): treeset a = case+ s of
      | TreeSet(_, a, y, b) => TreeSet(Black, a, y, b)
      | _ => s
}

implement{a} size_set(s) = size_trec(0, s, lam(x:int) =<cloref1> x) where {
  fun size_trec(acc: int, s: treeset a, cnt: int -<cloref1> int): int = case+ s of
  | EmptySet () => cnt acc
  | TreeSet (_,l,_,r) => size_trec(acc+1, l, lam(l_sz: int) =<cloref1>
                                              size_trec(l_sz, r, cnt))
}

// ----------------------------------------------------------------------------------
// ------------------------------ MAP ------------------------------------------------
// ----------------------------------------------------------------------------------

implement{a,b} member_map(x, s) =
  case+ s of
  | EmptyMap () => false
  | TreeMap (_, a, y, _, b) => if lt(x, y) then member_map(x, a)
                        else if eq(x, y) then true
                        else member_map(x, b)

implement{a,b} balance_map(t) =
  case+ t of
  | @(Black(), TreeMap(Red(), TreeMap(Red(), a, x, u, b), y, v, c), z, w, d) =>
    TreeMap(Red, TreeMap(Black, a, x, u, b), y, v, TreeMap(Black, c, z, w, d))
  | @(Black(), TreeMap(Red(), a, x, u, TreeMap(Red(), b, y, v, c)), z, w, d) =>
    TreeMap(Red, TreeMap(Black, a, x, u, b), y, v, TreeMap(Black, c, z, w, d))
  | @(Black(), a, x, u, TreeMap(Red(), TreeMap(Red(), b, y, v, c), z, w, d)) =>
    TreeMap(Red, TreeMap(Black, a, x, u, b), y, v, TreeMap(Black, c, z, w, d))
  | @(Black(), a, x, u, TreeMap(Red(), b, y, v, TreeMap(Red(), c, z, w, d))) =>
    TreeMap(Red, TreeMap(Black, a, x, u, b), y, v, TreeMap(Black, c, z, w, d))
  | @(color, a, y, u, b) => TreeMap(color, a, y, u, b)

implement{a,b} insert_map(x,y,s) = make_black(ins(x,y,s)) where {
    fun ins (v: a, w:b, s: treemap(a,b)): treemap(a,b) =
      case+ s of
      | EmptyMap() => TreeMap(Red, EmptyMap, v, w, EmptyMap)
      | TreeMap(color, a, y, u, b) => if lt(v, y) then balance_map @(color, ins(v,w,a), y, u, b)
                                   else if eq(v, y) then TreeMap(color, a, y, w, b)
                                   else balance_map @(color, a, y, u, ins(v,w,b))
   fun make_black (s: treemap(a,b)): treemap(a,b) = case+ s of
      | TreeMap(_, a, y, u, b) => TreeMap(Black, a, y, u, b)
      | _ => s
}

implement{a, b} size_map(s) = size_trec(0, s, lam(x:int) =<cloref1> x) where {
  fun size_trec(acc: int, s: treemap(a,b), cnt: int -<cloref1> int): int = case+ s of
  | EmptyMap () => cnt acc
  | TreeMap (_,l,_, _,r) => size_trec(acc+1, l, lam(l_sz: int) =<cloref1>
                                              size_trec(l_sz, r, cnt))
}

implement{a, b} get_value_map(s, x) = case+ s of
  | EmptyMap () => None
  | TreeMap (_,l,k,v,r) => if lt(x, k) then
                             get_value_map(l, x)
                           else if eq(x, k) then Some v
                           else get_value_map(r, x)
