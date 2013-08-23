#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "gl/SATS/matrix.sats"

staload "util/SATS/array_ptr.sats"
staload "prelude/SATS/number.sats"
staload "util/SATS/number.sats"

staload _(*anon*) = "util/DATS/array_ptr.dats"

(* ------------ VEC3 ----------------- *)

implement{a} vec3_create(x, y, z) = array_make_view_ptr(pf|p) where {
  val (_, pf|p, sz) = $arrpsz {a}(x, y, z)
}
  
implement{a} vec3_add(v1, v2) = vec3_create(x, y, z) where {
  val x = add(v1[0], v2[0])
  val y = add(v1[1], v2[1])
  val z = add(v1[2], v2[2])
}

implement{a} vec3_substract(v1, v2) = vec3_create(x, y, z) where {
  val x = sub(v1[0], v2[0])
  val y = sub(v1[1], v2[1])
  val z = sub(v1[2], v2[2])
}

implement{a} vec3_multiply(v1, v2) = vec3_create(x, y, z) where {
  val x = mul(v1[0], v2[0])
  val y = mul(v1[1], v2[1])
  val z = mul(v1[2], v2[2])
}

implement{a} vec3_negate(v) = vec3_create(neg v[0], neg v[1], neg v[2])

implement{a} vec3_scale(v1, s) = vec3_create(x, y, z) where {
  val x = mul(v1[0], s)
  val y = mul(v1[1], s)
  val z = mul(v1[2], s)
}

implement{a} vec3_normalize(v) = vec3_res where {
  val len = vec3_length v
  val zero = lit<int>(0)
  val one = lit<int>(1)
  macdef eq_zero (x) = eq<a>(,(x), zero)
  macdef eq_one (x) = eq<a>(,(x), one)
  val vec3_res = case+ 0 of
    | _ when eq_zero(len) => vec3_create<a>(zero, zero, zero)
    | _ when eq_one(len) => v
    | _ => vec3_create<a>(div(v[0], len), div(v[1], len), div(v[2], len))
}

implement{a} vec3_cross(v1, v2) = vec3_create(x, y, z) where {
  val x = sub(mul(v1[1],v2[2]), mul(v1[2],v2[1]))
  val y = sub(mul(v1[2],v2[0]), mul(v1[0],v2[2]))
  val z = sub(mul(v1[0],v2[1]), mul(v1[1],v2[0]))
}

implement{a} vec3_length(v) = sqrt(add(x_2, add(y_2, z_2))) where {
  val x_2 = mul(v[0], v[0])
  val y_2 = mul(v[1], v[1])
  val z_2 = mul(v[2], v[2])
}

implement{a} vec3_dot(v1, v2) = add(x, add(y, z)) where {
  val x = mul(v1[0], v2[0])
  val y = mul(v1[1], v2[1])
  val z = mul(v1[2], v2[2])
}

implement{a} vec3_direction(v1, v2) = vec3_create(x, y, z) where {
  val v0 = vec3_substract(v1, v2)
  val len = vec3_length v0
  val x = mul(v0[0], len)
  val y = mul(v0[1], len)
  val z = mul(v0[2], len)
}

implement{a} vec3_lerp(v1, v2, lerp) = vec3_create(x, y, z) where {
  val x = add(v1[0], mul(lerp, sub(v2[0], v1[0])))
  val y = add(v1[1], mul(lerp, sub(v2[1], v1[1])))
  val z = add(v1[2], mul(lerp, sub(v2[2], v1[2])))
}

implement{a} vec3_dist(v1, v2) = sqrt( add(x_2, add(y_2, z_2)) ) where {
  val v0 = vec3_substract(v1,v2)
  val x_2 = mul(v0[0], v0[0])
  val y_2 = mul(v0[1], v0[1])
  val z_2 = mul(v0[2], v0[2])
}

(* ---------- VEC4 ------------ *)

implement{a} vec4_create(x, y, z, w) = array_make_view_ptr(pf|p) where {
  val (_, pf|p, sz) = $arrpsz {a}(x, y, z, w)
}

(* ---------- MAT3 ------------ *)

