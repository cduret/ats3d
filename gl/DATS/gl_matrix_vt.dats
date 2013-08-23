#include "share/atspre_staload_tmpdef.hats"

staload "gl/SATS/matrix_vt.sats"
staload "contrib/GL/SATS/gl.sats"

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "libc/SATS/math.sats"
staload "gl/SATS/glnum.sats"
staload _ = "libc/DATS/math.dats"
staload _ = "gl/DATS/glnum.dats"

local
  assume vector2_vt(a:t@ype) = arrayptr(a,2)
  assume vector3_vt(a:t@ype) = arrayptr(a,3)
  assume vector4_vt(a:t@ype) = arrayptr(a,4)
  assume matrix2_vt(a:t@ype) = arrayptr(a,4)
  assume matrix3_vt(a:t@ype) = arrayptr(a,9)
  assume matrix4_vt(a:t@ype) = arrayptr(a,16)

  macdef gli2glf(x) = GLfloat_of_float(g0int2float_int_float(int_of_GLint ,(x)))
  #define GLI GLint_of_int
  #define GLF GLfloat_of_float
  #define GLD GLdouble_of_double

  extern fun{a: t@ype}{b: t@ype} lit(x: a): b
in

implement lit<int><GLfloat>(x) = GLfloat_of_float(g0int2float_int_float x)
implement lit<int><GLdouble>(x) = GLdouble_of_double(g0int2float_int_double x)

implement lit<double><GLfloat>(x) = GLfloat_of_float(g0float2float_double_float x)
implement lit<double><GLdouble>(x) = GLdouble_of_double x

// ------------ VEC2 -----------------

implement{a} vec2_vt_create(x, y) = (arrayptr)$arrpsz{a}(x, y)

implement{a} vec2_vt_ptr(v) = arrayptr2ptr{a}(v)

implement{a} vec2_vt_free(v) = arrayptr_free{a} v

implement{a} vec2_vt_fprint(out, vec) = fprint(out, vec, i2sz(2))

// ------------ VEC3 -----------------

implement{a} vec3_vt_create(x, y, z) = (arrayptr)$arrpsz{a}(x, y, z)

implement{a} vec3_vt_ptr(v) = arrayptr2ptr{a}(v)

implement{a} vec3_vt_free(v) = arrayptr_free{a} v

implement{a} vec3_vt_fprint(out, vec) = fprint(out, vec, i2sz(3))

// vec3_vt_add
implement vec3_vt_add<GLint>(v1, v2) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) + AT(v2,0)
  val y = AT(v1,1) + AT(v2,1)
  val z = AT(v1,2) + AT(v2,2)
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}
implement vec3_vt_add<GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) + AT(v2,0)
  val y = AT(v1,1) + AT(v2,1)
  val z = AT(v1,2) + AT(v2,2)
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}
implement vec3_vt_add<GLdouble>(v1, v2) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) + AT(v2,0)
  val y = AT(v1,1) + AT(v2,1)
  val z = AT(v1,2) + AT(v2,2)
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_substract
implement vec3_vt_substract<GLint>(v1, v2) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) - AT(v2,0)
  val y = AT(v1,1) - AT(v2,1)
  val z = AT(v1,2) - AT(v2,2)
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}

implement vec3_vt_substract<GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) - AT(v2,0)
  val y = AT(v1,1) - AT(v2,1)
  val z = AT(v1,2) - AT(v2,2)
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}

implement vec3_vt_substract<GLdouble>(v1, v2) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) - AT(v2,0)
  val y = AT(v1,1) - AT(v2,1)
  val z = AT(v1,2) - AT(v2,2)
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_multiply
implement vec3_vt_multiply<GLint>(v1, v2) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}

implement vec3_vt_multiply<GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}

implement vec3_vt_multiply<GLdouble>(v1, v2) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_negate
implement vec3_vt_negate<GLint>(v) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = ~AT(v, 0)
  val y = ~AT(v, 1)
  val z = ~AT(v, 2)
  val () = vec3_vt_free<GLint> v
}

implement vec3_vt_negate<GLfloat>(v) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = ~AT(v, 0)
  val y = ~AT(v, 1)
  val z = ~AT(v, 2)
  val () = vec3_vt_free<GLfloat> v
}

implement vec3_vt_negate<GLdouble>(v) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = ~AT(v, 0)
  val y = ~AT(v, 1)
  val z = ~AT(v, 2)
  val () = vec3_vt_free<GLdouble> v
}

// vec3_vt_scale
implement vec3_vt_scale<GLint>(v1, s) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) * s
  val y = AT(v1,1) * s
  val z = AT(v1,2) * s
  val () = vec3_vt_free<GLint> v1
}

implement vec3_vt_scale<GLfloat>(v1, s) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) * s
  val y = AT(v1,1) * s
  val z = AT(v1,2) * s
  val () = vec3_vt_free<GLfloat> v1
}

implement vec3_vt_scale<GLdouble>(v1, s) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) * s
  val y = AT(v1,1) * s
  val z = AT(v1,2) * s
  val () = vec3_vt_free<GLdouble> v1
}

// vec3_vt_length
implement vec3_vt_length<GLint,GLfloat>(v) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x_2 = gli2glf(AT(v,0) * AT(v,0))
  val y_2 = gli2glf(AT(v,1) * AT(v,1))
  val z_2 = gli2glf(AT(v,2) * AT(v,2))
}
implement vec3_vt_length<GLfloat,GLfloat>(v) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x_2 = AT(v,0) * AT(v,0)
  val y_2 = AT(v,1) * AT(v,1)
  val z_2 = AT(v,2) * AT(v,2)
}
implement vec3_vt_length<GLdouble,GLdouble>(v) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x_2 = AT(v,0) * AT(v,0)
  val y_2 = AT(v,1) * AT(v,1)
  val z_2 = AT(v,2) * AT(v,2)
}

// vec3_vt_normalize
implement vec3_vt_normalize<GLint,GLfloat>(v) = norm(v) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  fun vec3_GLint_2_GLfloat(v: vector3_vt(GLint)): vector3_vt(GLfloat) = vec3_vt_create<GLfloat>(x,y,z) where {
    val x =  gli2glf( AT(v, 0) )
    val y =  gli2glf( AT(v, 1) )
    val z =  gli2glf( AT(v, 2) )
    val () = vec3_vt_free<GLint> (v)
  }
  fun norm(v: vector3_vt(GLint)): vector3_vt(GLfloat) = let
    val len = vec3_vt_length<GLint,GLfloat> v
  in
    if len = GLF 0.0f then let
      val () = vec3_vt_free<GLint> v
    in vec3_vt_create<GLfloat>(GLF 0.0f, GLF 0.0f, GLF 0.0f) end
    else if len = GLF 1.0f then vec3_GLint_2_GLfloat v
    else let 
      val r = vec3_vt_create<GLfloat>(gli2glf(AT(v,0)) / len, 
                                    gli2glf(AT(v,1)) / len, 
                                    gli2glf(AT(v,2)) / len)
      val () = vec3_vt_free<GLint> v
    in r end
  end
}

implement vec3_vt_normalize<GLfloat,GLfloat>(v) = norm(v) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  fun norm(v: vector3_vt(GLfloat)): vector3_vt(GLfloat) = let
    val len = vec3_vt_length<GLfloat,GLfloat> v
  in
    if len = GLF 0.0f then let
      val () = vec3_vt_free<GLfloat> v
    in vec3_vt_create<GLfloat>(GLF 0.0f, GLF 0.0f, GLF 0.0f) end
    else if len = GLF 1.0f then v
    else let 
      val r = vec3_vt_create<GLfloat>(AT(v,0) / len, AT(v,1) / len, AT(v,2) / len)
      val () = vec3_vt_free<GLfloat> v
    in r end
  end
}

implement vec3_vt_normalize<GLdouble,GLdouble>(v) = norm(v) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  fun norm(v: vector3_vt(GLdouble)): vector3_vt(GLdouble) = let
    val len = vec3_vt_length<GLdouble,GLdouble> v
  in
    if len = GLD 0.0 then let
      val () = vec3_vt_free<GLdouble> v
    in vec3_vt_create<GLdouble>(GLD 0.0, GLD 0.0, GLD 0.0) end
    else if len = GLD 1.0 then v
    else let 
      val r = vec3_vt_create<GLdouble>(AT(v,0) / len, AT(v,1) / len, AT(v,2) / len)
      val () = vec3_vt_free<GLdouble> v
    in r end
  end
}

