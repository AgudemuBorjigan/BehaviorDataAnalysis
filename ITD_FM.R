dat <- read.csv('~/Desktop/Lab/Experiment/DataAnalysis/BehaviorDataAnalysis/dataSet.csv', header = TRUE)
# dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSet.csv', header = TRUE)
# str(dat) # structure of dat

dat$block <- as.factor(dat$block) # converting block into category (factor/string) type

library(lme4) # library for linear regression modeling
library(car) 

m <- lmer(ITD ~ FMleft + FMright + block + X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data = dat)
m1 <- lmer(ITD ~ block + X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data = dat) # outcome is model
# the category was '500Hzleft' in original dataset, but R doesn't allow vairable starting with number

anova(m, m1) # it shows which model is better, the model listed at the bottom is the best

whichWorse <- dat$FMleft < dat$FMright
dat$FMworse[whichWorse] <- dat$FMleft[whichWorse]
dat$FMworse[!whichWorse] <- dat$FMright[!whichWorse]
m2 <- lmer(ITD ~ FMworse + block +X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data=dat)
anova(m1, m2) # it reveals that "bad ear" FM is a better predictor than combining left and right FM, since it has lower p value

dat$FMbothEars <- (dat$FMleft + dat$FMright) / 2
m3 <- lmer(ITD ~ FMbothEars + block +X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data=dat)
anova(m1, m3)

dat$FMdifference <- abs(dat$FMleft - dat$FMright)
m4 <- lmer(ITD ~ FMdifference + block +X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data=dat)
anova(m, m4) 
#anova(m) #Anova(m, test.statistic = 'F')
#summary(m)

m5 <- lmer(ITD ~ FMleft + FMright + X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data = dat) # doesn't have block
anova(m, m5) # result shows there's no significance effect from blocks


m6 <- lmer(ITD ~ FMleft + FMright + block + X4000Hzleft + X4000Hzright + (1|Subject), data = dat)
anova(m, m6)

m7 <- lmer(ITD ~ FMleft + FMright + block + X500Hzleft + X500Hzright + (1|Subject), data = dat)
anova(m, m7)

# plots
library(ggplot2)
#p <- ggplot(aes(x = Subject, y = ITD), data = dat) + geom_violin() + theme_classic() # aes: aesthetics, violin plot
p <- ggplot(aes(x = Subject, y = ITD), data = dat) + geom_boxplot() + theme_classic()
p # show the plot

p <- ggplot(aes(x = Subject, y = dat$FMleft), data = dat) + geom_boxplot() + theme_classic()
p

p <- ggplot(aes(x = Subject, y = dat$FMright), data = dat) + geom_boxplot() + theme_classic()
p

dat$FMmeanBothEars <- (dat$FMleft+dat$FMright)/2
p <- ggplot(aes(x = Subject, y = dat$FMmeanBothEars), data = dat) + geom_boxplot() + theme_classic()
p


p <- ggplot(aes(x = FMworse, y = ITD), data = dat) +geom_point() + theme_classic()
p
# regressing out the block
m8 <- lm(ITD ~ block, data = dat) # what's the difference between lm and lmer
dat$ITDadjBlock <- resid(m8) # removing the effect of blocks

p <- ggplot(aes(x = FMworse, y = ITDadjBlock), data = dat) + geom_point() +theme_classic()
p

m9 <- lmer(ITDadjBlock ~ (log10(FMworse)) + (1|Subject), data=dat)
m10 <- lmer(ITDadjBlock ~ (1|Subject), data=dat)
anova(m9, m10)
summary(m9)

# log scale
dat$logFMWorse <- log10(dat$FMworse)
dat$logFMbothEars <- log10(dat$FMbothEars)
p <- ggplot(aes(x=logFMWorse, y=ITDadjBlock), data=dat) + geom_point() + theme_classic()
p

dat$logITD <- log10(dat$ITD)
m11 <- lmer(logITD ~ block + logFMWorse + (1|Subject), data=dat)
m12 <- lmer(logITD ~ block + (1|Subject), data=dat)
anova(m11, m12)

m13 <- lmer(logITD ~ EEG_20us + (1|Subject), data=dat)
m14 <- lmer(logITD ~ EEG_60us + (1|Subject), data=dat)
m15 <- lmer(logITD ~ EEG_180us + (1|Subject), data=dat)
m16 <- lmer(logITD ~ EEG_540us + (1|Subject), data=dat)
m17 <- lmer(logITD ~ EEG_avg + (1|Subject), data=dat)
m18 <- lmer(logITD ~ + (1|Subject), data=dat)
m19 <- lmer(logITD ~ EEG_mag20us + (1|Subject), data=dat)
m20 <- lmer(logITD ~ EEG_mag60us + (1|Subject), data=dat)
m21 <- lmer(logITD ~ EEG_mag180us + (1|Subject), data=dat)
m22 <- lmer(logITD ~ EEG_mag540us + (1|Subject), data=dat)
m23 <- lmer(logITD ~ EEG_mag_avg + (1|Subject), data=dat)

m24 <- lmer(logITD ~ EEG_20us + EEG_60us + EEG_180us + EEG_540us + (1|Subject), data=dat)
anova(m18, m13)
anova(m18, m14)
anova(m18, m15)
anova(m18, m16)
anova(m18, m17)

anova(m18, m19)
anova(m18, m20)
anova(m18, m21)
anova(m18, m22)
anova(m18, m23)
anova(m18, m24)
