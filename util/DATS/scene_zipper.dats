#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
//staload "prelude/SATS/array.sats"
staload "util/SATS/scene_zipper.sats"
staload "gl/SATS/engine.sats"
staload "gl/SATS/matrix.sats"

//staload _(*anonymous*)="prelude/DATS/array.dats"
staload _(*anonymous*)="prelude/DATS/list_vt.dats"
staload _(*anonymous*)="gl/DATS/matrix.dats"

implement zip_free(loc) = case+ loc of
  | ~Top () => ()
  | ~ZipperFail (msg) => strptr_free msg
  | ~Location (tree, path) => () where {
    val () = ats3d_scene_free tree
    val () = zip_free path
  }
  | ~LocationApp (appearance, path) => () where {
    val () = ats3d_appearance_free appearance
    val () = zip_free path
  }
  | ~NodeGeometry (id, _, kind, path) => () where {
    val () = strptr_free id
    val () = strptr_free kind
    val () = zip_free path
  }
  | ~NodeTransform (matrix, path) => () where {
    val () = mat4_vt_delete matrix
    val () = zip_free path
  }
  | ~NodeScale (scale, path) => () where {
    val () = vec3_vt_delete scale
    val () = zip_free path
  }
  | ~NodeRotate (rotate, path) => () where {
    val () = vec3_vt_delete rotate
    val () = zip_free path
  }
  | ~NodeTranslate (translate, path) => () where {
    val () = vec3_vt_delete translate
    val () = zip_free path
  }
  | ~NodeGroup (left, path, right) => () where {
    val () = list_vt_free_fun<scene_vt>(left, lam (scene) => $effmask_all(ats3d_scene_free scene))
    val () = zip_free path
    val () = list_vt_free_fun<scene_vt>(right, lam (scene) => $effmask_all(ats3d_scene_free scene))
  }
  | ~NodeShape (geometry, path) => () where {
    val () = ats3d_scene_free geometry
    val () = zip_free path
  }
  | ~NodeShapeApp (appearance, path) => () where {
    val () = ats3d_appearance_free appearance
    val () = zip_free path
  }


