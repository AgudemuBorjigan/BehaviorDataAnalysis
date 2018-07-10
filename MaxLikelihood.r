ITDcorr <- c(40, 50, 100)
ITDwrong <- c(20, 25, 30, 35)


for (i in ITDcorr) {
  pCorrt[i] <- 0.5 + 0.5 / (1 + exp(-k * (ITDcorr[i] - Thresh)))
}

for (i in ITDwrong){
  pWrong[i] <- 0.5 - 0.5 / (1 + exp(-k * (ITDwrong[i] - Thresh)))
}

for (i in ITDcorr){
  if (i == 1){
    p_corrt_mul = pCorrt[i]
  } else {
    p_corrt_mul = p_corrt_mul * pCorrt[i]
  }
}

for (i in ITDwrong){
  if (i == 1){
    p_wrong_mul = pWrong[i]
  } else {
    p_wrong_mul = p_wrong_mul * pWrong[i]
  }
}

likelihood = p_corrt_mul * p_wrong_mul