// vec3_vt_cross
implement vec3_vt_cross<GLint>(v1, v2) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = (AT(v1,1) * AT(v2,2)) - (AT(v1,2) * AT(v2,1))
  val y = (AT(v1,2) * AT(v2,0)) - (AT(v1,0) * AT(v2,2))
  val z = (AT(v1,0) * AT(v2,1)) - (AT(v1,1) * AT(v2,0))
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}

implement vec3_vt_cross<GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = (AT(v1,1) * AT(v2,2)) - (AT(v1,2) * AT(v2,1))
  val y = (AT(v1,2) * AT(v2,0)) - (AT(v1,0) * AT(v2,2))
  val z = (AT(v1,0) * AT(v2,1)) - (AT(v1,1) * AT(v2,0))
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}

implement vec3_vt_cross<GLdouble>(v1, v2) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = (AT(v1,1) * AT(v2,2)) - (AT(v1,2) * AT(v2,1))
  val y = (AT(v1,2) * AT(v2,0)) - (AT(v1,0) * AT(v2,2))
  val z = (AT(v1,0) * AT(v2,1)) - (AT(v1,1) * AT(v2,0))
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_dot
implement vec3_vt_dot<GLint>(v1, v2) = x + y + z where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}
implement vec3_vt_dot<GLfloat>(v1, v2) = x + y + z where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}
implement vec3_vt_dot<GLdouble>(v1, v2) = x + y + z where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) * AT(v2,0)
  val y = AT(v1,1) * AT(v2,1)
  val z = AT(v1,2) * AT(v2,2)
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_direction
implement vec3_vt_direction<GLint,GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLint>(v1, v2)
  val len = vec3_vt_length<GLint,GLfloat> (v0)
  val x = gli2glf(AT(v0,0)) * len
  val y = gli2glf(AT(v0,1)) * len
  val z = gli2glf(AT(v0,2)) * len
  val () = vec3_vt_free<GLint> v0
}
implement vec3_vt_direction<GLfloat,GLfloat>(v1, v2) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLfloat>(v1, v2)
  val len = vec3_vt_length<GLfloat,GLfloat> (v0)
  val x = AT(v0,0) * len
  val y = AT(v0,1) * len
  val z = AT(v0,2) * len
  val () = vec3_vt_free<GLfloat> v0
}
implement vec3_vt_direction<GLdouble,GLdouble>(v1, v2) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLdouble>(v1, v2)
  val len = vec3_vt_length<GLdouble,GLdouble> (v0)
  val x = AT(v0,0) * len
  val y = AT(v0,1) * len
  val z = AT(v0,2) * len
  val () = vec3_vt_free<GLdouble> v0
}

// vec3_vt_direction
implement vec3_vt_lerp<GLint>(v1, v2, lerp) = vec3_vt_create<GLint>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v1,0) + (lerp * (AT(v2,0) - AT(v1,0)))
  val y = AT(v1,1) + (lerp * (AT(v2,1) - AT(v1,1)))
  val z = AT(v1,2) + (lerp * (AT(v2,2) - AT(v1,2)))
  val () = vec3_vt_free<GLint> v1
  val () = vec3_vt_free<GLint> v2
}
implement vec3_vt_lerp<GLfloat>(v1, v2, lerp) = vec3_vt_create<GLfloat>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v1,0) + (lerp * (AT(v2,0) - AT(v1,0)))
  val y = AT(v1,1) + (lerp * (AT(v2,1) - AT(v1,1)))
  val z = AT(v1,2) + (lerp * (AT(v2,2) - AT(v1,2)))
  val () = vec3_vt_free<GLfloat> v1
  val () = vec3_vt_free<GLfloat> v2
}
implement vec3_vt_lerp<GLdouble>(v1, v2, lerp) = vec3_vt_create<GLdouble>(x, y, z) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v1,0) + (lerp * (AT(v2,0) - AT(v1,0)))
  val y = AT(v1,1) + (lerp * (AT(v2,1) - AT(v1,1)))
  val z = AT(v1,2) + (lerp * (AT(v2,2) - AT(v1,2)))
  val () = vec3_vt_free<GLdouble> v1
  val () = vec3_vt_free<GLdouble> v2
}

// vec3_vt_dist
implement vec3_vt_dist<GLint,GLfloat>(v1, v2) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLint>(v1,v2)
  val x_2 = gli2glf(AT(v0,0) * AT(v0,0))
  val y_2 = gli2glf(AT(v0,1) * AT(v0,1))
  val z_2 = gli2glf(AT(v0,2) * AT(v0,2))
  val () = vec3_vt_free<GLint> v0
}
implement vec3_vt_dist<GLfloat,GLfloat>(v1, v2) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLfloat>(v1,v2)
  val x_2 = AT(v0,0) * AT(v0,0)
  val y_2 = AT(v0,1) * AT(v0,1)
  val z_2 = AT(v0,2) * AT(v0,2)
  val () = vec3_vt_free<GLfloat> v0
}
implement vec3_vt_dist<GLdouble,GLdouble>(v1, v2) = sqrt( x_2 + y_2 + z_2 ) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val v0 = vec3_vt_substract<GLdouble>(v1,v2)
  val x_2 = AT(v0,0) * AT(v0,0)
  val y_2 = AT(v0,1) * AT(v0,1)
  val z_2 = AT(v0,2) * AT(v0,2)
  val () = vec3_vt_free<GLdouble> v0
}

// ---------- VEC4 ------------

implement{a} vec4_vt_create(x, y, z, w) = (arrayptr)$arrpsz{a}(x, y, z, w)

implement{a} vec4_vt_ptr(v) = arrayptr2ptr{a}(v)

implement{a} vec4_vt_free(v) = arrayptr_free{a} v

implement{a} vec4_vt_fprint(out, vec) = fprint(out, vec, i2sz(4))

// ---------- MAT2 ------------

implement{a} mat2_vt_create (m11, m12, m21, m22) = 
  (arrayptr)$arrpsz{a} (m11, m12, m21, m22)

implement{a} mat2_vt_ptr(m) = arrayptr2ptr{a}(m)

implement{a} mat2_vt_free(m) = arrayptr_free{a} m

// ---------- MAT3 ------------

implement{a} mat3_vt_create (m11, m12, m13, m21, m22, m23, m31, m32, m33) = 
  (arrayptr)$arrpsz{a} (m11, m12, m13, m21, m22, m23, m31, m32, m33)

implement{a} mat3_vt_copy (m) = let
  macdef AT(x, y) = arrayptr_get_at<a>(,(x), i2sz ,(y))
  val r = mat3_vt_create(AT(m,0), AT(m,1), AT(m,2),
                         AT(m,3), AT(m,4), AT(m,5),
                         AT(m,6), AT(m,7), AT(m,8))
in
  r
end

implement{a} mat3_vt_ptr(m) = arrayptr2ptr{a}(m)

implement{a} mat3_vt_free(m) = arrayptr_free{a} m
  
implement{a} mat3_vt_identity() = mat3_vt_create(one, zero, zero,
                                                 zero, one, zero,
                                                 zero, zero, one) where {
  val zero = lit<int><a>(0)
  val one = lit<int><a>(1)
}

implement{a} mat3_vt_transpose(m) = let
  macdef AT(x, y) = arrayptr_get_at<a>(,(x), i2sz ,(y))
  val r = mat3_vt_create(AT(m,0), AT(m,3), AT(m,6),
                         AT(m,1), AT(m,4), AT(m,7),
                         AT(m,2), AT(m,5), AT(m,8))
  val () = mat3_vt_free<a> m
in
  r
end

