staload MATH = "libc/SATS/math.sats"
staload "prelude/SATS/number.sats"

implement print_typ<GLfloat> () = print "GLfloat"
implement print_elt<GLfloat> (x) = print_float(float_of_GLfloat x)

implement abs<GLfloat,GLfloat> (x) = GLfloat_of_float(abs_float (float_of_GLfloat x))
implement neg<GLfloat> (x) = GLfloat_of_float(neg_float (float_of_GLfloat x))

implement add<GLfloat> (x1, x2) = GLfloat_of_float(add_float_float (float_of_GLfloat x1, float_of_GLfloat x2))
implement sub<GLfloat> (x1, x2) = GLfloat_of_float(sub_float_float (float_of_GLfloat x1, float_of_GLfloat x2))
implement mul<GLfloat> (x1, x2) = GLfloat_of_float(mul_float_float (float_of_GLfloat x1, float_of_GLfloat x2))
implement div<GLfloat> (x1, x2) = GLfloat_of_float(div_float_float (float_of_GLfloat x1, float_of_GLfloat x2))

implement pow<GLfloat> (x, y) = GLfloat_of_float($MATH.powf (float_of_GLfloat x, float_of_GLfloat y))
implement ceil<GLfloat> (x) = GLfloat_of_float($MATH.ceilf (float_of_GLfloat x))
implement floor<GLfloat> (x) = GLfloat_of_float($MATH.floorf (float_of_GLfloat x))
implement sqrt<GLfloat> (a) = GLfloat_of_float($MATH.sqrtf (float_of_GLfloat a))
implement scal<GLfloat,GLfloat> (x1, x2) = GLfloat_of_float(mul_float_float (float_of_GLfloat x1, float_of_GLfloat x2))

implement eq<GLfloat> (x1, x2) = float_of_GLfloat(x1) = float_of_GLfloat(x2)
implement lt<GLfloat> (x1, x2) = float_of_GLfloat(x1) < float_of_GLfloat(x2)
implement lte<GLfloat> (x1, x2) = float_of_GLfloat(x1) <= float_of_GLfloat(x2)
implement gt<GLfloat> (x1, x2) = float_of_GLfloat(x1) > float_of_GLfloat(x2)
implement gte<GLfloat> (x1, x2) = float_of_GLfloat(x1) >= float_of_GLfloat(x2)
implement signof<GLfloat> (x) = compare_float_float (float_of_GLfloat(x), (float_of)0.0)
implement compare<GLfloat> (x1, x2) = compare_float_float (float_of_GLfloat x1, float_of_GLfloat x2)
implement neq<GLfloat> (x1, x2) = neq_float_float (float_of_GLfloat x1, float_of_GLfloat x2) 

implement sin<GLfloat> (x) = GLfloat_of_float($MATH.sinf (float_of_GLfloat x))
implement cos<GLfloat> (x) = GLfloat_of_float($MATH.cosf (float_of_GLfloat x))
implement tan<GLfloat> (x) = GLfloat_of_float($MATH.tanf (float_of_GLfloat x))
implement asin<GLfloat> (x) = GLfloat_of_float($MATH.asinf (float_of_GLfloat x))
implement acos<GLfloat> (x) = GLfloat_of_float($MATH.acosf (float_of_GLfloat x))
implement atan<GLfloat> (x) = GLfloat_of_float($MATH.atanf (float_of_GLfloat x))
implement atan2<GLfloat> (x, y) = GLfloat_of_float($MATH.atan2f (float_of_GLfloat x, float_of_GLfloat y))

implement lit<int><GLfloat>(x) = GLfloat_of_float(float_of_int x)
implement lit<double><GLfloat>(x) = GLfloat_of_float(float_of_double x)
