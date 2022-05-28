#:::::::::::::::::::: MODEL AND PLOTS SCRIPT ::::::::::::::::::::::::::::: #
#   This file contains the code to read data from the 2016 ANES survey.
#   The data was cleaned/saved in SPSS. This code reads the SPSS
#   data file with that cleaning syntax already run. The cleaning syntax 
#   was produced by Sarah Alexander. This code was adapted from code 
#   developed by Chris Wirz and Mikhaila Calice. All authors were at the 
#   University of Wisconsin-Madison.
#
#### ::::: SET-UP :::::::::::::::::::::::::::::::::::::::::::::::::::::::: ####
library(haven)
library(psych)
library(sjPlot)
library(summarytools)
library(lattice)
library(jtools)
library(ggstance)
library(stats)
library(survival)
library(Formula)
library(ggplot2)
library(Hmisc)
library(expss)
library(here)
library(car)
library(foreign)
library(magrittr)
library(tidyverse)
library(dplyr)
library(sjmisc)
library(patchwork) 
library(ggeffects)
library(effects)

install.packages(c("haven", "psych", "sjPlot", "summarytools", "lattice", 
                   "jtools", "ggstance", "stats", "survival", "Formula", 
                   "ggplot2", "Hmisc", "expss", "here", "car", "foreign", 
                   "magrittr", "tidyverse", "dplyr","sjmisc","patchwork",
                   "ggeffects","effects"))

#### ::::: DATA :::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ####
#set working directory

# Entire dataset (raw+cleaned variables)
anes <- read.spss("file_name.sav",to.data.frame = TRUE, use.value.labels = F)

# Pulling only the cleaned variables needed for analyses
subanes <- subset(anes, select=c(climateBelief,
                             anthroClimate,
                             includeFlag,
                             DEFFWGT,
                             age,
                             gender,
                             socioecon,
                             polParty,
                             relig,
                             evangelical,
                             timeCommunity,
                             newsAttn,
                             anyfoxtv,
                             anymsnbctv,
                             RecentRainfallAmount,
                             AnomalyAugJJARainfall,
                             ExtHighRIrainfall2016,
                             TrendExtRainfall,
                             LongTermExtPreLowRI,
                             LongTermExtPreHighRI,
                             VariabilityAug2016,
                             RecentExtMedRI))

subanes$climateCause <- subanes$anthroClimate

for (i in 1:4270){
  if (is.na(subanes$climateCause[i]) == FALSE){
  if(subanes$climateCause[i] == 0){subanes$climateCause[i] <- "natural"}
  if(subanes$climateCause[i] == 1){subanes$climateCause[i] <- "both"}
  if(subanes$climateCause[i] == 2){subanes$climateCause[i] <- "human"}
}
}
subanes$climateCause <- as.factor(subanes$climateCause)
subanes3 <- subanes

subanes$climateBelief <- as.factor(subanes$climateBelief)
subanes$gender <- as.factor(subanes$gender)
subanes$polParty <- as.factor(subanes$polParty)
subanes$relig <- as.factor(subanes$relig)
subanes$evangelical <- as.factor(subanes$evangelical)
subanes$newsAttn <- as.factor(subanes$newsAttn)
subanes$anyfoxtv <- as.factor(subanes$anyfoxtv)
subanes$anymsnbctv <- as.factor(subanes$anymsnbctv)

anes$climateBelief <- as.factor(anes$climateBelief)
anes$gender <- as.factor(anes$gender)
anes$polParty <- as.factor(anes$polParty)
anes$relig <- as.factor(anes$relig)
anes$evangelical <- as.factor(anes$evangelical)
anes$newsAttn <- as.factor(anes$newsAttn)
anes$anyfoxtv <- as.factor(anes$anyfoxtv)
anes$anymsnbctv <- as.factor(anes$anymsnbctv)

#### :::::::::: Summary Reports :::::::::::::::::::::::::::::::::::::::::: ####

# Generates a report of variable names, labels and value labels 
sjPlot::view_df(subanes) # Just vars used

# Generates a report of basic descriptives for the data frame
summarytools::view(summarytools::dfSummary(subanes)) # Just vars used