implement{a} mat4_vt_of_mat3(m) = let
  macdef AT(x, y) = arrayptr_get_at<a>(,(x), i2sz ,(y))
  val zero = lit<int><a>(0)
  val one = lit<int><a>(1)
  val r = mat4_vt_create(AT(m,0), AT(m,1), AT(m,2), zero,
                         AT(m,3), AT(m,4), AT(m,5), zero,
                         AT(m,6), AT(m,7), AT(m,8), zero,
                         zero, zero, zero, one)
  val () = mat3_vt_free<a> m
in
  r
end

implement{a} mat3_vt_fprint(out, vec) = fprint(out, vec, i2sz(9))

// ---------- MAT4 ------------

implement{a} mat4_vt_create(m11, m12, m13, m14, m21, m22, m23, m24,
                         m31, m32, m33, m34, m41, m42, m43, m44) = 
  (arrayptr)$arrpsz{a} (m11, m12, m13, m14, m21, m22, m23, m24,
                   m31, m32, m33, m34, m41, m42, m43, m44)

implement{a} mat4_vt_copy(m) = let
  macdef AT(x, y) = arrayptr_get_at<a>(,(x), i2sz ,(y))
  val r = mat4_vt_create<a>(AT(m,0), AT(m,1), AT(m,2), AT(m,3),
                            AT(m,4), AT(m,5), AT(m,6), AT(m,7),
                            AT(m,8), AT(m,9), AT(m,10), AT(m,11),
                            AT(m,12), AT(m,13), AT(m,14), AT(m,15))
in
  r
end

implement{a} mat4_vt_ptr(m) = arrayptr2ptr{a}(m)

implement{a} mat4_vt_free(m) = arrayptr_free{a} m

implement{a} mat4_vt_identity() = mat4_vt_create<a>(one, zero, zero, zero,
                                                    zero, one, zero, zero,
                                                    zero, zero, one, zero,
                                                    zero, zero, zero, one) where {
  val zero = lit<int><a>(0)
  val one = lit<int><a>(1)
}

implement{a} mat4_vt_transpose(m) = let
  macdef AT(x, y) = arrayptr_get_at<a>(,(x), i2sz ,(y))
  val r = mat4_vt_create<a>(AT(m,0), AT(m,4), AT(m,8), AT(m,12),
                      AT(m,1), AT(m,5), AT(m,9), AT(m,13),
                      AT(m,2), AT(m,6), AT(m,10), AT(m,14),
                      AT(m,3), AT(m,7), AT(m,11), AT(m,15))
  val () = mat4_vt_free<a> m
in
  r
end

// mat4_vt_determinant
implement mat4_vt_determinant<GLint>(m) = x where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val c11 = a30 * a21 * a12 * a03 val c12 = a20 * a31 * a12 * a03
  val c13 = a30 * a11 * a22 * a03 val c1 = c11 - c12 - c13
  val e1 = a10 * a31 * a22 * a03

  val c21 = a20 * a11 * a32 * a03 val c22 = a10 * a21 * a32 * a03
  val c23 = a30 * a21 * a02 * a13 val c2 = c21 - c22 - c23
  val e2 = a20 * a31 * a02 * a13

  val c31 = a30 * a01 * a22 * a13 val c32 = a00 * a31 * a22 * a13
  val c33 = a20 * a01 * a22 * a13 val c3 = c31 - c32 - c33
  val e3 = a00 * a21 * a32 * a13

  val c41 = a30 * a11 * a02 * a23 val c42 = a10 * a31 * a02 * a23
  val c43 = a30 * a01 * a12 * a23 val c4 = c41 - c42 - c43
  val e4 = a00 * a31 * a12 * a23

  val c51 = a10 * a01 * a32 * a23 val c52 = a00 * a11 * a32 * a23
  val c53 = a20 * a11 * a02 * a33 val c5 = c51 - c52 - c53
  val e5 = a10 * a21 * a02 * a33

  val c61 = a20 * a01 * a12 * a33 val c62 = a00 * a21 * a12 * a23
  val c63 = a10 * a01 * a22 * a33 val c6 = c61 - c62 - c63
  val e6 = a00 * a11 * a22 * a33

  val x = c1 + e1 + c2 + e2 + c3 + e3 + c4 + e4 + c5 + e5 + c6 + e6
}

implement mat4_vt_determinant<GLfloat>(m) = x where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val c11 = a30 * a21 * a12 * a03 val c12 = a20 * a31 * a12 * a03
  val c13 = a30 * a11 * a22 * a03 val c1 = c11 - c12 - c13
  val e1 = a10 * a31 * a22 * a03

  val c21 = a20 * a11 * a32 * a03 val c22 = a10 * a21 * a32 * a03
  val c23 = a30 * a21 * a02 * a13 val c2 = c21 - c22 - c23
  val e2 = a20 * a31 * a02 * a13

  val c31 = a30 * a01 * a22 * a13 val c32 = a00 * a31 * a22 * a13
  val c33 = a20 * a01 * a22 * a13 val c3 = c31 - c32 - c33
  val e3 = a00 * a21 * a32 * a13

  val c41 = a30 * a11 * a02 * a23 val c42 = a10 * a31 * a02 * a23
  val c43 = a30 * a01 * a12 * a23 val c4 = c41 - c42 - c43
  val e4 = a00 * a31 * a12 * a23

  val c51 = a10 * a01 * a32 * a23 val c52 = a00 * a11 * a32 * a23
  val c53 = a20 * a11 * a02 * a33 val c5 = c51 - c52 - c53
  val e5 = a10 * a21 * a02 * a33

  val c61 = a20 * a01 * a12 * a33 val c62 = a00 * a21 * a12 * a23
  val c63 = a10 * a01 * a22 * a33 val c6 = c61 - c62 - c63
  val e6 = a00 * a11 * a22 * a33

  val x = c1 + e1 + c2 + e2 + c3 + e3 + c4 + e4 + c5 + e5 + c6 + e6
}

implement mat4_vt_determinant<GLdouble>(m) = x where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val c11 = a30 * a21 * a12 * a03 val c12 = a20 * a31 * a12 * a03
  val c13 = a30 * a11 * a22 * a03 val c1 = c11 - c12 - c13
  val e1 = a10 * a31 * a22 * a03

  val c21 = a20 * a11 * a32 * a03 val c22 = a10 * a21 * a32 * a03
  val c23 = a30 * a21 * a02 * a13 val c2 = c21 - c22 - c23
  val e2 = a20 * a31 * a02 * a13

  val c31 = a30 * a01 * a22 * a13 val c32 = a00 * a31 * a22 * a13
  val c33 = a20 * a01 * a22 * a13 val c3 = c31 - c32 - c33
  val e3 = a00 * a21 * a32 * a13

  val c41 = a30 * a11 * a02 * a23 val c42 = a10 * a31 * a02 * a23
  val c43 = a30 * a01 * a12 * a23 val c4 = c41 - c42 - c43
  val e4 = a00 * a31 * a12 * a23

  val c51 = a10 * a01 * a32 * a23 val c52 = a00 * a11 * a32 * a23
  val c53 = a20 * a11 * a02 * a33 val c5 = c51 - c52 - c53
  val e5 = a10 * a21 * a02 * a33

  val c61 = a20 * a01 * a12 * a33 val c62 = a00 * a21 * a12 * a23
  val c63 = a10 * a01 * a22 * a33 val c6 = c61 - c62 - c63
  val e6 = a00 * a11 * a22 * a33

  val x = c1 + e1 + c2 + e2 + c3 + e3 + c4 + e4 + c5 + e5 + c6 + e6
}

