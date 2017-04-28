select = dplyr::select

tobit.wilcox = function(pre.trt, post.trt, pre.ctrl, post.ctrl, effect.min, effect.max, step = 0.1) {
  p.values = vector()
  for (i in seq(from = effect.min, to = effect.max, by = step)) { # Compute p-value for each tau in the range [effect.min,effect.max].
    tau=i
    
    if (tau>=0) {
      trt = pmax((post.trt - pre.trt) - tau, -pre.trt)
      ctrl = (post.ctrl - pre.ctrl)
    }
    if (tau<0) {
      trt = (post.trt - pre.trt)
      ctrl = pmax((post.ctrl - pre.ctrl) + tau, -pre.ctrl)
    }
    p.values = append(p.values, pvalue(wilcoxsign_test(trt ~ ctrl)))
  }
  data.frame(tau=seq(from = effect.min, to = effect.max, by = step), p.values=p.values)
}