#### :::::::::: Cleaning up labels ::::::::::::::::::::::::::::::::::::::: ####
subanes <- expss::apply_labels(subanes,
                            climateBelief = "Believe in CC (0 = no, 1 = yes)",
                            climateCause = "Believe cause of CC to be 0 = natural, 1 = both, 2 = human",
                            age = "Age (years)",
                            gender = "Gender (1 = male)",
                            socioecon = "Socioeconomic status",
                            polParty = "Partisanship (1 = strong dem, 5 = strong repub)",
                            relig = "Religiosity (1 = none; 5 = a lot)",
                            evangelical = "Evangelical (0 = no, 1 = yes)",
                            timeCommunity = "Length of time in current community (years.months)",
                            newsAttn = "Attention to media (0 = none, 4 = a great deal)",
                            anyfoxtv = "Watch Fox News > 1/mo (1 = yes, 0 = no)",
                            anymsnbctv = "Watch MSNBC News > 1/mo (1 = yes, 0 = no)",
                            RecentRainfallAmount = "Average rainfall few years prior to survey",
                            AnomalyAugJJARainfall = "Anomalous rainfall months prior to survey",
                            ExtHighRIrainfall2016 = "Extreme rainstorms year of survey",
                            TrendExtRainfall = "39-yr trend in extreme rain events",
                            LongTermExtPreLowRI = "39-yr number extreme events of low recurrance interval",
                            LongTermExtPreHighRI = "39-yr number of extreme events of high recurrance interval",
                            VariabilityAug2016 = "Variability in rainfall during Aug 2016",
                            RecentExtMedRI = "Number extreme events the last 3-5 years")

# More concise labels for plotting
subanes3 <- expss::apply_labels(subanes3,
                               climateBelief = "Believe in CC (0 = no, 1 = yes)",
                               climateCause = "Believe cause of CC to be 0 = natural, 1 = both, 2 = human",
                               age = "Age",
                               gender = "Gender",
                               socioecon = "Socioeconomic status",
                               polParty = "Partisanship",
                               relig = "Religiosity",
                               evangelical = "Evangelical",
                               timeCommunity = "Length of time in current community",
                               newsAttn = "Attention to media",
                               anyfoxtv = "Watch Fox News > 1/mo",
                               anymsnbctv = "Watch MSNBC News > 1/mo",
                               RecentRainfallAmount = "Average rainfall few years prior to survey",
                               AnomalyAugJJARainfall = "Anomalous rainfall months prior to survey",
                               ExtHighRIrainfall2016 = "Extreme rainstorms year of survey",
                               TrendExtRainfall = "39-yr trend in extreme rain events",
                               LongTermExtPreLowRI = "39-yr number extreme events of low recurrance interval",
                               LongTermExtPreHighRI = "39-yr number of extreme events of high recurrance interval",
                               VariabilityAug2016 = "Variability in rainfall during Aug 2016",
                               RecentExtMedRI = "Number extreme events the last 3-5 years")

#include the right respondents in the analysis
subanes2 <- subset(subanes,includeFlag==1)
subanes3 <- subset(subanes3,includeFlag==1)

# Apply dataset weight to be representative of the US population
DEFFWGT <- subset(subanes2, select=c(DEFFWGT))
DEFFWGT <- unlist(DEFFWGT)

#### :::::::::: Variables :::::::::::::::::::::::::::::::::::::::::::::::: ####
# ::::: Controls/IVS ::::: #
summarytools::freq(subanes2$age)
summarytools::freq(subanes2$gender)
summarytools::freq(subanes2$socioecon)
summarytools::freq(subanes2$polParty)
summarytools::freq(subanes2$relig)
summarytools::freq(subanes2$evangelical)
summarytools::freq(subanes2$timeCommunity)
summarytools::freq(subanes2$newsAttn)
summarytools::freq(subanes2$anyfoxtv)
summarytools::freq(subanes2$anymsnbctv)

# ::::: DVs ::::: #
summarytools::freq(subanes2$climateBelief) # believe in CC (yes/no)
summarytools::freq(subanes2$climateCause) # cause of CC (natural/both/human)


#### ::::: ANALYSES :::::::::::::::::::::::::::::::::::::::::::::::::::::: ####
# NOTE: Using 'summ' from the jtools package because it offers more flexibility
#       for reporting the results of regressions. The basic command is 'summary'
# NOTE: The 'scale = T' argument sets the output to std.coeffs,
#       the default (F) is unstd