// mat4_vt_determinant
implement mat4_vt_inverse<GLint,GLfloat>(m) = inverse(m) where {
  macdef AT(x, y) = gli2glf (arrayptr_get_at<GLint>(,(x), i2sz ,(y)))

  fun inverse(m: matrix4_vt(GLint)): matrix4_vt(GLfloat) = let
    val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
    val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
    val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
    val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)
    val () = mat4_vt_free<GLint> m

    val b00 = (a00 * a11) - (a01 * a10) val b01 = (a00 * a12) - (a02 * a10)
    val b02 = (a00 * a13) - (a03 * a10) val b03 = (a01 * a12) - (a02 * a11)
    val b04 = (a01 * a13) - (a03 * a11) val b05 = (a02 * a13) - (a03 * a12)
    val b06 = (a20 * a31) - (a21 * a30) val b07 = (a20 * a32) - (a22 * a30)
    val b08 = (a20 * a33) - (a23 * a30) val b09 = (a21 * a32) - (a22 * a31)
    val b10 = (a21 * a33) - (a23 * a31) val b11 = (a22 * a33) - (a23 * a32)

    val det = ((((b00 * b11) - (b01 * b10)) + (b02 * b09) + (b03 * b08)) - (b04 * b07)) + (b05 * b06)
  in
    if det = GLF 0.0f then mat4_vt_create<GLfloat>(GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f)
    else let
      val inv_det = GLF 1.0f / det
      val m00 = (((a11 * b11) - (a12 * b10)) + (a13 * b09)) * inv_det
      val m01 = ((~a01 * b11) + ((a02 * b10) - (a03 * b09))) * inv_det
      val m02 = (((a31 * b05) - (a32 * b04)) + (a33 * b03)) * inv_det
      val m03 = (((~a21 * b05) - (a22 * b04)) + (a23 * b03)) * inv_det
      val m10 = (((~a10 * b11) + (a12 * b08)) - (a13 * b07)) * inv_det
      val m11 = (((a00 * b11) - (a02 * b08)) + (a03 * b07)) * inv_det
      val m12 = (((~a30 * b05) + (a32 * b02)) - (a33 * b01)) * inv_det
      val m13 = (((a20 * b05) - (a22 * b02)) + (a23 * b01)) * inv_det
      val m20 = (((a10 * b10) - (a11 * b08)) + (a13 * b06)) * inv_det
      val m21 = (((~a00 * b10) + (a01 * b08)) - (a03 * b06)) * inv_det
      val m22 = (((a30 * b04) - (a31 * b02)) + (a33 * b00)) * inv_det
      val m23 = (((~a20 * b04) + (a21 * b02)) - (a23 * b00)) * inv_det
      val m30 = (((~a10 * b09) + (a11 * b07)) - (a12 * b06)) * inv_det
      val m31 = (((a00 * b09) - (a01 * b07)) + (a02 * b06)) * inv_det
      val m32 = (((~a30 * b03) + (a31 * b01)) - (a32 * b00)) * inv_det
      val m33 = (((a20 * b03) - (a21 * b01)) + (a22 * b00)) * inv_det
    in
      mat4_vt_create<GLfloat>(m00, m01, m02, m03,
                            m10, m11, m12, m13, 
                            m20, m21, m22, m23, 
                            m30, m31, m32, m33)
    end
  end // of inverse
}

implement mat4_vt_inverse<GLfloat,GLfloat>(m) = inverse(m) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  fun inverse(m: matrix4_vt(GLfloat)): matrix4_vt(GLfloat) = let
    val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
    val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
    val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
    val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)
    val () = mat4_vt_free<GLfloat> m

    val b00 = (a00 * a11) - (a01 * a10) val b01 = (a00 * a12) - (a02 * a10)
    val b02 = (a00 * a13) - (a03 * a10) val b03 = (a01 * a12) - (a02 * a11)
    val b04 = (a01 * a13) - (a03 * a11) val b05 = (a02 * a13) - (a03 * a12)
    val b06 = (a20 * a31) - (a21 * a30) val b07 = (a20 * a32) - (a22 * a30)
    val b08 = (a20 * a33) - (a23 * a30) val b09 = (a21 * a32) - (a22 * a31)
    val b10 = (a21 * a33) - (a23 * a31) val b11 = (a22 * a33) - (a23 * a32)

    val det = ((((b00 * b11) - (b01 * b10)) + (b02 * b09) + (b03 * b08)) - (b04 * b07)) + (b05 * b06)
  in
    if det = GLF 0.0f then mat4_vt_create<GLfloat>(GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                                             GLF 0.0f, GLF 0.0f, GLF 0.0f, GLF 0.0f)
    else let
      val inv_det = GLF 1.0f / det
      val m00 = (((a11 * b11) - (a12 * b10)) + (a13 * b09)) * inv_det
      val m01 = ((~a01 * b11) + ((a02 * b10) - (a03 * b09))) * inv_det
      val m02 = (((a31 * b05) - (a32 * b04)) + (a33 * b03)) * inv_det
      val m03 = (((~a21 * b05) - (a22 * b04)) + (a23 * b03)) * inv_det
      val m10 = (((~a10 * b11) + (a12 * b08)) - (a13 * b07)) * inv_det
      val m11 = (((a00 * b11) - (a02 * b08)) + (a03 * b07)) * inv_det
      val m12 = (((~a30 * b05) + (a32 * b02)) - (a33 * b01)) * inv_det
      val m13 = (((a20 * b05) - (a22 * b02)) + (a23 * b01)) * inv_det
      val m20 = (((a10 * b10) - (a11 * b08)) + (a13 * b06)) * inv_det
      val m21 = (((~a00 * b10) + (a01 * b08)) - (a03 * b06)) * inv_det
      val m22 = (((a30 * b04) - (a31 * b02)) + (a33 * b00)) * inv_det
      val m23 = (((~a20 * b04) + (a21 * b02)) - (a23 * b00)) * inv_det
      val m30 = (((~a10 * b09) + (a11 * b07)) - (a12 * b06)) * inv_det
      val m31 = (((a00 * b09) - (a01 * b07)) + (a02 * b06)) * inv_det
      val m32 = (((~a30 * b03) + (a31 * b01)) - (a32 * b00)) * inv_det
      val m33 = (((a20 * b03) - (a21 * b01)) + (a22 * b00)) * inv_det
    in
      mat4_vt_create<GLfloat>(m00, m01, m02, m03,
                            m10, m11, m12, m13, 
                            m20, m21, m22, m23, 
                            m30, m31, m32, m33)
    end
  end // of inverse
}

implement mat4_vt_inverse<GLdouble,GLdouble>(m) = inverse(m) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  fun inverse(m: matrix4_vt(GLdouble)): matrix4_vt(GLdouble) = let
    val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
    val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
    val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
    val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)
    val () = mat4_vt_free<GLdouble> m

    val b00 = (a00 * a11) - (a01 * a10) val b01 = (a00 * a12) - (a02 * a10)
    val b02 = (a00 * a13) - (a03 * a10) val b03 = (a01 * a12) - (a02 * a11)
    val b04 = (a01 * a13) - (a03 * a11) val b05 = (a02 * a13) - (a03 * a12)
    val b06 = (a20 * a31) - (a21 * a30) val b07 = (a20 * a32) - (a22 * a30)
    val b08 = (a20 * a33) - (a23 * a30) val b09 = (a21 * a32) - (a22 * a31)
    val b10 = (a21 * a33) - (a23 * a31) val b11 = (a22 * a33) - (a23 * a32)

    val det = ((((b00 * b11) - (b01 * b10)) + (b02 * b09) + (b03 * b08)) - (b04 * b07)) + (b05 * b06)
  in
    if det = GLD 0.0 then mat4_vt_create<GLdouble>(GLD 0.0, GLD 0.0, GLD 0.0, GLD 0.0,
                                             GLD 0.0, GLD 0.0, GLD 0.0, GLD 0.0,
                                             GLD 0.0, GLD 0.0, GLD 0.0, GLD 0.0,
                                             GLD 0.0, GLD 0.0, GLD 0.0, GLD 0.0)
    else let
      val inv_det = GLD 1.0 / det
      val m00 = (((a11 * b11) - (a12 * b10)) + (a13 * b09)) * inv_det
      val m01 = ((~a01 * b11) + ((a02 * b10) - (a03 * b09))) * inv_det
      val m02 = (((a31 * b05) - (a32 * b04)) + (a33 * b03)) * inv_det
      val m03 = (((~a21 * b05) - (a22 * b04)) + (a23 * b03)) * inv_det
      val m10 = (((~a10 * b11) + (a12 * b08)) - (a13 * b07)) * inv_det
      val m11 = (((a00 * b11) - (a02 * b08)) + (a03 * b07)) * inv_det
      val m12 = (((~a30 * b05) + (a32 * b02)) - (a33 * b01)) * inv_det
      val m13 = (((a20 * b05) - (a22 * b02)) + (a23 * b01)) * inv_det
      val m20 = (((a10 * b10) - (a11 * b08)) + (a13 * b06)) * inv_det
      val m21 = (((~a00 * b10) + (a01 * b08)) - (a03 * b06)) * inv_det
      val m22 = (((a30 * b04) - (a31 * b02)) + (a33 * b00)) * inv_det
      val m23 = (((~a20 * b04) + (a21 * b02)) - (a23 * b00)) * inv_det
      val m30 = (((~a10 * b09) + (a11 * b07)) - (a12 * b06)) * inv_det
      val m31 = (((a00 * b09) - (a01 * b07)) + (a02 * b06)) * inv_det
      val m32 = (((~a30 * b03) + (a31 * b01)) - (a32 * b00)) * inv_det
      val m33 = (((a20 * b03) - (a21 * b01)) + (a22 * b00)) * inv_det
    in
      mat4_vt_create<GLdouble>(m00, m01, m02, m03,
                             m10, m11, m12, m13, 
                             m20, m21, m22, m23, 
                             m30, m31, m32, m33)
    end
  end // of inverse
}

