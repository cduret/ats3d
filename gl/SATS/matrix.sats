staload "util/SATS/array_ptr.sats"

(* ********** *)

typedef vector2_t(a:t@ype) = array(a,2)
typedef vector3_t(a:t@ype) = array(a,3)
typedef vector4_t(a:t@ype) = array(a,4)
typedef matrix2_t(a:t@ype) = array(a,4)
typedef matrix3_t(a:t@ype) = array(a,9)
typedef matrix4_t(a:t@ype) = array(a,16)

castfn{a:t@ype} array_of_vector2 (x: vector2_t(a)):<> array(a, 2)
castfn{a:t@ype} array_of_vector3 (x: vector3_t(a)):<> array(a, 3)
castfn{a:t@ype} array_of_vector4 (x: vector4_t(a)):<> array(a, 4)

castfn{a:t@ype} array_of_matrix2 (x: matrix2_t(a)):<> array(a, 4)
castfn{a:t@ype} array_of_matrix3 (x: matrix3_t(a)):<> array(a, 9)
castfn{a:t@ype} array_of_matrix4 (x: matrix4_t(a)):<> array(a, 16)

(* ********** *)

fun{a:t@ype}
vec3_create (x: a, y: a, z: a): vector3_t(a)

fun{a:t@ype}
vec3_add (v1: vector3_t(a), v2: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_substract (v1: vector3_t(a), v2: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_multiply (v1: vector3_t(a), v2: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_negate (v: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_scale (v: vector3_t(a), s: a): vector3_t(a)

fun{a:t@ype}
vec3_normalize (v: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_cross (v1: vector3_t(a), v2: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_length (v: vector3_t(a)): a

fun{a:t@ype}
vec3_dot (v1: vector3_t(a), v2: vector3_t(a)): a

fun{a:t@ype}
vec3_direction (v1: vector3_t(a), v2: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
vec3_lerp (v1: vector3_t(a), v2: vector3_t(a), lerp: a): vector3_t(a)

fun{a:t@ype}
vec3_dist (v1: vector3_t(a), v2: vector3_t(a)): a

//fun{a:t@ype}
//vec3_unproject (v1: vector3_t(a), v2: vector3_t(a)): double

(* ********** *)

fun{a:t@ype}
vec4_create (x: a, y: a, z: a, w: a): vector4_t(a)

(* ********** *)
fun{a:t@ype}
mat3_create (m11: a, m12: a, m13: a, m21: a, m22: a, m23: a, m31: a, m32: a, m33: a): matrix3_t(a)

fun{a:t@ype}
mat3_identity (): matrix3_t(a)

fun{a:t@ype}
mat3_transpose (m: matrix3_t(a)): matrix3_t(a)

fun{a:t@ype}
mat4_of_mat3 (m: matrix3_t(a)): matrix4_t(a)

(* ********** *)
fun{a:t@ype}
mat4_create (m11: a, m12: a, m13: a, m14: a, 
             m21: a, m22: a, m23: a, m24: a,
             m31: a, m32: a, m33: a, m34: a,
             m41: a, m42: a, m43: a, m44: a): matrix4_t(a)

fun{a:t@ype}
mat4_identity (): matrix4_t(a)

fun{a:t@ype}
mat4_transpose (m: matrix4_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_determinant (m: matrix4_t(a)): a

fun{a:t@ype}
mat4_inverse (m: matrix4_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_multiply (m1: matrix4_t(a), m2: matrix4_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_multiply_vec3 (m: matrix4_t(a), v: vector3_t(a)): vector3_t(a)

fun{a:t@ype}
mat4_multiply_vec4 (m: matrix4_t(a), v: vector4_t(a)): vector4_t(a)

fun{a:t@ype}
mat4_translate (m: matrix4_t(a), v: vector3_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_scale (m: matrix4_t(a), v: vector3_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_rotate (m: matrix4_t(a), angle: a, axis: vector3_t(a)): matrix4_t(a)

fun{a:t@ype}
mat4_frustum (left: a, right: a, bottom: a, top: a, near: a, far: a): matrix4_t(a)

fun{a:t@ype}
mat4_perspective (fovy: a, aspect: a, near: a, far: a): matrix4_t(a)

fun{a:t@ype}
mat4_ortho (left: a, right: a, bottom: a, top: a, near: a, far: a): matrix4_t(a)

fun{a:t@ype}
mat4_lookat (eye: vector3_t(a), center: vector3_t(a), up: vector3_t(a)): matrix4_t(a)
