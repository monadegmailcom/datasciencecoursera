best <- function( state, outcome) {
  ## Read outcome data
  dt <- read.csv(
    "rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", 
    colClasses = "character")
  
  # columns
  # Hospital.Name = 2
  # state = 7
  # heart attack = 11
  # heart failure = 17
  # pneumonia = 23

  # get outcome column col
  col <- if (outcome == "heart attack") 11
  else if (outcome == "heart failure") 17
  else if (outcome == "pneumonia") 23
  else stop( "invalid outcome" )
  
  # select data frame by hospital name, state and outcome, sort out na's
  dt <- dt[dt$State == state,c(2,7,col)]
  
  # check if data contains rows (valid state given)
  if (nrow(dt) == 0)
    stop( "invalid state")
  
  # convert col to numeric
  dt[,3] <- as.numeric(dt[,3])
  
  # sort data by column col and hospital name
  ordering <- order(dt[,3],dt[,1])
  dt <- dt[ordering,]
  
  # return best hospital
  dt[1,1]
}
