staload "gl/SATS/core.sats"

#include "share/atspre_staload_tmpdef.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload _ = "libc/DATS/math.dats"

staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "gl/SATS/matrix_vt.sats"

staload _ = "gl/DATS/glnum.dats"
staload _ = "gl/DATS/gl_matrix_vt.dats"



#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

%{^
#include <GL/gl.h>
#include <GL/glext.h>

void
glBufferData_convert (
  atstype_GLenum target, atstype_GLenum type
, atstype_size tsz, atstype_size sz
, atstype_ptr data, atstype_GLenum usage
) {
  glBufferData (target, sz * tsz, (void *)data, usage);
  return;
}

void glVertexAttribPointerBuffer (
  atstype_GLuint indx , atstype_GLsizei size
, atstype_GLenum type , atstype_GLsizei stride
, atstype_GLsizeiptr pos) {
  glVertexAttribPointer (indx, size, type, GL_FALSE, stride, (void *)pos);
  return;
}

void glDrawElementsBuffer (
  atstype_GLenum mode
, atstype_GLsizei count
, atstype_GLenum type
) {
  glDrawElements (mode, count, type, NULL);
  return;
}
%}

extern fun 
glBufferDataConvert {l: addr} {a:t@ype}  (
  target: GLenum, type: GLenum_type a
, tsz: size_t (sizeof a)
, sz: size_t, data: ptr l, usage: GLenum
) : void
  = "glBufferData_convert"

extern fun 
glVertexAttribPointerBuffer {a:t@ype} (
  indx: GLuint , size: GLsizei , type: GLenum_type a , stride: GLsizei , pos: GLsizeiptr) : void
  = "glVertexAttribPointerBuffer"

extern fun 
glDrawElementsBuffer {a:t@ype} (
  mode: GLenum, count: GLsizei, type: GLenum_type a
) : void
  = "glDrawElementsBuffer"

implement glc_check_error(msg) = let
  val v = glGetError()
  val () = (case+ 0 of
    | _ when v = GL_INVALID_ENUM => fprintln! (stderr_ref,$UN.castvwtp1 {string} (msg)," : GL_INVALID_ENUM\n")
    | _ when v = GL_INVALID_VALUE => fprintln! (stderr_ref,$UN.castvwtp1 {string} (msg), " : GL_INVALID_VALUE\n")
    | _ when v = GL_INVALID_OPERATION => fprintln! (stderr_ref,$UN.castvwtp1 {string} (msg), " : GL_INVALID_OPERATION\n")
    | _ when v = GL_OUT_OF_MEMORY => fprintln! (stderr_ref,$UN.castvwtp1 {string} (msg), " : GL_OUT_OF_MEMORY\n")
    | _ => () ): void
in
  strptr_free msg
end

implement glc_print_shader_log(shader) = let
  #define BUFSZ 1024
  val (pf, pfgc| p) = malloc_gc(i2sz BUFSZ)
  var len: GLsizei // uninitialized
  val () = glGetShaderInfoLog(shader, GLsizei_of_int BUFSZ, len, !p)
  val () = fprint_strbuf (stderr_ref, !p);
  val () = fprint! (stderr_ref, "\n")
  prval () = pf := strbuf2bytes_v (pf)
in
  mfree_gc(pf, pfgc| p)
end

implement glc_compile_shader(code, shader) = let
    val () = glShaderSource__string(shader, code)
    val () = glCompileShader(shader)
    var shader_ok: GLint
    val () = glGetShaderiv(shader, GL_COMPILE_STATUS, shader_ok)
    val () = strptr_free code
  in
    if int_of_GLint(shader_ok) = 0 then let
      val () = glc_print_shader_log(shader)
      val () = glDeleteShader(shader)
    in None_vt{GLuint}
    end else Some_vt{GLuint}(GLuint_of_GLshader shader)//success
  end

