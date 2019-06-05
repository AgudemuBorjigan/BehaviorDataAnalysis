dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetBehaviorEEG_ITD.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$FM <- (dat$FMleft + dat$FMright)/2

m_itd_res <- lm(ITD ~ mistakeITD, data = dat)
dat$residITD <- resid(m_itd_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

dat$lat180 <- (dat$ERPn1lat180 + dat$ERPp2lat180)/2
dat$lat180dB <- 10 * log10(dat$ERPn1lat180/0.1) + 10 * log10(dat$ERPp2lat180/0.2)
m_itd_lat <- lm(ITD ~ lat180dB, data = dat)

p_itd_lat <- ggplot(aes(x = ITD, y = lat180dB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itd_lat + xlab('ITD [dB re: 1 us]') + ylab('Latency [dB re: 1 ms]\ncond: ITD = 180 us') + annotate("text", x = 24, y = 2, size = 8, label = paste("R = ", signif(sqrt(summary(m_itd_lat)$r.squared), 3),  " \nP =",signif(summary(m_itd_lat)$coef[2,4], 3), "\n n = 32")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
# + ggtitle('ITD threshold vs average of n1 and p2 latencies')

m_ITDresid_lat <- lm(residITD ~ lat180dB, data = dat)
p_ITDresid_lat <- ggplot(aes(x = residITD, y = lat180dB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_ITDresid_lat + xlab('ITD [residual]') + ylab('Latency [dB re: 1 ms]\ncond: ITD = 180 us') + annotate("text", x = -4, y = 2.1, size = 8, label = paste("R = ", signif(sqrt(summary(m_ITDresid_lat)$r.squared), 3),  " \nP =",signif(summary(m_ITDresid_lat)$coef[2,4], 3), "\n n = 32")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
