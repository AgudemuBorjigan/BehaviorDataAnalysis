# dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSetEEG.csv', header = TRUE)
dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetEEG.csv', header = TRUE)
library(lme4) # library for linear regression modeling
library(car) 
m <- lmer(EEG_ITC ~ Conditions + FM_avg + ITD_avg (1|Subject), data = dat)
m1<- lmer(EEG_ITC ~ Conditions (1|Subject), data = dat)
anova(m, m1) # it shows which model is better, the model listed at the bottom is the best