// mat4_vt_multiply
implement mat4_vt_multiply<GLint>(m1, m2) = 
  mat4_vt_create<GLint>(c00, c01, c02, c03,
                      c10, c11, c12, c13,
                      c20, c21, c22, c23,
                      c30, c31, c32, c33) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))

  val a00 = AT(m1,0) val a01 = AT(m1,1) val a02 = AT(m1,2) val a03 = AT(m1,3)
  val a10 = AT(m1,4) val a11 = AT(m1,5) val a12 = AT(m1,6) val a13 = AT(m1,7)
  val a20 = AT(m1,8) val a21 = AT(m1,9) val a22 = AT(m1,10) val a23 = AT(m1,11)
  val a30 = AT(m1,12) val a31 = AT(m1,13) val a32 = AT(m1,14) val a33 = AT(m1,15)
  val b00 = AT(m2,0) val b01 = AT(m2,1) val b02 = AT(m2,2) val b03 = AT(m2,3)
  val b10 = AT(m2,4) val b11 = AT(m2,5) val b12 = AT(m2,6) val b13 = AT(m2,7)
  val b20 = AT(m2,8) val b21 = AT(m2,9) val b22 = AT(m2,10) val b23 = AT(m2,11)
  val b30 = AT(m2,12) val b31 = AT(m2,13) val b32 = AT(m2,14) val b33 = AT(m2,15)

  val c00 = (b00 * a00) + (b01 * a10) + (b02 * a20) + (b03 * a30)
  val c01 = (b00 * a01) + (b01 * a11) + (b02 * a21) + (b03 * a31)
  val c02 = (b00 * a02) + (b01 * a12) + (b02 * a22) + (b03 * a32)
  val c03 = (b00 * a03) + (b01 * a13) + (b02 * a23) + (b03 * a33)
  val c10 = (b10 * a00) + (b11 * a10) + (b12 * a20) + (b13 * a30)
  val c11 = (b10 * a01) + (b11 * a11) + (b12 * a21) + (b13 * a31)
  val c12 = (b10 * a02) + (b11 * a12) + (b12 * a22) + (b13 * a32)
  val c13 = (b10 * a03) + (b11 * a13) + (b12 * a23) + (b13 * a33)
  val c20 = (b20 * a00) + (b21 * a10) + (b22 * a20) + (b23 * a30)
  val c21 = (b20 * a01) + (b21 * a11) + (b22 * a21) + (b23 * a31)
  val c22 = (b20 * a02) + (b21 * a12) + (b22 * a22) + (b23 * a32)
  val c23 = (b20 * a03) + (b21 * a13) + (b22 * a23) + (b23 * a33)
  val c30 = (b30 * a00) + (b31 * a10) + (b32 * a20) + (b33 * a30)
  val c31 = (b30 * a01) + (b31 * a11) + (b32 * a21) + (b33 * a31)
  val c32 = (b30 * a02) + (b31 * a12) + (b32 * a22) + (b33 * a32)
  val c33 = (b30 * a03) + (b31 * a13) + (b32 * a23) + (b33 * a33)

  val () = mat4_vt_free<GLint> m1
  val () = mat4_vt_free<GLint> m2
}

implement mat4_vt_multiply<GLfloat>(m1, m2) = 
  mat4_vt_create<GLfloat>(c00, c01, c02, c03,
                        c10, c11, c12, c13,
                        c20, c21, c22, c23,
                        c30, c31, c32, c33) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val a00 = AT(m1,0) val a01 = AT(m1,1) val a02 = AT(m1,2) val a03 = AT(m1,3)
  val a10 = AT(m1,4) val a11 = AT(m1,5) val a12 = AT(m1,6) val a13 = AT(m1,7)
  val a20 = AT(m1,8) val a21 = AT(m1,9) val a22 = AT(m1,10) val a23 = AT(m1,11)
  val a30 = AT(m1,12) val a31 = AT(m1,13) val a32 = AT(m1,14) val a33 = AT(m1,15)
  val b00 = AT(m2,0) val b01 = AT(m2,1) val b02 = AT(m2,2) val b03 = AT(m2,3)
  val b10 = AT(m2,4) val b11 = AT(m2,5) val b12 = AT(m2,6) val b13 = AT(m2,7)
  val b20 = AT(m2,8) val b21 = AT(m2,9) val b22 = AT(m2,10) val b23 = AT(m2,11)
  val b30 = AT(m2,12) val b31 = AT(m2,13) val b32 = AT(m2,14) val b33 = AT(m2,15)

  val c00 = (b00 * a00) + (b01 * a10) + (b02 * a20) + (b03 * a30)
  val c01 = (b00 * a01) + (b01 * a11) + (b02 * a21) + (b03 * a31)
  val c02 = (b00 * a02) + (b01 * a12) + (b02 * a22) + (b03 * a32)
  val c03 = (b00 * a03) + (b01 * a13) + (b02 * a23) + (b03 * a33)
  val c10 = (b10 * a00) + (b11 * a10) + (b12 * a20) + (b13 * a30)
  val c11 = (b10 * a01) + (b11 * a11) + (b12 * a21) + (b13 * a31)
  val c12 = (b10 * a02) + (b11 * a12) + (b12 * a22) + (b13 * a32)
  val c13 = (b10 * a03) + (b11 * a13) + (b12 * a23) + (b13 * a33)
  val c20 = (b20 * a00) + (b21 * a10) + (b22 * a20) + (b23 * a30)
  val c21 = (b20 * a01) + (b21 * a11) + (b22 * a21) + (b23 * a31)
  val c22 = (b20 * a02) + (b21 * a12) + (b22 * a22) + (b23 * a32)
  val c23 = (b20 * a03) + (b21 * a13) + (b22 * a23) + (b23 * a33)
  val c30 = (b30 * a00) + (b31 * a10) + (b32 * a20) + (b33 * a30)
  val c31 = (b30 * a01) + (b31 * a11) + (b32 * a21) + (b33 * a31)
  val c32 = (b30 * a02) + (b31 * a12) + (b32 * a22) + (b33 * a32)
  val c33 = (b30 * a03) + (b31 * a13) + (b32 * a23) + (b33 * a33)

  val () = mat4_vt_free<GLfloat> m1
  val () = mat4_vt_free<GLfloat> m2
}

