%% Data processing code for precipitation variables 
% Written by Sarah Alexander, University of Wisconsin-Madison, 2021

clc

%% Determine closest gage to each ZCTA (COLS B-C)

%load data - gage station latitude/longitude and ZCTA latitude/longitude

numZCTA = length(ZCTAlatlon);
gageid2 = string(gageid);
closeGage = string.empty;
distGage = NaN(numZCTA,2);

%loop through and find gage with the minimum distance for each ZCTA
for i = 1:numZCTA
    [d1km, d2km]=distance(ZCTAlatlon(i,:),gagelatlon);
    [M1,I1] = min(d1km);
    [M2,I2] = min(d2km);
    closeGage(i,1) = gageid2(I1);
    closeGage(i,2) = gageid2(I2);
    distGage(i,1) = M1;
    distGage(i,2) = M2;
end

%% Process the GHCN precipitation data (COLS D-AQ)
%load GHCN precipitation data from NOAA, omitting stations that
% have more than five years of missing data between 1979-2019. Years with
% more than 60 unrecorded days are considered missing for this analysis.
% https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily

%define variables to calculate
numseries = 2745;
stdLong3Yr = NaN(numseries,1);
stdLongYr = NaN(numseries,1);
stdAug = NaN(numseries,1);
stdJJA = NaN(numseries,1);

std12 = NaN(numseries,1);
std16 = NaN(numseries,1);
std18 = NaN(numseries,1);
std3y12 = NaN(numseries,1);
std3y16 = NaN(numseries,1);
std3y18 = NaN(numseries,1);
stdJJA12 = NaN(numseries,1);
stdJJA16 = NaN(numseries,1);
stdJJA18 = NaN(numseries,1);
stdAug12 = NaN(numseries,1);
stdAug16 = NaN(numseries,1);
stdAug18 = NaN(numseries,1);

stdTotLongYr = NaN;
stdTotLong3Yr = NaN;
stdTotAug = NaN;
stdTotJJA = NaN;

longAugCOV = NaN(numseries,1);
longJJACOV = NaN(numseries,1);
longYrCOV = NaN(numseries,1);
long3YrCOV = NaN(numseries,1);
Aug12COV = NaN(numseries,1);
JJA12COV = NaN(numseries,1);
Aug16COV = NaN(numseries,1);
JJA16COV = NaN(numseries,1);
Aug18COV = NaN(numseries,1);
JJA18COV = NaN(numseries,1);
COV2012 = NaN(numseries,1);
COV2016 = NaN(numseries,1);
COV2018 = NaN(numseries,1);
COV3y_2012 = NaN(numseries,1);
COV3y_2016 = NaN(numseries,1);
COV3y_2018 = NaN(numseries,1);
anomAug12COV = NaN(numseries,1);
anomJJA12COV = NaN(numseries,1);
anomAug16COV = NaN(numseries,1);
anomJJA16COV = NaN(numseries,1);
anomAug18COV = NaN(numseries,1);
anomJJA18COV = NaN(numseries,1);
anomCOV2012 = NaN(numseries,1);
anomCOV2016 = NaN(numseries,1);
anomCOV2018 = NaN(numseries,1);
anomCOV3y_2012 = NaN(numseries,1);
anomCOV3y_2016 = NaN(numseries,1);
anomCOV3y_2018 = NaN(numseries,1);
PerDiffAug12COV = NaN(numseries,1);
PerDiffJJA12COV = NaN(numseries,1);
PerDiffAug16COV = NaN(numseries,1);
PerDiffJJA16COV = NaN(numseries,1);
PerDiffAug18COV = NaN(numseries,1);
PerDiffJJA18COV = NaN(numseries,1);
PerDiffCOV2012 = NaN(numseries,1);
PerDiffCOV2016 = NaN(numseries,1);
PerDiffCOV2018 = NaN(numseries,1);
PerDiffCOV3y_2012 = NaN(numseries,1);
PerDiffCOV3y_2016 = NaN(numseries,1);
PerDiffCOV3y_2018 = NaN(numseries,1);

TotlongYrPRE = NaN(numseries,1);
Totlong3YrPRE = NaN(numseries,1);
TotlongAugPRE = NaN(numseries,1);
TotlongjjaPRE = NaN(numseries,1);
TotAug12PRE = NaN(numseries,1);
TotJJA12PRE = NaN(numseries,1);
TotAug16PRE = NaN(numseries,1);
TotJJA16PRE = NaN(numseries,1);
TotAug18PRE = NaN(numseries,1);
TotJJA18PRE = NaN(numseries,1);
TotPRE2012 = NaN(numseries,1);
TotPRE2016 = NaN(numseries,1);
TotPRE2018 = NaN(numseries,1);
TotPRE3y_2012 = NaN(numseries,1);
TotPRE3y_2016 = NaN(numseries,1);
TotPRE3y_2018 = NaN(numseries,1);

