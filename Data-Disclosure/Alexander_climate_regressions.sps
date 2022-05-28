﻿* Encoding: UTF-8.
*Code to run regressions forANES  climate analyses.
*created by Sarah Alexander, University of Wisconsin-Madison, 2021.

******RUN CLEANING SCIPRT FIRST**********.

*set the appropriate weight.
compute DEFFWGT = V160101 / 1.45. 
weight by DEFFWGT. 

*---------------------------------LOGISTIC REGRESSIONS------------------------------------.

*FINAL MODEL: belief in climate change with all precipitation variables.
TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER RecentRainfallAmount AnomalyAugJJARainfall ExtHighRIrainfall2016 TrendExtRainfall LongTermExtPreLowRI 
  LongTermExtPreHighRI VariabilityAug2016 RecentExtMedRI
  /METHOD=ENTER age gender socioecon 
  /METHOD=ENTER polParty relig evangelical timeCommunity 
  /METHOD=ENTER newsAttn anyfoxtv anymsnbctv
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*---------------------------------Before-entries for belief in climate change model.
TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER RecentRainfallAmount
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER AnomalyAugJJARainfall
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER ExtHighRIrainfall2016
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER TrendExtRainfall
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER LongTermExtPreLowRI
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER LongTermExtPreHighRI
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER VariabilityAug2016
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER RecentExtMedRI
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER age
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER gender
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER socioecon
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER polParty
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER relig
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER evangelical
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER timeCommunity
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER newsAttn
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER anyfoxtv
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

TEMPORARY.
select if (includeFlag=1.00).
LOGISTIC REGRESSION VARIABLES climateBelief
  /METHOD=ENTER anymsnbctv
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*FINAL MODEL: cause of climate change with all precipitation variables.
TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH RecentRainfallAmount AnomalyAugJJARainfall ExtHighRIrainfall2016 
  TrendExtRainfall LongTermExtPreLowRI LongTermExtPreHighRI VariabilityAug2016 RecentExtMedRI age gender socioecon polParty 
  relig evangelical timeCommunity newsAttn anyfoxtv anymsnbctv
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.


*---------------------------------Before-entries for cause of climate change model.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH RecentRainfallAmount
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH AnomalyAugJJARainfall
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.


TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH ExtHighRIrainfall2016
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH TrendExtRainfall
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH LongTermExtPreLowRI
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH LongTermExtPreHighRI
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH VariabilityAug2016
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH RecentExtMedRI
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH age
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH gender
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH socioecon
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH polParty
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH relig
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH evangelical
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH timeCommunity
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH newsAttn
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH anyfoxtv
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.

TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH anymsnbctv
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.