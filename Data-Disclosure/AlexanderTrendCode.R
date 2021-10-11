rm(list = ls())

library('trend')
library('RSPS')
library(MASS)
library(tseries)
library(smooth)

#######################
#set working directory and file input accordingly
setwd("~/Box Sync/R")

dat=read.table('data.csv',sep=',',header=T)
year=dat$year
startyear=year[1]
endyear=year[length(year)]

#######################
tind<-16
counts=dat[,tind]
year=dat[,1]
newframe=data.frame(counts=counts)
newframe$year=year

####Loop to perform trend analysis for each state/district#######
slope <- rep(0,51)
pvalue <- rep(0,51)
for (i in 2:51){
  if(all(dat[,i] == 0)){next}
  else{
    counts=dat[,i]
    year=dat[,1]
    newframe=data.frame(counts=counts)
    newframe$year=year
    nbGLM <- glm.nb(counts~year, data=newframe)
    
    slope[i] <- summary(nbGLM)$coefficients[2,1]
    pvalue[i]<- summary(nbGLM)$coefficients[2,4]
  }
}
write.table(slope, file="slope.txt", row.names=FALSE, col.names=FALSE)
write.table(pvalue, file="pvalue.txt", row.names=FALSE, col.names=FALSE)