implement{a} mat3_create (m11, m12, m13, m21, m22, m23, m31, m32, m33) = 
  array_make_view_ptr(pf|p) where {
  val (_, pf|p, sz) = $arrpsz {a}(m11, m12, m13, m21, m22, m23, m31, m32, m33)
}
  
implement{a} mat3_identity() = mat3_create(one, zero, zero,
                                           zero, one, zero,
                                           zero, zero, one) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
}

implement{a} mat3_transpose(m) = mat3_create(m[0], m[3], m[6],
                                             m[1], m[4], m[7],
                                             m[2], m[5], m[8])

implement{a} mat4_of_mat3(m) = mat4_create(m[0], m[1], m[2], zero,
                                           m[3], m[4], m[5], zero,
                                           m[6], m[7], m[8], zero,
                                           zero, zero, zero, one) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
}

(* ---------- MAT4 ------------ *)

implement{a} mat4_create(m11, m12, m13, m14, m21, m22, m23, m24,
                         m31, m32, m33, m34, m41, m42, m43, m44) = 
  array_make_view_ptr(pf|p) where {
  val (_, pf|p, sz) = $arrpsz {a}(m11, m12, m13, m14, m21, m22, m23, m24,
                                 m31, m32, m33, m34, m41, m42, m43, m44)
}

implement{a} mat4_identity() = mat4_create(one, zero, zero, zero,
                                           zero, one, zero, zero,
                                           zero, zero, one, zero,
                                           zero, zero, zero, one) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
}

implement{a} mat4_transpose(m) = mat4_create(m[0], m[4], m[8], m[12],
                                             m[1], m[5], m[9], m[13],
                                             m[2], m[6], m[10], m[14],
                                             m[3], m[7], m[11], m[15])

implement{a} mat4_determinant(m) = x where {
  val a00 = m[0] val a01 = m[1] val a02 = m[2] val a03 = m[3]
  val a10 = m[4] val a11 = m[5] val a12 = m[6] val a13 = m[7]
  val a20 = m[8] val a21 = m[9] val a22 = m[10] val a23 = m[11]
  val a30 = m[12] val a31 = m[13] val a32 = m[14] val a33 = m[15]

  val c11 = mul(mul(mul(a30, a21), a12), a03)
  val c12 = mul(mul(mul(a20, a31), a12), a03)
  val c13 = mul(mul(mul(a30, a11), a22), a03)
  val c1 = sub(sub(c11, c12), c13)
  val e1 = mul(mul(mul(a10, a31), a22), a03)

  val c21 = mul(mul(mul(a20, a11), a32), a03)
  val c22 = mul(mul(mul(a10, a21), a32), a03)
  val c23 = mul(mul(mul(a30, a21), a02), a13)
  val c2 = sub(sub(c21, c22), c23)
  val e2 = mul(mul(mul(a20, a31), a02), a13)

  val c31 = mul(mul(mul(a30, a01), a22), a13)
  val c32 = mul(mul(mul(a00, a31), a22), a13)
  val c33 = mul(mul(mul(a20, a01), a22), a13)
  val c3 = sub(sub(c31, c32), c33)
  val e3 = mul(mul(mul(a00, a21), a32), a13)

  val c41 = mul(mul(mul(a30, a11), a02), a23)
  val c42 = mul(mul(mul(a10, a31), a02), a23)
  val c43 = mul(mul(mul(a30, a01), a12), a23)
  val c4 = sub(sub(c41, c42), c43)
  val e4 = mul(mul(mul(a00, a31), a12), a23)

  val c51 = mul(mul(mul(a10, a01), a32), a23)
  val c52 = mul(mul(mul(a00, a11), a32), a23)
  val c53 = mul(mul(mul(a20, a11), a02), a33)
  val c5 = sub(sub(c51, c52), c53)
  val e5 = mul(mul(mul(a10, a21), a02), a33)

  val c61 = mul(mul(mul(a20, a01), a12), a33)
  val c62 = mul(mul(mul(a00, a21), a12), a23)
  val c63 = mul(mul(mul(a10, a01), a22), a33)
  val c6 = sub(sub(c61, c62), c63)
  val e6 = mul(mul(mul(a00, a11), a22), a33)

  val x = add(add(add(add(add(add(add(add(add(add(add(c1, e1), 
                                                  c2), 
                                              e2), 
                                          c3), 
                                      e3), 
                                  c4), 
                              e4), 
                          c5), 
                      e5), 
                  c6), 
              e6)
}

