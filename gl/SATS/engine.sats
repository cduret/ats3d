staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "gl/SATS/matrix.sats"
staload "gl/SATS/core.sats"

absviewt@ype array_ptr_vt(vt0p, int)

dataviewtype uniform_data_vt =
  UniformInt of (strptr1, int) // (name, value)
  | UniformBool of (strptr1, bool) // (name, value)
  | UniformFloat of (strptr1, float) // (name, value)
  | UniformIntVec2 of (strptr1, array_ptr_vt(int, 2)) // (name, value)
  | UniformIntVec3 of (strptr1, array_ptr_vt(int, 3)) // (name, value)
  | UniformIntVec4 of (strptr1, array_ptr_vt(int, 4)) // (name, value)
  | UniformBoolVec2 of (strptr1, array_ptr_vt(bool, 2)) // (name, value)
  | UniformBoolVec3 of (strptr1, array_ptr_vt(bool, 3)) // (name, value)
  | UniformBoolVec4 of (strptr1, array_ptr_vt(bool, 4)) // (name, value)
  | UniformFloatVec2 of (strptr1, array_ptr_vt(float, 2)) // (name, value)
  | UniformFloatVec3 of (strptr1, array_ptr_vt(float, 3)) // (name, value)
  | UniformFloatVec4 of (strptr1, array_ptr_vt(float, 4)) // (name, value)
  | UniformIntMat2 of (strptr1, array_ptr_vt(int, 4)) // (name, value)
  | UniformIntMat3 of (strptr1, array_ptr_vt(int, 9)) // (name, value)
  | UniformIntMat4 of (strptr1, array_ptr_vt(int, 16)) // (name, value)
  | UniformMat2 of (strptr1, array_ptr_vt(float, 4)) // (name, value)
  | UniformMat3 of (strptr1, array_ptr_vt(float, 9)) // (name, value)
  | UniformMat4 of (strptr1, array_ptr_vt(float, 16)) // (name, value)

dataviewtype uniform_data_gl_vt = 
  UniformIntGL of (GLint, int) // (idx, value)
  | UniformIntVec2GL of (GLint, array_ptr_vt(int, 2)) // (idx, value)
  | UniformIntVec3GL of (GLint, array_ptr_vt(int, 3)) // (idx, value)
  | UniformIntVec4GL of (GLint, array_ptr_vt(int, 4)) // (idx, value)
  | UniformFloatVec2GL of (GLint, array_ptr_vt(float, 2)) // (idx, value)
  | UniformFloatVec3GL of (GLint, array_ptr_vt(float, 3)) // (idx, value)
  | UniformFloatVec4GL of (GLint, array_ptr_vt(float, 4)) // (idx, value)
  | UniformMat2GL of (GLint, array_ptr_vt(float, 4)) // (idx, value)
  | UniformMat3GL of (GLint, array_ptr_vt(float, 9)) // (idx, value)
  | UniformMat4GL of (GLint, array_ptr_vt(float, 16)) // (idx, value)

dataviewtype appearance_vt =
  {m, n: nat} Shader of (strptr1, strptr1, strptr1, list_vt(strptr1, m), list_vt(strptr1, n)) // (id, vertex_src, fragment_src, attributes, uniforms)
  | {n: nat} ShaderMaterial of (list_vt(uniform_data_vt, n))

dataviewtype appearance_gl_vt =
  | {m, n: nat} ShaderGL of (strptr1, GLprogram, list_vt(GLuint, m), list_vt(GLint, n), GLint, GLint) // (id, program, attributes, uniforms, mv_u_idx, p_u_idx)
  | {m, n: nat} ActivatedShaderGL of (appearance_gl_vt, list_vt(GLuint, m), GLuint, list_vt(GLint, n)) // (parent, attributes_h, default_attr_h, uniforms_h)
  | {n: nat} ShaderMaterialGL of (list_vt(uniform_data_gl_vt, n))

dataviewtype gl_context_data_vt = GlContext of (appearance_gl_vt) // (active_shader) (only ShaderGL !!)

dataviewtype scene_vt =
  Fail of (strptr1) // (msg)
  | Perspective of (strptr1, float, float, float, float) // (uniform, fov, ratio, near, far)
  | Viewpoint of (strptr1, vector3_t(GLfloat)) // (uniform, view)
  | Geometry of (strptr1, scene_vt, bool, strptr1) // (id, scene, visible, kind)
  | Transform of (matrix4_t(GLfloat), scene_vt) // (matrix, scene)
  | Scale of (vector3_t(GLfloat), scene_vt) // (scale, scene)
  | Translate of (vector3_t(GLfloat), scene_vt) // (translate, scene)
  | Rotate of (vector3_t(GLfloat), scene_vt) // (rotate, scene)
  | {n: nat} Group of (list_vt(scene_vt, n)) // (scenes)
  | Shape of (appearance_vt, scene_vt) // (appearance, geometry)
  | {n: nat} Lines of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} LineLoop of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} LineStrip of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} Points of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} Triangles of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} TriangleStrip of (array_ptr_vt(GLfloat, n), size_t n, strptr1, strptr1) // (vertices, size, ref, attribute)
  | {n: nat} Buffer of (array_ptr_vt(GLfloat, n), size_t n, strptr1) // (data, size, attribute)  !!!!-- array of ???

dataviewtype scene_gl_vt =
  FailGL of (strptr1) // (msg)
  | PerspectiveGL of (GLint, float, float, float, float) // (uniform_idx, fov, ratio, near, far)
  | ViewpointGL of (GLint, vector3_t(GLfloat)) // (uniform_idx, view)
  | GeometryGL of (strptr1, scene_gl_vt, bool, strptr1) // (id, scene, visible, kind)
  | TransformGL of (GLint, matrix4_t(GLfloat), scene_gl_vt) // (uniform_idx, matrix, scene)
  | ScaleGL of (GLint, vector3_t(GLfloat), scene_gl_vt) // (uniform_idx, rotate, scene)
  | TranslateGL of (GLint, vector3_t(GLfloat), scene_gl_vt) // (uniform_idx, rotate, scene)
  | RotateGL of (GLint, vector3_t(GLfloat), scene_gl_vt) // (uniform_idx, rotate, scene)
  | {n: nat} GroupGL of (list_vt(scene_gl_vt, n)) // (scenes)
  | ShapeGL of (appearance_gl_vt, scene_gl_vt) // (appearance, geometry)
  | LinesGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | LineLoopGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | LineStripGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | PointsGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | TrianglesGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | TriangleStripGL of (glbuffer_t, strptr1, GLuint, GLuint) // (buffer, ref_id, ref_buf, attribute_idx)
  | BufferGL of (glbuffer_t, GLuint) // (buffer, attribute_idx)

fun ats3d_scene_free(scene: scene_vt): void
fun ats3d_scene_gl_free(scene: scene_gl_vt): void
fun ats3d_appearance_free(appearance: appearance_vt): void
fun ats3d_appearance_gl_free(appearance: appearance_gl_vt): void
fun ats3d_uniform_data_free(uniform: uniform_data_vt): void
fun ats3d_uniform_data_gl_free(uniform: uniform_data_gl_vt): void

//fun ats3d_scene_compile(scene: scene_vt): scene_gl_vt
