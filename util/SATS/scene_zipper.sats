staload "gl/SATS/engine.sats"
staload "contrib/GL/SATS/gl.sats"
staload "gl/SATS/matrix.sats"

absviewt@ype array_ptr_vt(vt0p)

dataviewtype scene_zipper_vt =
  Top of ()
  | Fail of (string) // (msg)
  | Location of (scene_vt, scene_zipper_vt) //(tree, path)
  | NodeGeometry of (string, bool, string, scene_zipper_vt) // (id, visible, kind, path)
  | NodeTransform of (matrix4_t(GLfloat), scene_zipper_vt) // (matrix, path)
  | NodeScale of (vector3_t(GLfloat), scene_zipper_vt) // (scale, path)
  | NodeRotate of (vector3_t(GLfloat), scene_zipper_vt) // (rotate, path)
  | NodeTranslate of (vector3_t(GLfloat), scene_zipper_vt) // (translate, path)
  | {m, n: nat} NodeGroup of (array_ptr_vt(scene_vt), size_t m, scene_zipper_vt, array_ptr_vt(scene_vt), size_t n) // (left, path, right)
  | NodeShape of (appearance_vt, scene_zipper_vt, scene_vt) // (appearance, path , geometry)

(*
dataviewtype SceneZipperGL =
  TopGL of ()
  | FailGL of (string) // (msg)
  | LocationGL of (SceneGL, SceneZipperGL) //(tree, path)
  | NodeGeometryGL of (string, bool, string, SceneZipperGL) // (id, visible, kind, path)
  | NodeTransformGL of (matrix4_t(GLfloat), SceneZipperGL) // (matrix, path)
  | NodeScaleGL of (vector3_t(GLfloat), SceneZipperGL) // (scale, path)
  | NodeRotateGL of (vector3_t(GLfloat), SceneZipperGL) // (rotate, path)
  | NodeTranslateGL of (vector3_t(GLfloat), SceneZipperGL) // (translate, path)
  | {m, n: nat} NodeGroupGL of (array(SceneGL, m), SceneZipperGL, array(SceneGL, n)) // (left, path, right)
  | NodeShapeGL of (AppearanceGL, SceneZipperGL, SceneGL) // (appearance, path , geometry)
*)
//fun zip_free(loc: SceneZipper): void

fun zip_down(loc: !scene_zipper_vt): scene_zipper_vt
(*
fun zip_down_gl(loc: SceneZipperGL): SceneZipperGL

fun zip_up(loc: SceneZipper): SceneZipper
fun zip_up_gl(loc: SceneZipperGL): SceneZipperGL

fun zip_root(loc: SceneZipper): SceneZipper
fun zip_root_gl(loc: SceneZipperGL): SceneZipperGL

fun zip_right(loc: SceneZipper): SceneZipper
fun zip_right_gl(loc: SceneZipperGL): SceneZipperGL

fun zip_left(loc: SceneZipper): SceneZipper
fun zip_left_gl(loc: SceneZipperGL): SceneZipperGL

fun {n: nat} zip_nth(loc: SceneZipper, index: int n): SceneZipper
fun {n: nat} zip_nth_gl(loc: SceneZipperGL, index: int n): SceneZipperGL

fun zip_insert_right(loc: SceneZipper, s: Scene): SceneZipper
fun zip_insert_right_gl(loc: SceneZipper, s: Scene): SceneZipperGL

fun zip_insert_left(loc: SceneZipper, s: Scene): SceneZipper
fun zip_insert_left_gl(loc: SceneZipper, s: Scene): SceneZipperGL

fun zip_insert_down(loc: SceneZipper, s: Scene): SceneZipper
fun zip_insert_down_gl(loc: SceneZipper, s: Scene): SceneZipperGL

fun zip_replace(loc: SceneZipper, s: Scene): SceneZipper
fun zip_replace_gl(loc: SceneZipperGL, s: Scene): SceneZipperGL

fun zip_remove(loc: SceneZipper): SceneZipper
fun zip_remove_gl(loc: SceneZipperGL): SceneZipperGL
*)