MNlongYrPRE = NaN(numseries,1);
MNlong3YrPRE = NaN(numseries,1);
MNlongAugPRE = NaN(numseries,1);
MNlongjjaPRE = NaN(numseries,1);
MNAug12PRE = NaN(numseries,1);
MNJJA12PRE = NaN(numseries,1);
MNAug16PRE = NaN(numseries,1);
MNJJA16PRE = NaN(numseries,1);
MNAug18PRE = NaN(numseries,1);
MNJJA18PRE = NaN(numseries,1);
MNPRE2012 = NaN(numseries,1);
MNPRE2016 = NaN(numseries,1);
MNPRE2018 = NaN(numseries,1);
MNPRE3y_2012 = NaN(numseries,1);
MNPRE3y_2016 = NaN(numseries,1);
MNPRE3y_2018 = NaN(numseries,1);
anomAug_2012 = NaN(numseries,1);
anomAug_2016 = NaN(numseries,1);
anomAug_2018 = NaN(numseries,1);
anomJJA_2012 = NaN(numseries,1);
anomJJA_2016 = NaN(numseries,1);
anomJJA_2018 = NaN(numseries,1);
anomYr_2012 = NaN(numseries,1);
anomYr_2016 = NaN(numseries,1);
anomYr_2018 = NaN(numseries,1);
anom3Yr_2012 = NaN(numseries,1);
anom3Yr_2016 = NaN(numseries,1);
anom3Yr_2018 = NaN(numseries,1);
STDanomAug_2012 = NaN(numseries,1);
STDanomAug_2016 = NaN(numseries,1);
STDanomAug_2018 = NaN(numseries,1);
STDanomJJA_2012 = NaN(numseries,1);
STDanomJJA_2016 = NaN(numseries,1);
STDanomJJA_2018 = NaN(numseries,1);
STDanomYr_2012 = NaN(numseries,1);
STDanomYr_2016 = NaN(numseries,1);
STDanomYr_2018 = NaN(numseries,1);
STDanom3Yr_2012 = NaN(numseries,1);
STDanom3Yr_2016 = NaN(numseries,1);
STDanom3Yr_2018 = NaN(numseries,1);

% Process and calculate coefficient of variation and total precipitation
m = month(dateS);
augidx = (m == 8);
jjaidx = ((m > 5) & (m < 9));