#subanes3 has variables as continuous and less descriptive labels
# to use when plotting the odds ratio diagram (otherwise same as subanes2)
subanes3$polParty <- as.numeric(subanes3$polParty)
subanes3$relig <- as.numeric(subanes3$relig)
subanes3$gender <- as.numeric(subanes3$gender)
subanes3$evangelical <- as.numeric(subanes3$evangelical)
subanes3$newsAttn <- as.numeric(subanes3$newsAttn)
subanes3$anyfoxtv <- as.numeric(subanes3$anyfoxtv)
subanes3$anymsnbctv <- as.numeric(subanes3$anymsnbctv)

#### :::::::::: ANALYSES :::::::::::::::::::::::::::::::::::::::::::::: ####
# use subanes2 (subset based on includeFlag) unless running odds ratio diagrams
# or plotting categorical variables as continous, then use subanes3
mod.reg1 <- glm(climateBelief~
                        age+
                        gender+
                        socioecon+
                        polParty+
                        relig+
                        evangelical+
                        timeCommunity+
                        newsAttn+
                        anyfoxtv+
                        anymsnbctv+
                        RecentRainfallAmount+
                        AnomalyAugJJARainfall+
                        ExtHighRIrainfall2016+
                        TrendExtRainfall+
                        LongTermExtPreLowRI+
                        LongTermExtPreHighRI+
                        VariabilityAug2016+
                        RecentExtMedRI,
                      data = subanes2,
                      weights = DEFFWGT,
                      family = binomial)

summary(mod.reg1)
jtools::summ(mod.reg1, scale = T)
jtools::plot_summs(mod.reg1, Scale = T, plot.distributions = T)

subanes2$climateCause <- relevel(subanes2$climateCause, ref = "human")
subanes3$climateCause <- relevel(subanes3$climateCause, ref = "human")
mod.reg2 <- multinom(climateCause~
                        age+
                        gender+
                        socioecon+
                        polParty+
                        relig+
                        evangelical+
                        timeCommunity+
                        newsAttn+
                        anyfoxtv+
                        anymsnbctv+
                        RecentRainfallAmount+
                        AnomalyAugJJARainfall+
                        ExtHighRIrainfall2016+
                        TrendExtRainfall+
                        LongTermExtPreLowRI+
                        LongTermExtPreHighRI+
                        VariabilityAug2016+
                        RecentExtMedRI,
                      data = subanes2,
                      weights = DEFFWGT,
                      family = binomial)
summary(mod.reg2)

## extracting coefficients from the model and exponentiate
exp(coef(mod.reg2))

# set theme for plotting
set_theme(
  base = theme_blank(),
  title.color = "gray5",
  title.size = 1.2,
  axis.title.color = "gray5",
  axis.title.size = 1.2,
  axis.textsize = 1.2,
  axis.textcolor = "gray5",
  axis.linecolor = "gray5",
  axis.line.size = .5,
  legend.size = .7,
  legend.title.size = .8,
)

#::::::PLOT ODDS RATIOS:::::::::::::::#

plot_model(mod.reg1,vline.color = "grey",
           axis.lim = c(0.5,5),show.values = TRUE,value.size = 8, value.offset = .4,
           title = "Odds ratio for respondents' belief that climate change is happening")

plot_model(mod.reg2,vline.color = "grey",
           axis.lim = c(0.5,5),show.values = TRUE,value.size = 8, value.offset = .4,
           title = "Odds ratio for respondents' belief in the cause of climate change")

#::::::INTERACTIONS AND PLOTS::::::::#
# Run each interaction
interact.belief1 <- glm(climateBelief~
                         age+
                         gender+
                         socioecon+
                         polParty+
                         relig+
                         evangelical+
                         timeCommunity+
                         newsAttn+
                         anyfoxtv+
                         anymsnbctv+
                         RecentRainfallAmount+
                         AnomalyAugJJARainfall+
                         ExtHighRIrainfall2016+
                         TrendExtRainfall+
                         LongTermExtPreLowRI+
                         LongTermExtPreHighRI+
                         VariabilityAug2016+
                         RecentExtMedRI+
                         Zsocioecon*ZpolParty,
                       data = anes2,
                       weights = DEFFWGT,
                       family = binomial(link = "logit"))

