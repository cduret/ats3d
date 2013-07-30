#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "contrib/GL/SATS/gl.sats"
staload "gl/SATS/engine.sats"
staload "prelude/SATS/array.sats"
staload "contrib/GLEXT/SATS/glext.sats"

staload _(*anonymous*)="prelude/DATS/array.dats"
staload _(*anonymous*)="prelude/DATS/list_vt.dats"

assume array_ptr_vt (a: vt0p, n: int)  = [l:agz] @{pfgc = free_gc_v (a?, n, l), 
                                                   pf = array_v (a, n, l), 
                                                   p = ptr l}

implement ats3d_scene_free(scene) = case+ scene of
  | ~Fail (msg) => strptr_free(msg)
  | ~Perspective (uniform, _, _, _, _) => strptr_free uniform
  | ~Viewpoint (uniform, _) => strptr_free uniform
  | ~Geometry (id, scene, _, kind) => () where {
    val () = strptr_free id
    val () = ats3d_scene_free scene
    val () = strptr_free kind
  }
  | ~Transform (_, scene) => ats3d_scene_free scene
  | ~Scale (_, scene) => ats3d_scene_free scene
  | ~Translate (_, scene) => ats3d_scene_free scene
  | ~Rotate (_, scene) => ats3d_scene_free scene
  | ~Group (scenes) => list_vt_free_fun<scene_vt>(scenes, lam (scene) => $effmask_all(ats3d_scene_free scene))
  | ~Shape (appearance, scene) => () where {
    val () = ats3d_appearance_free appearance
    val () = ats3d_scene_free scene
  }
  | ~Lines (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~LineLoop (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~LineStrip (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Points (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Triangles (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~TriangleStrip (vertices, _, ref, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
    val () = strptr_free ref
    val () = strptr_free attribute
  }
  | ~Buffer (vertices, _, attribute) => () where {
    val () = array_ptr_free(vertices.pfgc, vertices.pf|vertices.p)
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
  | ~ViewpointGL (_, _) => ()
  | ~GeometryGL (id, scene, _, kind) => () where {
    val () = strptr_free id
    val () = ats3d_scene_gl_free scene
    val () = strptr_free kind
  }
  | ~TransformGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~ScaleGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~TranslateGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~RotateGL (_, _, scene) => ats3d_scene_gl_free scene
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
    val () = list_vt_free<GLuint>(attributes)
    val () = list_vt_free<GLint>(uniforms)
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
  | ~UniformIntVec2 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformIntVec3 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformIntVec4 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformBoolVec2 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformBoolVec3 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformBoolVec4 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformFloatVec2 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformFloatVec3 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformFloatVec4 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformIntMat2 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformIntMat3 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformIntMat4 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformMat2 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformMat3 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }
  | ~UniformMat4 (name, value) => () where {
    val () = strptr_free name
    val () = array_ptr_free(value.pfgc, value.pf|value.p)
  }

implement ats3d_uniform_data_gl_free(uniform) = case+ uniform of
   ~UniformIntGL (_, _) => ()
  | ~UniformIntVec2GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformIntVec3GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformIntVec4GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformFloatVec2GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformFloatVec3GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformFloatVec4GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformMat2GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformMat3GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)
  | ~UniformMat4GL (_, value) => array_ptr_free(value.pfgc, value.pf|value.p)

(*implement ats3d_scene_compile(scene) = let
  fun find_attribute(shader_attributes: array(string
in
  None_vt
end*)