for i = 1:numseries
    pre = timeseries(i,:);
    TT = timetable(dateS,pre');
    T1 = retime(TT,'yearly','sum');
    TStd = retime(TT,'yearly',@std);
    T3 = retime(TT,'yearly','mean');
    T2 = table2array(T1);
    T2std = table2array(TStd);
    T4 = table2array(T3);
    aug = mean(reshape(pre(augidx),31,[]),'omitnan');
    jja = mean(reshape(pre(jjaidx),92,[]),'omitnan');
    augSum = sum(reshape(pre(augidx),31,[]),'omitnan');
    jjaSum = sum(reshape(pre(jjaidx),92,[]),'omitnan');
    augStd = std(reshape(pre(augidx),31,[]),'omitnan');
    jjaStd = std(reshape(pre(jjaidx),92,[]),'omitnan');
    
    % precipitation 
    Totlong3YrPRE(i,1) = mean(sum(reshape(T2(1:39),3,[]),1,'omitnan'),'omitnan');
    TotlongYrPRE(i,1) = mean(T2,'omitnan');
    TotlongAugPRE(i,1) = mean(augSum,'omitnan');
    TotlongjjaPRE(i,1) = mean(jjaSum,'omitnan');
      
    TotAug12PRE(i,1) = augSum(34);
    TotJJA12PRE(i,1) = jjaSum(34);
    TotAug16PRE(i,1) = augSum(38);
    TotJJA16PRE(i,1) = jjaSum(38);
    TotAug18PRE(i,1) = augSum(40);
    TotJJA18PRE(i,1) = jjaSum(40);
    
    TotPRE2012(i,1) = sum(pre(12054:12419),'omitnan');
    TotPRE2016(i,1) = sum(pre(13515:13881),'omitnan');
    TotPRE2018(i,1) = sum(pre(14246:14610),'omitnan');
    TotPRE3y_2012(i,1) = sum(pre(11324:12419),'omitnan');
    TotPRE3y_2016(i,1) = sum(pre(12785:13881),'omitnan');
    TotPRE3y_2018(i,1) = sum(pre(13150:14610),'omitnan');
    
    MNlongYrPRE(i,1) = mean(T4,'omitnan');
    MNlong3YrPRE(i,1) = mean(mean(reshape(T4(1:39),3,[]),1,'omitnan'),'omitnan');
    MNlongAugPRE(i,1) = mean(aug,'omitnan');
    MNlongjjaPRE(i,1) = mean(jja,'omitnan');
      
    MNAug12PRE(i,1) = aug(34);
    MNJJA12PRE(i,1) = jja(34);
    MNAug16PRE(i,1) = aug(38);
    MNJJA16PRE(i,1) = jja(38);
    MNAug18PRE(i,1) = aug(40);
    MNJJA18PRE(i,1) = jja(40);
    
    MNPRE2012(i,1) = mean(pre(12054:12419),'omitnan');
    MNPRE2016(i,1) = mean(pre(13515:13881),'omitnan');
    MNPRE2018(i,1) = mean(pre(14246:14610),'omitnan');
    MNPRE3y_2012(i,1) = mean(pre(11324:12419),'omitnan');
    MNPRE3y_2016(i,1) = mean(pre(12785:13881),'omitnan');
    MNPRE3y_2018(i,1) = mean(pre(13150:14610),'omitnan');
    
    % standard deviation for total precipitation
    stdTotLongYr = std(T2,'omitnan');
    stdTotLong3Yr = std(sum(reshape(T2(1:39),3,[]),1,'omitnan'),'omitnan');
    stdTotAug = std(augSum,'omitnan');
    stdTotJJA = std(jjaSum,'omitnan');
    
    % precipitation anomaly
    anomAug_2012(i,1) = TotAug12PRE(i,1)./TotlongAugPRE(i,1);
    anomAug_2016(i,1) = TotAug16PRE(i,1)./TotlongAugPRE(i,1);
    anomAug_2018(i,1) = TotAug18PRE(i,1)./TotlongAugPRE(i,1);
    anomJJA_2012(i,1) = TotJJA12PRE(i,1)./TotlongjjaPRE(i,1);
    anomJJA_2016(i,1) = TotJJA16PRE(i,1)./TotlongjjaPRE(i,1);
    anomJJA_2018(i,1) = TotJJA18PRE(i,1)./TotlongjjaPRE(i,1);
    anomYr_2012(i,1) = TotPRE2012(i,1)./TotlongYrPRE(i,1);
    anomYr_2016(i,1) = TotPRE2016(i,1)./TotlongYrPRE(i,1);
    anomYr_2018(i,1) = TotPRE2018(i,1)./TotlongYrPRE(i,1);
    anom3Yr_2012(i,1) = TotPRE3y_2012(i,1)./Totlong3YrPRE(i,1);
    anom3Yr_2016(i,1) = TotPRE3y_2016(i,1)./Totlong3YrPRE(i,1);
    anom3Yr_2018(i,1) = TotPRE3y_2018(i,1)./Totlong3YrPRE(i,1);
    
    STDanomAug_2012(i,1) = (TotAug12PRE(i,1)-TotlongAugPRE(i,1))./stdTotAug;
    STDanomAug_2016(i,1) = (TotAug16PRE(i,1)-TotlongAugPRE(i,1))./stdTotAug;
    STDanomAug_2018(i,1) = (TotAug18PRE(i,1)-TotlongAugPRE(i,1))./stdTotAug;
    STDanomJJA_2012(i,1) = (TotJJA12PRE(i,1)-TotlongjjaPRE(i,1))./stdTotJJA;
    STDanomJJA_2016(i,1) = (TotJJA16PRE(i,1)-TotlongjjaPRE(i,1))./stdTotJJA;
    STDanomJJA_2018(i,1) = (TotJJA18PRE(i,1)-TotlongjjaPRE(i,1))./stdTotJJA;
    STDanomYr_2012(i,1) = (TotPRE2012(i,1)-TotlongYrPRE(i,1))./stdTotLongYr;
    STDanomYr_2016(i,1) = (TotPRE2016(i,1)-TotlongYrPRE(i,1))./stdTotLongYr;
    STDanomYr_2018(i,1) = (TotPRE2018(i,1)-TotlongYrPRE(i,1))./stdTotLongYr;
    STDanom3Yr_2012(i,1) = (TotPRE3y_2012(i,1)-Totlong3YrPRE(i,1))./stdTotLong3Yr;
    STDanom3Yr_2016(i,1) = (TotPRE3y_2016(i,1)-Totlong3YrPRE(i,1))./stdTotLong3Yr;
    STDanom3Yr_2018(i,1) = (TotPRE3y_2018(i,1)-Totlong3YrPRE(i,1))./stdTotLong3Yr;
   
    % long-term standard deviation
    stdLongYr(i,1) = mean(T2std,'omitnan');
    stdLong3Yr(i,1) = mean(mean(reshape(T2std(1:39),3,[]),1,'omitnan'),'omitnan');
    stdAug(i,1) = mean(augStd,'omitnan');
    stdJJA(i,1) = mean(jjaStd,'omitnan');
    
    std12(i,1) = std(pre(12054:12419),'omitnan');
    std16(i,1) = std(pre(13515:13881),'omitnan');
    std18(i,1) = std(pre(14246:14610),'omitnan');
    std3y12(i,1) = std(pre(11324:12419),'omitnan');
    std3y16(i,1) = std(pre(12785:13881),'omitnan');
    std3y18(i,1) = std(pre(13150:14610),'omitnan');
    stdJJA12(i,1) = std(pre(12206:12297),'omitnan');
    stdJJA16(i,1) = std(pre(13667:13758),'omitnan');
    stdJJA18(i,1) = std(pre(14397:14488),'omitnan');
    stdAug12(i,1) = std(pre(12267:12297),'omitnan');
    stdAug16(i,1) = std(pre(13728:13758),'omitnan');
    stdAug18(i,1) = std(pre(14458:14488),'omitnan');
    
    % coefficient of variation
    longYrCOV(i,1) = stdLongYr(i,1)./MNlongYrPRE(i,1);
    long3YrCOV(i,1) = stdLong3Yr(i,1)./MNlong3YrPRE(i,1);
    longAugCOV(i,1) = stdAug(i,1)./MNlongAugPRE(i,1);
    longJJACOV(i,1) = stdJJA(i,1)./MNlongjjaPRE(i,1);
    Aug12COV(i,1) = stdAug12(i,1)./MNAug12PRE(i,1);
    JJA12COV(i,1) = stdJJA12(i,1)./MNJJA12PRE(i,1);
    Aug16COV(i,1) = stdAug16(i,1)./MNAug16PRE(i,1);
    JJA16COV(i,1) = stdJJA16(i,1)./MNJJA16PRE(i,1);
    Aug18COV(i,1) = stdAug18(i,1)./MNAug18PRE(i,1);
    JJA18COV(i,1) = stdJJA18(i,1)./MNJJA18PRE(i,1);
    COV2012(i,1) = std12(i,1)./MNPRE2012(i,1);
    COV2016(i,1) = std16(i,1)./MNPRE2016(i,1);
    COV2018(i,1) = std18(i,1)./MNPRE2018(i,1);
    COV3y_2012(i,1) = std3y12(i,1)./MNPRE3y_2012(i,1);
    COV3y_2016(i,1) = std3y16(i,1)./MNPRE3y_2016(i,1);
    COV3y_2018(i,1) = std3y18(i,1)./MNPRE3y_2018(i,1);
    
    anomAug12COV(i,1) = Aug12COV(i,1)./longAugCOV(i,1);
    anomJJA12COV(i,1) = JJA12COV(i,1)./longJJACOV(i,1);
    anomAug16COV(i,1) = Aug16COV(i,1)./longAugCOV(i,1);
    anomJJA16COV(i,1) = JJA16COV(i,1)./longJJACOV(i,1);
    anomAug18COV(i,1) = Aug18COV(i,1)./longAugCOV(i,1);
    anomJJA18COV(i,1) = JJA18COV(i,1)./longJJACOV(i,1);
    anomCOV2012(i,1) = COV2012(i,1)./longYrCOV(i,1);
    anomCOV2016(i,1) = COV2016(i,1)./longYrCOV(i,1);
    anomCOV2018(i,1) = COV2018(i,1)./longYrCOV(i,1);
    anomCOV3y_2012(i,1) = COV3y_2012(i,1)./long3YrCOV(i,1);
    anomCOV3y_2016(i,1) = COV3y_2016(i,1)./long3YrCOV(i,1);
    anomCOV3y_2018(i,1) = COV3y_2018(i,1)./long3YrCOV(i,1);
    
    PerDiffAug12COV(i,1) = (Aug12COV(i,1)-longAugCOV(i,1))./longAugCOV(i,1);
    PerDiffJJA12COV(i,1) = (JJA12COV(i,1)-longJJACOV(i,1))./longJJACOV(i,1);
    PerDiffAug16COV(i,1) = (Aug16COV(i,1)-longAugCOV(i,1))./longAugCOV(i,1);
    PerDiffJJA16COV(i,1) = (JJA16COV(i,1)-longJJACOV(i,1))./longJJACOV(i,1);
    PerDiffAug18COV(i,1) = (Aug18COV(i,1)-longAugCOV(i,1))./longAugCOV(i,1);
    PerDiffJJA18COV(i,1) = (JJA18COV(i,1)-longJJACOV(i,1))./longJJACOV(i,1);
    PerDiffCOV2012(i,1) = (COV2012(i,1)-longYrCOV(i,1))./longYrCOV(i,1);
    PerDiffCOV2016(i,1) = (COV2016(i,1)-longYrCOV(i,1))./longYrCOV(i,1);
    PerDiffCOV2018(i,1) = (COV2018(i,1)-longYrCOV(i,1))./longYrCOV(i,1);
    PerDiffCOV3y_2012(i,1) = (COV3y_2012(i,1)-long3YrCOV(i,1))./long3YrCOV(i,1);
    PerDiffCOV3y_2016(i,1) = (COV3y_2016(i,1)-long3YrCOV(i,1))./long3YrCOV(i,1);
    PerDiffCOV3y_2018(i,1) = (COV3y_2018(i,1)-long3YrCOV(i,1))./long3YrCOV(i,1);

end

%% Define variables for precipitation extremes (COLS AR-BU)

% load GHCN precipitation data

%define variables
numseries = 2745;
numyears = 41;

extremes = zeros(numseries,14975,7);
extremesPreVal = zeros(numseries,14975,7);
AllGageExtPre = NaN(numseries,numyears,7);

TotLongExt = NaN(numseries,7);
ExtAug12 = NaN(numseries,7);
ExtAug16 = NaN(numseries,7);
ExtAug18 = NaN(numseries,7);
ExtJJA12 = NaN(numseries,7);
ExtJJA16 = NaN(numseries,7);
ExtJJA18 = NaN(numseries,7);
Ext2012 = NaN(numseries,7);
Ext2016 = NaN(numseries,7);
Ext2018 = NaN(numseries,7);
Ext3y_2012 = NaN(numseries,7);
Ext3y_2016 = NaN(numseries,7);
Ext3y_2018 = NaN(numseries,7);
Ext5y_2012 = NaN(numseries,7);
Ext5y_2016 = NaN(numseries,7);
Ext5y_2018 = NaN(numseries,7);

% Run peaks over threshold, process results and calculate extreme precipitation values
m = month(dateS);
augidx = (m == 8);
jjaidx = ((m > 5) & (m < 9));

for i = 1:numseries 
    %Run POT code for 1,2,5,10,25,50,100-yr return intervals
    for j = 1:7
        thresh = idf(i,2,j); %threshold value
        X = timeseries(i,:); %DEFINE your data

        boo = X > thresh;               %find values over threshold
        crossings = diff(boo);          %find all threshold crossings
        upcross = find(crossings == 1); %find upcrossing
        [extr, indextr] = findpeaks(X,'MINPEAKHEIGHT',thresh);
                                        %picks off peaks over threshold
        for k = 1:length(indextr)
            extremes(i,indextr(k),j) = 1;
            extremesPreVal(i,indextr(k),j) = extr(k);
        end
    end
    
    for a = 1:7
        %count extremes and assign to variables
        ExtPre = extremes(i,:,a);
        ExtPre = squeeze(ExtPre);
        augSum = sum(reshape(ExtPre(augidx),31,[]),'omitnan');
        jjaSum = sum(reshape(ExtPre(jjaidx),92,[]),'omitnan');

        TotLongExt(i,a) = sum(ExtPre);
        ExtAug12(i,a) = augSum(34);
        ExtAug16(i,a) = augSum(38);
        ExtAug18(i,a) = jjaSum(40);
        ExtJJA12(i,a) = jjaSum(34);
        ExtJJA16(i,a) = jjaSum(38);
        ExtJJA18(i,a) = jjaSum(40);
        Ext2012(i,a) = sum(ExtPre(12054:12419),'omitnan');
        Ext2016(i,a) = sum(ExtPre(13515:13881),'omitnan');
        Ext2018(i,a) = sum(ExtPre(14246:14610),'omitnan');
        Ext3y_2012(i,a) = sum(ExtPre(11324:12419),'omitnan');
        Ext3y_2016(i,a) = sum(ExtPre(12785:13881),'omitnan');
        Ext3y_2018(i,a) = sum(ExtPre(13150:14610),'omitnan');
        Ext5y_2012(i,a) = sum(ExtPre(10593:12419),'omitnan');
        Ext5y_2016(i,a) = sum(ExtPre(11324:13881),'omitnan');
        Ext5y_2018(i,a) = sum(ExtPre(12785:14610),'omitnan');
        
        % create matrix of counts by year for each station for trend
        TT = timetable(dateS,ExtPre');
        T1 = retime(TT,'yearly','sum');
        T2 = table2array(T1);
        AllGageExtPre(i,:,a) = T2;
           
    end
end

%% Process cluster results to identify # rainstorms for each ZIP (COLS BV-BX)

% load raw precipitation data from Wright et al. (2019)

% define variables
numYears = 41;
numGages = 2745;
rainclusters = zeros(numGages, numYears);
rainclustersHead = [1979:1:2019];
gage = string(gageid);

exceedanceClusterNoProc = exceedanceClusterNo;
LatLonYrProc = LatLonYr;
gageListProc = gageList;
clusterNo = zeros(numGages, numYears);
clusterHead = [1979:1:2019];

% go through and mark duplicate gage entries for the same cluster
% (i.e. station listed twice because exceeded 2 yr and 5 yr)
for j = 1:length(exceedanceClusterNo)
    year = LatLonYr(j,3);
    indexYr = find(rainclustersHead==year);
    indexGage = find(gage(:,1)==gageList(j,1));
    if clusterNo(indexGage,indexYr) == exceedanceClusterNo(j,3) && clusterNo(indexGage,indexYr) ~= 0
        %[mark row]
        exceedanceClusterNoProc(j,3) = -1;
    else
        %[mark down cluster no]
        clusterNo(indexGage,indexYr) = exceedanceClusterNo(j,3);
    end
end

% index to get a processed list of gages per cluster
exceedanceClusterNoProcIDX = (exceedanceClusterNoProc(:,3) ~= -1);
exceedanceClusterNoProc2 = exceedanceClusterNoProc(exceedanceClusterNoProcIDX,:);
LatLonYrProc2 = LatLonYrProc(exceedanceClusterNoProcIDX,:);
gageListProc2 = gageListProc(exceedanceClusterNoProcIDX,:);

% loop through cluster data and count # per year for gages
for i = 1:length(exceedanceClusterNoProc2)
    year = LatLonYrProc2(i,3);
    indexYr = find(rainclustersHead==year);
    indexGage = find(gage(:,1)==gageListProc2(i,1));
    rainclusters(indexGage,indexYr) = rainclusters(indexGage,indexYr) + 1;
end


NumClusters16 = rainclusters(:,38);
NumClusters3y16 = sum(rainclusters(:,34:36),2);
NumClusters5y16 = sum(rainclusters(:,32:36),2);

% Aggregate extremes to state level for trend analysis
% define variables
numseries = 2745;
numyr = 41;
StateExtPre_1yr = zeros(50,41);
StateExtPre_2yr = zeros(50,41);
StateExtPre_5yr = zeros(50,41);
StateExtPre_10yr = zeros(50,41);
StateExtPre_cluster = zeros(50,41);

% loop through and aggregate extremes by state
for i = 1:numseries
    indexGageState = find(StatesAlpha(:,1)== GageStateMatch(i,2));
    
    StateExtPre_1yr(indexGageState,:) = StateExtPre_1yr(indexGageState,:) + AllGageExtPre(i,:,1);
    StateExtPre_2yr(indexGageState,:) = StateExtPre_2yr(indexGageState,:) + AllGageExtPre(i,:,2);
    StateExtPre_5yr(indexGageState,:) = StateExtPre_5yr(indexGageState,:) + AllGageExtPre(i,:,3);
    StateExtPre_10yr(indexGageState,:) = StateExtPre_10yr(indexGageState,:) + AllGageExtPre(i,:,4);

end

% loop through and aggregate by state for clusters
for i = 1:numseries
    indexGageState = find(StatesAlpha(:,1)== GageStateMatch(i,2));
    StateExtPre_cluster(indexGageState,:) = StateExtPre_cluster(indexGageState,:) + rainclusters(i,:);
end

%% Compute trend in total precipitation across 1979-2019 (COLS BY-BZ)
% Uses non-parametric Mann Kendall and Theil Sen trend/significance tests
% Mann Kendall code from: https://www.mathworks.com/matlabcentral/fileexchange/11190-mann-kendall-tau-b-with-sen-s-method-enhanced

%load GHCN precipitation data
%Calculate the total annual precipitation from 1979-2019 for each station
numseries = 2745;
PreSeriesYrSum = NaN(41,numseries);
PreSeriesYrMean = NaN(41,numseries);
PreSeriesYrStd = NaN(41,numseries);

for i = 1:numseries
    pre = timeseries(i,:);
    TT = timetable(dateS,pre');
    T1 = retime(TT,'yearly','sum');
    TStd1 = retime(TT,'yearly',@std);
    T3 = retime(TT,'yearly','mean');
    Tsum = table2array(T1);
    Tstd = table2array(TStd1);
    Tmean = table2array(T3);
    
    PreSeriesYrSum(:,i) = Tsum;
    PreSeriesYrMean(:,i) = Tmean;
    PreSeriesYrStd(:,i) = Tstd;
end

%define variables
numseries = 2745;
yrs = [1979:1:2019]';
alpha = 0.1;
TotPre_trendsMK = NaN(numseries,11);
TotPre_trendsLM = NaN(4,numseries);

for i = 1:numseries
    %define data
    precip = PreSeriesYrSum(:,i);
    datain = cat(2,yrs,precip);
    wantplot = 0;

    %run Mann Kendall and Sen Slope
    [taub,tau,h,sig,Z,S,sigma,sen,n,senplot,CIlower,CIupper,D,Dall,C3]...
                   = ktaub(datain, alpha, wantplot);
               
    %save output to file
    TotPre_trendsMK(i,:) = [taub,tau,h,sig,Z,S,sigma,sen,n,CIlower,CIupper];
end


for j = 1:numseries
    precip = PreSeriesYrSum(:,j);
    mdl = fitlm(yrs,precip);
    
    TotPre_trendsLM(:,j) = table2array(mdl.Coefficients(2,:));
end

TotPre_trendsLM = TotPre_trendsLM';

for a = 1:2745
    if TotPre_trendsLM(a,4) < alpha
        TotPre_trendsLM(a,5) = 1;
    else
        TotPre_trendsLM(a,5) = 0;
    end
end

%pull just slopes for sig trends and 0 for others
MKtrend05 = NaN(numseries,1);
for i = 1:numseries
    if TotPre_trendsMK_05(i,3) == 1
        MKtrend05(i,:) = TotPre_trendsMK_05(i,8);
    else
        MKtrend05(i,:) = 0;
    end
end

%% Compute trend in extreme precipitation across 1979-2019 (COLS CA-CC)
% Aggregates number of peaks over threshold extreme events to the state
% level and uses a negative binomial regression

% load POT extreme precipitation data aggregated to the state level (as
% processed above) into R and run the following script:
% "AlexanderTrendCode.R"

%% FEMA Disaster Declarations (COLS CD-CE) 
% determine the number of flood declarations by ZCTA & year

% load US geographic crosswalk file
% load FEMA flood disaster declarations - available at https://www.fema.gov/about/openfema/data-sets

FEMA_DDF12 = zeros(33144,1);
FEMA_DDF16 = zeros(33144,1);
FEMA_DDF18 = zeros(33144,1);
FEMA_DDF3y12 = zeros(33144,1);
FEMA_DDF3y16 = zeros(33144,1);
FEMA_DDF3y18 = zeros(33144,1);

for i = 1:length(FEMA_DDF_1018)
  
    if FEMA_DDF_1018(i,1) == 2010
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y12(index,1) = FEMA_DDF3y12(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2011
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y12(index,1) = FEMA_DDF3y12(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2012
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y12(index,1) = FEMA_DDF3y12(index,1) + 1;
                FEMA_DDF12(index,1) = FEMA_DDF12(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2014
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y16(index,1) = FEMA_DDF3y16(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2015
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y16(index,1) = FEMA_DDF3y16(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2016
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y16(index,1) = FEMA_DDF3y16(index,1) + 1;
                FEMA_DDF3y18(index,1) = FEMA_DDF3y18(index,1) + 1;
                FEMA_DDF16(index,1) = FEMA_DDF16(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2017
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y18(index,1) = FEMA_DDF3y18(index,1) + 1;
            end
        end
    end
    if FEMA_DDF_1018(i,1) == 2018
        indexZIP = find(USGeogBoundCrosswalk(:,3)==FEMA_DDF_1018F(i,5));
        if isempty(indexZIP) == 0
            for j = 1:length(indexZIP)
                index = find(ZCTA(:,1)==USGeogBoundCrosswalk(indexZIP(j),2));
                FEMA_DDF3y18(index,1) = FEMA_DDF3y18(index,1) + 1;
                FEMA_DDF18(index,1) = FEMA_DDF18(index,1) + 1;
            end
        end
    end
end

%% Compute number of FEMA flood insurance claims and cost per year & ZIP code (COLS CF-CK)
% Pull csv of the claims cost and locations from:
% https://www.fema.gov/openfema-data-page/fima-nfip-redacted-claims-v1

% load US geographic crosswalk file
% load FEMA flood insurance claims and cost

%define variables
numclaims = 1341145;
DataSort = sortrows(FEMA_data,1);
FEMA_numClaims = zeros(41107,11);
FEMA_costContents = zeros(41107,11);
FEMA_costBuild = zeros(41107,11);

%count claims
for i = 855834:numclaims %855834 is the start of 2009
    if DataSort(i,1) == 2009
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,2) = FEMA_numClaims(indexZIP,2) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,2) = FEMA_costContents(indexZIP,2) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,2) = FEMA_costBuild(indexZIP,2) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2010
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,3) = FEMA_numClaims(indexZIP,3) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,3) = FEMA_costContents(indexZIP,3) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,3) = FEMA_costBuild(indexZIP,3) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2011
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,4) = FEMA_numClaims(indexZIP,4) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,4) = FEMA_costContents(indexZIP,4) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,4) = FEMA_costBuild(indexZIP,4) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2012
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,5) = FEMA_numClaims(indexZIP,5) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,5) = FEMA_costContents(indexZIP,5) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,5) = FEMA_costBuild(indexZIP,5) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2013
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,6) = FEMA_numClaims(indexZIP,6) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,6) = FEMA_costContents(indexZIP,6) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,6) = FEMA_costBuild(indexZIP,2) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2014
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,7) = FEMA_numClaims(indexZIP,7) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,7) = FEMA_costContents(indexZIP,7) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,7) = FEMA_costBuild(indexZIP,7) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2015
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,8) = FEMA_numClaims(indexZIP,8) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,8) = FEMA_costContents(indexZIP,8) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,8) = FEMA_costBuild(indexZIP,8) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2016
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,9) = FEMA_numClaims(indexZIP,9) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,9) = FEMA_costContents(indexZIP,9) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,9) = FEMA_costBuild(indexZIP,9) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2017
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,10) = FEMA_numClaims(indexZIP,10) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,10) = FEMA_costContents(indexZIP,10) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,10) = FEMA_costBuild(indexZIP,10) + DataSort(i,6);
        end
    end
    if DataSort(i,1) == 2018
        indexZIP = find(USGeogBoundCrosswalk(:,1)==DataSort(i,3));
        FEMA_numClaims(indexZIP,11) = FEMA_numClaims(indexZIP,11) + 1;
        if isnan(DataSort(i,7)) == 0
            FEMA_costContents(indexZIP,11) = FEMA_costContents(indexZIP,11) + DataSort(i,7);
        end
        if isnan(DataSort(i,6)) == 0
            FEMA_costBuild(indexZIP,11) = FEMA_costBuild(indexZIP,11) + DataSort(i,6);
        end
    end
end

%calculate aggregate variables for cost and claims
FEMA_totalCost = FEMA_costBuild+FEMA_costContents;
FEMA_claims16 = FEMA_numClaims(:,9);
FEMA_cost16 = FEMA_totalCost(:,9);
FEMA_claims3y16 = sum(FEMA_numClaims(:,7:9),2);
FEMA_cost3y16 = sum(FEMA_totalCost(:,7:9),2);
FEMA_claims5y16 = sum(FEMA_numClaims(:,5:9),2);
FEMA_cost5y16 = sum(FEMA_totalCost(:,5:9),2);

%% NOAA Storm Events Database (COLS CL-CM)
% pull data for the number of floods by zip code directly from NOAA online
% https://www.ncdc.noaa.gov/stormevents/

%% U.S. Climate Extremes Index (COL CN)
% pull data for each state directly from NOAA online and record for each
% zip code.
% https://www.ncdc.noaa.gov/extremes/cei/