implement mat4_vt_multiply<GLdouble>(m1, m2) = 
  mat4_vt_create<GLdouble>(c00, c01, c02, c03,
                         c10, c11, c12, c13,
                         c20, c21, c22, c23,
                         c30, c31, c32, c33) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val a00 = AT(m1,0) val a01 = AT(m1,1) val a02 = AT(m1,2) val a03 = AT(m1,3)
  val a10 = AT(m1,4) val a11 = AT(m1,5) val a12 = AT(m1,6) val a13 = AT(m1,7)
  val a20 = AT(m1,8) val a21 = AT(m1,9) val a22 = AT(m1,10) val a23 = AT(m1,11)
  val a30 = AT(m1,12) val a31 = AT(m1,13) val a32 = AT(m1,14) val a33 = AT(m1,15)
  val b00 = AT(m2,0) val b01 = AT(m2,1) val b02 = AT(m2,2) val b03 = AT(m2,3)
  val b10 = AT(m2,4) val b11 = AT(m2,5) val b12 = AT(m2,6) val b13 = AT(m2,7)
  val b20 = AT(m2,8) val b21 = AT(m2,9) val b22 = AT(m2,10) val b23 = AT(m2,11)
  val b30 = AT(m2,12) val b31 = AT(m2,13) val b32 = AT(m2,14) val b33 = AT(m2,15)

  val c00 = (b00 * a00) + (b01 * a10) + (b02 * a20) + (b03 * a30)
  val c01 = (b00 * a01) + (b01 * a11) + (b02 * a21) + (b03 * a31)
  val c02 = (b00 * a02) + (b01 * a12) + (b02 * a22) + (b03 * a32)
  val c03 = (b00 * a03) + (b01 * a13) + (b02 * a23) + (b03 * a33)
  val c10 = (b10 * a00) + (b11 * a10) + (b12 * a20) + (b13 * a30)
  val c11 = (b10 * a01) + (b11 * a11) + (b12 * a21) + (b13 * a31)
  val c12 = (b10 * a02) + (b11 * a12) + (b12 * a22) + (b13 * a32)
  val c13 = (b10 * a03) + (b11 * a13) + (b12 * a23) + (b13 * a33)
  val c20 = (b20 * a00) + (b21 * a10) + (b22 * a20) + (b23 * a30)
  val c21 = (b20 * a01) + (b21 * a11) + (b22 * a21) + (b23 * a31)
  val c22 = (b20 * a02) + (b21 * a12) + (b22 * a22) + (b23 * a32)
  val c23 = (b20 * a03) + (b21 * a13) + (b22 * a23) + (b23 * a33)
  val c30 = (b30 * a00) + (b31 * a10) + (b32 * a20) + (b33 * a30)
  val c31 = (b30 * a01) + (b31 * a11) + (b32 * a21) + (b33 * a31)
  val c32 = (b30 * a02) + (b31 * a12) + (b32 * a22) + (b33 * a32)
  val c33 = (b30 * a03) + (b31 * a13) + (b32 * a23) + (b33 * a33)

  val () = mat4_vt_free<GLdouble> m1
  val () = mat4_vt_free<GLdouble> m2
}


// mat4_vt_multiply_vec3
implement mat4_vt_multiply_vec3<GLint>(m, v) = vec3_vt_create<GLint>(x1, y1, z1) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)

  val () = mat4_vt_free<GLint> m
  val () = vec3_vt_free<GLint> v
}

implement mat4_vt_multiply_vec3<GLfloat>(m, v) = vec3_vt_create<GLfloat>(x1, y1, z1) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)

  val () = mat4_vt_free<GLfloat> m
  val () = vec3_vt_free<GLfloat> v
}

implement mat4_vt_multiply_vec3<GLdouble>(m, v) = vec3_vt_create<GLdouble>(x1, y1, z1) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)

  val () = mat4_vt_free<GLdouble> m
  val () = vec3_vt_free<GLdouble> v
}

// mat4_vt_multiply_vec4
implement mat4_vt_multiply_vec4<GLint>(m, v) = vec4_vt_create<GLint>(x1, y1, z1, w1) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)
  val w1 = (AT(v,0) * AT(m,3)) + (AT(v,1) * AT(m,7)) + (AT(v,2) * AT(m,11)) + AT(m,15)

  val () = mat4_vt_free<GLint> m
  val () = vec4_vt_free<GLint> v
}

implement mat4_vt_multiply_vec4<GLfloat>(m, v) = vec4_vt_create<GLfloat>(x1, y1, z1, w1) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)
  val w1 = (AT(v,0) * AT(m,3)) + (AT(v,1) * AT(m,7)) + (AT(v,2) * AT(m,11)) + AT(m,15)

  val () = mat4_vt_free<GLfloat> m
  val () = vec4_vt_free<GLfloat> v
}

implement mat4_vt_multiply_vec4<GLdouble>(m, v) = vec4_vt_create<GLdouble>(x1, y1, z1, w1) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val x1 = (AT(v,0) * AT(m,0)) + (AT(v,1) * AT(m,4)) + (AT(v,2) * AT(m,8)) + AT(m,12)
  val y1 = (AT(v,0) * AT(m,1)) + (AT(v,1) * AT(m,5)) + (AT(v,2) * AT(m,9)) + AT(m,13)
  val z1 = (AT(v,0) * AT(m,2)) + (AT(v,1) * AT(m,6)) + (AT(v,2) * AT(m,10)) + AT(m,14)
  val w1 = (AT(v,0) * AT(m,3)) + (AT(v,1) * AT(m,7)) + (AT(v,2) * AT(m,11)) + AT(m,15)

  val () = mat4_vt_free<GLdouble> m
  val () = vec4_vt_free<GLdouble> v
}

// mat4_vt_translate
implement mat4_vt_translate<GLint>(m, v) = 
  mat4_vt_create<GLint>(a00, a01, a02, a03,
                      a10, a11, a12, a13,
                      a20, a21, a22, a23,    
                      b30, b31, b32, b33) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val b30 = (a00 * AT(v,0)) + (a10 * AT(v,1)) + (a20 * AT(v,2)) + a30
  val b31 = (a01 * AT(v,0)) + (a11 * AT(v,1)) + (a21 * AT(v,2)) + a31
  val b32 = (a02 * AT(v,0)) + (a12 * AT(v,1)) + (a22 * AT(v,2)) + a32
  val b33 = (a03 * AT(v,0)) + (a13 * AT(v,1)) + (a23 * AT(v,2)) + a33

  val () = mat4_vt_free<GLint> m
  val () = vec3_vt_free<GLint> v
}

implement mat4_vt_translate<GLfloat>(m, v) = 
  mat4_vt_create<GLfloat>(a00, a01, a02, a03,
                      a10, a11, a12, a13,
                      a20, a21, a22, a23,    
                      b30, b31, b32, b33) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val b30 = (a00 * AT(v,0)) + (a10 * AT(v,1)) + (a20 * AT(v,2)) + a30
  val b31 = (a01 * AT(v,0)) + (a11 * AT(v,1)) + (a21 * AT(v,2)) + a31
  val b32 = (a02 * AT(v,0)) + (a12 * AT(v,1)) + (a22 * AT(v,2)) + a32
  val b33 = (a03 * AT(v,0)) + (a13 * AT(v,1)) + (a23 * AT(v,2)) + a33

  val () = mat4_vt_free<GLfloat> m
  val () = vec3_vt_free<GLfloat> v
}

implement mat4_vt_translate<GLdouble>(m, v) = 
  mat4_vt_create<GLdouble>(a00, a01, a02, a03,
                         a10, a11, a12, a13,
                         a20, a21, a22, a23,    
                         b30, b31, b32, b33) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val b30 = (a00 * AT(v,0)) + (a10 * AT(v,1)) + (a20 * AT(v,2)) + a30
  val b31 = (a01 * AT(v,0)) + (a11 * AT(v,1)) + (a21 * AT(v,2)) + a31
  val b32 = (a02 * AT(v,0)) + (a12 * AT(v,1)) + (a22 * AT(v,2)) + a32
  val b33 = (a03 * AT(v,0)) + (a13 * AT(v,1)) + (a23 * AT(v,2)) + a33

  val () = mat4_vt_free<GLdouble> m
  val () = vec3_vt_free<GLdouble> v
}

// mat4_vt_scale
implement mat4_vt_scale<GLint>(m, v) = 
  mat4_vt_create<GLint>(a00, a01, a02, a03,
                      a10, a11, a12, a13,
                      a20, a21, a22, a23,     
                      a30, a31, a32, a33) where {
  macdef AT(x, y) = arrayptr_get_at<GLint>(,(x), i2sz ,(y))
  val x = AT(v,0) val y = AT(v,1) val z = AT(v,2)

  val a00 = AT(m,0) * x val a01 = AT(m,1) * x val a02 = AT(m,2) * x val a03 = AT(m,3) * x
  val a10 = AT(m,4) * y val a11 = AT(m,5) * y val a12 = AT(m,6) * y val a13 = AT(m,7) * y
  val a20 = AT(m,8) * z val a21 = AT(m,9) * z val a22 = AT(m,10) * z val a23 = AT(m,11) * z
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val () = mat4_vt_free<GLint> m
  val () = vec3_vt_free<GLint> v
}

