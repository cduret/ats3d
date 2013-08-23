staload "prelude/SATS/arrayptr.sats"

staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"

staload "gl/SATS/matrix_vt.sats"

#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

typedef glbuffer_t = (GLuint, int, size_t) // buffer, nb_components, num_items

fun glc_check_error(msg: Strptr1): void
fun glc_print_shader_log( shader: !GLshader ): void
fun glc_compile_shader(code: Strptr1, shader: GLshader): Option_vt GLuint

fun glc_compile_fragment_shader(src: Strptr1): Option_vt GLuint // GLuint = GLshader
fun glc_compile_vertex_shader(src: Strptr1): Option_vt GLuint

fun glc_make_program(vertex_shader: GLshader, fragment_shader: GLshader): Option_vt GLuint // GLuint = GLprogram

fun glc_new_buf{n:nat}(buffer: arrayptr(GLfloat, n), size: int, num_items: size_t): glbuffer_t

fun glc_setup_attribute(program: !GLprogram, attribute: !Strptr1): GLuint
fun glc_bind_attribute(buffer: glbuffer_t, attribute: GLuint): void

fun glc_draw(type: GLenum, buffer: glbuffer_t): void

fun glc_bind_uniform_int(location: GLint, value: GLint): void
fun glc_bind_uniform_float(location: GLint, value: GLfloat): void

fun glc_bind_uniform_int_vec2(location: GLint, value: !vector2_vt(GLint)): void
fun glc_bind_uniform_int_vec3(location: GLint, value: !vector3_vt(GLint)): void
fun glc_bind_uniform_int_vec4(location: GLint, value: !vector4_vt(GLint)): void

fun glc_bind_uniform_float_vec2(location: GLint, value: !vector2_vt(GLfloat)): void
fun glc_bind_uniform_float_vec3(location: GLint, value: !vector3_vt(GLfloat)): void
fun glc_bind_uniform_float_vec4(location: GLint, value: !vector4_vt(GLfloat)): void

fun glc_bind_uniform_matrix2(location: GLint, value: !matrix2_vt(GLfloat)): void
fun glc_bind_uniform_matrix3(location: GLint, value: !matrix3_vt(GLfloat)): void
fun glc_bind_uniform_matrix4(location: GLint, value: !matrix4_vt(GLfloat)): void

fun glc_perspective(location: GLint, fov: GLfloat, ratio: GLfloat, near: GLfloat, far: GLfloat): matrix4_vt(GLfloat)
fun glc_camera(location: GLint, eye: vector3_vt(GLfloat), center: vector3_vt(GLfloat), up: vector3_vt(GLfloat)): matrix4_vt(GLfloat)
fun glc_clear_all(r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat): void
fun glc_setup_uniform(program: !GLprogram, uniform: !Strptr1): GLint

fun glc_new_ibuf{n:nat}(buffer: arrayptr(GLushort, n), size: int, num_items: size_t): glbuffer_t
fun glc_bind_index(index_buffer: glbuffer_t): void
fun glc_draw_indices(mode: GLenum, index_buffer: glbuffer_t): void

fun glc_set_matrix(location: GLint, mvm: matrix4_vt(GLfloat), mat4: matrix4_vt(GLfloat)): matrix4_vt(GLfloat)
fun glc_translate(location: GLint, mvm: matrix4_vt(GLfloat), x: GLfloat, y: GLfloat, z: GLfloat): matrix4_vt(GLfloat)
fun glc_rotate(location : GLint, mvm: matrix4_vt(GLfloat), angle: GLfloat, axis: vector3_vt(GLfloat)): matrix4_vt(GLfloat)
fun glc_rotate_x(location: GLint, mvm: matrix4_vt(GLfloat), angle: GLfloat): matrix4_vt(GLfloat)
fun glc_rotate_y(location: GLint, mvm: matrix4_vt(GLfloat), angle: GLfloat): matrix4_vt(GLfloat)
fun glc_rotate_z(location: GLint, mvm: matrix4_vt(GLfloat), angle: GLfloat): matrix4_vt(GLfloat)
fun glc_scale(location: GLint, mvm: matrix4_vt(GLfloat), axis: vector3_vt(GLfloat)): matrix4_vt(GLfloat)

fun glc_normal_matrix(mvm: matrix4_vt(GLfloat)): matrix4_vt(GLfloat)
