staload "prelude/SATS/list.sats"

staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "gl/SATS/matrix.sats"

fun check_error(msg: string): void
fun print_shader_log( shader: !GLshader ): void

fun compile_shader(code: string, shader: GLshader): Option GLuint

fun compile_fragment_shader(src: string): Option GLuint // GLuint = GLshader
fun compile_vertex_shader(src: string): Option GLuint

fun make_program(vertex_shader: GLshader, fragment_shader: GLshader): Option GLuint // GLuint = GLprogram
//fun use_program(program: GLprogram): void

typedef glbuffer_t = (GLuint, int, size_t) // buffer, nb_components, num_items

fun new_buf{n:nat}(buffer: &(@[GLfloat][n]), size: int, num_items: size_t): glbuffer_t

fun setup_attribute(program: !GLprogram, attribute: string): GLuint
//fun setup_attributes{n:int}(program: GLprogram, attributes: list(string, n)): void

fun bind_attribute(buffer: glbuffer_t, attribute: GLuint): void

fun draw(type: GLenum, buffer: glbuffer_t): void

fun bind_uniform_int(location: GLint, value: GLint): void
fun bind_uniform_float(location: GLint, value: GLfloat): void

//fun bind_uniform_int_vec2(location: GLint, value: &GLarray2(GLint, 2, 1)): void
//fun bind_uniform_int_vec3(location: GLint, value: &GLarray2(GLint, 3, 1)): void
//fun bind_uniform_int_vec4(location: GLint, value: &GLarray2(GLint, 4, 1)): void
fun bind_uniform_int_vec2(location: GLint, value: vector2_t(GLint)): void
fun bind_uniform_int_vec3(location: GLint, value: vector3_t(GLint)): void
fun bind_uniform_int_vec4(location: GLint, value: vector4_t(GLint)): void

//fun bind_uniform_float_vec2(location: GLint, value: &GLarray2(GLfloat, 2, 1)): void
//fun bind_uniform_float_vec3(location: GLint, value: &GLarray2(GLfloat, 3, 1)): void
//fun bind_uniform_float_vec4(location: GLint, value: &GLarray2(GLfloat, 4, 1)): void
fun bind_uniform_float_vec2(location: GLint, value: vector2_t(GLfloat)): void
fun bind_uniform_float_vec3(location: GLint, value: vector3_t(GLfloat)): void
fun bind_uniform_float_vec4(location: GLint, value: vector4_t(GLfloat)): void

fun bind_uniform_matrix2(location: GLint, value: matrix2_t(GLfloat)): void
fun bind_uniform_matrix3(location: GLint, value: matrix3_t(GLfloat)): void
fun bind_uniform_matrix4(location: GLint, value: matrix4_t(GLfloat)): void

fun perspective(location: GLint, fov: GLfloat, ratio: GLfloat, near: GLfloat, far: GLfloat): matrix4_t(GLfloat)
fun camera(location: GLint, eye: vector3_t(GLfloat), center: vector3_t(GLfloat), up: vector3_t(GLfloat)): matrix4_t(GLfloat)
fun clear_all(r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat): void
fun setup_uniform(program: !GLprogram, uniform: string): GLint

fun new_ibuf{n:nat}(buffer: &(@[GLushort][n]), size: int, num_items: size_t): glbuffer_t
fun bind_index(index_buffer: glbuffer_t): void
fun draw_indices(mode: GLenum, index_buffer: glbuffer_t): void

fun set_matrix(location: GLint, mvm: matrix4_t(GLfloat), mat4: matrix4_t(GLfloat)): matrix4_t(GLfloat)
fun translate(location: GLint, mvm: matrix4_t(GLfloat), x: GLfloat, y: GLfloat, z: GLfloat): matrix4_t(GLfloat)
fun rotate(location : GLint, mvm: matrix4_t(GLfloat), angle: GLfloat, axis: vector3_t(GLfloat)): matrix4_t(GLfloat)
fun rotate_x(location: GLint, mvm: matrix4_t(GLfloat), angle: GLfloat): matrix4_t(GLfloat)
fun rotate_y(location: GLint, mvm: matrix4_t(GLfloat), angle: GLfloat): matrix4_t(GLfloat)
fun rotate_z(location: GLint, mvm: matrix4_t(GLfloat), angle: GLfloat): matrix4_t(GLfloat)
fun scale(location: GLint, mvm: matrix4_t(GLfloat), axis: vector3_t(GLfloat)): matrix4_t(GLfloat)

fun normal_matrix(mvm: matrix4_t(GLfloat)): matrix4_t(GLfloat)