interact.belief2 <- glm(climateBelief~
                         age+
                         gender+
                         socioecon+
                         polParty+
                         relig+
                         evangelical+
                         timeCommunity+
                         newsAttn+
                         anyfoxtv+
                         anymsnbctv+
                         RecentRainfallAmount+
                         AnomalyAugJJARainfall+
                         ExtHighRIrainfall2016+
                         TrendExtRainfall+
                         LongTermExtPreLowRI+
                         LongTermExtPreHighRI+
                         VariabilityAug2016+
                         RecentExtMedRI+
                         ZnewsAttn*ZpolParty,
                       data = anes2,
                       weights = DEFFWGT,
                       family = binomial(link = "logit"))

interact.belief3 <- glm(climateBelief~
                         age+
                         gender+
                         socioecon+
                         polParty+
                         relig+
                         evangelical+
                         timeCommunity+
                         newsAttn+
                         anyfoxtv+
                         anymsnbctv+
                         RecentRainfallAmount+
                         AnomalyAugJJARainfall+
                         ExtHighRIrainfall2016+
                         TrendExtRainfall+
                         LongTermExtPreLowRI+
                         LongTermExtPreHighRI+
                         VariabilityAug2016+
                         RecentExtMedRI+
                         ZVariabilityAug2016*ZnewsAttn,
                       data = anes2,
                       weights = DEFFWGT,
                       family = binomial(link = "logit"))

interact.belief4 <- glm(climateBelief~
                         age+
                         gender+
                         socioecon+
                         polParty+
                         relig+
                         evangelical+
                         timeCommunity+
                         newsAttn+
                         anyfoxtv+
                         anymsnbctv+
                         RecentRainfallAmount+
                         AnomalyAugJJARainfall+
                         ExtHighRIrainfall2016+
                         TrendExtRainfall+
                         LongTermExtPreLowRI+
                         LongTermExtPreHighRI+
                         VariabilityAug2016+
                         RecentExtMedRI+
                         ZVariabilityAug2016*Zrelig,
                       data = anes2,
                       weights = DEFFWGT,
                       family = binomial(link = "logit"))

# Plot the interaction figures
# SOCIOECON X POL PARTY
colors = c ("dodgerblue4", "darkgrey","indianred4")
p1s<-plot_model(interact.belief1, type = "pred", terms = c("socioecon[-4:2]","polParty[1,4,7]"),
                title = "The relationship between socioeconomic status and \nbelief in climate change differs based on political party",
                col=colors,
                legend.title = "Political Party \n(3-point scale)",
                
                axis.title = "Probability of belief in climate change") +
  labs(x = "Socioeconomic Status")

p1s

# NEWS ATTN X POL PARTY
colors = c ("dodgerblue4", "darkgrey","indianred4")
p2s<-plot_model(interact.belief2, type = "pred", terms = c("newsAttn[0:3]","polParty[1,4,7]"),
                title = "The relationship between news attention and \nbelief in climate change differs based on political party",
                col=colors, 
                legend.title = "Political Party \n(3-point scale)",
                
                axis.title = "Probability of belief in climate change") +
  labs(x = "News Attention (0 = none, 3 = a great deal)")

p2s

# VARIABILITY X NEWS ATTN
colors = c ("darkgrey","black")
p3s<-plot_model(interact.belief3, type = "pred", terms = c("VariabilityAug2016[all]","newsAttn[0,4]"),
                #mdrt.values = "all",
                title = "The relationship between variable rainfall and \nbelief in climate change differs based on news attention",
                col=colors,
                #axis.lim = c(30,100),
                legend.title = "News Attention \n(2-point scale)",
                axis.title = "Probability of belief in climate change") +
  labs(x = "Variability in rainfall in August 2016")

p3s 

# VARIABILITY X RELIG
colors = c ("darkgrey","black")
p4s<-plot_model(interact.belief4, type = "pred", terms = c("VariabilityAug2016","relig[0,3]"),
                title = "The relationship between recent rainfall and \nbelief in climate change differs based on religiosity",
                col=colors,
                #axis.lim = c(30,100),
                legend.title = "Religiosity \n(2-point scale)",
                axis.title = "Probability of belief in climate change") +
  labs(x = "Variability in rainfall in August 2016")

p4s 
