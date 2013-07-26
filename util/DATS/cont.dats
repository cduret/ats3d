#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

staload "util/SATS/cont.sats"

implement{a, b} return (value) = my_lambda where {
  val my_lambda = lam (f: a -<cloref1> b): b =<cloref1> f value
}

implement{a, b} run_cont (C, f) = C f

implement{a, b} bind (v, f) = my_lambda where {
  val my_lambda = lam (C: a -<cloref1> b): b =<cloref1>
                    run_cont<a,b>(v, lam (vp: a): b =<cloref1> 
                                           run_cont<a,b>(f vp, C))
}

implement{a,b} chain (conts) = l where {
  val l = lam (value: cont(a,b)): cont(a, b) =<cloref1>
            list_fold_left_fun<cont(a, b)><cloref_cont_1(a,b)>(f, value, conts) where {
              fn f (mv:cont(a,b), mf:cloref_cont_1(a,b)): cont(a,b) = 
                bind<a,b>(mv, lam (v:a): cont(a,b) =<cloref1> mf v)
            }
}
