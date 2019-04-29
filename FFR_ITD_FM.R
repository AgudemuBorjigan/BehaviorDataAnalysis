library(lme4) 
library(car)
library(ggplot2)
dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetFFR_ITD_FM.csv', header = TRUE)
dat$avgLat180us <- (dat$n1lat180 + dat$p2lat180)/2
m_ffr <- lm(FFR_1KHz ~ ITD + FM + avgLat180us + ERP180, data = dat) # anova(m_itd)