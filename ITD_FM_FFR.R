dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSetBehaviorEEG_ITD_FFR.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$ABR <- (dat$ABRneg + dat$ABRpos)/2
dat$FFR1Kmag_nor <- 20 * log10(dat$FFR1Kmag / dat$ABR)
dat$FFR1kmagdB <- 20 * log10(dat$FFR1Kmag/1e-6)
dat$lat180dB <- 10 * log10(dat$ERPn1lat180/0.1) + 10 * log10(dat$ERPp2lat180/0.2)

m_itd_ffr_nor = lm(ITDmean ~ FFR1Kmag_nor, data = dat, na.action = na.exclude)
m_itd_lat = lm(ITDmean ~ mistakeITD + lat180dB, data = dat, na.action = na.exclude)
m_itd_ffr = lm(ITDmean ~ FFR1kmagdB, data = dat, na.action = na.exclude)
p_itd_ffr <- ggplot(aes(x = ITDmean, y = FFR1kmagdB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_ffr + xlab('ITD [dB re: 1 us]') + ylab('FFR magnitude [dB]') + annotate("text", x = 24, y = 35, size = 8, label = paste("R = ", signif(sqrt(summary(m_itd_ffr)$r.squared), 3),  " \nP =",signif(summary(m_itd_ffr)$coef[2,4], 3), "\n n = 25")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
#+ ggtitle('ITD threshold vs FFR 1 KHz component')


m_itd_ffr_lat = lm(ITDmean ~ mistakeITD + FFR1kmagdB + lat180dB, data = dat, na.action = na.exclude)
dat$ITDmeanPredicted <- predict(m_itd_ffr_lat)
#dat$ITDmeanPredicted <- predict(m_itd_lat)
m_itd_pred = lm(ITDmean ~ ITDmeanPredicted, data = dat)
p_itd_pred <- ggplot(aes(x = ITDmeanPredicted, y = ITDmean), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_pred + xlab('Predicted ITD thresholds [dB re: 1 us]') + ylab('ITD thresholds [dB re: 1 us]') + annotate("text", x = 26, y = 35, size = 7, label = paste("R = ", signif(sqrt(summary(m_itd_pred)$r.squared), 3),  " \nP =",signif(summary(m_itd_pred)$coef[2,4], 3), "\n n = 26")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 22))
#ggtitle('Predicted vs actual ITD thresholds')