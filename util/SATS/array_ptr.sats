staload "prelude/SATS/array.sats"
staload "prelude/SATS/list_vt.sats"

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

// utiliser arrayptr !!! et tester dans test/ ZZZ
absviewt@ype array_ptr_vt(t@ype, int) = ptr

fun{a: t@ype}
array_ptr_new{n: nat} (array: arrpsz(a, n)): array_ptr_vt(a, n)

fun{a: t@ype}
array_ptr_data{n: nat} (array: !array_ptr_vt(a, n)): [l: addr] ptr l

fun{a: t@ype}
array_ptr_get_elt{n: nat}{i: nat | i < n} (array: !array_ptr_vt(a, n), i: size_t i): a

fun{a: t@ype}
array_ptr_delete{n: nat} (array: array_ptr_vt(a, n)): void

(* ----------------  VIEWTYPE ---------------------------------------*)
absviewt@ype array_ptr_vtvt(viewt@ype, int) = ptr

//fun{a: viewt@ype}
//array_ptr_new_vt{n: nat} (list: list_vt(a, n)): array_ptr_vtvt(a, n)

//fun{a: viewt@ype}
//array_ptr_delete_fun{n: nat} (array: array_ptr_vtvt(a, n), sz: size_t n, f: (&a >> a?) -<fun> void): void

fun{a: viewt@ype}
array_ptr_delete_vt{n: nat} (array: array_ptr_vtvt(a?, n)): void
