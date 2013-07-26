#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
staload "gl/SATS/engine.sats"
staload "util/SATS/scene_zipper.sats"

(*
implement zip_free(loc) = case+ loc of
  | ~Top () => ()
  | ~Fail (_) => ()
  | ~Location (_, path) => zip_free path
  | ~NodeGeometry (_, _, _, path) => zip_free path
  | ~NodeTransform (_, path) => zip_free path
  | ~NodeScale (_, path) => zip_free path
  | ~NodeRotate (_, path) => zip_free path
  | ~NodeTranslate (_, path) => zip_free path
  | ~NodeGroup (_, path, _) => zip_free path
  | ~NodeShape (_, path, _) => zip_free path
*)

implement zip_down(loc) = Top
(*
implement zip_down(loc) = case+ loc of
  | Location (tree, path) => case+ tree of
    | Geometry (id, scene, visible, kind) => Location(scene, NodeGeometry(id, visible, kind, path))
    | Transform (matrix, scene) => Location(scene, NodeTransform(matrix, path))
    | Scale (scale, scene) => Location(scene, NodeScale(scale, path))
  | _ => Fail "Not a location !"
*)
//implement zip_down_gl(loc) =