implement zip_down(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  fun group_down{n: nat} (scenes: list_vt(scene_vt, n), path: scene_zipper_vt): scene_zipper_vt =
   case+ scenes of
      | ~list_vt_cons(x, xs) => Location(x, NodeGroup(list_vt_nil(), path, xs))
      | ~list_vt_nil() => Location(Group(list_vt_nil()), path) //cannot go down 
  fun location_down(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ scene of
    | ~Geometry (id, scene, visible, kind) => Location(scene, NodeGeometry(id, visible, kind, path))
    | ~Transform (matrix, scene) => Location(scene, NodeTransform(matrix, path))
    | ~Scale (scale, scene) => Location(scene, NodeScale(scale, path))
    | ~Translate (translate, scene) => Location(scene, NodeTranslate(translate, path))
    | ~Rotate (rotate, scene) => Location(scene, NodeRotate(rotate, path))
    | ~Shape (appearance, geometry) => LocationApp(appearance, NodeShape(geometry, path))
    | ~Group (scenes) => group_down(scenes, path)
    | _ => Location(scene, path)
in
  case+ loc of
  | ~Location (scene, path) => location_down(scene, path)
  | _ => let
    val () = ___leak(loc)
  in
    ZipperFail(sprintf("Not a location object !", @()))
  end
end

implement zip_up(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  fun location_up(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeGeometry (id, visible, kind, path) => Location(Geometry(id, scene, visible, kind), path)
    | ~NodeTransform (matrix, path) => Location(Transform(matrix, scene), path)
    | ~NodeScale (scale, path) => Location(Scale(scale, scene), path)
    | ~NodeTranslate (translate, path) => Location(Translate(translate, scene), path)
    | ~NodeRotate (rotate, path) => Location(Rotate(rotate, scene), path)
    | ~NodeShapeApp (appearance, path) => Location(Shape(appearance, scene), path)
    | ~NodeGroup (left, path, right) => Location(Group(lst), path) where {
      val m = list_vt_cons(scene, list_vt_nil())
      val l = list_vt_reverse_append(left, m)
      val lst = list_vt_append(l, right)
    }
    | _ => Location(scene, path)
  fun location_app_up(appearance: appearance_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeShape (geometry, path) => Location(Shape(appearance, geometry), path)
    | _ => LocationApp(appearance, path)
in
  case+ loc of
  | ~Location (scene, path) => location_up(scene, path)
  | ~LocationApp (appearance, path) => location_app_up(appearance, path)
  | _ => let
    val () = ___leak(loc)
  in
    ZipperFail(sprintf("Not a location object !", @()))
  end
end

implement zip_root(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  fun location_root(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~Top () => Location(scene, Top)
    | _ => zip_root(zip_up(Location(scene, path)))
in
  case+ loc of
    | ~Location (scene, path) => location_root(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_right(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  fun location_right(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeGroup (left, path, right) => if list_vt_length(right) > 0 then let
      val ~list_vt_cons(new_scene, new_right) = right
      val new_left = list_vt_append( list_vt_cons(scene, list_vt_nil()), left )
    in
      Location(new_scene, NodeGroup(new_left, path, new_right))
    end else
      Location(scene, NodeGroup(left, path, right)) // cannot go further right
    | _ => Location(scene, path)
  fun location_app_right(appearance: appearance_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeShape(geometry, path) => Location(geometry, NodeShapeApp(appearance, path))
    | _ => LocationApp(appearance, path) // should not happen..
in
  case+ loc of
    | ~Location (scene, path) => location_right(scene, path)
    | ~LocationApp (appearance, path) => location_app_right(appearance, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_left(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  fun location_left(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeShapeApp (appearance, path) => LocationApp(appearance, NodeShape(scene, path))
    | ~NodeGroup (left, path, right) => if list_vt_length(left) > 0 then let
      val ~list_vt_cons(new_scene, new_left) = left
      val new_right = list_vt_append( list_vt_cons(scene, list_vt_nil()), right )
    in
      Location(new_scene, NodeGroup(new_left, path, new_right))
    end else
      Location(scene, NodeGroup(left, path, right)) // cannot go further left
    | _ => Location(scene, path)
in
  case+ loc of
    | ~Location (scene, path) => location_left(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_nth(loc, index) = let
  fun nth_aux{n: nat} .<n>. (i: int n, seed: scene_zipper_vt): scene_zipper_vt =
    if i = 0 then
      seed
    else
      zip_right(nth_aux(i - 1, seed))
in
  nth_aux(index, zip_down(loc))
end

implement zip_insert_right(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(path: scene_vt):<> void
  fun location_insert(scene: scene_vt, path: scene_zipper_vt, s: scene_vt): scene_zipper_vt =
    case+ path of
    | ~NodeGroup (left, path, right) => let
      val new_right = list_vt_append(list_vt_cons(s, list_vt_nil()), right)
    in
      Location(scene, NodeGroup(left, path, new_right))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFail(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~Location (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_insert_left(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(path: scene_vt):<> void
  fun location_insert(scene: scene_vt, path: scene_zipper_vt, s: scene_vt): scene_zipper_vt =
    case+ path of
    | ~NodeGroup (left, path, right) => let
      val new_left = list_vt_append(list_vt_cons(s, list_vt_nil()), left)
    in
      Location(scene, NodeGroup(new_left, path, right))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFail(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~Location (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_insert_down(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(path: scene_vt):<> void
  fun location_insert(scene: scene_vt, path: scene_zipper_vt, s: scene_vt): scene_zipper_vt =
    case+ scene of
    | ~Group (scenes) => Location(s, NodeGroup(list_vt_nil(), path, scenes))
    | ~Geometry (id, scene, visible, kind) => let
      val () = ats3d_scene_free scene
    in  
      Location(s, NodeGeometry(id, visible, kind, path))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFail(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~Location (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_remove(loc) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(path: scene_vt):<> void
  fun location_remove(scene: scene_vt, path: scene_zipper_vt): scene_zipper_vt =
    case+ path of
    | ~NodeGroup (left, path, right) => let
      val () = ats3d_scene_free scene
    in if list_vt_length(right) > 0 then let
      val ~list_vt_cons(new_scene, new_right) = right
      in
        Location(new_scene, NodeGroup(left, path, new_right))
      end else if list_vt_length(left) > 0 then let
      val ~list_vt_cons(new_scene, new_left) = left
      in
        Location(new_scene, NodeGroup(new_left, path, right))
      end else let
        val ~list_vt_nil() = left
        val ~list_vt_nil() = right
      in
        Location(Group(list_vt_nil()), path)
      end
    end
    | _ => let
      val () = ___leak(path)
      val () = ___leak1(scene)
    in
      ZipperFail(sprintf("Cannot remove this element !", @()))
    end
in
  case+ loc of
    | ~Location (scene, path) => location_remove(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_replace(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(s: scene_vt):<> void

  fun location_replace(scene: scene_vt, path: scene_zipper_vt, s: scene_vt): scene_zipper_vt =
    case+ path of
    | ~Top () => let
      val () = ats3d_scene_free scene
    in Location(s, Top) end
    | ~NodeGeometry (id, visible, kind, path) => let
      val () = ats3d_scene_free scene
    in Location(s, NodeGeometry(id, visible, kind, path)) end
    | ~NodeShapeApp (appearance, path) => let
      val () = ats3d_scene_free scene
    in Location(s, NodeShapeApp(appearance, path)) end
    | ~NodeGroup (left, path, right) => 
      zip_remove(zip_insert_right(Location(scene, NodeGroup(left, path, right)), s))
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFail(sprintf("Cannot replace scene !", @())) end
in
  case+ loc of
    | ~Location (scene, path) => location_replace(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

implement zip_replace_app(loc, a) = let
  extern castfn ___leak(sz: scene_zipper_vt):<> void
  extern castfn ___leak1(s: appearance_vt):<> void

  fun location_replace(appearance: appearance_vt, path: scene_zipper_vt, a: appearance_vt): scene_zipper_vt =
    case+ path of
    | ~NodeShape (geometry, path) => let
      val () = ats3d_appearance_free appearance
    in LocationApp(a, NodeShape(geometry, path)) end
    | _ => let 
      val () = ___leak1(a)
      val () = ___leak1(appearance)
      val () = ___leak(path)
    in ZipperFail(sprintf("Cannot replace scene !", @())) end
in
  case+ loc of
    | ~LocationApp (appearance, path) => location_replace(appearance, path, a)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(a)
    in
      ZipperFail(sprintf("Not a location object !", @()))
    end
end

(* -------------------------------------------------- GL ----------------------------------------------------------- *)
implement zip_free_gl(loc) = case+ loc of
  | ~TopGL () => ()
  | ~ZipperFailGL (msg) => strptr_free msg
  | ~LocationGL (tree, path) => () where {
    val () = ats3d_scene_gl_free tree
    val () = zip_free_gl path
  }
  | ~LocationAppGL (appearance, path) => () where {
    val () = ats3d_appearance_gl_free appearance
    val () = zip_free_gl path
  }
  | ~NodeGeometryGL (id, _, kind, path) => () where {
    val () = strptr_free id
    val () = strptr_free kind
    val () = zip_free_gl path
  }
  | ~NodeTransformGL (_, matrix, path) => () where {
    val () = mat4_vt_delete matrix
    val () = zip_free_gl path
  }
  | ~NodeScaleGL (_, scale, path) => () where {
    val () = vec3_vt_delete scale
    val () = zip_free_gl path
  }
  | ~NodeRotateGL (_, rotate, path) => () where {
    val () = vec3_vt_delete rotate
    val () = zip_free_gl path
  }
  | ~NodeTranslateGL (_, translate, path) => () where {
    val () = vec3_vt_delete translate
    val () = zip_free_gl path
  }
  | ~NodeGroupGL (left, path, right) => () where {
    val () = list_vt_free_fun<scene_gl_vt>(left, lam (scene) => $effmask_all(ats3d_scene_gl_free scene))
    val () = zip_free_gl path
    val () = list_vt_free_fun<scene_gl_vt>(right, lam (scene) => $effmask_all(ats3d_scene_gl_free scene))
  }
  | ~NodeShapeGL (geometry, path) => () where {
    val () = ats3d_scene_gl_free geometry
    val () = zip_free_gl path
  }
  | ~NodeShapeAppGL (appearance, path) => () where {
    val () = ats3d_appearance_gl_free appearance
    val () = zip_free_gl path
  }

implement zip_down_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  fun group_down{n: nat} (scenes: list_vt(scene_gl_vt, n), path: scene_zipper_gl_vt): scene_zipper_gl_vt =
   case+ scenes of
      | ~list_vt_cons(x, xs) => LocationGL(x, NodeGroupGL(list_vt_nil(), path, xs))
      | ~list_vt_nil() => LocationGL(GroupGL(list_vt_nil()), path) //cannot go down 
  fun location_down(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ scene of
    | ~GeometryGL (id, scene, visible, kind) => LocationGL(scene, NodeGeometryGL(id, visible, kind, path))
    | ~TransformGL (uniform_idx, matrix, scene) => LocationGL(scene, NodeTransformGL(uniform_idx, matrix, path))
    | ~ScaleGL (uniform_idx, scale, scene) => LocationGL(scene, NodeScaleGL(uniform_idx, scale, path))
    | ~TranslateGL (uniform_idx, translate, scene) => LocationGL(scene, NodeTranslateGL(uniform_idx, translate, path))
    | ~RotateGL (uniform_idx, rotate, scene) => LocationGL(scene, NodeRotateGL(uniform_idx, rotate, path))
    | ~ShapeGL (appearance, geometry) => LocationAppGL(appearance, NodeShapeGL(geometry, path))
    | ~GroupGL (scenes) => group_down(scenes, path)
    | _ => LocationGL(scene, path)
in
  case+ loc of
  | ~LocationGL (scene, path) => location_down(scene, path)
  | _ => let
    val () = ___leak(loc)
  in
    ZipperFailGL(sprintf("Not a locationGL object !", @()))
  end
end

implement zip_up_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  fun location_up(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeGeometryGL (id, visible, kind, path) => LocationGL(GeometryGL(id, scene, visible, kind), path)
    | ~NodeTransformGL (uniform_idx, matrix, path) => LocationGL(TransformGL(uniform_idx, matrix, scene), path)
    | ~NodeScaleGL (uniform_idx, scale, path) => LocationGL(ScaleGL(uniform_idx, scale, scene), path)
    | ~NodeTranslateGL (uniform_idx, translate, path) => LocationGL(TranslateGL(uniform_idx, translate, scene), path)
    | ~NodeRotateGL (uniform_idx, rotate, path) => LocationGL(RotateGL(uniform_idx, rotate, scene), path)
    | ~NodeShapeAppGL (appearance, path) => LocationGL(ShapeGL(appearance, scene), path)
    | ~NodeGroupGL (left, path, right) => LocationGL(GroupGL(lst), path) where {
      val m = list_vt_cons(scene, list_vt_nil())
      val l = list_vt_reverse_append(left, m)
      val lst = list_vt_append(l, right)
    }
    | _ => LocationGL(scene, path)
  fun location_app_up(appearance: appearance_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeShapeGL (geometry, path) => LocationGL(ShapeGL(appearance, geometry), path)
    | _ => LocationAppGL(appearance, path)
in
  case+ loc of
  | ~LocationGL (scene, path) => location_up(scene, path)
  | ~LocationAppGL (appearance, path) => location_app_up(appearance, path)
  | _ => let
    val () = ___leak(loc)
  in
    ZipperFailGL(sprintf("Not a location object !", @()))
  end
end

implement zip_root_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  fun location_root(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~TopGL () => LocationGL(scene, TopGL)
    | _ => zip_root_gl(zip_up_gl(LocationGL(scene, path)))
in
  case+ loc of
    | ~LocationGL (scene, path) => location_root(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_right_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  fun location_right(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeGroupGL (left, path, right) => if list_vt_length(right) > 0 then let
      val ~list_vt_cons(new_scene, new_right) = right
      val new_left = list_vt_append( list_vt_cons(scene, list_vt_nil()), left )
    in
      LocationGL(new_scene, NodeGroupGL(new_left, path, new_right))
    end else
      LocationGL(scene, NodeGroupGL(left, path, right)) // cannot go further right
    | _ => LocationGL(scene, path)
  fun location_app_right(appearance: appearance_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeShapeGL(geometry, path) => LocationGL(geometry, NodeShapeAppGL(appearance, path))
    | _ => LocationAppGL(appearance, path) // should not happen..
in
  case+ loc of
    | ~LocationGL (scene, path) => location_right(scene, path)
    | ~LocationAppGL (appearance, path) => location_app_right(appearance, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_left_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  fun location_left(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeShapeAppGL (appearance, path) => LocationAppGL(appearance, NodeShapeGL(scene, path))
    | ~NodeGroupGL (left, path, right) => if list_vt_length(left) > 0 then let
      val ~list_vt_cons(new_scene, new_left) = left
      val new_right = list_vt_append( list_vt_cons(scene, list_vt_nil()), right )
    in
      LocationGL(new_scene, NodeGroupGL(new_left, path, new_right))
    end else
      LocationGL(scene, NodeGroupGL(left, path, right)) // cannot go further left
    | _ => LocationGL(scene, path)
in
  case+ loc of
    | ~LocationGL (scene, path) => location_left(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_nth_gl(loc, index) = let
  fun nth_aux{n: nat} .<n>. (i: int n, seed: scene_zipper_gl_vt): scene_zipper_gl_vt =
    if i = 0 then
      seed
    else
      zip_right_gl(nth_aux(i - 1, seed))
in
  nth_aux(index, zip_down_gl(loc))
end

implement zip_insert_right_gl(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(path: scene_gl_vt):<> void
  fun location_insert(scene: scene_gl_vt, path: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeGroupGL (left, path, right) => let
      val new_right = list_vt_append(list_vt_cons(s, list_vt_nil()), right)
    in
      LocationGL(scene, NodeGroupGL(left, path, new_right))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFailGL(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~LocationGL (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_insert_left_gl(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(path: scene_gl_vt):<> void
  fun location_insert(scene: scene_gl_vt, path: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeGroupGL (left, path, right) => let
      val new_left = list_vt_append(list_vt_cons(s, list_vt_nil()), left)
    in
      LocationGL(scene, NodeGroupGL(new_left, path, right))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFailGL(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~LocationGL (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_insert_down_gl(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(path: scene_gl_vt):<> void
  fun location_insert(scene: scene_gl_vt, path: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt =
    case+ scene of
    | ~GroupGL (scenes) => LocationGL(s, NodeGroupGL(list_vt_nil(), path, scenes))
    | ~GeometryGL (id, scene, visible, kind) => let
      val () = ats3d_scene_gl_free scene
    in  
      LocationGL(s, NodeGeometryGL(id, visible, kind, path))
    end
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFailGL(sprintf("Cannot insert scene !", @())) end
in
  case+ loc of
    | ~LocationGL (scene, path) => location_insert(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_remove_gl(loc) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(path: scene_gl_vt):<> void
  fun location_remove(scene: scene_gl_vt, path: scene_zipper_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeGroupGL (left, path, right) => let
      val () = ats3d_scene_gl_free scene
    in if list_vt_length(right) > 0 then let
      val ~list_vt_cons(new_scene, new_right) = right
      in
        LocationGL(new_scene, NodeGroupGL(left, path, new_right))
      end else if list_vt_length(left) > 0 then let
      val ~list_vt_cons(new_scene, new_left) = left
      in
        LocationGL(new_scene, NodeGroupGL(new_left, path, right))
      end else let
        val ~list_vt_nil() = left
        val ~list_vt_nil() = right
      in
        LocationGL(GroupGL(list_vt_nil()), path)
      end
    end
    | _ => let
      val () = ___leak(path)
      val () = ___leak1(scene)
    in
      ZipperFailGL(sprintf("Cannot remove this element !", @()))
    end
in
  case+ loc of
    | ~LocationGL (scene, path) => location_remove(scene, path)
    | _ => let
      val () = ___leak(loc)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_replace_gl(loc, s) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(s: scene_gl_vt):<> void

  fun location_replace(scene: scene_gl_vt, path: scene_zipper_gl_vt, s: scene_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~TopGL () => let
      val () = ats3d_scene_gl_free scene
    in LocationGL(s, TopGL) end
    | ~NodeGeometryGL (id, visible, kind, path) => let
      val () = ats3d_scene_gl_free scene
    in LocationGL(s, NodeGeometryGL(id, visible, kind, path)) end
    | ~NodeShapeAppGL (appearance, path) => let
      val () = ats3d_scene_gl_free scene
    in LocationGL(s, NodeShapeAppGL(appearance, path)) end
    | ~NodeGroupGL (left, path, right) => 
      zip_remove_gl(zip_insert_right_gl(LocationGL(scene, NodeGroupGL(left, path, right)), s))
    | _ => let 
      val () = ___leak1(s)
      val () = ___leak1(scene)
      val () = ___leak(path)
    in ZipperFailGL(sprintf("Cannot replace scene !", @())) end
in
  case+ loc of
    | ~LocationGL (scene, path) => location_replace(scene, path, s)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(s)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end

implement zip_replace_app_gl(loc, a) = let
  extern castfn ___leak(sz: scene_zipper_gl_vt):<> void
  extern castfn ___leak1(s: appearance_gl_vt):<> void

  fun location_replace(appearance: appearance_gl_vt, path: scene_zipper_gl_vt, a: appearance_gl_vt): scene_zipper_gl_vt =
    case+ path of
    | ~NodeShapeGL (geometry, path) => let
      val () = ats3d_appearance_gl_free appearance
    in LocationAppGL(a, NodeShapeGL(geometry, path)) end
    | _ => let 
      val () = ___leak1(a)
      val () = ___leak1(appearance)
      val () = ___leak(path)
    in ZipperFailGL(sprintf("Cannot replace scene !", @())) end
in
  case+ loc of
    | ~LocationAppGL (appearance, path) => location_replace(appearance, path, a)
    | _ => let
      val () = ___leak(loc)
      val () = ___leak1(a)
    in
      ZipperFailGL(sprintf("Not a location object !", @()))
    end
end
