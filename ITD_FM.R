#setwd('~/DataAnalysis/BehaviorDataAnalysis/')
#dat <- read.csv('dataSetBehavior.csv', header = TRUE)
dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetBehavior.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$FMmedian <- (dat$FMleftMedian + dat$FMrightMedian)/2

dat$HL500 <- (dat$HL500left + dat$HL500right)/2
dat$HL500diff <- abs(dat$HL500left - dat$HL500right)

dat$HL4K <- (dat$HL4Kleft + dat$HL4Kright)/2
dat$HL4Kdiff <- abs(dat$HL4Kleft - dat$HL4Kright)

#m_behavior <- lm(ITDmax ~ FMmedian + HL500 + HL500diff + HL4K + HL4Kdiff, data = dat) 
m_behavior <- lm(ITDmax ~ FMmedian, data = dat) 
Anova(m_behavior)

p_behavior <- ggplot(aes(x = FMmedian, y = ITDmax), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_behavior + xlab('Fdev [dB re: 500 Hz]') + ylab('ITD [dB re: 1 us]') + annotate("text", x = 12, y = 44.5, size =8, label = paste("R = ", signif(sqrt(summary(m_behavior)$r.squared), 3),  " \nP =",signif(summary(m_behavior)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
#ggtitle('ITD vs FM thresholds')

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
p_behavior_res + xlab('Fdev [residual]') + ylab('ITD [residual]') + annotate("text", x = 5, y = -4, size =8, label = paste("R = ", signif(sqrt(summary(m_behavior_res)$r.squared), 3),  " \nP =",signif(summary(m_behavior_res)$coef[2,4], 3), "\n n = 33")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 24))
#ggtitle('ITD vs FM thresholds (with attention score factored out)')
