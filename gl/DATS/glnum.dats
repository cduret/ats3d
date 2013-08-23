#include "share/atspre_staload_tmpdef.hats"

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "libc/SATS/math.sats"

staload "gl/SATS/glnum.sats"

//staload _ = "prelude/DATS/float.dats"
//staload _ = "prelude/DATS/integer.dats"
staload "contrib/GL/SATS/gl.sats"

#define i2gli GLint_of_int
#define gli2i int_of_GLint
#define f2glf GLfloat_of_float
#define glf2f float_of_GLfloat
#define d2gld GLdouble_of_double
#define gld2d double_of_GLdouble

implement glint_abs(x) = if x < i2gli(0) then ~x else x
implement glfloat_abs(x) = if x < f2glf(0.0f) then ~x else x
implement gldouble_abs(x) = if x < d2gld(0.0) then ~x else x

implement glint_neg(x) = i2gli ~(gli2i x)
implement glfloat_neg(x) = f2glf ~(glf2f x)
implement gldouble_neg(x) = d2gld ~(gld2d x)

implement glint_glint_add(x,y) = i2gli(gli2i(x) + gli2i(y))
implement glfloat_glfloat_add(x,y) = f2glf(glf2f(x) + glf2f(y))
implement gldouble_gldouble_add(x,y) = d2gld(gld2d(x) + gld2d(y))

implement glint_glint_sub(x,y) = i2gli(gli2i(x) - gli2i(y))
implement glfloat_glfloat_sub(x,y) = f2glf(glf2f(x) - glf2f(y))
implement gldouble_gldouble_sub(x,y) = d2gld(gld2d(x) - gld2d(y))

implement glint_glint_mul(x,y) = i2gli(gli2i(x) * gli2i(y))
implement glfloat_glfloat_mul(x,y) = f2glf(glf2f(x) * glf2f(y))
implement gldouble_gldouble_mul(x,y) = d2gld(gld2d(x) * gld2d(y))

implement glint_glint_div(x,y) = i2gli(gli2i(x) / gli2i(y))
implement glfloat_glfloat_div(x,y) = f2glf(glf2f(x) / glf2f(y))
implement gldouble_gldouble_div(x,y) = d2gld(gld2d(x) / gld2d(y))

implement glint_lt(x, y) = gli2i(x) < gli2i(y)
implement glfloat_lt(x, y) = glf2f(x) < glf2f(y)
implement gldouble_lt(x, y) = gld2d(x) < gld2d(y)

implement glint_lte(x, y) = gli2i(x) <= gli2i(y)
implement glfloat_lte(x, y) = glf2f(x) <= glf2f(y)
implement gldouble_lte(x, y) = gld2d(x) <= gld2d(y)

implement glint_eq(x, y) = gli2i(x) = gli2i(y)
implement glfloat_eq(x, y) = glf2f(x) = glf2f(y)
implement gldouble_eq(x, y) = gld2d(x) = gld2d(y)

implement glint_neq(x, y) = gli2i(x) != gli2i(y)
implement glfloat_neq(x, y) = glf2f(x) != glf2f(y)
implement gldouble_neq(x, y) = gld2d(x) != gld2d(y)

implement glint_gte(x, y) = gli2i(x) >= gli2i(y)
implement glfloat_gte(x, y) = glf2f(x) >= glf2f(y)
implement gldouble_gte(x, y) = gld2d(x) >= gld2d(y)

implement glint_gt(x, y) = gli2i(x) > gli2i(y)
implement glfloat_gt(x, y) = glf2f(x) > glf2f(y)
implement gldouble_gt(x, y) = gld2d(x) > gld2d(y)


implement pow<GLfloat> (x, y) = f2glf(pow (glf2f x, glf2f y))
implement pow<GLdouble> (x, y) = d2gld(pow (gld2d x, gld2d y))
implement ceil<GLfloat> (x) = f2glf(ceil (glf2f x))
implement ceil<GLdouble> (x) = d2gld(ceil (gld2d x))
implement floor<GLfloat> (x) = f2glf(floor (glf2f x))
implement floor<GLdouble> (x) = d2gld(floor (gld2d x))
implement sqrt<GLfloat> (a) = f2glf(sqrt (glf2f a))
implement sqrt<GLdouble> (a) = d2gld(sqrt (gld2d a))

implement sin<GLfloat> (x) = f2glf(sin (glf2f x))
implement sin<GLdouble> (x) = d2gld(sin (gld2d x))
implement cos<GLfloat> (x) = f2glf(cos (glf2f x))
implement cos<GLdouble> (x) = d2gld(cos (gld2d x))
implement tan<GLfloat> (x) = f2glf(tan (glf2f x))
implement tan<GLdouble> (x) = d2gld(tan (gld2d x))
implement asin<GLfloat> (x) = f2glf(asin (glf2f x))
implement asin<GLdouble> (x) = d2gld(asin (gld2d x))
implement acos<GLfloat> (x) = f2glf(acos (glf2f x))
implement acos<GLdouble> (x) = d2gld(acos (gld2d x))
implement atan<GLfloat> (x) = f2glf(atan (glf2f x))
implement atan<GLdouble> (x) = d2gld(atan (gld2d x))
implement atan2<GLfloat> (x, y) = f2glf(atan2 (glf2f x, glf2f y))
implement atan2<GLdouble> (x, y) = d2gld(atan2 (gld2d x, gld2d y))
