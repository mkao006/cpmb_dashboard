########################################################################
## Title: Script for the FAO strategic objective scorecard.
## Date: 2013-08-02
########################################################################


SO = "so1"
path = paste0(getwd(), "/scorecard_", SO,"/")
template = "timeseries"
version = "A"
texFileName = paste0(SO, "scorecardsFAO", template, version, ".tex")
pdfFileName = gsub("tex", "pdf", texFileName)

## Data are taken from the Statistical yearbook for consistency
library(FAOSTAT)
source("package_scorecard.R")
source("metaToDissemination.R")

## Load dissemination file
dissemination.df =
  read.csv(file = paste0(path, SO, "_dissemination.csv"),
                              stringsAsFactors = FALSE)
dissemination.df = dissemination.df[which(dissemination.df[, paste0("SCORECARD_", version)]), ]

## Load statistical yearbook data
##
## NOTE (Michael): Need access to the SYB data base
load("~/Dropbox/SYBproject/RegionalBooks/Data/SO.RData")
## final.df = M49.lst$dataset
final.df = SO.df
final.df$UN_CODE = NULL
final.df$FAO_TABLE_NAME = NULL
final.df = final.df[final.df$Area == "Territory", ]

## Manually convert back zero to NA for GHG data
final.df[final.df$Year %in% c(2011:2013),
         grep("GHG", colnames(final.df), value = TRUE)] = NA

## Convert data to numeric and subset countries
final.df$FAOST_CODE = as.numeric(final.df$FAOST_CODE)
## final.df = final.df[which(final.df$FAOST_CODE %in%
##   na.omit(c(FAOregionProfile[!is.na(FAOregionProfile$UNSD_MACRO_REG),
##                              "FAOST_CODE"]))), ]

## Construct new variables
allData.df = arrange(final.df, FAOST_CODE, Year)
allData.dt = data.table(allData.df)
## allData.dt[, AQ.WAT.PROD.SH.NO := NV.AGR.TOTL.KD/AQ.WAT.WWAGR.MC.NO]
if(SO == "so4"){
  tmp = read.csv(file = "./old_manual_data/GV.VS.FPI.IN.NO.csv",
    header = TRUE, stringsAsFactors = FALSE)
  allData.dt = merge(allData.dt, tmp, by = "Year", all.x = TRUE)
}

## if(SO == "so5"){
##     tmp = read.csv(file = "./old_manual_data/TP.FO.AID.NO.csv",
##         header = TRUE, stringsAsFactors = FALSE)
##     allData.dt = merge(allData.dt, tmp, by = c("FAOST_CODE", "Year"),
##         all.x = TRUE)
##     allData.dt[, TP.FO.AID.SHP := (TP.FO.AID.NO * 1000)/POP.TOT]
## }

allData.df = data.frame(allData.dt)


## Take only variables required to be disseminated
SO.df = subset(allData.df,
  select = c("FAOST_CODE", "Year",
      intersect(dissemination.df$DATA_KEY, colnames(allData.df))))

SO.df = merge(SO.df,
  FAOcountryProfile[!is.na(FAOcountryProfile$FAOST_CODE),
                           c("FAOST_CODE", "ABBR_FAO_NAME")],
  all.x = TRUE, by = "FAOST_CODE")


## Check whether all variables are included
if(NROW(dissemination.df[which(dissemination.df[, paste0("SCORECARD_", version)]), c("DATA_KEY", "SERIES_NAME")][!dissemination.df[which(dissemination.df[, paste0("SCORECARD_", version)]), "DATA_KEY"] %in% colnames(SO.df),]) != 0L){
  warning("Some variables are not available in the data base, missing values are inserted")
  missVar = dissemination.df[which(dissemination.df[, paste0("SCORECARD_", version)]), c("DATA_KEY", "SERIES_NAME")][!dissemination.df[which(dissemination.df[, paste0("SCORECARD_", version)]), "DATA_KEY"] %in% colnames(SO.df),]
  cat(missVar[, 1], file = paste0(path, SO, "_missvar.txt"))
  SO.df[, missVar[, "DATA_KEY"]] = rep(NA, NROW(SO.df))  
}

## Scale the units
source("~/Dropbox/SYBproject/Packages/InternalCodes/scaleUnit.R")

