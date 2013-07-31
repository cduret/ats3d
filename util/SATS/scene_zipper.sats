staload "gl/SATS/engine.sats"
staload "contrib/GL/SATS/gl.sats"
staload "gl/SATS/matrix.sats"

(*dataviewtype either_vt (a: vt0p, b: vt0p) =
  Left (a, b) of (a)
  | Right (a, b) of (b)*)

dataviewtype scene_zipper_vt =
  Top of ()
  | ZipperFail of (strptr1) // (msg)
  | Location of (scene_vt, scene_zipper_vt) //(tree, path)
  | LocationApp of (appearance_vt, scene_zipper_vt) //(tree, path)
  | NodeGeometry of (strptr1, bool, strptr1, scene_zipper_vt) // (id, visible, kind, path)
  | NodeTransform of (matrix4_vt(GLfloat), scene_zipper_vt) // (matrix, path)
  | NodeScale of (vector3_vt(GLfloat), scene_zipper_vt) // (scale, path)
  | NodeRotate of (vector3_vt(GLfloat), scene_zipper_vt) // (rotate, path)
  | NodeTranslate of (vector3_vt(GLfloat), scene_zipper_vt) // (translate, path)
  | {m, n: nat} NodeGroup of (list_vt(scene_vt, m), scene_zipper_vt, list_vt(scene_vt, n)) // (left, path, right)
  | NodeShape of (scene_vt, scene_zipper_vt) // (geometry, path)
  | NodeShapeApp of (appearance_vt, scene_zipper_vt) // (appearance, path)

dataviewtype scene_zipper_gl_vt =
  TopGL of ()
  | ZipperFailGL of (strptr1) // (msg)
  | LocationGL of (scene_gl_vt, scene_zipper_gl_vt) //(tree, path)
  | LocationAppGL of (appearance_gl_vt, scene_zipper_gl_vt) //(tree, path)
  | NodeGeometryGL of (strptr1, bool, strptr1, scene_zipper_gl_vt) // (id, visible, kind, path)
  | NodeTransformGL of (GLint, matrix4_vt(GLfloat), scene_zipper_gl_vt) // (uniform_idx, matrix, path)
  | NodeScaleGL of (GLint, vector3_vt(GLfloat), scene_zipper_gl_vt) // (scale, path)
  | NodeRotateGL of (GLint, vector3_vt(GLfloat), scene_zipper_gl_vt) // (rotate, path)
  | NodeTranslateGL of (GLint, vector3_vt(GLfloat), scene_zipper_gl_vt) // (translate, path)
  | {m, n: nat} NodeGroupGL of (list_vt(scene_gl_vt, m), scene_zipper_gl_vt, list_vt(scene_gl_vt, n)) // (left, path, right)
  | NodeShapeGL of (scene_gl_vt, scene_zipper_gl_vt) // (geometry, path)
  | NodeShapeAppGL of (appearance_gl_vt, scene_zipper_gl_vt) // (appearance, path)

fun zip_free(loc: scene_zipper_vt): void
fun zip_free_gl(loc: scene_zipper_gl_vt): void

fun zip_down(loc: scene_zipper_vt): scene_zipper_vt
fun zip_down_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_up(loc: scene_zipper_vt): scene_zipper_vt
fun zip_up_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_root(loc: scene_zipper_vt): scene_zipper_vt
fun zip_root_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_right(loc: scene_zipper_vt): scene_zipper_vt
fun zip_right_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_left(loc: scene_zipper_vt): scene_zipper_vt
fun zip_left_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_nth{n: nat} (loc: scene_zipper_vt, index: int n): scene_zipper_vt
fun zip_nth_gl{n: nat} (loc: scene_zipper_gl_vt, index: int n): scene_zipper_gl_vt

fun zip_insert_right(loc: scene_zipper_vt, s: scene_vt): scene_zipper_vt
fun zip_insert_right_gl(loc: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt

fun zip_insert_left(loc: scene_zipper_vt, s: scene_vt): scene_zipper_vt
fun zip_insert_left_gl(loc: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt

fun zip_insert_down(loc: scene_zipper_vt, s: scene_vt): scene_zipper_vt
fun zip_insert_down_gl(loc: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt

fun zip_remove(loc: scene_zipper_vt): scene_zipper_vt
fun zip_remove_gl(loc: scene_zipper_gl_vt): scene_zipper_gl_vt

fun zip_replace(loc: scene_zipper_vt, s: scene_vt): scene_zipper_vt
fun zip_replace_app(loc: scene_zipper_vt, a: appearance_vt): scene_zipper_vt
fun zip_replace_gl(loc: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt
fun zip_replace_app_gl(loc: scene_zipper_gl_vt, a: appearance_gl_vt): scene_zipper_gl_vt

