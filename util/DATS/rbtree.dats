#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "util/SATS/rbtree.sats"
staload UN = "prelude/SATS/unsafe.sats"

// ----------------------------------------------------------------------------------
// ------------------------------ SET ------------------------------------------------
// ----------------------------------------------------------------------------------

local

#include "util/HATS/number.hats"

in

implement{a} member_set(x, s) =
  case+ s of
  | EmptySet () => false
  | TreeSet (_, a, y, b) => if lt(x, y) then member_set(x, a)
                        else if eq(x, y) then true
                        else member_set(x, b)

implement{a} balance_set(col,l,x,r) =
  case- (col, l, x, r) of // why non exhaustive ?
  | (BLACK, ~TreeSet(RED, ~TreeSet(RED, a, x, b), y, c), z, d) =>
    TreeSet(RED, TreeSet(BLACK, a, x, b), y, TreeSet(BLACK, c, z, d))
  | (BLACK, ~TreeSet(RED, a, x, ~TreeSet(RED, b, y, c)), z, d) =>
    TreeSet(RED, TreeSet(BLACK, a, x, b), y, TreeSet(BLACK, c, z, d))
  | (BLACK, a, x, ~TreeSet(RED, ~TreeSet(RED, b, y, c), z, d)) =>
    TreeSet(RED, TreeSet(BLACK, a, x, b), y, TreeSet(BLACK, c, z, d))
  | (BLACK, a, x, ~TreeSet(RED, b, y, ~TreeSet(RED, c, z, d))) =>
    TreeSet(RED, TreeSet(BLACK, a, x, b), y, TreeSet(BLACK, c, z, d))
  | (color, a, y, b) => TreeSet(color, a, y, b)

implement{a} insert_set(x, s) = make_black(ins<a>(x,s)) where {
    fun{a: t@ype} ins{c: color} (v: a, s: treeset_vt(a,c)): [c: color] treeset_vt(a,c) =
      case- s of
      | ~EmptySet () => TreeSet(RED, EmptySet, v, EmptySet)
      | ~TreeSet (color, a, y, b) => if lt(v, y) then balance_set(color, ins(v, a), y, b)
                                   else if eq(v, y) then TreeSet(color, a, y, b)
                                   else balance_set(color, a, y, ins(v,b))
   fun make_black{c: color} (s: treeset_vt(a,c)): [c: color] treeset_vt(a,c) = case+ s of
      | ~TreeSet(_, a, y, b) => TreeSet(BLACK, a, y, b)
      | _ => s
}


implement{a} size_set(s) = size_rec(0, s) where {
  (* tail recursive is impossible here ?
  val ptrl = lam (x: int): int =<cloptr>  x
  
  fun{a: t@ype} size_trec{c: color} (acc: int, s: !treeset_vt(a,c), cnt: int -<cloptr> int): int = case+ s of
  | EmptySet () => let val r = cnt acc val () = cloptr_free($UN.castvwtp0{cloptr0}(cnt)) in r end
  | TreeSet (_,l,_,r) => size_trec(acc+1, l, lam(l_sz: int): int =<cloptr>
                                              size_trec(l_sz, r, cnt))*)
  fun{a: t@ype} size_rec{c: color} (acc: int, s: !treeset_vt(a,c)): int = case+ s of
  | EmptySet () => acc
  | TreeSet (_,l,_,r) => size_rec(size_rec(acc+1, l), r)
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

implement{a,b} balance_map(col, l, k, v, r) =
  case+ (col, l, k, v, r) of
  | (BLACK, ~TreeMap(RED, ~TreeMap(RED, a, x, u, b), y, v, c), z, w, d) =>
    TreeMap(RED, TreeMap(BLACK, a, x, u, b), y, v, TreeMap(BLACK, c, z, w, d))
  | (BLACK, ~TreeMap(RED, a, x, u, ~TreeMap(RED, b, y, v, c)), z, w, d) =>
    TreeMap(RED, TreeMap(BLACK, a, x, u, b), y, v, TreeMap(BLACK, c, z, w, d))
  | (BLACK, a, x, u, ~TreeMap(RED, ~TreeMap(RED, b, y, v, c), z, w, d)) =>
    TreeMap(RED, TreeMap(BLACK, a, x, u, b), y, v, TreeMap(BLACK, c, z, w, d))
  | (BLACK, a, x, u, ~TreeMap(RED, b, y, v, ~TreeMap(RED, c, z, w, d))) =>
    TreeMap(RED, TreeMap(BLACK, a, x, u, b), y, v, TreeMap(BLACK, c, z, w, d))
  | (color, a, y, u, b) => TreeMap(color, a, y, u, b)

implement{a,b} insert_map(x,y,s) = make_black(ins(x,y,s)) where {
    fun{a, b: t@ype} ins{c: color} (v: a, w:b, s: treemap_vt(a,b,c)): [c: color] treemap_vt(a,b,c) =
      case+ s of
      | ~EmptyMap() => TreeMap(RED, EmptyMap, v, w, EmptyMap)
      | ~TreeMap(color, a, y, u, b) => if lt(v, y) then balance_map (color, ins(v,w,a), y, u, b)
                                   else if eq(v, y) then TreeMap(color, a, y, w, b)
                                   else balance_map (color, a, y, u, ins(v,w,b))
   fun{a, b: t@ype} make_black{c: color} (s: treemap_vt(a,b,c)): [c: color] treemap_vt(a,b,c) = case+ s of
      | ~TreeMap(_, a, y, u, b) => TreeMap(BLACK, a, y, u, b)
      | _ => s
}

implement{a, b} size_map(s) = size_rec(0, s) where {
(* size_trec(0, s, lam(x:int) =<cloref1> x) where {
  fun size_trec(acc: int, s: treemap(a,b), cnt: int -<cloref1> int): int = case+ s of
  | EmptyMap () => cnt acc
  | TreeMap (_,l,_, _,r) => size_trec(acc+1, l, lam(l_sz: int) =<cloref1>
                                              size_trec(l_sz, r, cnt))*)
  fun{a,b: t@ype} size_rec{c: color} (acc: int, s: !treemap_vt(a,b,c)): int = case+ s of
  | EmptyMap () => acc
  | TreeMap (_,l,_,_,r) => size_rec(size_rec(acc+1, l), r)
}

implement{a, b} get_value_map(s, x) = case+ s of
  | EmptyMap () => None{b} ()
  | TreeMap (_,l,k,v,r) => if lt(x, k) then
                             get_value_map(l, x)
                           else if eq(x, k) then Some{b} (v)
                           else get_value_map(r, x)
end//local
