complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  # initialize data vector accumulating values from all files specified by id 
  vs <- numeric( 0 )
  # iterate all files 
  for (i in id)
  {
    # evaluate file path
    file <- paste0(directory, "/", formatC(i, flag="0", width=3), ".csv")
    # read data frame
    data <- read.csv( file, colClasses=c(NA, "numeric", "numeric", NA) )
    # extract column vectors
    sul <- data$sulfate
    nit <- data$nitrate
    # get complete cases
    good <- complete.cases(sul, nit)
    # append number of valid rows
    vs <- append( vs, sum(good))
  }
  
  # build data frame
  frame <- data.frame( id=id, nobs=vs)
}