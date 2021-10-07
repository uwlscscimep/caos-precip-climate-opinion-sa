* Encoding: UTF-8.
*Code to clean ANES and climate merged data file
*created by Sarah Alexander, University of Wisconsin-Madison, 2021.

*------display some summary statistics of key variables for the analysis---------------------------------------.
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=V161010d V163001a V161342 V161267 V161158x V161126 V161127 V161310x 
    V161264x V161265x V161241 V161242 V161270 V161361x V161324 V161331x V161334 V161330 V161008 
    V161009 V161495 V161221 V161222 V161224 V161224a V161225x V162112
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*Check correlation of length of time in current community and home ownership.
CORRELATIONS V161331x V161334.

*------set ANES negatives to missing values--------------------------------------------------------------.
missing values V161010d V163001a V161342 V161267 V161158x V161126 V161127 V161310x 
    V161264x V161265x V161241 V161242 V161270 V161361x V161324 V161331x V161334 V161330 V161008 
    V161009 V161495 V161221 V161222 V161224 V161224a V161225x V162112 V161263 V161265x (-9 to -1).

*------create a subset of the dataset that omits respondents who have been at current addres <2 years, do not have 
a GHCN gage ID <5 km away or have key variables with missing data-------------------------------------------.
*intermediate variable to flag entries with gage station more than 5 km away.
compute gageTooFar=0.
if range(DISTKM,100,5000) gageTooFar=1.
value labels gageTooFar 0 'gage < 100km' 1 'gage > 100km'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=gageTooFar
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*intermediate variable to flag entries with respondents who have lived in the community less than 2 years.
compute tooRecent=0.
if range(V161331x,0,1.999) tooRecent=1.
value labels tooRecent 0 'lived in community > 2 years' 1 'lived in community <2 years'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=tooRecent
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*intermediate variable to flag entries with respondents who have live in states we need to omit.
*omitting respondents in: AK, HA, DC, ID, WA, OR, MT, WY.
compute omitState=0.
if (state="AK" OR state="HI" OR state="DC" OR state="WA" OR state="ID" OR state="OR" OR state="MT" OR state="WY") omitState=1.
value labels omitState 0 'in a valid state' 1 'in a state that gets omitted'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=omitState
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*create one variable to mark which respondents to exclude from analysis.
compute includeFlag = 1.
if(omitState=1) includeFlag = 0.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=includeFlag
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*------add dummy variables for region------------------------------------------------------------------.
*reference is Ohio Valley (central) = MO, IL, IN, OH, WV, KY, TN.

compute south=0.
if (state="TX" OR state="OK" OR state="KS" OR state="AR" OR state="LA" OR state="MS") south=1.
value labels south 0 'not in south' 1 'south'.

compute southwest=0.
if (state="AZ" OR state="UT" OR state="CO" OR state="NM") southwest=1.
value labels southwest 0 'not in southwest' 1 'southwest'.

compute west=0.
if (state="CA" OR state="NV") west=1.
value labels west 0 'not in west' 1 'west'.

compute northwest=0.
if (state="OR" OR state="ID" OR state="WA") northwest=1.
value labels northwest 0 'not in northwest' 1 'northwest'.

compute rockyplains=0.
if (state="MT" OR state="WY" OR state="ND" OR state="SD" OR state="NE") rockyplains=1.
value labels rockyplains 0 'not in rockies or plains' 1 'Rockies/plains'.

compute upmidwest=0.
if (state="MN" OR state= "IA" OR state="WI" OR state="MI") upmidwest=1.
value labels upmidwest 0 'not in upper midwest' 1 'upper midwest'.

compute southeast=0.
if (state="AL" OR state="GA" OR state="FL" OR state="SC" OR state="NC" OR state="VA") southeast=1.
value labels southeast 0 'not in southeast' 1 'southeast'.

