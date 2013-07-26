#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "gl/SATS/engine.sats"
staload "prelude/SATS/array.sats"

staload _(*anonymous*)="prelude/DATS/array.dats"

assume array_ptr_vt (a: vt0p, n: nat) [l:agz] = @{pfgc = free_gc_v (a?, n, l), pf_arr = array_v (a?, n, l), ptr_arr = ptr l}
//implement ats3d_scene_debug(scene) = let
  //fun __leak(s: Scene): void = ()
//in __leak scene end

(*
implement ats3d_scene_free(scene) = case+ scene of
  | ~Fail (_) => ()
  | ~Perspective (_, _, _, _, _) => ()
  | ~Viewpoint (_, _) => ()
  | ~Geometry (_, scene, _, _) => ats3d_scene_free scene
  | ~Transform (_, scene) => ats3d_scene_free scene
  | ~Scale (_, scene) => ats3d_scene_free scene
  | ~Translate (_, scene) => ats3d_scene_free scene
  | ~Rotate (_, scene) => ats3d_scene_free scene
  | ~Group (scenes, sz) => array_ptr_free_fun(scenes, f, sz) where {
    fun f (scene: &scene_vt >> scene_vt?): void = ats3d_scene_free scene
  }
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
*)

(*
implement ats3d_appearance_free(appearance) = case+ appearance of
  | ~Shader (_, _, _, _, _) => ()
  | ~ShaderMaterial (_) => ()
*)
