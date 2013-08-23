// first prototype should be : /home/cydu/programming/scheme/modules/test/simple-engine2

#include "share/atspre_staload_tmpdef.hats"

staload UN = "prelude/SATS/unsafe.sats"

staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "contrib/GLFW/SATS/glfw.sats"

staload "gl/SATS/matrix_vt.sats"
staload "gl/SATS/core.sats"

staload _ = "libc/DATS/math.dats"
staload _ = "gl/DATS/glnum.dats"
staload _ = "gl/DATS/gl_matrix_vt.dats"
staload _ = "gl/DATS/core.dats"

macdef F (x) = GLfloat_of_float ,(x)
macdef I (x) = GLint_of_int ,(x)
macdef SZ (x) = GLsizei_of_int ,(x)

dataviewtype
maybe_error_vt (a:t@ype+,b:t@ype+) =
  | Error (a, b) of (b) | Just (a, b) of (a)

viewtypedef cloptr_maybee_1 (a:t@ype, b: t@ype) = a -<cloptr1> maybe_error_vt(a,b)

extern fun{a,b:t@ype}
return (value: a): maybe_error_vt(a,b)

extern fun{a,b:t@ype}
bind (v: maybe_error_vt(a,b), f: cloptr_maybee_1(a,b)): maybe_error_vt(a,b)

extern fun
bind_int_string (v: maybe_error_vt(int,string), f: cloptr_maybee_1(int,string)): maybe_error_vt(int,string)

symintr >>=
infixl (+) >>=
overload >>= with bind_int_string

extern fun
bool_of_int(x: int): bool

implement{a,b} return (value) = Just{a,b} value

implement{a,b} bind (v, f) = case+ v of
  | ~Error (w) => Error{a,b} w where {
    val () = cloptr_free($UN.castvwtp0{cloptr0}(f))
  }
  | ~Just (x) => r where {
    val r = f x
    val () = cloptr_free($UN.castvwtp0{cloptr0}(f))
  }

implement bind_int_string(v, f) = bind<int, string>(v, f)

implement bool_of_int(x: int) =
  if x = 0 then false else true

extern fun setup_glfw(): int
extern fun gl_main(v_position_attribute: GLuint, f_color_uniform: GLint,
                   mv_matrix_uniform: GLint, p_matrix_uniform: GLint,
                   projection_matrix: matrix4_vt(GLfloat), modelview_matrix: matrix4_vt(GLfloat)): int

implement setup_glfw() = let
  fn glfw_init(): maybe_error_vt(int, string) = let
    val v = glfwInit()
  in
    if ( v = 0 ) then
      Error{int,string} "Failed to initialize GLFW"
    else Just{int,string} v
  end
  val glfw_openw_m: cloptr_maybee_1(int, string) = lambda where {
    val lambda = lam (c:int): maybe_error_vt(int, string) =<cloptr1> let
      val v = glfwOpenWindow(640, 480, 0,0,0,0,0,0,GLFW_WINDOW)
    in
      if ( v = 0 ) then let val () = glfwTerminate() in
        Error{int,string} ("Failed to open GLFW window") end
      else
        Just{int,string} v
    end
  }
  val setup_opengl_m: cloptr_maybee_1(int, string) = lambda where {
    val lambda = lam (c:int): maybe_error_vt(int, string) =<cloptr1> let
      val () = glfwSetWindowTitle( "Simple Triangle" )
      val () = glfwEnable( GLFW_STICKY_KEYS )
      val () = glfwSwapInterval( 1 )
      var width: int = 0
      var height: int = 0
      val () = glfwGetWindowSize( addr@(width), addr@(height) )
      val () = if ( height <= 0 ) then height := 1
      val () = glViewport (I 0, I 0, SZ width, SZ height)
      val () = glClearColor (GLclampf_of_float(0.0f), GLclampf_of_float(0.0f), GLclampf_of_float(0.0f), GLclampf_of_float(0.5f))
      val () = glClearDepth(GLclampd_of_double(1.0))
      val () = glDepthFunc GL_LEQUAL
      val () = glEnable GL_DEPTH_TEST
      val () = glShadeModel GL_SMOOTH
      val () = glHint (GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
    in
      Just{int,string} 1
    end
  }
in 
  case+ (glfw_init() >>= 
         glfw_openw_m >>= 
         setup_opengl_m) of
  | ~Error (msg) => let val () = prerrln! ("ERROR ", msg: string) in 0 end
  | ~Just (_) => 1
end // of setup_glfw

implement gl_main(v_position_attribute, f_color_uniform,
            mv_matrix_uniform, p_matrix_uniform,
            projection_matrix, modelview_matrix) = let
  var bt = arrayptr $arrpsz{GLfloat}(F 0.0f,  F 1.0f,  F 0.0f,
                                     F ~1.0f, F ~1.0f, F 0.0f,
                                     F 1.0f,  F ~1.0f, F 0.0f)
  val triangle_vertex_position_buffer = glc_new_buf(bt, 3, i2sz 3)
  var bs = arrayptr $arrpsz{GLfloat}(F 1.0f,  F 1.0f,  F 0.0f,
                                     F ~1.0f, F 1.0f,  F 0.0f,
                                     F 1.0f,  F ~1.0f, F 0.0f,
                                     F ~1.0f, F ~1.0f,  F 0.0f)
  val square_vertex_position_buffer = glc_new_buf(bs, 3, i2sz 4)

  val vec4_red = vec4_vt_create<GLfloat>(F 1.0f, F 0.0f, F 0.0f, F 1.0f)

  val modelview_matrix' = mat4_vt_translate(mat4_vt_copy<GLfloat>(modelview_matrix), 
                                              vec3_vt_create<GLfloat>(F 3.0f, F 0.0f, F 0.0f))
  val vec4_yellow = vec4_vt_create<GLfloat>(F 1.0f, F 1.0f, F 0.0f, F 1.0f)
  fn render(mvm1: !matrix4_vt(GLfloat), col1: !vector4_vt(GLfloat), 
            mvm2: !matrix4_vt(GLfloat), col2: !vector4_vt(GLfloat),
            pm:   !matrix4_vt(GLfloat)):<cloptr1> void = let
    val () = glClearColor(F 0.0f, F 0.0f, F 0.0f, F 1.0f)
    val () = glClear(GL_COLOR_BUFFER_BIT lor GL_DEPTH_BUFFER_BIT)
    val () = glc_bind_uniform_matrix4(p_matrix_uniform, pm)

    val () = glc_bind_uniform_float_vec4(f_color_uniform, col1)
    val () = glc_bind_attribute(triangle_vertex_position_buffer, v_position_attribute)
    val () = glc_bind_uniform_matrix4(mv_matrix_uniform, mvm1)
    val () = glc_draw(GL_TRIANGLES, triangle_vertex_position_buffer)

    val () = glc_bind_uniform_float_vec4(f_color_uniform, col2)
    val () = glc_bind_attribute(square_vertex_position_buffer, v_position_attribute)
    val () = glc_bind_uniform_matrix4(mv_matrix_uniform, mvm2)
    val () = glc_draw(GL_TRIANGLE_STRIP, square_vertex_position_buffer)

    val () = glfwSwapBuffers()
  in end
  val () = for( ; ;  ) let
    val () = render(modelview_matrix, vec4_red, 
                    modelview_matrix', vec4_yellow, 
                    projection_matrix)
    val () = glfwWaitEvents()
    val () = print("event !?\n")
  in if ( glfwGetKey(GLFW_KEY_ESC) = GLFW_PRESS ||
          ~bool_of_int(glfwGetWindowParam(GLFW_OPENED)) ) then 
    $break
  end
  val () = glfwTerminate()
  val () = vec4_vt_free<GLfloat> vec4_red
  val () = vec4_vt_free<GLfloat> vec4_yellow
  val () = mat4_vt_free<GLfloat> projection_matrix
  val () = mat4_vt_free<GLfloat> modelview_matrix
  val () = mat4_vt_free<GLfloat> modelview_matrix'
  val () = cloptr_free($UN.castvwtp0{cloptr0}(render)) 
