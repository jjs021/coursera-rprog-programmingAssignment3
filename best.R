source("common.R")
best <- function(state, outcome, datadir = NULL, csv = "outcome-of-care-measures.csv") {
  ## Read outcome data
  outcomeData <- readCsvDir(datadir, csv)
  ## Convert data for the 30 day mortality of the outcomes to numeric
  envValsAsNumeric(environment(), "outcomeData", outcomes)
  ## Check that state and outcome are valid
  stopifbadstate(state, outcomeData)
  stopifbadoutcome(outcome)
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcomeState <- subset(outcomeData, outcomeData[, 7] == state)
  col <- outcomes[[outcome]]
  stateMin <- min(outcomeState[,col], na.rm = TRUE)
  rows <- which(outcomeState[,col] == stateMin)
  names <- outcomeState[rows,2]
  min(names)
}