## Defines the column numbers for 30d mortality rates
## in Outcome of Care Measures csv
## Setup columns for outcome name
if (!exists("outcomes")) {
  outcomes <- new.env(size = 3L)
  outcomes[["heart attack"]] <- 11
  outcomes[["heart failure"]] <- 17
  outcomes[["pneumonia"]] <- 23
}

## Reads a csv from the current or a specific directory
readCsvDir <- function(datadir, csv) {
  stopifnot(!missing(datadir), !missing(csv))

  ## Read data
  file <- csv
  if (!is.null(datadir)) {
    file <- paste(datadir,csv,sep="/")
  }
  read.csv(file, colClasses = "character")
}


## Convert data for the 30 day mortality of the outcomes to numeric
## by passing in outcomes as the env and outcome data's variable name.
## UNFORTUNATELY ASSIGNMENTS DON'T APPLY TO THE CALLING SCOPE
## SO THE SCOPE ENVIRONMENT NEEDS TO BE PASSED
## FOR OVERWROUGHT PASS-BY-REFERECE; SERIOUSLY R CAN ... ITSELF
envValsAsNumeric <- function(dataenv, dataname, env) {
  stopifnot(!missing(dataenv), !missing(dataname),
            exists(dataname, where=dataenv), !missing(env))
  data<-get(dataname, pos=dataenv)
  for (o in ls(env)) {
    data[, env[[o]]] <- as.numeric(data[, env[[o]]])
  }
  assign(dataname, data, pos=dataenv)
}

## Stops if the state or outcome are not valid
stopifbad <- function(state, outcome, data) {
  ## Check that state and outcome are valid
  if (missing(state) || !(state %in% data[, 7])) {
    stop("invalid state")
  }
  if (missing(outcome) || !(outcome %in% ls(outcomes))) {
    stop("invalid outcome")
  }
}