compute northeast=0.
if (state="MD" OR state="DC" OR state="DE" OR state="PA" OR state="NJ" OR state="NY" OR state="CT" OR
state="RI" OR state="VT" OR state="MA" OR state="NH" OR state="ME") northeast=1.
value labels northeast 0 'not in northeast' 1 'northeast'.

compute central=0.
if (state="MO" OR state="IL" OR state="IN" OR state="KY" OR state="TN" OR state="OH" OR state="WV") central=1.
value labels central 0 'not central' 1 'central'.

DESCRIPTIVES VARIABLES=south southwest west northwest rockyplains upmidwest southeast northeast central
  /STATISTICS=SUM MEAN STDDEV MIN MAX.

*------save cleaned dataset separately from original data-----------------------------------------------------.
*SAVE OUTFILE= 'ANESmergeSubset.sav'.

*------rename some ANES vars for ease of analysis-----------------------------------------------------------.
*Variable keys: V161267 (age), V161342 (gender), V161310x (race), V161270 (educ), V161361x (income), V161158x (pol party),
V161241 & V161242 (relig), V161008 & V161009 (newsAttn), V161331x (time in community), V161221 & V161222 (climateBelief).

compute age=V161267.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=age
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute gender=V161342.
missing values gender (3).
value labels gender - 1 'male' 2 'female'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=gender
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute income=V161361x.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=income
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute timeCommunity=V161331x.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=timeCommunity
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute polParty=V161158x.
value labels polParty - 1 'strong democrat' 2 'democrat' 3 'weak democrat' 4 'independent' 5 'weak republican' 6 'republican'
7 'strong republican'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=polParty
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*------add additional variables that combine questions in ANES-------------------------------------------------.
compute climateBelief=0.
if V161221=1 climateBelief=1. 
if V161221=-8 climateBelief=-8.
if V161221=-9 climateBelief=-9.

value labels climateBelief - 0 'CC probably not happening' 1 'CC probably happening'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=climateBelief
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute NoClimateBelief=0.
if V161221=2 NoClimateBelief=1.
if V161221=-8 NoClimateBelief=-8.
if V161221=-9 NoClimateBelief=-9.
value labels NoClimateBelief - 0 'believe in CC' 1 'do not believe in CC'.

compute anthroClimate=0.
if V161221=2 anthroClimate=-1. 
if V161221=1 and V161222=2 anthroClimate=0.
if V161221=1 and V161222=3 anthroClimate=1.
if V161221=1 and V161222=1 anthroClimate=2.
if V161221=-8 anthroClimate=-8.
if V161221=-9 anthroClimate=-9.

value labels anthroClimate - 0 'yes, natural cause' 1 'yes, both cause' 2 'yes, human cause'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=anthroClimate
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*0 'relig guidance not important' 1 'some' 2 'quite a bit' 3 'a great deal'.
compute relig=0.
if V161241=2 relig=0. 
if V161241=1 and V161242=1 relig=1.
if V161241=1 and V161242=2 relig=2.
if V161241=1 and V161242=3 relig=3.
if V161241=-8 OR V161242=-8 relig=-8.
if V161241=-9 OR V161242=-9 relig=-9.

value labels relig - 0 'relig guidance not important' 1 'some' 2 'quite a bit' 3 'a great deal'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=relig
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute evangelical=0.
if V161265x=2 evangelical=1.
if V161265x=-2 evangelical=-2.
FREQUENCIES VARIABLES=evangelical
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute bornagain=0.
if V161263=1 bornagain=1.
if (V161263=-4) bornagain = -4.
if (V161263=-8) bornagain = -8.
if (V161263=-9) bornagain = -9.
FREQUENCIES VARIABLES=bornagain
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*0 'no media attn' 1 'a little' 2 'a moderate amount' 3 'a lot' 4 'a great deal'.
compute newsAttn=0.
if V161008=0 newsAttn=0. 
if V161009=5 newsAttn=0.
if V161009=4 newsAttn=1.
if V161009=3 newsAttn=2.
if V161009=2 newsAttn=3.
if V161009=1 newsAttn=4.
if V161008=-8 newsAttn=-8.
if V161009=-1 newsAttn=-1.
if V161008=-9 OR V161009=-9 newsAttn=-9.

