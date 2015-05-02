source("common.R")
rankhospital <- function(state, outcome, num = "best",
                         datadir=NULL, csv="outcome-of-care-measures.csv") {
  ## Read outcome data
  outcomeData <- readCsvDir(datadir, csv)
  ## Convert data for the 30 day mortality of the outcomes to numeric
  envValsAsNumeric(environment(), "outcomeData", outcomes)
  ## Check that state and outcome are valid
  stopifbad(state, outcome, outcomeData)
  if (num != "best" && num != "worst" && is.na(as.numeric(num))) {
        stop("invalid num")
      }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  col <- outcomes[[outcome]]
  outcomeState <- subset(outcomeData, outcomeData[, 7] == state
                         & !is.na(outcome[,col])
  outcomeState <- outcomeState[order(outcomeState[,col], outcomeState[,2]),]
  if (num == "best") {
    outcomeState[1, 2]
  } else {
    if (num == "worst") {
      tail(outcomeState[, 2], n = 1)
    } else {
      outcomeState[num, 2]
    }
  }
}