dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSetBehaviorEEG_ITD.csv', header = TRUE)
str(dat) # structure of dat
# library for linear regression modeling
library(lme4)
library(car) 
library(ggplot2)

dat$FMmean <- (dat$FMleftMean + dat$FMrightMean)/2
dat$HL500 <- (dat$HL500left + dat$HL500right)/2
dat$HL500diff <- abs(dat$HL500left - dat$HL500right)
dat$HFA <- (dat$HFAleft + dat$HFAright)/2
dat$HFAdiff <- abs(dat$HFAleft - dat$HFAright)


m_itdMean_res <- lm(ITDmean ~ mistakeITD, data = dat)
dat$residITDmean <- resid(m_itdMean_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmLeft_res <- lm(FMleftMean ~ mistakeFMLeft, data = dat)
dat$residFMleft <- resid(m_fmLeft_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

m_fmRight_res <- lm(FMrightMean ~ mistakeFMRight, data = dat)
dat$residFMright <- resid(m_fmRight_res) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed

dat$residFMmean <- (dat$residFMleft + dat$residFMright)/2


dat$lat180 <- (dat$ERPn1lat180 + dat$ERPp2lat180)/2
dat$lat180dB <- 10 * log10(dat$ERPn1lat180/0.1) + 10 * log10(dat$ERPp2lat180/0.2)
dat$ERPmag180dB <- 20 * log10(dat$ERPmag180)
dat$ITCmag180dB <- 20 * log10(dat$ITCmag180)

# latencies
m_itdMean_lat <- lm(ITDmean ~ lat180dB, data = dat)
p_itdMean_lat <- ggplot(aes(x = ITDmean, y = lat180dB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_itdMean_lat + xlab('ITDmean [dB re: 1 us]') + ylab('Latency [dB re: 1 ms]\ncond: ITD = 180 us') + annotate("text", x = 24, y = 2, size = 8, label = paste("R = ", signif(sqrt(summary(m_itdMean_lat)$r.squared), 3),  " \nP =",signif(summary(m_itdMean_lat)$coef[2,4], 3), "\n n = 31")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
# + ggtitle('ITD threshold vs average of n1 and p2 latencies')

m_ITDmeanResid_lat <- lm(residITDmean ~ lat180dB, data = dat)
p_ITDmeanResid_lat <- ggplot(aes(x = residITDmean, y = lat180dB), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_ITDmeanResid_lat + xlab('ITD [residual]') + ylab('Latency [dB re: 1 ms]\ncond: ITD = 180 us') + annotate("text", x = -4, y = 2.1, size = 8, label = paste("R = ", signif(sqrt(summary(m_ITDmeanResid_lat)$r.squared), 3),  " \nP =",signif(summary(m_ITDmeanResid_lat)$coef[2,4], 3), "\n n = 31")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))

m_FMmeanResid_lat <- lm(residFMmean ~ lat180dB, data = dat)
m_FMmean_lat <- lm(FMmean ~ lat180dB, data = dat)
m_aud500_lat <- lm(HL500 ~ lat180dB, data = dat)
m_audHFA_lat <- lm(HFA ~ lat180dB, data = dat)

# magnitudes
m_ITDmean_mag_erp <- lm(ITDmean ~ ERPmag180dB, data = dat)
m_ITDmean_mag_itc <- lm(ITDmean ~ ITCmag180dB, data = dat)
m_ITDmeanResid_mag_erp <- lm(residITDmean ~ ERPmag180dB, data = dat)
m_ITDmeanResid_mag_itc <- lm(residITDmean ~ ITCmag180dB, data = dat)

m_FMmean_mag_erp <- lm(FMmean ~ ERPmag180dB, data = dat)
m_FMmean_mag_itc <- lm(FMmean ~ ITCmag180dB, data = dat)
m_FMmeanResid_mag_erp <- lm(residFMmean ~ ERPmag180dB, data = dat)
m_FMmeanResid_mag_itc <- lm(residFMmean ~ ITCmag180dB, data = dat)

m_audHFA_mag_erp <- lm(HFA ~ ERPmag180, data = dat)
p_audHFA_mag_erp <- ggplot(aes(x = HFA, y = ERPmag180), data = dat) + theme_classic() + geom_point(size = 3) + geom_smooth(method = "lm", col = "red", se = TRUE) 
p_audHFA_mag_erp + xlab('HFA') + ylab('ERP magnitude \ncond: ITD = 180 us') + annotate("text", x = -2, y = 3, size = 8, label = paste("R = ", signif(sqrt(summary(m_audHFA_mag_erp)$r.squared), 3),  " \nP =",signif(summary(m_audHFA_mag_erp)$coef[2,4], 3), "\n n = 32")) + theme_update(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size = 25))
m_audHFA_mag_itc <- lm(HFA ~ ITCmag180dB, data = dat)
m_aud500_mag_erp <- lm(HL500 ~ ERPmag180dB, data = dat)
m_aud500_mag_itc <- lm(HL500 ~ ITCmag180dB, data = dat)