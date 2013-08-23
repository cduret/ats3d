staload "prelude/SATS/arrayptr.sats"

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

absvtype vector2_vt (a:t@ype) = ptr
absvtype vector3_vt (a:t@ype) = ptr
absvtype vector4_vt (a:t@ype) = ptr
absvtype matrix2_vt (a:t@ype) = ptr
absvtype matrix3_vt (a:t@ype) = ptr
absvtype matrix4_vt (a:t@ype) = ptr

fun{a:t@ype}
vec2_vt_create (x: a, y: a): vector2_vt(a)

fun{a:t@ype}
vec2_vt_ptr (v: !vector2_vt(a)):[l: addr] ptr l

fun{a:t@ype}
vec2_vt_free (v: vector2_vt(a)): void

fun{a:t@ype}
vec2_vt_fprint (out: FILEref, vec: !vector2_vt(a)): void

overload fprint with vec2_vt_fprint

fun{a:t@ype}
vec3_vt_create (x: a, y: a, z: a): vector3_vt(a)

fun{a:t@ype}
vec3_vt_ptr (v: !vector3_vt(a)):[l: addr] ptr l

fun{a:t@ype}
vec3_vt_free (v: vector3_vt(a)): void

fun{a:t@ype}
vec3_vt_fprint (out: FILEref, vec: !vector3_vt(a)): void

overload fprint with vec3_vt_fprint

fun{a:t@ype}
vec3_vt_add (v1: vector3_vt(a), v2: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
vec3_vt_substract (v1: vector3_vt(a), v2: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
vec3_vt_multiply (v1: vector3_vt(a), v2: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
vec3_vt_negate (v: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
vec3_vt_scale (v: vector3_vt(a), s: a): vector3_vt(a)

fun{a,b:t@ype}
vec3_vt_length (v: !vector3_vt(a)): b

fun{a,b:t@ype}
vec3_vt_normalize (v: vector3_vt(a)): vector3_vt(b)

fun{a:t@ype}
vec3_vt_cross (v1: vector3_vt(a), v2: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
vec3_vt_dot (v1: vector3_vt(a), v2: vector3_vt(a)): a

fun{a,b:t@ype}
vec3_vt_direction (v1: vector3_vt(a), v2: vector3_vt(a)): vector3_vt(b)

fun{a:t@ype}
vec3_vt_lerp (v1: vector3_vt(a), v2: vector3_vt(a), lerp: a): vector3_vt(a)

fun{a,b:t@ype}
vec3_vt_dist (v1: vector3_vt(a), v2: vector3_vt(a)): b

fun{a:t@ype}
vec4_vt_create (x: a, y: a, z: a, w: a): vector4_vt(a)

fun{a:t@ype}
vec4_vt_ptr (v: !vector4_vt(a)):[l: addr] ptr l

fun{a:t@ype}
vec4_vt_free (v: vector4_vt(a)): void

fun{a:t@ype}
vec4_vt_fprint (out: FILEref, vec: !vector4_vt(a)): void

overload fprint with vec4_vt_fprint

fun{a:t@ype}
mat2_vt_create (m11: a, m12: a, m21: a, m22: a): matrix2_vt(a)

fun{a:t@ype}
mat2_vt_ptr (m: !matrix2_vt(a)):[l: addr] ptr l

fun{a:t@ype}
mat2_vt_free (m: matrix2_vt(a)): void

fun{a:t@ype}
mat3_vt_create (m11: a, m12: a, m13: a, m21: a, m22: a, m23: a, m31: a, m32: a, m33: a): matrix3_vt(a)

fun{a:t@ype}
mat3_vt_copy (m: !matrix3_vt(a)): matrix3_vt(a)

fun{a:t@ype}
mat3_vt_ptr (m: !matrix3_vt(a)):[l: addr] ptr l

fun{a:t@ype}
mat3_vt_free (m: matrix3_vt(a)): void

fun{a:t@ype}
mat3_vt_identity (): matrix3_vt(a)

fun{a:t@ype}
mat3_vt_transpose (m: matrix3_vt(a)): matrix3_vt(a)

fun{a:t@ype}
mat4_vt_of_mat3 (m: matrix3_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat3_vt_fprint (out: FILEref, vec: !matrix3_vt(a)): void

overload fprint with mat3_vt_fprint


fun{a:t@ype}
mat4_vt_create (m11: a, m12: a, m13: a, m14: a, 
                m21: a, m22: a, m23: a, m24: a,
                m31: a, m32: a, m33: a, m34: a,
                m41: a, m42: a, m43: a, m44: a): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_copy (m: !matrix4_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_free (m: matrix4_vt(a)): void

fun{a:t@ype}
mat4_vt_ptr (m: !matrix4_vt(a)):[l: addr] ptr l

fun{a:t@ype}
mat4_vt_identity (): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_transpose (m: matrix4_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_determinant (m: !matrix4_vt(a)): a

fun{a,b:t@ype}
mat4_vt_inverse (m: matrix4_vt(a)): matrix4_vt(b)

fun{a:t@ype}
mat4_vt_multiply (m1: matrix4_vt(a), m2: matrix4_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_multiply_vec3 (m: matrix4_vt(a), v: vector3_vt(a)): vector3_vt(a)

fun{a:t@ype}
mat4_vt_multiply_vec4 (m: matrix4_vt(a), v: vector4_vt(a)): vector4_vt(a)

fun{a:t@ype}
mat4_vt_translate (m: matrix4_vt(a), v: vector3_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_scale (m: matrix4_vt(a), v: vector3_vt(a)): matrix4_vt(a)

fun{a,b:t@ype}
mat4_vt_rotate (m: matrix4_vt(a), angle: b, axis: vector3_vt(b)): matrix4_vt(b)

fun{a:t@ype}
mat4_vt_frustum (left: a, right: a, bottom: a, top: a, near: a, far: a): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_perspective (fovy: a, aspect: a, near: a, far: a): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_ortho (left: a, right: a, bottom: a, top: a, near: a, far: a): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_lookat (eye: vector3_vt(a), center: vector3_vt(a), up: vector3_vt(a)): matrix4_vt(a)

fun{a:t@ype}
mat4_vt_fprint (out: FILEref, vec: !matrix4_vt(a)): void

overload fprint with mat4_vt_fprint
