* Encoding: UTF-8.
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
  /METHOD=ENTER age gender race socioecon 
  /METHOD=ENTER polParty relig evangelical timeCommunity 
  /METHOD=ENTER newsAttn anyfoxtv anymsnbctv
  /PRINT=CI(95) GOODFIT
  /SAVE=PRED PGROUP
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*FINAL MODEL: cause of climate change with all precipitation variables.
TEMPORARY.
select if (NoClimateBelief=0 AND includeFlag=1.00).
NOMREG anthroClimate (BASE=LAST ORDER=ASCENDING) WITH RecentRainfallAmount AnomalyAugJJARainfall ExtHighRIrainfall2016 
  TrendExtRainfall LongTermExtPreLowRI LongTermExtPreHighRI VariabilityAug2016 RecentExtMedRI age gender race socioecon polParty 
  relig evangelical timeCommunity newsAttn anyfoxtv anymsnbctv
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP
  /SAVE ESTPROB PREDCAT PCPROB.