value labels newsAttn - 0 'no media attn' 1 'a little' 2 'a moderate amount' 3 'a lot' 4 'a great deal'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=newsAttn
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*partisan tv viewing variables come specifically from people who said yes to:
HEARD ABOUT PRES CAMPAIGN ON TV NEWS/TALK/PUBLIC AFFAIRS/ NEWS ANALYSIS PROG(S)
follow-up was: if that's true, then which of the following television programs do you watch regularly? 
Please check any that you watch at least once a month. (Mark all that apply) Randomized response option order
0 - not selected
1 - selected.
*compute variable for fox news tv viewing.
compute anyfoxtv = 0.
if (V161370=1 OR V161409 = 1 OR V161372 = 1) anyfoxtv = 1.
fre anyfoxtv.
VALUE LABELS
anyfoxtv
0 '0 - does not watch fox tv opinion at least once a month'
1 '1 - watches fox tv opinion at least once a month'.
fre anyfoxtv.

*compute variable for msnbc news tv viewing.
compute anymsnbctv = 0.
if (V161365=1 OR V161386 = 1 OR V161393 = 1) anymsnbctv = 1.
fre anymsnbctv.
VALUE LABELS
anymsnbctv
0 '0 - does not watch msnbc tv opinion at least once a month'
1 '1 - watches msnbc tv opinion at least once a month'.
fre anymsnbctv.

*0 'white' 1 'nonwhite'.
compute race=0.
if V161310x=1 race=0. 
if V161310x=2 race=1.
if V161310x=3 race=1.
if V161310x=4 race=1.
if V161310x=5 race=1.
if V161310x=6 race=1.
if V161310x=-2 race=-2.

value labels race - 0 'white' 1 'nonwhite'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=race
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*1 'less 1st' 2 '1-4th gr' 3 '5-6 gr' 4 '7-8 gr' 5 '9 gr' 6 '10 gr' 7 '11 gr' 8 '12gr no diploma' 9 'HS diploma/GED' 10 'some college'
11 ' associate deg' 13 'bachelor deg' 14 'MS degree' 15 'Prof/doctorate'.
compute educ=V161270.
if V161270=90 educ=9. 
if V161270=12 educ=11.
if V161270=13 educ=12.
if V161270=14 educ=13.
if V161270=15 educ=14.
if V161270=16 educ=14.
missing values V161270 (95).
if V161270=-9 educ=-9.

value labels educ - 1 'less than 1st' 2 '1-4th gr' 3 '5-6 gr' 4 '7-8 gr' 5 '9 gr' 6 '10 gr' 7 '11 gr' 8 '12gr no diploma' 9 'HS diploma/GED' 
10 'some college' 11 ' associate deg' 12 'bachelor deg' 13 'MS degree' 14 'Prof/doctorate'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=educ
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*standardize education and income and combine into socioeconomic status variable.
DESCRIPTIVES VARIABLES=income educ
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

compute socioecon=MEAN(Zincome,Zeduc).

FREQUENCIES VARIABLES=socioecon
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

*compute polideology.
recode V161126 (1 thru 7 = copy) into polideology.
if V161126=99 and V161127=1 polideology=3.
if V161126=99 and V161127=2 polideology=5.
if V161126=99 and V161127=3 polideology=4.
if V161127=-8 polideology=-8.
if V161127=-9 polideology=-9.

value labels polideology - 1 'ext liberal' 2 'liberal' 3 'slight liberal' 4 'moderate' 5 'slight conservative' 6 'conservative' 7 'ext conservative'.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=polideology
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

compute trustSci=V162112.
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=trustSci
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

missing values age gender race educ income polParty timeCommunity relig evangelical bornagain newsAttn
polideology trustSci anyfoxtv anymsnbctv climateFullBelief climateBelief anthroClimateAll anthroClimate (-9 to -1).