implement glc_compile_fragment_shader(src) =  let val sh = glCreateShader(GL_FRAGMENT_SHADER)
in
  glc_compile_shader(src, sh)
end

implement glc_compile_vertex_shader(src) =  glc_compile_shader(src, glCreateShader(GL_VERTEX_SHADER))

implement glc_make_program(vertex_shader, fragment_shader) = let
  val program = glCreateProgram()
  val () = glAttachShader(program, vertex_shader )
  val () = glAttachShader(program, fragment_shader )
  val () = glLinkProgram(program)
  var program_ok: GLint
  val () = glGetProgramiv(program, GL_LINK_STATUS, program_ok)
  extern castfn __leak1 (x: GLshader): void
  val () = __leak1(vertex_shader)
  val () = __leak1(fragment_shader)
in
  if int_of_GLint program_ok = 0 then let
    val () = prerr("Failed to link shader program\n")
    val () = glDeleteProgram(program)
  in None_vt{GLuint} end // program ends here !
  else Some_vt{GLuint}(GLuint_of_GLprogram(program))
end

implement glc_new_buf(buffer, size, num_items) = let
  var vertex_buffer: GLbuffer
  val () = glGenBuffer vertex_buffer
  val () = glBindBuffer(GL_ARRAY_BUFFER, vertex_buffer)
  val () = glBufferDataConvert(GL_ARRAY_BUFFER, GL_FLOAT, sizeof<GLfloat>, 
                               g0int2uint_int_size(size) * num_items, arrayptr2ptr{GLfloat} buffer, GL_STATIC_DRAW)
  val () = glc_check_error(string0_copy("new_buf"))
  val () = arrayptr_free{GLfloat} buffer
 in @(GLuint_of_GLbuffer vertex_buffer, size, num_items) end 

implement glc_setup_attribute(program, attribute) = let
  val position = GLuint_of_uint(g0int2uint_int_uint(int_of_GLint(
                           glGetAttribLocation(program, $UN.castvwtp1 {string} (attribute)))))
  val () = glEnableVertexAttribArray(position)
in position end

implement glc_bind_attribute(buffer, attribute) = let
  val vbuf = GLbuffer_of_GLuint(buffer.0)
  val () = glBindBuffer(GL_ARRAY_BUFFER, vbuf)
  extern castfn __leak3 (x: GLbuffer): void
  val () = __leak3(vbuf)
in
  glVertexAttribPointerBuffer(attribute, GLsizei_of_int buffer.1, GL_FLOAT, GLsizei_of_int 0, GLsizeiptr_of_int1 0)
end

implement glc_draw(type, buffer) = glDrawArrays(type, GLint_of_int 0, GLsizei_of_size buffer.2)

implement glc_bind_uniform_int(location, value) = glUniform1i(location, value)
implement glc_bind_uniform_float(location, value) = glUniform1f(location, value)

implement glc_bind_uniform_int_vec2(location, value) = let
  val p = vec2_vt_ptr(value)
