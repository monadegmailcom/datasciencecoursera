rankall <- function( outcome, num = "best") {
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
  
  # get vector of state names
  states <- sort(unique(dt$State))
  
  hv <- character(0)
  
  for (state in states)
  {
    outcomes <- dt[dt$State == state, c(2,col)]  

    # convert col to numeric
    outcomes[,2] <- as.numeric(outcomes[,2])
    
    # sort data by column col and hospital name
    ordering <- order(outcomes[,2],outcomes[,1])
    outcomes <- outcomes[ordering,]

    # ranked hospitals without NAs
    hos <- outcomes[!is.na(outcomes[,2]),1]

    # return ranked hospital
    i <- as.integer(num)
    result <- 
      if (!is.na(i)) hos[i]
    else if (num == "best") hos[1]
    else if (num == "worst") hos[length(hos)]
    else NA

    hv <- append( hv, result ) 
  }
    
  data.frame( hospital = hv, state = states)
}
