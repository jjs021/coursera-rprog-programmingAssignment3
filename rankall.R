source("common.R")
rankall <- function(outcome, num = "best",
                         datadir="data", csv="outcome-of-care-measures.csv") {
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
  col <- outcomes[[outcome]]
  outcomeData <- outcomeData[order(
    outcomeData[, 7], outcomeData[, col], outcomeData[, 2]),]
  stateOutcomes <- split(outcomeData, outcomeData[, 7])
  hospital <- lapply(stateOutcomes, function (d) {
    d <- subset(d, !is.na(d[, col]))
    if (num == "best") {
      d[1, 2]
    } else {
      if (num == "worst") {
        tail(d[, 2], n = 1)
      } else {
        d[num, 2]
      }
    }
  })
  state <- names(hospital)
  as.data.frame(cbind(hospital, state))
}