in $effmask_ref(glUniform2iv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_int_vec3(location, value) = let
  val p = vec3_vt_ptr(value)
in $effmask_ref(glUniform3iv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_int_vec4(location, value) = let
  val p = vec4_vt_ptr(value)
in $effmask_ref(glUniform4iv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_float_vec2(location, value) = let
  val p = vec2_vt_ptr(value)
in $effmask_ref(glUniform2fv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_float_vec3(location, value) = let
  val p = vec3_vt_ptr(value)
in $effmask_ref(glUniform3fv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_float_vec4(location, value) = let
  val p = vec4_vt_ptr(value)
in $effmask_ref(glUniform4fv(location, GLsizei_of_int1 1, p)) end

implement glc_bind_uniform_matrix2(location, value) = let
  val p = mat2_vt_ptr(value)
in $effmask_ref(glUniformMatrix2fv(location, GLsizei_of_int1 1, GL_FALSE, p)) end

implement glc_bind_uniform_matrix3(location, value) = let
  val p = mat3_vt_ptr(value)
in $effmask_ref(glUniformMatrix3fv(location, GLsizei_of_int1 1, GL_FALSE, p)) end

implement glc_bind_uniform_matrix4(location, value) = let
  val p = mat4_vt_ptr(value)
in $effmask_ref(glUniformMatrix4fv(location, GLsizei_of_int1 1, GL_FALSE, p)) end

implement glc_perspective(location, fov, ratio, near, far) = let
  val pm = mat4_vt_perspective<GLfloat>(fov, ratio, near, far)
  val () = glc_bind_uniform_matrix4(location, pm)
in pm end

implement glc_camera(location, eye, center, up) = let
  val mvm = mat4_vt_lookat<GLfloat>(eye, center, up)
  val () = glc_bind_uniform_matrix4(location, mvm)
in mvm end

implement glc_clear_all(r, g, b, a) = let
  val () = glClearColor(r, g, b, a)
  val () = glClearDepth(GLclampd_of_double 1.0)
  val () = glEnable(GL_DEPTH_TEST)
  val () = glDepthFunc(GL_LEQUAL)
  val () = glClear(GL_COLOR_BUFFER_BIT lor GL_DEPTH_BUFFER_BIT)
in end

implement glc_setup_uniform(program, uniform) = glGetUniformLocation(program, $UN.castvwtp1 {string} (uniform))

implement glc_new_ibuf(buffer, size, num_items) = let
  var index_buffer: GLbuffer
  val () = glGenBuffer index_buffer
  val () = glBindBuffer(GL_ARRAY_BUFFER, index_buffer)
  val () = glBufferDataConvert(GL_ARRAY_BUFFER, GL_UNSIGNED_SHORT, sizeof<GLushort>, 
                               g0int2uint_int_size(size) * num_items, arrayptr2ptr{GLushort} buffer, GL_STATIC_DRAW)
  val () = glc_check_error(string0_copy("new_ibuf"))
  val () = arrayptr_free{GLushort} buffer
 in @(GLuint_of_GLbuffer index_buffer, size, num_items) end

implement glc_bind_index(index_buffer) = let
  val ibuf = GLbuffer_of_GLuint(index_buffer.0)
  val () = glBindBuffer(GL_ARRAY_BUFFER, ibuf)
  extern castfn __leak3 (x: GLbuffer): void
in __leak3(ibuf) end

implement glc_draw_indices(mode, index_buffer) = 
    glDrawElementsBuffer(mode, GLsizei_of_size index_buffer.2, GL_UNSIGNED_SHORT)

implement glc_set_matrix(location, mvm, mat4) = let
  val new_mvm = mat4_vt_multiply(mvm, mat4)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_translate(location, mvm, x, y, z) = let
  val new_mvm = mat4_vt_translate(mvm, vec3_vt_create(x, y, z))
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_rotate(location, mvm, angle, axis) = let
  val new_mvm = mat4_vt_rotate<GLfloat, GLfloat>(mvm, angle, axis)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_rotate_x(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_vt_create(GLfloat_of_float 1.0f, 
                                                  GLfloat_of_float 0.0f, 
                                                  GLfloat_of_float 0.0f))

implement glc_rotate_y(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_vt_create(GLfloat_of_float 0.0f, 
                                                  GLfloat_of_float 1.0f, 
                                                  GLfloat_of_float 0.0f))

implement glc_rotate_z(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_vt_create(GLfloat_of_float 0.0f, 
                                                  GLfloat_of_float 0.0f, 
                                                  GLfloat_of_float 1.0f))

implement glc_scale(location, mvm, axis) = let
  val new_mvm = mat4_vt_scale(mvm, axis)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_normal_matrix(mvm) = mat4_vt_transpose<GLfloat> inv where {
  val inv = mat4_vt_inverse<GLfloat,GLfloat>(mvm)
}
