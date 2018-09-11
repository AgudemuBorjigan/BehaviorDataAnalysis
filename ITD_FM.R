dat <- read.csv('~/Desktop/Lab/PilotExperiment/DataAnalysis/BehaviorDataAnalysis/dataSet.csv', header = TRUE)

# str(dat) # structure of dat
dat$block <- as.factor(dat$block) # converting block into category (factor) type

library(lme4) # library for linear regression modeling
library(car) 

m <- lmer(ITD ~ FMleft + FMright + block + (1|Subject), data = dat)

anova(m) #Anova(m, test.statistic = 'F')
summary(m)

m2 <- lmer(ITD ~ block + (1|Subject), data = dat)

anova(m, m2) # it shows which model is better, the model listed at the bottom is the best

library(ggplot2)

p <- ggplot(aes(x = Subject, y = ITD), data = dat) + geom_violin() + theme_classic() # aes: aesthetics, violin plot

p <- ggplot(aes(x = Subject, y = ITD), data = dat) + geom_boxplot() + theme_classic()

p # show the plot

m3 <- lmer(ITD ~ block + X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data = dat)
# the category was '500Hzleft' in original dataset, but R doesn't allow vairable starting with number

m4 <- lmer(ITD ~ FMleft + FMright + block + X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data = dat)

anova(m3, m4)

whichWorse <- dat$FMleft < dat$FMright

dat$FMworse[whichWorse] <- dat$FMleft[whichWorse]
dat$FMworse[!whichWorse] <- dat$FMright[!whichWorse]

m5 <- lmer(ITD ~ FMworse + block +X500Hzleft + X500Hzright + X4000Hzleft + X4000Hzright + (1|Subject), data=dat)

anova(m3, m5)

p <- ggplot(aes(x = FMworse, y = ITD), data = dat) +geom_point() + theme_classic()

p

m6 <- lm(ITD ~ block, data = dat) # what's the difference between lm and lmer
dat$ITDadjBlock <- resid(m6) # removing the effect of blocks

p <- ggplot(aes(x = FMworse, y = ITDadjBlock), data = dat) + geom_point() +theme_classic()

p

m6 <- lmer(ITDadjBlock ~ (log10(FMworse)) + (1|Subject), data=dat)
m7 <- lmer(ITDadjBlock ~ (1|Subject), data=dat)
anova(m6, m7)
summary(m6)

dat$logFM <- log10(dat$FMworse)
p <- ggplot(aes(x=logFM, y=ITDadjBlock), data=dat) + geom_point() + theme_classic()
p

dat$logITD <- log10(dat$ITD)
m8 <- lmer(logITD ~ block + logFM + (1|Subject), data=dat)
m9 <- lmer(logITD ~ block + (1|Subject), data=dat)
anova(m8, m9)
