staload "util/SATS/array_ptr.sats"

staload "prelude/SATS/array.sats"
staload "prelude/SATS/list_vt.sats"
staload _(*anonymous*)="prelude/DATS/array.dats"
staload _(*anonymous*)="prelude/DATS/list_vt.dats"

assume array_ptr_vt (a: t@ype, n: int)  = [l:addr] @{pfgc = mfree_ngc_v (l), 
                                                     pf = array_v (a, l, n), 
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
  val (pf1, fpf2 | pi) = array_ptr_takeout<a> (pf | p, i)
  val r = !pi
  prval () = array.pf := fpf2(pf1)
  //val r = array_ptr_get_elt_at<a>(!p, i)
  //prval () = array.pf := pf
in
  r
end

implement{a} array_ptr_delete(array) = array_ptr_free {a?} (array.pfgc, array.pf|array.p)

(* ----------------  VIEWTYPE ---------------------------------------*)

assume array_ptr_vtvt (a: viewt@ype, n: int)  = [l:addr] @{pfgc = mfree_ngc_v (l), 
                                                          pf = array_v (a, l, n), 
                                                          p = ptr l}

(*
implement{a} array_ptr_new_vt(list) = let
  val sz = size_of_int(list_vt_length list)
  val (pfgc, pf | p) = array_ptr_alloc<a> sz
  val () = array_ptr_initialize_lst_vt<a> (!p, list) // does not exist anymore !!
in
  @{pfgc=pfgc, pf=pf, p=p}
end
*)

//implement{a} array_ptr_delete_fun(array, sz, f) = array_ptr_free_fun<a>(array.pfgc, array.pf|array.p, sz, f) // does not exist anymore !!
implement{a} array_ptr_delete_vt(array) = array_ptr_free{a?}(array.pfgc, array.pf|array.p)

