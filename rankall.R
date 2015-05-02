source("common.R")
rankall <- function(outcome, num = "best",
                         datadir=NULL, csv="outcome-of-care-measures.csv") {
  ## Read outcome data
  outcomeData <- readCsvDir(datadir, csv)
  ## Convert data for the 30 day mortality of the outcomes to numeric
  envValsAsNumeric(environment(), "outcomeData", outcomes)
  ## Check that num and outcome are valid
  stopifbadoutcome(outcome)
  stopifbadnum(num)
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}
