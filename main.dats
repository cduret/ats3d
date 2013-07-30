staload "prelude/SATS/array.sats"
staload "contrib/GL/SATS/gl.sats"
staload "contrib/GLEXT/SATS/glext.sats"
staload "contrib/GLFW/SATS/glfw.sats"
staload "gl/SATS/matrix.sats"
staload "gl/SATS/core.sats"
staload "gl/SATS/engine.sats"
staload "util/SATS/scene_zipper.sats"

staload "util/SATS/number.sats"
#include "util/HATS/number.hats"
#include "gl/HATS/number.hats"

staload _(*anonymous*)="prelude/DATS/array.dats"
staload _(*anonymous*) = "gl/DATS/matrix.dats"
staload _(*anonymous*) = "gl/DATS/core.dats"
staload _(*anonymous*) = "gl/DATS/engine.dats"
staload _(*anonymous*) = "util/DATS/scene_zipper.dats"

// new
dataviewtype world_vt =
  | GlData of (gl_context_data_vt, scene_zipper_vt, scene_gl_vt) // (ctxt, loc, scene)
  | DataSet of (string, string) // (name, mode)


macdef T (x) = GLfloat_of_float ,(x)

// maybe/error monad
datatype
maybe_error (a:t@ype+,b:t@ype+) =
  | Error (a, b) of (b) | Just (a, b) of (a)

typedef cloref_maybee_1 (a:t@ype, b: t@ype) = a -<cloref1> maybe_error(a,b)

fun{a,b:t@ype}
return (value: a): maybe_error(a,b) = Just value

fun{a,b:t@ype}
bind (v: maybe_error(a,b), f: cloref_maybee_1(a, b)): maybe_error(a,b) =
  case+ v of
  | Error (_) => v
  | Just (x) => f x

// int, string maybe_error instance
infixl (+) >>=

fun 
>>= (c: maybe_error(int, string), mf: cloref_maybee_1(int,string)): maybe_error(int,string) =
  bind<int,string>(c, mf)

implement bool_of_int(x: int) =
  if x = 0 then false else true

