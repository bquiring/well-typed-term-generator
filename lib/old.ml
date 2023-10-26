(* old functions idk if we want to use again *)

(* TODO: use this again *)
let rec type_complexity (prog : Exp.program) (ty : Type.ty_label) =
  match prog.ty.get_ty ty with
  | Type.TyBool -> 1
  | Type.TyInt -> 1
  | Type.TyList ty' -> 2 + type_complexity prog ty'
  | Type.TyArrow (params, ty') ->
    List.fold_left
      (fun acc ty'' -> acc + type_complexity prog ty'')
      (1 + type_complexity prog ty')
      params
  | Type.TyArrowExt (params, ty') ->
    List.fold_left
      (fun acc ty'' -> acc + type_complexity prog ty'')
      (1 + type_complexity prog ty')
      (prog.ty.get_ty_params params)

(* TODO: pass full list of in-scope variables here *)
let rec random_type size (prog : Exp.program) =
  prog.ty.new_ty
    ((Choose.choose_frequency
        [(8, (fun _ -> Type.TyBool));
         (12, (fun _ -> Type.TyInt));
         (size / 4, (fun _ -> Type.TyList (random_type (size / 2) prog)));
         (size / 4, (fun _ ->
                       let n = (Random.int 3) + 1 in
                       let tys = List.init n (fun _ -> random_type (size / (2 * n)) prog) in
                       Type.TyArrow (tys, (random_type (size / 2) prog))))])
         (*
         (size / 4, (fun _ ->
                       let params = prog.ty.new_ty_params (prog.new_extvar ()) in
                       Type.TyArrowExt (params, (random_type (size / 2) prog))))])
         *)
     ())
