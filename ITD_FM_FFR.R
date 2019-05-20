dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetBehaviorEEG_All.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)
dat$lat180dB <- 10 * log10(dat$n1lat180/0.1) + 10 * log10(dat$p2lat180/0.2)
dat$FFRmag1KdB <- 20 * log10(dat$FFRmag1K/1e-6)
m_itd_ffr_lat = lm(ITDmean ~ mistakeITD + FFRmag1KdB + lat180dB, data = dat, na.action = na.exclude)
dat$ITDmeanPredicted <- predict(m_itd_ffr_lat)
m_itd_pred = lm(ITDmean ~ ITDmeanPredicted, data = dat)
m_itd_ffr = lm(ITDmean ~ FFRmag1KdB, data = dat)

p_itd_ffr <- ggplot(aes(x = ITDmean, y = FFRmag1KdB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_ffr + xlab('ITD [dB re: 1 us]') + ylab('FFR magnitude [dB]') + ggtitle('ITD threshold vs FFR 1 KHz component') + annotate("text", x = 24, y = 35, size = 8, label = paste("R = ", signif(sqrt(summary(m_itd_ffr)$r.squared), 3),  " \nP =",signif(summary(m_itd_ffr)$coef[2,4], 3), "\n n = 26")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))

p_itd_pred <- ggplot(aes(x = ITDmeanPredicted, y = ITDmean), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_pred + xlab('Predicted ITD thresholds [dB re: 1 us]') + ylab('ITD thresholds [dB re: 1 us]') + ggtitle('Predicted vs actual ITD thresholds') + annotate("text", x = 25, y = 35, size = 8, label = paste("R = ", signif(sqrt(summary(m_itd_pred)$r.squared), 3),  " \nP =",signif(summary(m_itd_pred)$coef[2,4], 3), "\n n = 26")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
