dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSet.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$ref_original <- dat$ref * 10e-6
dat$magMaskerSum_nor <- 20 * log10(dat$magMaskerSum / dat$ref_original)
dat$magMaskerSum_dB <- 20 * log10(dat$magMaskerSum/1e-6)
dat$magAdptDiff_nor <- 20 * log10(dat$magAdptDiff / dat$ref_original)
dat$magMaskerDiff_nor <- 20 * log10(dat$magMaskerDiff / dat$ref_original)
dat$magProbDiff_nor <- 20 * log10(dat$magProbDiff / dat$ref_original)
dat$lat180dB <- 10 * log10(dat$ERPn1lat180/0.1) + 10 * log10(dat$ERPp2lat180/0.2)
dat$HL500 <- (dat$HL500left + dat$HL500right)/2.0
dat$HFA <- (dat$HFAleft + dat$HFAright)/2.0
dat$FMmean <- (dat$FMleftMean + dat$FMrightMean)/2.0
dat$FMmedian <- (dat$FMleftMedian + dat$FMrightMedian)/2.0
dat$FMmax <- (dat$FMleftMax + dat$FMrightMax)/2.0

m_itd_res <- lm(ITDmean ~ mistakeITD, data = dat)
m_fmLeft_res <- lm(FMleftMean ~ mistakeFMLeft, data = dat)
m_fmRight_res <- lm(FMrightMean ~ mistakeFMRight, data = dat)
dat$residITDmean <- resid(m_itd_res)
dat$residFMright <- resid(m_fmRight_res)
dat$residFMleft <- resid(m_fmLeft_res)
dat$residFMmean <- (dat$residFMleft + dat$residFMright)/2

m_all = lm(ITDmean ~ mistakeITD + lat180dB + HL500 + HFA + magMaskerSum_nor, data = dat, na.action = na.exclude)
m = lm(ITDmean ~ FMmean, data = dat, na.action = na.exclude)

model = m
Y = dat$ITDmean
X = dat$FMmean
#which(dat$lat180dB %in% NaN) # it tells you the index of 'NaN'
ylabel = 'ITD detection thresholds \n [dB re: 1 us]'
xlabel = 'FM detection thresholds [dB re: 1 Hz]'
title = 'ITD thresholds vs FM thresholds'
#FM residual [dB re: 500 Hz], Latency [dB re: 1 ms], \ncond: ITD = 180 us, ITD detection thresholds\n[residual], FM detection thresholds\n[residual]
p <- ggplot(aes(x = X, y = Y), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p + xlab(xlabel) + ylab(ylabel) + annotate("text", x = 20, y = 25, size = 8, label = paste("R = ", signif(sqrt(summary(model)$r.squared), 1),  " \nP =",signif(summary(model)$coef[2,4], 1), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25)) + ggtitle(title) 
#+ xlim(20, 37)

#dat$ITDmeanPredicted <- predict(m_itd_audiogram_lat)
dat$ITDmeanPredicted <- predict(m)
m_itd_pred = lm(ITDmean ~ ITDmeanPredicted, data = dat)
p_itd_pred <- ggplot(aes(x = ITDmeanPredicted, y = ITDmean), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_pred + xlab('Predicted ITD thresholds [dB re: 1 us]') + ylab('ITD thresholds [dB re: 1 us]') + annotate("text", x = 26, y = 36, size = 7, label = paste("R = ", signif(sqrt(summary(m_itd_pred)$r.squared), 1),  " \nP =",signif(summary(m_itd_pred)$coef[2,4], 1), "\n n = 31")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 22)) + ggtitle('Predicted vs actual ITD thresholds')