#setwd('~/DataAnalysis/BehaviorDataAnalysis/')
#dat <- read.csv('dataSetBehavior.csv', header = TRUE)
dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetBehavior.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$FMmedian <- (dat$FMleftMedian + dat$FMrightMedian)/2

m_behavior <- lm(ITDmax ~ FMmedian, data = dat) 
Anova(m_behavior)

p_behavior <- ggplot(aes(x = FMmedian, y = ITDmax), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_behavior + xlab('FM [dB re: 1 Hz]') + ylab('ITD [dB re: 1 us]') + ggtitle('ITD vs FM thresholds') + annotate("text", x = 12, y = 44.5, size =8, label = paste("R = ", signif(sqrt(summary(m_behavior)$r.squared), 3),  " \nP =",signif(summary(m_behavior)$coef[2,4], 3), "\n n = 36")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))

m_itd_res <- lm(ITDmax ~ mistakeITD, data = dat)
dat$residITD <- resid(m_itd_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmLeft_res <- lm(FMleftMedian ~ mistakeFMLeft, data = dat)
dat$residFMleft <- resid(m_fmLeft_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmRight_res <- lm(FMrightMedian ~ mistakeFMRight, data = dat)
dat$residFMright <- resid(m_fmRight_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

dat$residFMmedian <- (dat$residFMleft + dat$residFMright)/2

m_behavior_res <- lm(residITD ~ residFMmedian, data = dat) 
Anova(m_behavior_res)

p_behavior_res <- ggplot(aes(x = residFMmedian, y = residITD), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_behavior_res + xlab('FM [dB re: 1 Hz]') + ylab('ITD [dB re: 1 us]') + ggtitle('ITD vs FM thresholds (with attention score factored out)') + annotate("text", x = 5, y = -4, size =8, label = paste("R = ", signif(sqrt(summary(m_behavior_res)$r.squared), 3),  " \nP =",signif(summary(m_behavior_res)$coef[2,4], 3), "\n n = 36")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