implement mat4_vt_scale<GLfloat>(m, v) = 
  mat4_vt_create<GLfloat>(a00, a01, a02, a03,
                        a10, a11, a12, a13,
                        a20, a21, a22, a23,     
                        a30, a31, a32, a33) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  val x = AT(v,0) val y = AT(v,1) val z = AT(v,2)

  val a00 = AT(m,0) * x val a01 = AT(m,1) * x val a02 = AT(m,2) * x val a03 = AT(m,3) * x
  val a10 = AT(m,4) * y val a11 = AT(m,5) * y val a12 = AT(m,6) * y val a13 = AT(m,7) * y
  val a20 = AT(m,8) * z val a21 = AT(m,9) * z val a22 = AT(m,10) * z val a23 = AT(m,11) * z
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val () = mat4_vt_free<GLfloat> m
  val () = vec3_vt_free<GLfloat> v
}

implement mat4_vt_scale<GLdouble>(m, v) = 
  mat4_vt_create<GLdouble>(a00, a01, a02, a03,
                         a10, a11, a12, a13,
                         a20, a21, a22, a23,     
                         a30, a31, a32, a33) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))
  val x = AT(v,0) val y = AT(v,1) val z = AT(v,2)

  val a00 = AT(m,0) * x val a01 = AT(m,1) * x val a02 = AT(m,2) * x val a03 = AT(m,3) * x
  val a10 = AT(m,4) * y val a11 = AT(m,5) * y val a12 = AT(m,6) * y val a13 = AT(m,7) * y
  val a20 = AT(m,8) * z val a21 = AT(m,9) * z val a22 = AT(m,10) * z val a23 = AT(m,11) * z
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val () = mat4_vt_free<GLdouble> m
  val () = vec3_vt_free<GLdouble> v
}

// mat4_vt_rotate
implement mat4_vt_rotate<GLint,GLfloat>(m, angle, axis) = 
  mat4_vt_create<GLfloat>(c00, c01, c02, c03,
                        c10, c11, c12, c13,
                        c20, c21, c22, c23,
                        c30, c31, c32, c33) where {
  macdef ATX(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))
  macdef AT(x, y) = gli2glf (arrayptr_get_at<GLint>(,(x), i2sz ,(y)))

  val x = ATX(axis,0) val y = ATX(axis,1) val z = ATX(axis,2)
  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val len = sqrt((x * x) + (y * y) + (z * z))
  val s = sin(angle)
  val c = cos(angle)
  val t = GLF 1.0f - c
  val b00 = (x * x * t) + c
  val b01 = (y * x * t) + (z * s)
  val b02 = (z * x * t) - (y * s)
  val b10 = (x * y * t) - (z * s)
  val b11 = (y * y * t) + c
  val b12 = (z * y * t) + (x * s)
  val b20 = (x * z * t) + (y * s)
  val b21 = (y * z * t) - (x * s)
  val b22 = (z * z * t) + c

  val c00 = (a00 * b00) + (a10 * b01) + (a20 * b02)
  val c01 = (a01 * b00) + (a11 * b01) + (a21 * b02)
  val c02 = (a02 * b00) + (a12 * b01) + (a22 * b02)
  val c03 = (a03 * b00) + (a13 * b01) + (a23 * b02)

  val c10 = (a00 * b10) + (a10 * b11) + (a20 * b12)
  val c11 = (a01 * b10) + (a11 * b11) + (a21 * b12)
  val c12 = (a02 * b10) + (a12 * b11) + (a22 * b12)
  val c13 = (a03 * b10) + (a13 * b11) + (a23 * b12)

  val c20 = (a00 * b20) + (a10 * b21) + (a20 * b22)
  val c21 = (a01 * b20) + (a11 * b21) + (a21 * b22)
  val c22 = (a02 * b20) + (a12 * b21) + (a22 * b22)
  val c23 = (a03 * b20) + (a13 * b21) + (a23 * b22)

  val c30 = AT(m,12) val c31 = AT(m,13) val c32 = AT(m,14) val c33 = AT(m,15)

  val () = mat4_vt_free<GLint> m
  val () = vec3_vt_free<GLfloat> axis
}

implement mat4_vt_rotate<GLfloat,GLfloat>(m, angle, axis) = 
  mat4_vt_create<GLfloat>(c00, c01, c02, c03,
                        c10, c11, c12, c13,
                        c20, c21, c22, c23,
                        c30, c31, c32, c33) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val x = AT(axis,0) val y = AT(axis,1) val z = AT(axis,2)
  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val len = sqrt((x * x) + (y * y) + (z * z))
  val s = sin(angle)
  val c = cos(angle)
  val t = GLF 1.0f - c
  val b00 = (x * x * t) + c
  val b01 = (y * x * t) + (z * s)
  val b02 = (z * x * t) - (y * s)
  val b10 = (x * y * t) - (z * s)
  val b11 = (y * y * t) + c
  val b12 = (z * y * t) + (x * s)
  val b20 = (x * z * t) + (y * s)
  val b21 = (y * z * t) - (x * s)
  val b22 = (z * z * t) + c

  val c00 = (a00 * b00) + (a10 * b01) + (a20 * b02)
  val c01 = (a01 * b00) + (a11 * b01) + (a21 * b02)
  val c02 = (a02 * b00) + (a12 * b01) + (a22 * b02)
  val c03 = (a03 * b00) + (a13 * b01) + (a23 * b02)

  val c10 = (a00 * b10) + (a10 * b11) + (a20 * b12)
  val c11 = (a01 * b10) + (a11 * b11) + (a21 * b12)
  val c12 = (a02 * b10) + (a12 * b11) + (a22 * b12)
  val c13 = (a03 * b10) + (a13 * b11) + (a23 * b12)

  val c20 = (a00 * b20) + (a10 * b21) + (a20 * b22)
  val c21 = (a01 * b20) + (a11 * b21) + (a21 * b22)
  val c22 = (a02 * b20) + (a12 * b21) + (a22 * b22)
  val c23 = (a03 * b20) + (a13 * b21) + (a23 * b22)

  val c30 = AT(m,12) val c31 = AT(m,13) val c32 = AT(m,14) val c33 = AT(m,15)

  val () = mat4_vt_free<GLfloat> m
  val () = vec3_vt_free<GLfloat> axis
}

implement mat4_vt_rotate<GLdouble,GLdouble>(m, angle, axis) = 
  mat4_vt_create<GLdouble>(c00, c01, c02, c03,
                         c10, c11, c12, c13,
                         c20, c21, c22, c23,
                         c30, c31, c32, c33) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val x = AT(axis,0) val y = AT(axis,1) val z = AT(axis,2)
  val a00 = AT(m,0) val a01 = AT(m,1) val a02 = AT(m,2) val a03 = AT(m,3)
  val a10 = AT(m,4) val a11 = AT(m,5) val a12 = AT(m,6) val a13 = AT(m,7)
  val a20 = AT(m,8) val a21 = AT(m,9) val a22 = AT(m,10) val a23 = AT(m,11)
  val a30 = AT(m,12) val a31 = AT(m,13) val a32 = AT(m,14) val a33 = AT(m,15)

  val len = sqrt((x * x) + (y * y) + (z * z))
  val s = sin(angle)
  val c = cos(angle)
  val t = GLD 1.0 - c
  val b00 = (x * x * t) + c
  val b01 = (y * x * t) + (z * s)
  val b02 = (z * x * t) - (y * s)
  val b10 = (x * y * t) - (z * s)
  val b11 = (y * y * t) + c
  val b12 = (z * y * t) + (x * s)
  val b20 = (x * z * t) + (y * s)
  val b21 = (y * z * t) - (x * s)
  val b22 = (z * z * t) + c

  val c00 = (a00 * b00) + (a10 * b01) + (a20 * b02)
  val c01 = (a01 * b00) + (a11 * b01) + (a21 * b02)
  val c02 = (a02 * b00) + (a12 * b01) + (a22 * b02)
  val c03 = (a03 * b00) + (a13 * b01) + (a23 * b02)

  val c10 = (a00 * b10) + (a10 * b11) + (a20 * b12)
  val c11 = (a01 * b10) + (a11 * b11) + (a21 * b12)
  val c12 = (a02 * b10) + (a12 * b11) + (a22 * b12)
  val c13 = (a03 * b10) + (a13 * b11) + (a23 * b12)

  val c20 = (a00 * b20) + (a10 * b21) + (a20 * b22)
  val c21 = (a01 * b20) + (a11 * b21) + (a21 * b22)
  val c22 = (a02 * b20) + (a12 * b21) + (a22 * b22)
  val c23 = (a03 * b20) + (a13 * b21) + (a23 * b22)

  val c30 = AT(m,12) val c31 = AT(m,13) val c32 = AT(m,14) val c33 = AT(m,15)

  val () = mat4_vt_free<GLdouble> m
  val () = vec3_vt_free<GLdouble> axis
}


