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
                             race,
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
subanes$race <- as.factor(subanes$race)
subanes$polParty <- as.factor(subanes$polParty)
subanes$relig <- as.factor(subanes$relig)
subanes$evangelical <- as.factor(subanes$evangelical)
subanes$newsAttn <- as.factor(subanes$newsAttn)
subanes$anyfoxtv <- as.factor(subanes$anyfoxtv)
subanes$anymsnbctv <- as.factor(subanes$anymsnbctv)

anes$climateBelief <- as.factor(anes$climateBelief)
anes$gender <- as.factor(anes$gender)
anes$race <- as.factor(anes$race)
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
                            race = "Race (0 = white, 1 = nonwhite)",
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

subanes3 <- expss::apply_labels(subanes3,
                               climateBelief = "Believe in CC (0 = no, 1 = yes)",
                               climateCause = "Believe cause of CC to be 0 = natural, 1 = both, 2 = human",
                               age = "Age",
                               gender = "Gender",
                               race = "Race",
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

subanes2 <- subset(subanes,includeFlag==1)
subanes3 <- subset(subanes3,includeFlag==1)

DEFFWGT <- subset(subanes2, select=c(DEFFWGT))
DEFFWGT <- unlist(DEFFWGT)

#### :::::::::: Variables :::::::::::::::::::::::::::::::::::::::::::::::: ####
# ::::: Controls/IVS ::::: #
summarytools::freq(subanes2$age)
summarytools::freq(subanes2$gender)
summarytools::freq(subanes2$race)
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
subanes3$race <- as.numeric(subanes3$race)
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
                        race+
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
                        race+
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
Anova(mod.reg2)

#order.terms = c(5,6,10,15,13,12,18)
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

plot_model(mod.reg1,vline.color = "grey",terms = c("socioecon","polParty","relig","anyfoxtv","RecentRainfallAmount","AnomalyAugJJARainfall","VariabilityAug2016","TrendExtRainfall"),
           axis.lim = c(0.5,5),show.values = TRUE,value.size = 8, value.offset = .4,
           title = "Odds ratio for respondents' belief that climate change is happening")

plot_model(mod.reg2,vline.color = "grey",terms = c("socioecon","polParty","relig","anyfoxtv","RecentRainfallAmount","AnomalyAugJJARainfall","VariabilityAug2016","TrendExtRainfall"),
           axis.lim = c(0.5,5),show.values = TRUE,value.size = 8, value.offset = .4,
           title = "Odds ratio for respondents' belief in the cause of climate change")

#::::::PLOT SINGLE VARS:::::::::::::::#

colors = c ("dodgerblue4","dodgerblue3","dodgerblue", "darkgrey", "indianred1","indianred3","indianred4")

# Input different variables to plot relation with climate beliefs
p1s<-plot_model(mod.reg1, type = "pred", terms = c("polParty[1,2,3,4,5,6,7]"),
                title = "The relationship between partisanship \nand belief in climate change",
                col=colors,
                axis.labels = c("Strong Dem","Dem","Dem Lean","Indep","Rep Lean","Repub","Strong Rep"))

p1s + scale_y_continuous(limits = c(0.5,1),labels = scales::percent)
