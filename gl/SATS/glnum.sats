#define ATS_DYNLOADFLAG 0 // no dynamic loading at run-time

staload "contrib/GL/SATS/gl.sats"

fun glint_abs(x: GLint): GLint
overload abs with glint_abs of 0
fun glfloat_abs(x: GLfloat): GLfloat
overload abs with glfloat_abs of 0
fun gldouble_abs(x: GLdouble): GLdouble
overload abs with gldouble_abs of 0

fun glint_neg(x: GLint): GLint
overload ~ with glint_neg of 0
fun glfloat_neg(x: GLfloat): GLfloat
overload ~ with glfloat_neg of 0
fun gldouble_neg(x: GLdouble): GLdouble
overload ~ with gldouble_neg of 0

fun glint_glint_add(x: GLint, y: GLint): GLint
overload + with glint_glint_add of 20
fun glfloat_glfloat_add(x: GLfloat, y: GLfloat): GLfloat
overload + with glfloat_glfloat_add of 20
fun gldouble_gldouble_add(x: GLdouble, y: GLdouble): GLdouble
overload + with gldouble_gldouble_add of 20

fun glint_glint_sub(x: GLint, y: GLint): GLint
overload - with glint_glint_sub of 20
fun glfloat_glfloat_sub(x: GLfloat, y: GLfloat): GLfloat
overload - with glfloat_glfloat_sub of 20
fun gldouble_gldouble_sub(x: GLdouble, y: GLdouble): GLdouble
overload - with gldouble_gldouble_sub of 20

fun glint_glint_mul(x: GLint, y: GLint): GLint
overload * with glint_glint_mul of 20
fun glfloat_glfloat_mul(x: GLfloat, y: GLfloat): GLfloat
overload * with glfloat_glfloat_mul of 20
fun gldouble_gldouble_mul(x: GLdouble, y: GLdouble): GLdouble
overload * with gldouble_gldouble_mul of 20

fun glint_glint_div(x: GLint, y: GLint): GLint
overload / with glint_glint_div of 20
fun glfloat_glfloat_div(x: GLfloat, y: GLfloat): GLfloat
overload / with glfloat_glfloat_div of 20
fun gldouble_gldouble_div(x: GLdouble, y: GLdouble): GLdouble
overload / with gldouble_gldouble_div of 20

fun glint_lt(x: GLint, y: GLint): bool
overload < with glint_lt of 0
fun glfloat_lt(x: GLfloat, y: GLfloat): bool
overload < with glfloat_lt of 0
fun gldouble_lt(x: GLdouble, y: GLdouble): bool
overload < with gldouble_lt of 0

fun glint_lte(x: GLint, y: GLint): bool
overload <= with glint_lte of 0
fun glfloat_lte(x: GLfloat, y: GLfloat): bool
overload <= with glfloat_lte of 0
fun gldouble_lte(x: GLdouble, y: GLdouble): bool
overload <= with gldouble_lte of 0

fun glint_eq(x: GLint, y: GLint): bool
overload = with glint_eq of 0
fun glfloat_eq(x: GLfloat, y: GLfloat): bool
overload = with glfloat_eq of 0
fun gldouble_eq(x: GLdouble, y: GLdouble): bool
overload = with gldouble_eq of 0

fun glint_neq(x: GLint, y: GLint): bool
overload != with glint_neq of 0
overload <> with glint_neq of 0
fun glfloat_neq(x: GLfloat, y: GLfloat): bool
overload != with glfloat_neq of 0
overload <> with glfloat_neq of 0
fun gldouble_neq(x: GLdouble, y: GLdouble): bool
overload != with gldouble_neq of 0
overload <> with gldouble_neq of 0

fun glint_gte(x: GLint, y: GLint): bool
overload >= with glint_gte of 0
fun glfloat_gte(x: GLfloat, y: GLfloat): bool
overload >= with glfloat_gte of 0
fun gldouble_gte(x: GLdouble, y: GLdouble): bool
overload >= with gldouble_gte of 0

fun glint_gt(x: GLint, y: GLint): bool
overload > with glint_gt of 0
fun glfloat_gt(x: GLfloat, y: GLfloat): bool
overload > with glfloat_gt of 0
fun gldouble_gt(x: GLdouble, y: GLdouble): bool
overload > with gldouble_gt of 0
