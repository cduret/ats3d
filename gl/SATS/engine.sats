staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "gl/SATS/matrix.sats"
staload "gl/SATS/core.sats"

(*

dataviewtype UniformData =
  UniformInt of (string, int) // (name, value)
  | UniformBool of (string, bool) // (name, value)
  | UniformFloat of (string, float) // (name, value)
  | UniformIntVec2 of (string, array(int, 2)) // (name, value)
  | UniformIntVec3 of (string, array(int, 3)) // (name, value)
  | UniformIntVec4 of (string, array(int, 4)) // (name, value)
  | UniformBoolVec2 of (string, array(bool, 2)) // (name, value)
  | UniformBoolVec3 of (string, array(bool, 3)) // (name, value)
  | UniformBoolVec4 of (string, array(bool, 4)) // (name, value)
  | UniformFloatVec2 of (string, array(float, 2)) // (name, value)
  | UniformFloatVec3 of (string, array(float, 3)) // (name, value)
  | UniformFloatVec4 of (string, array(float, 4)) // (name, value)
  | UniformIntMat2 of (string, array(int, 4)) // (name, value)
  | UniformIntMat3 of (string, array(int, 9)) // (name, value)
  | UniformIntMat4 of (string, array(int, 16)) // (name, value)
  | UniformMat2 of (string, array(float, 4)) // (name, value)
  | UniformMat3 of (string, array(float, 9)) // (name, value)
  | UniformMat4 of (string, array(float, 16)) // (name, value)

dataviewtype UniformDataGL = 
  UniformIntGL of (GLint, int) // (idx, value)
// ...

dataviewtype Appearance =
  {m, n: nat} Shader of (string, string, string, array(string, m), array(string, m)) // (id, vertex_src, fragment_src, attributes, uniforms)
  | {n: nat} ShaderMaterial of (array(GLint, n))

dataviewtype AppearanceGL =
  | {m, n: nat} ShaderGL of (string, GLprogram, array(GLuint, m), array(GLint, n), GLint, GLint) // (id, program, attributes, uniforms, mv_u_idx, p_u_idx)
  | {m, n: nat} ActivatedShaderGL of (AppearanceGL, array(GLuint, m), GLuint, array(GLint, n)) // (parent, attributes_h, default_attr_h, uniforms_h)
  | {n: nat} ShaderMaterialGL of (array(UniformDataGL, n))
*)

absviewt@ype array_ptr_vt(vt0p, nat)

dataviewtype scene_vt =
  Fail of (string)
  | Perspective of (string, float, float, float, float) // (uniform, fov, ratio, near, far)
  | Viewpoint of (string, vector3_t(GLfloat)) // (uniform, view)
  | Geometry of (string, scene_vt, bool, string) // (id, scene, visible, kind)
  | Transform of (matrix4_t(GLfloat), scene_vt) // (matrix, scene)
  | Scale of (vector3_t(GLfloat), scene_vt) // (scale, scene)
  | Translate of (vector3_t(GLfloat), scene_vt) // (translate, scene)
  | Rotate of (vector3_t(GLfloat), scene_vt) // (rotate, scene)
  | {n: nat} Group of (array_ptr_vt(scene_vt, n), size_t n) // (scenes)
  | Shape of (Appearance, scene_vt) // (appearance, geometry)
  | {n: nat} Lines of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} LineLoop of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} LineStrip of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} Points of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} Triangles of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} TriangleStrip of (array(GLfloat, n), string, string) // (vertices, ref, attribute)
  | {n: nat} Buffer of (array(GLfloat, n), string) // (data, attribute)  !!!!-- array of ???

(*
dataviewtype SceneGL =
  PerspectiveGL of (GLint, float, float, float, float) // (uniform_idx, fov, ratio, near, far)
  | ViewpointGL of (GLint, vector3_t(GLfloat)) // (uniform_idx, view)
  | GeometryGL of (string, SceneGL, bool, string) // (id, scene, visible, kind)
  | TransformGL of (GLint, matrix4_t(GLfloat), Scene) // (uniform_idx, matrix, scene)
  | ScaleGL of (GLint, vector3_t(GLfloat), Scene) // (uniform_idx, rotate, scene)
  | TranslateGL of (GLint, vector3_t(GLfloat), Scene) // (uniform_idx, rotate, scene)
  | RotateGL of (GLint, vector3_t(GLfloat), Scene) // (uniform_idx, rotate, scene)
  | {n: nat} GroupGL of (array(SceneGL, n)) // (scenes)
  | ShapeGL of (AppearanceGL, SceneGL) // (appearance, geometry)
  | LinesGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | LineLoopGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | LineStripGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | PointsGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | TrianglesGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | TriangleStripGL of (glbuffer_t, string, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | BufferGL of (glbuffer_t, GLuint) // (buffer, attribute_idx)
*)

//fun ats3d_scene_free(scene: scene_vt >> scene_vt?): void

(*
fun ats3d_appearance_free(appearance: Appearance): void

fun ats3d_scene_debug(scene: Scene): void
*)