implement{a} mat4_inverse(m) = mat4_res where {
  val a00 = m[0] val a01 = m[1] val a02 = m[2] val a03 = m[3]
  val a10 = m[4] val a11 = m[5] val a12 = m[6] val a13 = m[7]
  val a20 = m[8] val a21 = m[9] val a22 = m[10] val a23 = m[11]
  val a30 = m[12] val a31 = m[13] val a32 = m[14] val a33 = m[15]

  val b00 = sub(mul(a00, a11), mul(a01, a10))
  val b01 = sub(mul(a00, a12), mul(a02, a10))
  val b02 = sub(mul(a00, a13), mul(a03, a10))
  val b03 = sub(mul(a01, a12), mul(a02, a11))
  val b04 = sub(mul(a01, a13), mul(a03, a11))
  val b05 = sub(mul(a02, a13), mul(a03, a12))
  val b06 = sub(mul(a20, a31), mul(a21, a30))
  val b07 = sub(mul(a20, a32), mul(a22, a30))
  val b08 = sub(mul(a20, a33), mul(a23, a30))
  val b09 = sub(mul(a21, a32), mul(a22, a31))
  val b10 = sub(mul(a21, a33), mul(a23, a31))
  val b11 = sub(mul(a22, a33), mul(a23, a32))
  val det = add(sub(add(add(sub(mul(b00, b11), 
                                mul(b01, b10)), 
                            mul(b02, b09)), 
                        mul(b03, b08)), 
                    mul(b04, b07)), 
                mul(b05, b06))
  val zero = lit<int>(0)
  macdef eq_zero (x) = eq<a>(,(x), zero)
  val mat4_res = if eq_zero(det) then mat4_create<a>(zero, zero, zero, zero,
                                                     zero, zero, zero, zero,
                                                     zero, zero, zero, zero,
                                                     zero, zero, zero, zero)
                 else let
                   val inv_det = div<a>(lit<int>(1), det)
                   val m00 = mul(add(sub(mul<a>(a11, b11), mul<a>(a12, b10)), mul<a>(a13, b09)), inv_det)
                   val m01 = mul(add(mul<a>(neg<a>(a01), b11), sub(mul<a>(a02, b10), mul<a>(a03, b09))), inv_det)
                   val m02 = mul(add(sub(mul<a>(a31, b05), mul<a>(a32, b04)), mul<a>(a33, b03)), inv_det)
                   val m03 = mul(sub(add(mul<a>(neg<a>(a21), b05), mul<a>(a22, b04)), mul<a>(a23, b03)), inv_det)
                   val m10 = mul(sub(add(mul<a>(neg<a>(a10), b11), mul<a>(a12, b08)), mul<a>(a13, b07)), inv_det)
                   val m11 = mul(add(sub(mul<a>(a00, b11), mul<a>(a02, b08)), mul<a>(a03, b07)), inv_det)
                   val m12 = mul(sub(add(mul<a>(neg<a>(a30), b05), mul<a>(a32, b02)), mul<a>(a33, b01)), inv_det)
                   val m13 = mul(add(sub(mul<a>(a20, b05), mul<a>(a22, b02)), mul<a>(a23, b01)), inv_det)
                   val m20 = mul(add(sub(mul<a>(a10, b10), mul<a>(a11, b08)), mul<a>(a13, b06)), inv_det)
                   val m21 = mul(sub(add(mul<a>(neg<a>(a00), b10), mul<a>(a01, b08)), mul<a>(a03, b06)), inv_det)
                   val m22 = mul(add(sub(mul<a>(a30, b04), mul<a>(a31, b02)), mul<a>(a33, b00)), inv_det)
                   val m23 = mul(sub(add(mul<a>(neg<a>(a20), b04), mul<a>(a21, b02)), mul<a>(a23, b00)), inv_det)
                   val m30 = mul(sub(add(mul<a>(neg<a>(a10), b09), mul<a>(a11, b07)), mul<a>(a12, b06)), inv_det)
                   val m31 = mul(add(sub(mul<a>(a00, b09), mul<a>(a01, b07)), mul<a>(a02, b06)), inv_det)
                   val m32 = mul(sub(add(mul<a>(neg<a>(a30), b03), mul<a>(a31, b01)), mul<a>(a32, b00)), inv_det)
                   val m33 = mul(add(sub(mul<a>(a20, b03), mul<a>(a21, b01)), mul<a>(a22, b00)), inv_det)
                 in
                   mat4_create<a>(m00, m01, m02, m03,
                                  m10, m11, m12, m13, 
                                  m20, m21, m22, m23, 
                                  m30, m31, m32, m33)
                 end
}

