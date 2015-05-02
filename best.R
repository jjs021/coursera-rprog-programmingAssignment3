best <- function(state, outcome, datadir = NULL, csv = "outcome-of-care-measures.csv") {
  ## Read outcome data
  file <- csv
  if (!is.null(datadir)) {
    file <- paste(datadir,csv,sep="/")
  }
  outcomeData <- read.csv(file, colClasses = "character")
  ## Setup columns for outcome name
  if (!exists("outcomes")) {
    outcomes <- new.env(size = 3L)
    outcomes[["heart attack"]] <- 11
    outcomes[["heart failure"]] <- 17
    outcomes[["pneumonia"]] <- 23
  }
  ## Convert data for the 30 day mortality of the outcomes to numeric
  for (o in ls(outcomes)) {
    outcomeData[, outcomes[[o]]] <- as.numeric(outcomeData[, outcomes[[o]]])
  }
  ## Check that state and outcome are valid
  if (missing(state) || !(state %in% outcomeData[, 7])) {
    stop("invalid state")
  }
  if (missing(outcome) || !(outcome %in% ls(outcomes))) {
    stop("invalid outcome")
  }
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  col <- outcomes[[outcome]]
  stateMin <- min(outcomeData[,col]
                  [outcomeData[,7] == state], na.rm = TRUE)
  rows <- which(outcomeData[,col]==stateMin)
  names <- outcomeData[rows,2]
  min(names)
}