in 1 end

implement main0 () = let
  macdef D (x) = g0float2float_float_double(float_of_GLfloat ,(x))

  val FRAGMENT_SHADER = string0_copy("precision mediump float;\n
                           uniform vec4 vertexColor;\n
                           void main() \n
                           { \n
                               gl_FragColor = vertexColor;\n 
                           } \n")
  val VERTEX_SHADER = string0_copy("attribute vec3 vPosition;\n
                         uniform mat4 uMVMatrix;\n
                         uniform mat4 uPMatrix;\n
                         void main(void) {\n
                           gl_Position = uPMatrix * uMVMatrix * vec4(vPosition, 1.0);\n
                         }")
in
  if setup_glfw() = 1 then let
    val projection_matrix = mat4_vt_perspective<GLfloat>(F 45.0f, F (640.0f / 480.0f), 
                                                         F 0.1f, F 100.0f)
    val modelview_matrix = mat4_vt_translate(mat4_vt_identity<GLfloat>(), 
                              vec3_vt_create<GLfloat>(F ~1.5f, F 0.0f, F ~7.0f))
    val o_vshader = glc_compile_vertex_shader(VERTEX_SHADER)
    val o_fshader = glc_compile_fragment_shader(FRAGMENT_SHADER)
  in
    if option_vt_is_some(o_vshader) && option_vt_is_some(o_fshader) then let
      val ~Some_vt u_vertex_shader = o_vshader
      val vertex_shader = GLshader_of_GLuint u_vertex_shader
      val ~Some_vt u_fragment_shader = o_fshader
      val fragment_shader = GLshader_of_GLuint u_fragment_shader
      val o_program = glc_make_program(vertex_shader, fragment_shader)
    in
      if option_vt_is_some(o_program) then let
        val ~Some_vt u_program = o_program
        val program: GLprogram = GLprogram_of_GLuint u_program
        val () = glUseProgram program
        val position = string0_copy("vPosition")
        val v_position_attribute = glc_setup_attribute(program, position)
        val () = strptr_free position
        val f_color_uniform = glGetUniformLocation(program, "vertexColor")
        val mv_matrix_uniform = glGetUniformLocation(program, "uMVMatrix")
        val p_matrix_uniform = glGetUniformLocation(program, "uPMatrix")
        val _ = gl_main(v_position_attribute, f_color_uniform,
                         mv_matrix_uniform, p_matrix_uniform, 
                         projection_matrix, modelview_matrix)
        extern castfn __leak2 (x: GLprogram):<> void
      in
        __leak2(program)
      end
      else prerrln! ("ats3d program error. Aborting..\n") where {
        val () = option_vt_free<GLuint> o_program
      val () = mat4_vt_free<GLfloat> projection_matrix
        val () = mat4_vt_free<GLfloat> modelview_matrix
      }
    end
    else prerrln! ("ats3d shader error. Aborting..\n") where {
      val () = option_vt_free<GLuint> o_vshader
      val () = option_vt_free<GLuint> o_fshader
      val () = mat4_vt_free<GLfloat> projection_matrix
      val () = mat4_vt_free<GLfloat> modelview_matrix
    }
  end
  else () where {
    val () = strptr_free VERTEX_SHADER
    val () = strptr_free FRAGMENT_SHADER
  }
end