implement{a} mat4_multiply(m1, m2) = mat4_create(c00, c01, c02, c03,
                                                 c10, c11, c12, c13,
                                                 c20, c21, c22, c23,
                                                 c30, c31, c32, c33) where {
  val a00 = m1[0] val a01 = m1[1] val a02 = m1[2] val a03 = m1[3]
  val a10 = m1[4] val a11 = m1[5] val a12 = m1[6] val a13 = m1[7]
  val a20 = m1[8] val a21 = m1[9] val a22 = m1[10] val a23 = m1[11]
  val a30 = m1[12] val a31 = m1[13] val a32 = m1[14] val a33 = m1[15]
  val b00 = m2[0] val b01 = m2[1] val b02 = m2[2] val b03 = m2[3]
  val b10 = m2[4] val b11 = m2[5] val b12 = m2[6] val b13 = m2[7]
  val b20 = m2[8] val b21 = m2[9] val b22 = m2[10] val b23 = m2[11]
  val b30 = m2[12] val b31 = m2[13] val b32 = m2[14] val b33 = m2[15]

  val c00 = add(add(add(mul(b00, a00), mul(b01, a10)), mul(b02, a20)), mul(b03, a30))
  val c01 = add(add(add(mul(b00, a01), mul(b01, a11)), mul(b02, a21)), mul(b03, a31))
  val c02 = add(add(add(mul(b00, a02), mul(b01, a12)), mul(b02, a22)), mul(b03, a32))
  val c03 = add(add(add(mul(b00, a03), mul(b01, a13)), mul(b02, a23)), mul(b03, a33))
  val c10 = add(add(add(mul(b10, a00), mul(b11, a10)), mul(b12, a20)), mul(b13, a30))
  val c11 = add(add(add(mul(b10, a01), mul(b11, a11)), mul(b12, a21)), mul(b13, a31))
  val c12 = add(add(add(mul(b10, a02), mul(b11, a12)), mul(b12, a22)), mul(b13, a32))
  val c13 = add(add(add(mul(b10, a03), mul(b11, a13)), mul(b12, a23)), mul(b13, a33))
  val c20 = add(add(add(mul(b20, a00), mul(b21, a10)), mul(b22, a20)), mul(b23, a30))
  val c21 = add(add(add(mul(b20, a01), mul(b21, a11)), mul(b22, a21)), mul(b23, a31))
  val c22 = add(add(add(mul(b20, a02), mul(b21, a12)), mul(b22, a22)), mul(b23, a32))
  val c23 = add(add(add(mul(b20, a03), mul(b21, a13)), mul(b22, a23)), mul(b23, a33))
  val c30 = add(add(add(mul(b30, a00), mul(b31, a10)), mul(b32, a20)), mul(b33, a30))
  val c31 = add(add(add(mul(b30, a01), mul(b31, a11)), mul(b32, a21)), mul(b33, a31))
  val c32 = add(add(add(mul(b30, a02), mul(b31, a12)), mul(b32, a22)), mul(b33, a32))
  val c33 = add(add(add(mul(b30, a03), mul(b31, a13)), mul(b32, a23)), mul(b33, a33))
}

