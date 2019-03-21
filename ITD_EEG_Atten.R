library(lme4) 
library(car)
library(ggplot2)
dat <- read.csv('~/DataAnalysis/BehaviorDataAnalysis/dataSetBhvrEEG.csv', header = TRUE)
# str(dat) # structure of dat

dat$block <- as.factor(dat$block) # converting block into category (factor/string) type

# using lm instead of lmer, lmer requirs random effects
m_itd <- lm(ITD ~ block + prctMstkITD, data = dat) # anova(m_itd)
m_fml <- lm(FMleft ~ prctMstkFMleft, data = dat) # didn't add "block" since FM data here is the same for every block
m_fmr <- lm(FMright ~ prctMstkFMright, data = dat) 
# plot(resid(m_fml), resid(m_fmr))
dat$residITD <- resid(m_itd) # adding residuals of the parameter to the data set, with the effect of certain factor(s) removed
dat$residFML <- resid(m_fml)
dat$residFMR <- resid(m_fmr)
dat$residFMavg <- (dat$residFMR + dat$residFML)/2
dat$avgLat180us <- (dat$n1lat180us + dat$p2lat180us)/2
m_FM <- lm(residITD ~ residFMR + residFML, data = dat) #anova(m_FM)
m_FMavg <-lm(residITD ~ residFMavg, data = dat)
m_mag180 <- lm(residITD ~ mag180us, data = dat)
m_n1lat180 <- lm(residITD ~ n1lat180us, data = dat)
m_p2lat180 <- lm(residITD ~ p2lat180us, data = dat)
m_avglat180 <- lm(residITD ~ avgLat180us, data = dat)

m_avglat180 <- lmer(residITD ~ avgLat180us + (1|Subject), data = dat)
# # for lmer, no need to include EEG data (mag&lat) from 20 or 60 us conditions, since most of them are 'nan'
# m_att <- lmer(ITD ~ block + prctMstkITD + (1|Subject), data = dat)
# Anova(m_att, test.statistic = 'F') # list significance of each factor
# summary(m_att)
# p <- ggplot(aes(x = prctMstkITD, y = ITD), data = dat) +geom_point(size = 4 + theme_classic()) 
# p