#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "prelude/SATS/string.sats"
staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "util/SATS/array_ptr.sats"
staload "gl/SATS/core.sats"
staload "gl/SATS/matrix.sats"

staload UN = "prelude/SATS/unsafe.sats"

staload _(*anon*)="prelude/DATS/array.dats"
staload _(*anon*) = "util/DATS/array_ptr.dats"
staload _(*anon*) = "gl/DATS/matrix.dats"

staload "util/SATS/number.sats"
#include "gl/HATS/number.hats"

%{^
#include <GL/gl.h>
#include <GL/glext.h>

void
glBufferData_convert (
  ats_GLenum_type target, ats_GLenum_type type
, ats_size_type tsz, ats_size_type sz
, ats_ptr_type data, ats_GLenum_type usage
) {
  glBufferData (target, sz * tsz, (void *)data, usage);
  return;
} // end of [glBufferData_convert]

void glVertexAttribPointerBuffer (
  ats_GLuint_type indx , ats_GLsizei_type size
, ats_GLenum_type type , ats_GLsizei_type stride
, ats_GLsizeiptr_type pos) {
  glVertexAttribPointer (indx, size, type, GL_FALSE, stride, (void *)pos);
  return;
} // end of [glVertexAttribPointerBuffer]

void glDrawElementsBuffer (
  ats_GLenum_type mode
, ats_GLsizei_type count
, ats_GLenum_type type
) {
  glDrawElements (mode, count, type, NULL);
  return;
} // end of [glDrawElementsBuffer]
%}

extern fun 
glVertexAttribPointerBuffer {a:t@ype} (
  indx: GLuint , size: GLsizei , type: GLenum_type a , stride: GLsizei , pos: GLsizeiptr) : void
  = "glVertexAttribPointerBuffer"
// end of [glVertexAttribPointerBuffer]

extern fun 
glBufferDataConvert {l: addr} {a:t@ype}  (
  target: GLenum, type: GLenum_type a
, tsz: size_t (sizeof a)
, sz: size_t, data: ptr l, usage: GLenum
) : void
  = "glBufferData_convert"
// end of [fun]

extern
fun glDrawElementsBuffer {a:t@ype} (
  mode: GLenum, count: GLsizei, type: GLenum_type a
) : void
  = "glDrawElementsBuffer"
// end of [glDrawElementsBuffer]

implement glc_check_error(msg) = let
  val v = glGetError()
  val () = case+ 0 of
    | _ when v = GL_INVALID_ENUM => prerrf("%s : GL_INVALID_ENUM\n", @($UN.castvwtp1 {string} (msg)))
    | _ when v = GL_INVALID_VALUE => prerrf("%s : GL_INVALID_VALUE\n", @($UN.castvwtp1 {string} (msg)))
    | _ when v = GL_INVALID_OPERATION => prerrf("%s : GL_INVALID_OPERATION\n", @($UN.castvwtp1 {string} (msg)))
    | _ when v = GL_OUT_OF_MEMORY => prerrf("%s : GL_OUT_OF_MEMORY\n", @($UN.castvwtp1 {string} (msg)))
    | _ => ()
in
  strptr_free msg
end

implement glc_print_shader_log(shader) = let
  #define BUFSZ 1024
  var !p_log with pf_log = @[byte][BUFSZ]()
  var len: GLsizei // uninitialized
  prval pf_len = Some_v (view@ (len))
  val () = glGetShaderInfoLog(pf_log, pf_len |shader, GLsizei_of_int BUFSZ, &len, p_log)
  prval Some_v pf = pf_len; prval () = view@ (len) := pf 
  val () = fprint_strbuf (stderr_ref, !p_log);
  val () = prerrf("\n", @())
  prval () = pf_log := bytes_v_of_strbuf_v (pf_log)
in
end

implement glc_compile_shader(code, shader) = let
    val () = glShaderSource__string(shader, code)
    val () = glCompileShader(shader)
    var shader_ok: GLint
    val () = glGetShaderiv(shader, GL_COMPILE_STATUS, shader_ok)
    val () = strptr_free code
  in
    if int_of_GLint shader_ok = 0 then let
      val () = glc_print_shader_log(shader)
      val () = glDeleteShader(shader)
    in None
    end else Some(GLuint_of_GLshader shader)//success
  end

implement glc_compile_fragment_shader(src) =  glc_compile_shader(src, glCreateShader(GL_FRAGMENT_SHADER))
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
    val () = prerrf("Failed to link shader program\n", @())
    val () = glDeleteProgram(program)
  in None (* program ends here ! *) end
  else Some(GLuint_of_GLprogram(program))