thirdQuantileUnit = function(x){
  q3 = quantile(x, prob = 0.75, na.rm = TRUE)
  tmp = paste0("1e", as.numeric(nchar(as.character(round(q3)))) - 1)
  q3unit = eval(parse(text = tmp))
  q3unit
}

scale.df = data.frame(DATA_KEY = dissemination.df$DATA_KEY[dissemination.df$DATA_KEY %in%
  colnames(SO.df)],
  MULTIPLIER = sapply(SO.df[, dissemination.df$DATA_KEY[dissemination.df$DATA_KEY %in%
    colnames(SO.df)]],
  FUN = thirdQuantileUnit))

dissemination.df = merge(dissemination.df, scale.df, all.x = TRUE)


scaleVec = 1/dissemination.df$MULTIPLIER
names(scaleVec) = dissemination.df$DATA_KEY
sSO.df = scaleUnit(df = SO.df, multiplier = scaleVec)

## Melt into ER form
mSO.df = melt(sSO.df, id.var = c("FAOST_CODE", "ABBR_FAO_NAME",
                             "Year"))
mSO.df$variable = as.character(mSO.df$variable)
finalScorecards.df = merge(mSO.df,
  dissemination.df[, c("DATA_KEY", "SERIES_NAME", "TOPIC",
                       paste0("ORDER_", version),
                       "MULTIPLIER", "ORIG_UNIT")],
  all.x = TRUE, by.x = "variable", by.y = "DATA_KEY")


index = sapply(regexpr("\\(", finalScorecards.df$SERIES_NAME),
  FUN = function(x) x[[1]]) - 2
index[index == -3] = 1000000L
newQuantity = translateUnit(finalScorecards.df$MULTIPLIER)
newQuantity[is.na(newQuantity)] = ""

trim <- function(x){
  gsub("^[[:space:]]+|[[:space:]]+$", "", x)
}

newUnitName = trim(paste(newQuantity, " ", finalScorecards.df$ORIG_UNIT,
  sep = ""))

finalScorecards.df$SERIES_NAME =
  gsub("\\(\\)", "", paste(substr(finalScorecards.df$SERIES_NAME, 1,
                                  index), " (", newUnitName, ")",
                           sep = ""))


## Sort the data and change the column name
sortedFAO.df = arrange(finalScorecards.df,
    eval(parse(text = paste0("ORDER_", version))), FAOST_CODE, Year)



sortedFAO.df[, "SERIES_NAME"] = sanitize2(sortedFAO.df[, "SERIES_NAME"],
              type = "table")

## Rename the columns
colnames(sortedFAO.df)[colnames(sortedFAO.df) %in%
                       c("FAOST_CODE", "ABBR_FAO_NAME", "SERIES_NAME",
                         "TOPIC")] =
  c("areaCode", "areaName", "indicatorName", "topic")
scorecard.df = sortedFAO.df[, c("areaCode", "areaName", "Year",
  "variable", "indicatorName", "topic", "value")]

set.seed(587)
mySampleCountry = sample(x = scorecard.df$areaCode, size = 25)
scorecardFAO(variable = unique(scorecard.df$variable),
             data = scorecard.df[scorecard.df$areaCode %in%
                 mySampleCountry, ],
             file = paste0(path, texFileName),
             startYear = 2002, endYear = 2012,
             layout = template)

## Create meta data table
texMetaFileName = gsub("\\.", "Meta.", texFileName)
pdfMetaFileName = gsub("tex", "pdf", texMetaFileName)


cat("\\documentclass{faoyearbook}\\begin{document}",
    file = paste0(path, texMetaFileName), append = FALSE)
metaTable.df = dissemination.df[dissemination.df[,
    paste0("SCORECARD_", version)], ]
metaTable.df[, "SERIES_NAME"] = sanitize2(metaTable.df[, "SERIES_NAME"],
              type = "table")
metaTable.df[, "INFO"] = sanitize2(metaTable.df[, "INFO"],
              type = "table")
for(i in 1:NROW(metaTable.df)){
  cat("\\begin{metadata}{", metaTable.df[i, "SERIES_NAME"] ,"}{",
      metaTable.df[i, "DATA_KEY"], "}", metaTable.df[i, "INFO"],
      "\\end{metadata}", file = paste0(path, texMetaFileName), append = TRUE)
}
cat("\\end{document}", file = paste0(path, texMetaFileName),
    append = TRUE)



