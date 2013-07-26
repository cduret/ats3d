(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2009 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
**
** An interface for various common funtion on numbers
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Contributed by Shivkumar Chandrasekaran (shiv AT ece DOT ucsb DOT edu)
**
** Time: Summer, 2009
**
*)

(* ****** ****** *)

// HX: this is originally done for the ATS/CBLAS package

(* ****** ****** *)

staload MATH = "libc/SATS/math.sats"

(* ****** ****** *)

staload "prelude/SATS/number.sats"

(* ****** ****** *)

implement print_typ<float> () = print "float"
implement print_typ<double> () = print "double"

(* ****** ****** *)

implement print_elt<float> (x) = print_float x
implement print_elt<double> (x) = print_double x

(* ****** ****** *)

implement of_int<float> (x) = float_of_int (x)
implement of_int<double> (x) = double_of_int (x)

(* ****** ****** *)

implement of_size<float> (x) = float_of_size (x)
implement of_size<double> (x) = double_of_size (x)

(* ****** ****** *)

implement of_double<float> (x) = float_of_double (x)
implement of_double<double> (x) = x

(* ****** ****** *)

implement to_int<float> (x) = int_of_float (x)
implement to_int<double> (x) = int_of_double (x)

implement to_float<float> (x) = x
implement to_float<double> (x) = float_of_double (x)

implement to_double<float> (x) = double_of_float (x)
implement to_double<double> (x) = x

(* ****** ****** *)

implement abs<float,float> (x) = abs_float (x)
implement abs<double,double> (x) = abs_double (x)

(* ****** ****** *)

implement neg<float> (x) = neg_float (x)
implement neg<double> (x) = neg_double (x)

(* ****** ****** *)

implement add<float> (x1, x2) = add_float_float (x1, x2)
implement add<double> (x1, x2) = add_double_double (x1, x2)

implement sub<float> (x1, x2) = sub_float_float (x1, x2)
implement sub<double> (x1, x2) = sub_double_double (x1, x2)

implement mul<float> (x1, x2) = mul_float_float (x1, x2)
implement mul<double> (x1, x2) = mul_double_double (x1, x2)

implement div<float> (x1, x2) = div_float_float (x1, x2)
implement div<double> (x1, x2) = div_double_double (x1, x2)

(* ****** ****** *)

implement pow<float> (x, y) = $MATH.powf (x, y)
implement pow<double> (x, y) = $MATH.pow (x, y)

(* ****** ****** *)

implement ceil<float> (x) = $MATH.ceilf (x)
implement ceil<double> (x) = $MATH.ceil (x)

implement floor<float> (x) = $MATH.floorf (x)
implement floor<double> (x) = $MATH.floor (x)

(* ****** ****** *)

implement sqrt<float> (a) = $MATH.sqrtf (a)
implement sqrt<double> (a) = $MATH.sqrt (a)

(* ****** ****** *)

implement scal<float,float> (x1, x2) = mul_float_float (x1, x2)

implement scal<double,double> (x1, x2) = mul_double_double (x1, x2)

(* ****** ****** *)

implement lt<int> (x1, x2) = x1 < x2
implement lt<float> (x1, x2) = x1 < x2
implement lt<double> (x1, x2) = x1 < x2

implement lte<int> (x1, x2) = x1 <= x2
implement lte<float> (x1, x2) = x1 <= x2
implement lte<double> (x1, x2) = x1 <= x2

implement gt<int> (x1, x2) = x1 > x2
implement gt<float> (x1, x2) = x1 > x2
implement gt<double> (x1, x2) = x1 > x2

implement gte<int> (x1, x2) = x1 >= x2
implement gte<float> (x1, x2) = x1 >= x2
implement gte<double> (x1, x2) = x1 >= x2

(* ****** ****** *)

implement signof<float> (x) =
  compare_float_float (x, (float_of)0.0)
implement signof<double> (x) = compare_double_double (x, 0.0)

implement compare<float> (x1, x2) = compare_float_float (x1, x2)
implement compare<double> (x1, x2) = compare_double_double (x1, x2)

(* ****** ****** *)

implement{a} min (x, y) = if lte<a> (x,y) then x else y
implement{a} max (x, y) = if gte<a> (x,y) then x else y

(* ****** ****** *)

implement eq<int> (x1, x2) = eq_int_int (x1, x2)
implement eq<float> (x1, x2) = eq_float_float (x1, x2)
implement eq<double> (x1, x2) = eq_double_double (x1, x2)

implement neq<float> (x1, x2) = neq_float_float (x1, x2) 
implement neq<double> (x1, x2) = neq_double_double (x1, x2)

(* ****** ****** *)

implement sin<float> (x) = $MATH.sinf (x)
implement sin<double> (x) = $MATH.sin (x)

implement cos<float> (x) = $MATH.cosf (x)
implement cos<double> (x) = $MATH.cos (x)

implement tan<float> (x) = $MATH.tanf (x)
implement tan<double> (x) = $MATH.tan (x)

(* ****** ****** *)

implement asin<float> (x) = $MATH.asinf (x)
implement asin<double> (x) = $MATH.asin (x)

implement acos<float> (x) = $MATH.acosf (x)
implement acos<double> (x) = $MATH.acos (x)

implement atan<float> (x) = $MATH.atanf (x)
implement atan<double> (x) = $MATH.atan (x)

implement atan2<float> (x, y) = $MATH.atan2f (x, y)
implement atan2<double> (x, y) = $MATH.atan2 (x, y)

(* ****** ****** *)

implement lit<int><float>(x) = float_of_int x
implement lit<int><double>(x) = double_of_int x

implement lit<double><float>(x) = float_of_double x
implement lit<double><double>(x) = x


(* ****** ****** *)

(* end of [number.hats] *)
