#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "util/SATS/array_ptr.sats"

staload "prelude/SATS/array.sats"
staload "prelude/SATS/list_vt.sats"
staload _(*anonymous*)="prelude/DATS/array.dats"
staload _(*anonymous*)="prelude/DATS/list_vt.dats"

assume array_ptr_vt (a: t@ype, n: int)  = [l:addr] @{pfgc = free_gc_v (a?, n, l), 
                                                     pf = array_v (a, n, l), 
                                                     p = ptr l}

implement{a} array_ptr_new(array) = let
  val (pfgc, pf | p, sz) = array
in
  @{pfgc=pfgc, pf=pf, p=p}
end

implement{a} array_ptr_data(array) = array.p

implement{a} array_ptr_get_elt(array, i) = let
  val p = array.p
  prval pf = array.pf
  val r = array_ptr_get_elt_at<a>(!p, i)
  prval () = array.pf := pf
in
  r
end

implement{a} array_ptr_delete(array) = array_ptr_free {a?} (array.pfgc, array.pf|array.p)

(* ----------------  VIEWTYPE ---------------------------------------*)

assume array_ptr_vtvt (a: viewt@ype, n: int)  = [l:addr] @{pfgc = free_gc_v (a?, n, l), 
                                                          pf = array_v (a, n, l), 
                                                          p = ptr l}

implement{a} array_ptr_new_vt(list) = let
  val sz = size1_of_int1(list_vt_length list)
  val (pfgc, pf | p) = array_ptr_alloc<a> sz
  val () = array_ptr_initialize_lst_vt<a> (!p, list)
in
  @{pfgc=pfgc, pf=pf, p=p}
end

implement{a} array_ptr_delete_fun(array, sz, f) = array_ptr_free_fun<a>(array.pfgc, array.pf|array.p, sz, f)

