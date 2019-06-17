#setwd('~/DataAnalysis/BehaviorDataAnalysis/')
#dat <- read.csv('dataSetBehavior.csv', header = TRUE)
dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSetBehavior.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$FMmedian <- (dat$FMleftMedian + dat$FMrightMedian)/2
dat$FMmean <- (dat$FMleftMean + dat$FMrightMean)/2

dat$HL500 <- (dat$HL500left + dat$HL500right)/2
dat$HL500diff <- abs(dat$HL500left - dat$HL500right)

dat$HFA <- (dat$HFAleft + dat$HFAright)/2
dat$HFAdiff <- abs(dat$HFAleft - dat$HFAright)

#m_behavior <- lm(ITDmax ~ FMmedian + HL500 + HL500diff + HL4K + HL4Kdiff, data = dat) 
m_itd_fm <- lm(ITDmax ~ FMmedian, data = dat) 
Anova(m_itd_fm)

p_itd_fm <- ggplot(aes(x = FMmedian, y = ITDmax), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_fm + xlab('Fdev [dB re: 500 Hz]') + ylab('ITD [dB re: 1 us]') + annotate("text", x = 12, y = 44.5, size =8, label = paste("R = ", signif(sqrt(summary(m_itd_fm)$r.squared), 3),  " \nP =", signif(summary(m_itd_fm)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
#ggtitle('ITD vs FM thresholds')

m_itd_res <- lm(ITDmax ~ mistakeITD, data = dat)
dat$residITD <- resid(m_itd_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmLeft_res <- lm(FMleftMedian ~ mistakeFMLeft, data = dat)
dat$residFMleft <- resid(m_fmLeft_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmRight_res <- lm(FMrightMedian ~ mistakeFMRight, data = dat)
dat$residFMright <- resid(m_fmRight_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

dat$residFMmedian <- (dat$residFMleft + dat$residFMright)/2

m_itd_fm_res <- lm(residITD ~ residFMmedian, data = dat) 
Anova(m_itd_fm_res)

p_itd_fm_res <- ggplot(aes(x = residFMmedian, y = residITD), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_fm_res + xlab('Fdev [residual]') + ylab('ITD [residual]') + annotate("text", x = 5, y = -4, size =8, label = paste("R = ", signif(sqrt(summary(m_itd_fm_res)$r.squared), 3),  " \nP =", signif(summary(m_itd_fm_res)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
#ggtitle('ITD vs FM thresholds (with attention score factored out)')

###########################################################################################################################################################
#ITD and audiogram
m_itd_aud500 <- lm(ITDmin ~ HL500diff, data = dat)
p_itd_aud500 <- ggplot(aes(x = HL500diff, y = ITDmin), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_aud500 + xlab('Audiogram diff @ 500 Hz') + ylab('ITDmin [dB re: 1 us]') + annotate("text", x = 7, y = 32, size =8, label = paste("R = ", signif(sqrt(summary(m_itd_aud500)$r.squared), 3),  " \nP =",signif(summary(m_itd_aud500)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))

#ITD and audiogram: high frequnecy average
m_itd_audHFA <- lm(ITDmin ~ HFAdiff, data = dat)
p_itd_audHFA <- ggplot(aes(x = HFAdiff, y = ITDmin), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_audHFA + xlab('Audiogram HFA, diff') + ylab('ITDmin [dB re: 1 us]') + annotate("text", x = 9, y = 32, size =8, label = paste("R = ", signif(sqrt(summary(m_itd_audHFA)$r.squared), 3),  " \nP =",signif(summary(m_itd_audHFA)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))

#FM and audiogram
m_fm_aud500 <- lm(FMrightMean ~ HL500, data = dat)
p_fm_aud500 <- ggplot(aes(x = HL500, y = FMrightMean), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_fm_aud500 + xlab('Audiogram avg @ 500 Hz') + ylab('FMrightMean [dB re: 1 Hz]') + annotate("text", x = -2, y = 20, size =8, label = paste("R = ", signif(sqrt(summary(m_fm_aud500)$r.squared), 3),  " \nP =",signif(summary(m_fm_aud500)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