fn setup_glfw(): int = let
  fn glfw_init(): maybe_error(int, string) = let
    val v = glfwInit()
  in
    if ( v = 0 ) then
      Error "Failed to initialize GLFW"
    else Just v
  end
  val glfw_openw_m: cloref_maybee_1(int, string) = lambda where {
    val lambda = lam (c:int): maybe_error(int, string) =<cloref1> let
      val v = glfwOpenWindow(640, 480, 0,0,0,0,0,0,GLFW_WINDOW)
    in
      if ( v = 0 ) then let val () = glfwTerminate() in
        Error("Failed to open GLFW window") end
      else
        Just v
    end
  }
  val setup_opengl_m: cloref_maybee_1(int, string) = lambda where {
    val lambda = lam (c:int): maybe_error(int, string) =<cloref1> let
      val () = glfwSetWindowTitle( "Simple Triangle" )
      val () = glfwEnable( GLFW_STICKY_KEYS )
      val () = glfwSwapInterval( 1 )
      var width: int = 0
      var height: int = 0
      val () = glfwGetWindowSize( &width, &height )
      val () = if ( height <= 0 ) then height := 1
      val () = glViewport (0,0,width,height)
      val () = glClearColor (GLclampf_of_float(0.0f), GLclampf_of_float(0.0f), GLclampf_of_float(0.0f), GLclampf_of_float(0.5f))
      val () = glClearDepth(GLclampd_of_double(1.0))
      val () = glDepthFunc GL_LEQUAL
      val () = glEnable GL_DEPTH_TEST
      val () = glShadeModel GL_SMOOTH
      val () = glHint (GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
    in
      Just 1
    end
  }
in
  case+ (glfw_init() >>= 
         glfw_openw_m >>= 
         setup_opengl_m) of
  | Error (msg) => let val () = prerrf("ERROR [%s]\n", @(msg)) in 0 end
  | _ => 1
end // of setup_glfw

fun gl_main(v_position_attribute: GLuint, f_color_uniform: GLint,
            mv_matrix_uniform: GLint, p_matrix_uniform: GLint,
            projection_matrix: matrix4_t(GLfloat), modelview_matrix: matrix4_t(GLfloat)): void = let
  var !bt = @[GLfloat](T 0.0f,  T 1.0f,  T 0.0f, 
                       T ~1.0f, T ~1.0f, T 0.0f,
                       T 1.0f,  T ~1.0f, T 0.0f)
  val triangle_vertex_position_buffer = new_buf(!bt, 3, size_of_int 3)
  var !bs = @[GLfloat](T 1.0f,  T 1.0f,  T 0.0f,
                       T ~1.0f, T 1.0f,  T 0.0f,
                       T 1.0f,  T ~1.0f, T 0.0f,
                       T ~1.0f, T ~1.0,  T 0.0f)
  val square_vertex_position_buffer = new_buf(!bs, 3, size_of_int 4)
  fn render():<cloref1> void = let
    val () = glClearColor(T 0.0f, T 0.0f, T 0.0f, T 1.0f)
    val () = glClear(GL_COLOR_BUFFER_BIT lor GL_DEPTH_BUFFER_BIT)
    val () = bind_uniform_matrix4(p_matrix_uniform, projection_matrix)

    val () = bind_uniform_float_vec4(f_color_uniform, vec4_create(T 1.0f, T 0.0f, T 0.0f, T 1.0f))
    val () = bind_attribute(triangle_vertex_position_buffer, v_position_attribute)
    val () = bind_uniform_matrix4(mv_matrix_uniform, modelview_matrix)
    val () = draw(GL_TRIANGLES, triangle_vertex_position_buffer)

    val () = bind_uniform_float_vec4(f_color_uniform, vec4_create(T 1.0f, T 1.0f, T 0.0f, T 1.0f))
    val () = bind_attribute(square_vertex_position_buffer, v_position_attribute)
    val () = bind_uniform_matrix4(mv_matrix_uniform, mat4_translate(modelview_matrix, 
                                                                    vec3_create(T 3.0f, T 0.0f, T 0.0f)))
    val () = draw(GL_TRIANGLE_STRIP, square_vertex_position_buffer)

    val () = glfwSwapBuffers()
  in end
  val () = for( ; ;  ) let
    val () = render()
    //val () = glfwPollEvents()
    val () = glfwWaitEvents()
    val () = print("event !?\n")
  in if ( glfwGetKey(GLFW_KEY_ESC) = GLFW_PRESS ||
          ~bool_of_int(glfwGetWindowParam(GLFW_OPENED)) ) then 
    break
  end
in
end

implement main() = let
  macdef D (x) = double_of_float(float_of_GLfloat ,(x))
  fun print_array16{n:nat|n>15} (t: &(@[GLfloat][n])): void = 
    printf("%f, %f, %f, %f\n %f, %f, %f, %f\n %f, %f, %f, %f\n %f, %f, %f, %f\n", 
           @(D t[0], D t[1], D t[2], D t[3],
             D t[4], D t[5], D t[6], D t[7],
             D t[8], D t[9], D t[10], D t[11],
             D t[12], D t[13], D t[14], D t[15]))
  fun print_mat4(m: matrix4_t(GLfloat)): void = let
    val (vbox pf|p) = array_get_view_ptr(m)
  in $effmask_ref(print_array16(!p)) end

  val FRAGMENT_SHADER = "precision mediump float;\n
                           uniform vec4 vertexColor;\n
                           void main() \n
                           { \n
                               gl_FragColor = vertexColor;\n 
                           } \n"
  val VERTEX_SHADER = "attribute vec3 vPosition;\n
                         uniform mat4 uMVMatrix;\n
                         uniform mat4 uPMatrix;\n
                         void main(void) {\n
                           gl_Position = uPMatrix * uMVMatrix * vec4(vPosition, 1.0);\n
                         }"
  val _ = setup_glfw()
  val projection_matrix = mat4_perspective(T 45.0f, T (640.0f / 480.0f), 
                                           T 0.1f, T 100.0f)
  val modelview_matrix1 = mat4_translate(mat4_identity(), 
                            vec3_create(T ~1.5f, T 0.0f, T ~7.0f))
  val o_vshader = compile_vertex_shader(VERTEX_SHADER)
  val o_fshader = compile_fragment_shader(FRAGMENT_SHADER)
in
  if option_is_some(o_vshader) && option_is_some(o_fshader) then let
    val Some u_vertex_shader = o_vshader
    val vertex_shader = GLshader_of_GLuint u_vertex_shader
    val Some u_fragment_shader = o_fshader
    val fragment_shader = GLshader_of_GLuint u_fragment_shader
    val o_program = make_program(vertex_shader, fragment_shader)
  in
    if option_is_some(o_program) then let
      val Some u_program = o_program
      val program: GLprogram = GLprogram_of_GLuint u_program
      val () = glUseProgram program
      val v_position_attribute = setup_attribute(program, "vPosition")
      val f_color_uniform = glGetUniformLocation(program, "vertexColor")
      val mv_matrix_uniform = glGetUniformLocation(program, "uMVMatrix")
      val p_matrix_uniform = glGetUniformLocation(program, "uPMatrix")
      val () = gl_main(v_position_attribute, f_color_uniform,
                       mv_matrix_uniform, p_matrix_uniform, 
                       projection_matrix, modelview_matrix1)
      extern castfn __leak2 (x: GLprogram): void
    in
      __leak2(program)
    end
    else prerrf("ats3d program error. Aborting..\n", @())
  end
  else prerrf("ats3d shader error. Aborting..\n", @())
end