implement{a} mat4_multiply_vec3(m, v) = vec3_create(x1, y1, z1) where {
  val x1 = add(add(add(mul(v[0], m[0]), mul(v[1], m[4])), mul(v[2], m[8])), m[12])
  val y1 = add(add(add(mul(v[0], m[1]), mul(v[1], m[5])), mul(v[2], m[9])), m[13])
  val z1 = add(add(add(mul(v[0], m[2]), mul(v[1], m[6])), mul(v[2], m[10])), m[14])
}

implement{a} mat4_multiply_vec4(m, v) = vec4_create(x1, y1, z1, w1) where {
  val x1 = add(add(add(mul(v[0], m[0]), mul(v[1], m[4])), mul(v[2], m[8])), m[12])
  val y1 = add(add(add(mul(v[0], m[1]), mul(v[1], m[5])), mul(v[2], m[9])), m[13])
  val z1 = add(add(add(mul(v[0], m[2]), mul(v[1], m[6])), mul(v[2], m[10])), m[14])
  val w1 = add(add(add(mul(v[0], m[3]), mul(v[1], m[7])), mul(v[2], m[11])), m[15])
}

implement{a} mat4_translate(m, v) = mat4_create(a00, a01, a02, a03,
                                                a10, a11, a12, a13,
                                                a20, a21, a22, a23,    
                                                b30, b31, b32, b33) where {
  val a00 = m[0] val a01 = m[1] val a02 = m[2] val a03 = m[3]
  val a10 = m[4] val a11 = m[5] val a12 = m[6] val a13 = m[7]
  val a20 = m[8] val a21 = m[9] val a22 = m[10] val a23 = m[11]
  val a30 = m[12] val a31 = m[13] val a32 = m[14] val a33 = m[15]

  val b30 = add(add(add(mul(a00, v[0]), mul(a10, v[1])), mul(a20, v[2])), a30)
  val b31 = add(add(add(mul(a01, v[0]), mul(a11, v[1])), mul(a21, v[2])), a31)
  val b32 = add(add(add(mul(a02, v[0]), mul(a12, v[1])), mul(a22, v[2])), a32)
  val b33 = add(add(add(mul(a03, v[0]), mul(a13, v[1])), mul(a23, v[2])), a33)
}

implement{a} mat4_scale(m, v) = mat4_create(a00, a01, a02, a03,
                                         a10, a11, a12, a13,
                                         a20, a21, a22, a23,     
                                         a30, a31, a32, a33) where {
  val x = v[0] val y = v[1] val z = v[2]

  val a00 = mul(m[0], x) val a01 = mul(m[1], x) val a02 = mul(m[2], x) val a03 = mul(m[3], x)
  val a10 = mul(m[4], y) val a11 = mul(m[5], y) val a12 = mul(m[6], y) val a13 = mul(m[7], y)
  val a20 = mul(m[8], z) val a21 = mul(m[9], z) val a22 = mul(m[10], z) val a23 = mul(m[11], z)
  val a30 = m[12] val a31 = m[13] val a32 = m[14] val a33 = m[15]
}

