#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "gl/SATS/engine.sats"

staload "util/SATS/array_ptr.sats"
staload "contrib/GL/SATS/gl.sats"
staload "gl/SATS/core.sats"
staload "gl/SATS/matrix_vt.sats"
staload "contrib/GLEXT/SATS/glext.sats"

staload _(*anonymous*)="prelude/DATS/list_vt.dats"
staload _(*anonymous*)="util/DATS/array_ptr.dats"
staload _(*anonymous*)="gl/DATS/matrix_vt.dats"

implement ats3d_scene_free(scene) = case+ scene of
  | ~Fail (msg) => strptr_free(msg)
  | ~Perspective (uniform, _, _, _, _) => strptr_free uniform
  | ~Viewpoint (uniform, view) => ()  where {
    val () = strptr_free uniform
    val () = vec3_vt_delete view
  }
  | ~Geometry (id, scene, _, kind) => () where {
    val () = strptr_free id
    val () = ats3d_scene_free scene
    val () = strptr_free kind
  }
  | ~Transform (matrix, scene) => () where {
    val () = ats3d_scene_free scene
    val () = mat4_vt_delete matrix
  }
  | ~Scale (scale, scene) => () where {
    val () = ats3d_scene_free scene
    val () = vec3_vt_delete scale
  }
  | ~Translate (translate, scene) => () where {
    val () = ats3d_scene_free scene
    val () = vec3_vt_delete translate
  }
  | ~Rotate (rotate, scene) => () where {
    val () = ats3d_scene_free scene
    val () = vec3_vt_delete rotate
  }
  | ~Group (scenes) => list_vt_free_fun<scene_vt>(scenes, lam (scene) => $effmask_all(ats3d_scene_free scene))
  | ~Shape (appearance, scene) => () where {
    val () = ats3d_appearance_free appearance
    val () = ats3d_scene_free scene
  }
  | ~Lines (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~LineLoop (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~LineStrip (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Points (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Triangles (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~TriangleStrip (vertices, _, ref, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Buffer (vertices, _, attribute) => () where {
    val () = array_ptr_delete vertices
    val () = strptr_free attribute
  }

implement ats3d_appearance_free(appearance) = case+ appearance of
  | ~Shader (id, vertex_src, fragment_src, attributes, uniforms) => () where {
    val () = strptr_free id
    val () = strptr_free vertex_src
    val () = strptr_free fragment_src
    val () = list_vt_free_fun<strptr1>(attributes, lam (attribute) => $effmask_all(strptr_free attribute))
    val () = list_vt_free_fun<strptr1>(uniforms, lam (uniform) => $effmask_all(strptr_free uniform))
  }
  | ~ShaderMaterial (uniforms) => list_vt_free_fun<uniform_data_vt>(uniforms, lam (uniform) => $effmask_all(ats3d_uniform_data_free uniform))

implement ats3d_scene_gl_free(scene) = case+ scene of
  | ~FailGL (msg) => strptr_free msg
  | ~PerspectiveGL (_, _, _, _, _) => ()
  | ~ViewpointGL (_, view) => vec3_vt_delete view
  | ~GeometryGL (id, scene, _, kind) => () where {
    val () = strptr_free id
    val () = ats3d_scene_gl_free scene
    val () = strptr_free kind
  }
  | ~TransformGL (_, matrix, scene) => () where {
    val () = ats3d_scene_gl_free scene
    val () = mat4_vt_delete matrix
  }
  | ~ScaleGL (_, scale, scene) => () where {
    val () = ats3d_scene_gl_free scene
    val () = vec3_vt_delete scale
  }
  | ~TranslateGL (_, translate, scene) => () where {
    val () = ats3d_scene_gl_free scene
    val () = vec3_vt_delete translate
  }
  | ~RotateGL (_, rotate, scene) => () where {
    val () = ats3d_scene_gl_free scene
    val () = vec3_vt_delete rotate
  }
  | ~GroupGL (scenes) => list_vt_free_fun<scene_gl_vt>(scenes, lam (scene) => $effmask_all(ats3d_scene_gl_free scene))
  | ~ShapeGL (appearance, scene) => let
    val () = ats3d_appearance_gl_free appearance
    val () = ats3d_scene_gl_free scene
    in end
  | ~LinesGL (_, ref_id, _, _) => strptr_free ref_id
  | ~LineLoopGL (_, ref_id, _, _) => strptr_free ref_id
  | ~LineStripGL (_, ref_id, _, _) => strptr_free ref_id
  | ~PointsGL (_, ref_id, _, _) => strptr_free ref_id
  | ~TrianglesGL (_, ref_id, _, _) => strptr_free ref_id
  | ~TriangleStripGL (_, ref_id, _, _) => strptr_free ref_id
  | ~BufferGL (_, _) => ()

implement ats3d_appearance_gl_free(appearance) = case+ appearance of
  | ~ShaderGL (id, pgm, attributes, uniforms, _, _) => () where {
    val () = strptr_free id
    val () = glDeleteProgram pgm
    val () = list_vt_free_fun<strptr1>(attributes, lam (attribute) => $effmask_all(strptr_free attribute))
    val () = list_vt_free_fun<strptr1>(uniforms, lam (uniform) => $effmask_all(strptr_free uniform))
  }
  | ~ShaderMaterialGL (uniforms) => list_vt_free_fun<uniform_data_gl_vt>(uniforms, lam (uniform) => $effmask_all(ats3d_uniform_data_gl_free uniform))
  | ~ActivatedShaderGL (parent, attributes_h, _, uniforms_h) => ___leak(parent) where {
    extern castfn ___leak(s: appearance_gl_vt):<> void
    val () = list_vt_free<GLuint>(attributes_h)
    val () = list_vt_free<GLint>(uniforms_h)
  }

implement ats3d_uniform_data_free(uniform) = case+ uniform of
   ~UniformInt (name, _) => strptr_free name
  | ~UniformBool (name, _) => strptr_free name
  | ~UniformFloat (name, _) => strptr_free name
  | ~UniformIntVec3 (name, value) => () where {
    val () = strptr_free name
    val () = vec3_vt_delete<int> value
  }
  | ~UniformIntVec4 (name, value) => () where {
    val () = strptr_free name
    val () = vec4_vt_delete<int> value
  }
  | ~UniformBoolVec3 (name, value) => () where {
    val () = strptr_free name
    val () = vec3_vt_delete<bool> value
  }
  | ~UniformBoolVec4 (name, value) => () where {
    val () = strptr_free name
    val () = vec4_vt_delete<bool> value
  }
  | ~UniformFloatVec3 (name, value) => () where {
    val () = strptr_free name
    val () = vec3_vt_delete<float> value
  }
  | ~UniformFloatVec4 (name, value) => () where {
    val () = strptr_free name
    val () = vec4_vt_delete<float> value
  }
  | ~UniformIntMat3 (name, value) => () where {
    val () = strptr_free name
    val () = mat3_vt_delete<int> value
  }
  | ~UniformIntMat4 (name, value) => () where {
    val () = strptr_free name
    val () = mat4_vt_delete<int> value
  }
  | ~UniformMat3 (name, value) => () where {
    val () = strptr_free name
    val () = mat3_vt_delete<float> value
  }
  | ~UniformMat4 (name, value) => () where {
    val () = strptr_free name
    val () = mat4_vt_delete<float> value
  }

implement ats3d_uniform_data_gl_free(uniform) = case+ uniform of
   ~UniformIntGL (_, _) => ()
  | ~UniformIntVec3GL (_, value) => vec3_vt_delete<int> value
  | ~UniformIntVec4GL (_, value) => vec4_vt_delete<int> value
  | ~UniformFloatVec3GL (_, value) => vec3_vt_delete<float> value
  | ~UniformFloatVec4GL (_, value) => vec4_vt_delete<float> value
  | ~UniformMat3GL (_, value) => mat3_vt_delete<float> value
  | ~UniformMat4GL (_, value) => mat4_vt_delete<float> value

(*
local
  dataviewtype compile_ctxt_vt =
    Context of (scene_zipper_vt, appearance_gl_vt, scene_vt, strptr1, strptr1) // (loc, shader, viewpoint, mv_name, p_name)

  extern fun{a, b: vt0p} list_vt_vt_map_free_fun{n: nat} (l: list_vt(a, n), f: a -<cloref1> b): list_vt(b, n)

  implement{a, b} list_vt_vt_map_free_fun(l, f) = case+ l of
    | ~list_vt_nil () => list_vt_nil()
    | ~list_vt_cons (x, xs) => list_vt_cons(f x, list_vt_vt_map_free_fun(xs, f))

  extern fun compile_appearance(appearance: appearance_vt, ctxt: compile_ctxt_vt): (appearance_gl_vt, compile_ctxt_vt)
  implement compile_appearance(appearance, ctxt) = let
    fun compile_shader{n,m: nat} (id: strptr1, vertex_src: strptr1, 
                                  fragment_src: strptr1, attributes: list_vt(strptr1, n),
                                  uniforms: list_vt(strptr1, m)) Option appearance_gl_vt = let
      val compiled_vertex = glc_compile_vertex_shader(vertex_src)
      val compiled_fragment = glc_compile_fragment_shader(fragment_src)
      val pgm = glc_make_program(compiled_vertex, compiled_fragment)
    in
      case+ pgm of
        None () => None
        Some (program) => ShaderGL(id, program, attributes, uniforms, GLint_of_int ~1, GLint_of_int ~1)
    end
case+ appearance of
    | ~Shader (id, vertex_src, fragment_src, attributes, uniforms) => let
      val compiled_shader = compile_shader(
      


in
  implement ats3d_scene_compile(scene) = let
    fun find_index{n: nat} (name: strptr1, shader_attributes: list_vt(strptr1, n)): int = ~1 // for attributes and uniforms
    // ...
    fun compile_scene_aux(scene: scene_vt, ctxt: compile_ctxt_vt): scene_gl_vt =
      case+ scene of
      | ~Shape(appearance, geometry) => ShapeGL(ats3d_scene_compile 
    
  in
    None_vt
  end
end
*)