// mat4_vt_frustum
implement mat4_vt_frustum<GLfloat>(left, right, bottom, top, near, far) = 
  mat4_vt_create<GLfloat>(a00, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                 GLF 0.0f,  a11, GLF 0.0f, GLF 0.0f,
                 a20, a21, a22, GLF ~1.0f,
                 GLF 0.0f, GLF 0.0f, a32, GLF 0.0f) where {
  val mul_near_two = near * GLF 2.0f
  val rl = right - left
  val tb = top - bottom
  val f = far - near
  val a00 = mul_near_two / rl
  val a11 = mul_near_two / tb
  val a20 = (left + right) / rl
  val a21 = (top + bottom) / tb
  val a22 = ~((far + near) / f)
  val a32 = ~((far * mul_near_two) / f)
}

implement mat4_vt_frustum<GLdouble>(left, right, bottom, top, near, far) = 
  mat4_vt_create<GLdouble>(a00, GLD 0.0, GLD 0.0, GLD 0.0,
                 GLD 0.0,  a11, GLD 0.0, GLD 0.0,
                 a20, a21, a22, GLD ~1.0,
                 GLD 0.0, GLD 0.0, a32, GLD 0.0) where {
  val mul_near_two = near * GLD 2.0
  val rl = right - left
  val tb = top - bottom
  val f = far - near
  val a00 = mul_near_two / rl
  val a11 = mul_near_two / tb
  val a20 = (left + right) / rl
  val a21 = (top + bottom) / tb
  val a22 = ~((far + near) / f)
  val a32 = ~((far * mul_near_two) / f)
}


// mat4_vt_perspective
implement mat4_vt_perspective<GLfloat>(fovy, aspect, near, far) = 
        mat4_vt_frustum<GLfloat>(~right, right, ~top, top, near, far) where {
  val PI = GLF 3.14159265358979f
  val top = near * tan((fovy * PI) / GLF 360.0f)
  val right = top * aspect
}

implement mat4_vt_perspective<GLdouble>(fovy, aspect, near, far) = 
        mat4_vt_frustum<GLdouble>(~right, right, ~top, top, near, far) where {
  val PI = GLD 3.14159265358979
  val top = near * tan((fovy * PI) / GLD 360.0)
  val right = top * aspect
}

// mat4_vt_ortho
implement mat4_vt_ortho<GLfloat>(left, right, bottom, top, near, far) = 
        mat4_vt_create<GLfloat>(a00, GLF 0.0f, GLF 0.0f, GLF 0.0f,
                       GLF 0.0f,  a11, GLF 0.0f, GLF 0.0f,
                       GLF 0.0f, GLF 0.0f, a22, GLF 0.0f,
                       a30,  a31,  a32, GLF 1.0f) where {
  val rl = right - left
  val tb = top - bottom
  val f = far - near
  val a00 = GLF 2.0f / rl
  val a11 = GLF 2.0f / tb
  val a22 = GLF ~2.0f / f
  val a30 = ~(left + right) / rl
  val a31 = ~(top + bottom) / tb
  val a32 = ~(far + near) / f
}

implement mat4_vt_ortho<GLdouble>(left, right, bottom, top, near, far) = 
        mat4_vt_create<GLdouble>(a00, GLD 0.0, GLD 0.0, GLD 0.0,
                       GLD 0.0,  a11, GLD 0.0, GLD 0.0,
                       GLD 0.0, GLD 0.0, a22, GLD 0.0,
                       a30,  a31,  a32, GLD 1.0) where {
  val rl = right - left
  val tb = top - bottom
  val f = far - near
  val a00 = GLD 2.0 / rl
  val a11 = GLD 2.0 / tb
  val a22 = GLD ~2.0 / f
  val a30 = ~(left + right) / rl
  val a31 = ~(top + bottom) / tb
  val a32 = ~(far + near) / f
}

// mat4_vt_lookat
implement mat4_vt_lookat<GLfloat>(eye, center, up) = 
  mat4_vt_create<GLfloat>(x0,  y0,  z0,  GLF 0.0f,
                        x1,  y1,  z1,  GLF 0.0f,
                        x2,  y2,  z2,  GLF 0.0f,
                        a30, a31, a32, GLF 1.0f) where {
  macdef AT(x, y) = arrayptr_get_at<GLfloat>(,(x), i2sz ,(y))

  val eye0 = AT(eye,0) val eye1 = AT(eye,1) val eye2 = AT(eye,2)
  val z = vec3_vt_direction<GLfloat,GLfloat>(eye, center)
  val z0 = AT(z,0) val z1 = AT(z,1) val z2 = AT(z,2)
  val x = vec3_vt_normalize<GLfloat,GLfloat>(vec3_vt_cross<GLfloat>(up, z))
  val x0 = AT(x,0) val x1 = AT(x,1) val x2 = AT(x,2)
  val v = vec3_vt_create<GLfloat>(z0, z1, z2)
  val y = vec3_vt_normalize<GLfloat,GLfloat>(vec3_vt_cross<GLfloat>(v, x))
  val y0 = AT(y,0) val y1 = AT(y,1) val y2 = AT(y,2)

  val a30 = (x0 * eye0) + (x1 * eye1) - (x2 * eye2)
  val a31 = (y0 * eye0) + (y1 * eye1) - (y2 * eye2)
  val a32 = (z0 * eye0) + (z1 * eye1) - (z2 * eye2)

  val () = vec3_vt_free<GLfloat> y
}

implement mat4_vt_lookat<GLdouble>(eye, center, up) = 
  mat4_vt_create<GLdouble>(x0,  y0,  z0,  GLD 0.0,
                         x1,  y1,  z1,  GLD 0.0,
                         x2,  y2,  z2,  GLD 0.0,
                         a30, a31, a32, GLD 1.0) where {
  macdef AT(x, y) = arrayptr_get_at<GLdouble>(,(x), i2sz ,(y))

  val eye0 = AT(eye,0) val eye1 = AT(eye,1) val eye2 = AT(eye,2)
  val z = vec3_vt_direction<GLdouble,GLdouble>(eye, center)
  val z0 = AT(z,0) val z1 = AT(z,1) val z2 = AT(z,2)
  val x = vec3_vt_normalize<GLdouble,GLdouble>(vec3_vt_cross<GLdouble>(up, z))
  val x0 = AT(x,0) val x1 = AT(x,1) val x2 = AT(x,2)
  val v = vec3_vt_create<GLdouble>(z0, z1, z2)
  val y = vec3_vt_normalize<GLdouble,GLdouble>(vec3_vt_cross<GLdouble>(v, x))
  val y0 = AT(y,0) val y1 = AT(y,1) val y2 = AT(y,2)

  val a30 = (x0 * eye0) + (x1 * eye1) - (x2 * eye2)
  val a31 = (y0 * eye0) + (y1 * eye1) - (y2 * eye2)
  val a32 = (z0 * eye0) + (z1 * eye1) - (z2 * eye2)

  val () = vec3_vt_free<GLdouble> y
}

implement{a} mat4_vt_fprint(out, vec) = fprint(out, vec, i2sz(16))

end// local