implement {a} mat4_rotate(m, angle, axis) = mat4_create(c00, c01, c02, c03,
                                                        c10, c11, c12, c13,
                                                        c20, c21, c22, c23,
                                                        c30, c31, c32, c33) where {
  val x = axis[0] val y = axis[1] val z = axis[2]
  val a00 = m[0] val a01 = m[1] val a02 = m[2] val a03 = m[3]
  val a10 = m[4] val a11 = m[5] val a12 = m[6] val a13 = m[7]
  val a20 = m[8] val a21 = m[9] val a22 = m[10] val a23 = m[11]
  val a30 = m[12] val a31 = m[13] val a32 = m[14] val a33 = m[15]

  val len = sqrt(add(add(mul(x, x), mul(y,y)), mul(z,z)))
  val s = sin(angle)
  val c = cos(angle)
  val t = sub(lit<int>(1), c)
  val b00 = add(mul(mul(x, x), t), c)
  val b01 = add(mul(mul(y, x), t), mul(z, s))
  val b02 = sub(mul(mul(z, x), t), mul(y, s))
  val b10 = sub(mul(mul(x, y), t), mul(z, s))
  val b11 = add(mul(mul(y, y), t), c)
  val b12 = add(mul(mul(z, y), t), mul(x, s))
  val b20 = add(mul(mul(x, z), t), mul(y, s))
  val b21 = sub(mul(mul(y, z), t), mul(x, s))
  val b22 = add(mul(mul(z, z), t), c)

  val c00 = add(add(mul(a00, b00), mul(a10, b01)), mul(a20, b02))
  val c01 = add(add(mul(a01, b00), mul(a11, b01)), mul(a21, b02))
  val c02 = add(add(mul(a02, b00), mul(a12, b01)), mul(a22, b02))
  val c03 = add(add(mul(a03, b00), mul(a13, b01)), mul(a23, b02))

  val c10 = add(add(mul(a00, b10), mul(a10, b11)), mul(a20, b12))
  val c11 = add(add(mul(a01, b10), mul(a11, b11)), mul(a21, b12))
  val c12 = add(add(mul(a02, b10), mul(a12, b11)), mul(a22, b12))
  val c13 = add(add(mul(a03, b10), mul(a13, b11)), mul(a23, b12))

  val c20 = add(add(mul(a00, b20), mul(a10, b21)), mul(a20, b22))
  val c21 = add(add(mul(a01, b20), mul(a11, b21)), mul(a21, b22))
  val c22 = add(add(mul(a02, b20), mul(a12, b21)), mul(a22, b22))
  val c23 = add(add(mul(a03, b20), mul(a13, b21)), mul(a23, b22))

  val c30 = m[12] val c31 = m[13] val c32 = m[14] val c33 = m[15]
}

implement{a} mat4_frustum(left, right, bottom, top, near, far) = 
          mat4_create(a00, zero, zero, zero,
                      zero,  a11, zero, zero,
                      a20, a21, a22, neg(one),
                      zero, zero, a32, zero) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
  val mul_near_two = mul(near, lit<int>(2))
  val rl = sub(right, left)
  val tb = sub(top, bottom)
  val f = sub(far, near)
  val a00 = div(mul_near_two, rl)
  val a11 = div(mul_near_two, tb)
  val a20 = div(add(left, right), rl)
  val a21 = div(add(top, bottom), tb)
  val a22 = neg(div(add(far, near), f))
  val a32 = neg(div(mul(far, mul_near_two), f))
} 

implement{a} mat4_perspective(fovy, aspect, near, far) = 
        mat4_frustum(neg(right), right, neg(top), top, near, far) where {
  val PI = lit<double><a>(3.14159265358979)
  val top = mul(near, tan(div(mul(fovy, PI), lit<int>(360))))
  val right = mul(top, aspect)
}

implement{a} mat4_ortho(left, right, bottom, top, near, far) = 
        mat4_create(a00, zero, zero, zero,
                    zero,  a11, zero, zero,
                    zero, zero, a22, zero,
                    a30,  a31,  a32,  one) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
  val two = lit<int>(2)

  val rl = sub(right, left)
  val tb = sub(top, bottom)
  val f = sub(far, near)
  val a00 = div(two, rl)
  val a11 = div(two, tb)
  val a22 = div(neg(two), f)
  val a30 = div(neg(add(left, right)), rl)
  val a31 = div(neg(add(top, bottom)), tb)
  val a32 = div(neg(add(far, near)), f)
}

implement{a} mat4_lookat(eye, center, up) = mat4_create(x[0],  y[0],  z[0],  zero,
                                                        x[1],  y[1],  z[1],  zero,
                                                        x[2],  y[2],  z[2],  zero,
                                                        a30, a31, a32, one) where {
  val zero = lit<int>(0)
  val one = lit<int>(1)
  val z = vec3_direction(eye, center)
  val x = vec3_normalize(vec3_cross(up, z))
  val y = vec3_normalize(vec3_cross(z, x))

  val a30 = sub(add(mul(x[0], eye[0]), mul(x[1], eye[1])), mul(x[2], eye[2]))
  val a31 = sub(add(mul(y[0], eye[0]), mul(y[1], eye[1])), mul(y[2], eye[2]))
  val a32 = sub(add(mul(z[0], eye[0]), mul(z[1], eye[1])), mul(z[2], eye[2]))
}

