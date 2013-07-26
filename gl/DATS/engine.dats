#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "gl/SATS/engine.sats"
staload "prelude/SATS/array.sats"
staload "contrib/GLEXT/SATS/glext.sats"

staload _(*anonymous*)="prelude/DATS/array.dats"

assume array_ptr_vt (a: vt0p, n: int)  = [l:agz] @{pfgc = free_gc_v (a?, n, l), 
                                                   pf = array_v (a, n, l), 
                                                   p = ptr l}

implement ats3d_scene_free(scene) = case+ scene of
  | ~Fail (_) => ()
  | ~Perspective (_, _, _, _, _) => ()
  | ~Viewpoint (_, _) => ()
  | ~Geometry (_, scene, _, _) => ats3d_scene_free scene
  | ~Transform (_, scene) => ats3d_scene_free scene
  | ~Scale (_, scene) => ats3d_scene_free scene
  | ~Translate (_, scene) => ats3d_scene_free scene
  | ~Rotate (_, scene) => ats3d_scene_free scene
  | ~Group (scenes, sz) => array_ptr_free_fun<scene_vt>(scenes.pfgc, scenes.pf | scenes.p, sz, 
                                                        lam (scene) => $effmask_all(ats3d_scene_free scene))
  | ~Shape (appearance, scene) => let
    val () = ats3d_appearance_free appearance
    val () = ats3d_scene_free scene
    in end
  | ~Lines (_, _, _) => ()
  | ~LineLoop (_, _, _) => ()
  | ~LineStrip (_, _, _) => ()
  | ~Points (_, _, _) => ()
  | ~Triangles (_, _, _) => ()
  | ~TriangleStrip (_, _, _) => ()
  | ~Buffer (_, _) => ()

implement ats3d_appearance_free(appearance) = case+ appearance of
  | ~Shader (_, _, _, _, _) => ()
  | ~ShaderMaterial (uniforms, sz) => array_ptr_free_fun<uniform_data_vt>(uniforms.pfgc, uniforms.pf | uniforms.p, sz, 
                                                        lam (uniform) => $effmask_all(ats3d_uniform_data_free uniform))

implement ats3d_scene_gl_free(scene) = case+ scene of
  | ~PerspectiveGL (_, _, _, _, _) => ()
  | ~ViewpointGL (_, _) => ()
  | ~GeometryGL (_, scene, _, _) => ats3d_scene_gl_free scene
  | ~TransformGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~ScaleGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~TranslateGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~RotateGL (_, _, scene) => ats3d_scene_gl_free scene
  | ~GroupGL (scenes, sz) => array_ptr_free_fun<scene_gl_vt>(scenes.pfgc, scenes.pf | scenes.p, sz, 
                                                        lam (scene) => $effmask_all(ats3d_scene_gl_free scene))
  | ~ShapeGL (appearance, scene) => let
    val () = ats3d_appearance_gl_free appearance
    val () = ats3d_scene_gl_free scene
    in end
  | ~LinesGL (_, _, _, _) => ()
  | ~LineLoopGL (_, _, _, _) => ()
  | ~LineStripGL (_, _, _, _) => ()
  | ~PointsGL (_, _, _, _) => ()
  | ~TrianglesGL (_, _, _, _) => ()
  | ~TriangleStripGL (_, _, _, _) => ()
  | ~BufferGL (_, _) => ()

implement ats3d_appearance_gl_free(appearance) = case+ appearance of
  | ~ShaderGL (_, pgm, _, _, _, _) => glDeleteProgram pgm
  | ~ShaderMaterialGL (uniforms, sz) => array_ptr_free_fun<uniform_data_gl_vt>(uniforms.pfgc, uniforms.pf | uniforms.p, sz, 
                                                        lam (uniform) => $effmask_all(ats3d_uniform_data_gl_free uniform))
  | ~ActivatedShaderGL (parent, _, _, _) => ats3d_appearance_gl_free parent //  !!!!! 

implement ats3d_uniform_data_free(uniform) = case+ uniform of
   ~UniformInt (_, _) => ()
  | ~UniformBool (_, _) => ()
  | ~UniformFloat (_, _) => ()
  | ~UniformIntVec2 (_, _) => ()
  | ~UniformIntVec3 (_, _) => ()
  | ~UniformIntVec4 (_, _) => ()
  | ~UniformBoolVec2 (_, _) => ()
  | ~UniformBoolVec3 (_, _) => ()
  | ~UniformBoolVec4 (_, _) => ()
  | ~UniformFloatVec2 (_, _) => ()
  | ~UniformFloatVec3 (_, _) => ()
  | ~UniformFloatVec4 (_, _) => ()
  | ~UniformIntMat2 (_, _) => ()
  | ~UniformIntMat3 (_, _) => ()
  | ~UniformIntMat4 (_, _) => ()
  | ~UniformMat2 (_, _) => ()
  | ~UniformMat3 (_, _) => ()
  | ~UniformMat4 (_, _) => ()
 

implement ats3d_uniform_data_gl_free(uniform) = case+ uniform of
   ~UniformIntGL (_, _) => ()
  | ~UniformIntVec2GL (_, _) => ()
  | ~UniformIntVec3GL (_, _) => ()
  | ~UniformIntVec4GL (_, _) => ()
  | ~UniformFloatVec2GL (_, _) => ()
  | ~UniformFloatVec3GL (_, _) => ()
  | ~UniformFloatVec4GL (_, _) => ()
  | ~UniformMat2GL (_, _) => ()
  | ~UniformMat3GL (_, _) => ()
  | ~UniformMat4GL (_, _) => ()
