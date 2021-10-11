# The impact of extreme precipitation events and their variability on climate change beliefs

## Instructions for how to reproduce the analysis

This study involves secondary analysis of public opinion data that has been supplemented with climate data. In order to reproduce the analyses, researchers need access to each of the dataset components: (1) The public opinion survey data, (2) the climate data, and (3) the “key” variable, which, in this case, is the survey respondents’ ZIP codes. The procedure for accessing each component is described below:

1. The public opinion data used for this project comes from a nationally-representative survey conducted in 2016 by the American National Election Studies (ANES). It can be freely downloaded at this URL: [https://electionstudies.org/data-center/2016-time-series-study/](https://electionstudies.org/data-center/2016-time-series-study/). 

2. The climate data, which were compiled by researchers at the University of Wisconsin – Madison (the authors of this text) are disclosed freely on this GitHub repository. The name of this file is “climate-data-supplement-for-merge-2106.csv.”
  - Researchers who wish to fully recreate the climate data supplement can do so by following the instructions outlined in the “Reproduce the climate supplement” section (see below).

3. The “key” to merge the public opinion data and the climate data. In order to merge the first two components together, researchers will need access to the ANES “2016 restricted geocodes” file, which is available by application: [https://www.icpsr.umich.edu/web/ICPSR/studies/38087](https://www.icpsr.umich.edu/web/ICPSR/studies/38087). Note that gaining access to these data will require IRB approval and a Data Use Agreement with ICPSR. The existence of these restrictions pertaining to the survey respondents’ geocode data means that we have neither the right nor the desire to publicly disclose these data on GitHub.

Once researchers have all the necessary data components, the climate data supplement can be imported into a statistical software program of the researchers’ choice and then merged with the public opinion data, using the ZIP code “key” as the common identifier. 

After the data merge is complete, researchers can proceed to reproduce our analyses—in the statistical analysis program SPSS—using the syntax files we provide in this GitHub repository. Finally, researchers can recreate the figures using the scripts we provide, which can be run in the statistical analysis program R. The procedure is as follows:

1. Import the merged dataset into SPSS. Use the SPSS syntax file titled “ANES_climate_cleaning.sps” to clean the data. 
2. Use the SPSS syntax file titled “ANES_climate_regressions.sps” to run the regression analyses.
3. Import the dataset into R and recreate the figures using R.


## Reproduce the climate supplement

For researchers who also want to reproduce the climate data supplement before merging with public opinion data, the procedure is as follows:

1. Open the “AlexanderClimateProcessCode.m” file in Matlab and load the following files into the workspace: “ghcnd-stations_LatLon.txt”, “ZCTA_noMissing_list.csv”, and “US_GeogBoundaryCrosswalk_Master.xlsx”. In a later section of the Matlab code, the “AlexanderTrendCode.R” file will be needed.
2. Download data from the following sources:
  - Global Historical Climatology Network (GHCN) precipitation data, which are publicly available online from NOAA: [https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily](https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily)
- Rainstorm cluster precipitation data, as defined in Wright et al. (2019), available upon request to the authors of that publication.
- Flood entries from the NOAA storm events database, which are publicly available online from NOAA [https://www.ncdc.noaa.gov/stormevents/](https://www.ncdc.noaa.gov/stormevents/)
- U.S. Climate Extremes Index, which are publicly available online from NOAA [https://www.ncdc.noaa.gov/extremes/cei/](https://www.ncdc.noaa.gov/extremes/cei/) 
- FEMA Disaster Declarations for the number of claims and costs for flood disasters, available publicly online [https://www.fema.gov/openfema-data-page/disaster-declarations-summaries-v2](https://www.fema.gov/openfema-data-page/disaster-declarations-summaries-v2) 
- Run each section of the code to process the climate data and generate the corresponding data columns in the “climate-supplement-for-merge-2016.csv” file.