end

(*
implement glc_use_program(program) = let 
  val () = glUseProgram(program)
  extern castfn __leak3 (x: GLprogram): void
in __leak3(program) end
*)

implement glc_new_buf(buffer, size, num_items) = let
  var vertex_buffer: GLbuffer
  val () = glGenBuffer vertex_buffer
  val () = glBindBuffer(GL_ARRAY_BUFFER, vertex_buffer)
  val () = glBufferDataConvert(GL_ARRAY_BUFFER, GL_FLOAT, sizeof<GLfloat>, 
                               size*num_items, array_ptr_data<GLfloat> buffer, GL_STATIC_DRAW)
  val () = glc_check_error(sprintf("new_buf", @()))
  val () = array_ptr_delete<GLfloat> buffer
 in @(GLuint_of_GLbuffer vertex_buffer, size, num_items) end 

implement glc_setup_attribute(program, attribute) = let
  val position = GLuint_of_uint(uint_of_int(int_of_GLint(
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

implement glc_draw(type, buffer) =
glDrawArrays(type, GLint_of_int 0, GLsizei_of_size buffer.2)

implement glc_bind_uniform_int(location, value) = glUniform1i(location, value)
implement glc_bind_uniform_float(location, value) = glUniform1f(location, value)

implement glc_bind_uniform_int_vec2(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform2iv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_int_vec3(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform3iv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_int_vec4(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform4iv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_float_vec2(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform2fv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_float_vec3(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform3fv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_float_vec4(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniform4fv(location, GLsizei_of_int1 1, !p))
end

implement glc_bind_uniform_matrix2(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniformMatrix2fv(location, GLsizei_of_int1 1, GL_FALSE, !p))
end

implement glc_bind_uniform_matrix3(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniformMatrix3fv(location, GLsizei_of_int1 1, GL_FALSE, !p))
end

implement glc_bind_uniform_matrix4(location, value) = let
  val (vbox pf|p) = array_get_view_ptr(value)
in
  $effmask_ref(glUniformMatrix4fv(location, GLsizei_of_int1 1, GL_FALSE, !p))
end

implement glc_perspective(location, fov, ratio, near, far) = let
  val pm = mat4_perspective<GLfloat>(fov, ratio, near, far)
  val () = glc_bind_uniform_matrix4(location, pm)
in pm end

implement glc_camera(location, eye, center, up) = let
  val mvm = mat4_lookat<GLfloat>(eye, center, up)
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
                               size*num_items, array_ptr_data<GLushort> buffer, GL_STATIC_DRAW)
  val () = glc_check_error(sprintf("new_buf", @()))
  val () = array_ptr_delete<GLushort> buffer
 in @(GLuint_of_GLbuffer index_buffer, size, num_items) end 

implement glc_bind_index(index_buffer) = let
  val ibuf = GLbuffer_of_GLuint(index_buffer.0)
  val () = glBindBuffer(GL_ARRAY_BUFFER, ibuf)
  extern castfn __leak3 (x: GLbuffer): void
in __leak3(ibuf) end

implement glc_draw_indices(mode, index_buffer) = 
    glDrawElementsBuffer(mode, GLsizei_of_size index_buffer.2, GL_UNSIGNED_SHORT)

implement glc_set_matrix(location, mvm, mat4) = let
  val new_mvm = mat4_multiply(mvm, mat4)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_translate(location, mvm, x, y, z) = let
  val new_mvm = mat4_translate(mvm, vec3_create(x, y, z))
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_rotate(location, mvm, angle, axis) = let
  val new_mvm = mat4_rotate(mvm, angle, axis)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_rotate_x(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_create(GLfloat_of_float 1.0f, 
                                           GLfloat_of_float 0.0f, 
                                           GLfloat_of_float 0.0f))

implement glc_rotate_y(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_create(GLfloat_of_float 0.0f, 
                                           GLfloat_of_float 1.0f, 
                                           GLfloat_of_float 0.0f))

implement glc_rotate_z(location, mvm, angle) =
  glc_rotate(location, mvm, angle, vec3_create(GLfloat_of_float 0.0f, 
                                           GLfloat_of_float 0.0f, 
                                           GLfloat_of_float 1.0f))

implement glc_scale(location, mvm, axis) = let
  val new_mvm = mat4_scale(mvm, axis)
  val () = glc_bind_uniform_matrix4(location, new_mvm)
in new_mvm end

implement glc_normal_matrix(mvm) = 
  mat4_transpose(mat4_inverse mvm)
