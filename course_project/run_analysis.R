library(dplyr)

# make tidy data
# x_filename: X data
# y_filename: y data
# features: features data table
# labels: labels vector
read_data <- function( 
  x_filename, y_filename, sub_filename, features, labels )
{
  # read y data and replace var 1 with label names
  ydata <- 
    read.table( 
      y_filename,
      comment.char="", colClasses="numeric") %>% 
    tbl_df %>%
    # replace label indices by label names
    mutate( V1 = labels[V1])

  # read subjects
  subjects <- 
    read.table(
      sub_filename,
      comment.char="", colClasses="numeric") %>%
    tbl_df

  # read x data
  xdata <- 
    read.table( 
      x_filename,
      header=FALSE,comment.char="", colClasses="numeric") %>% 
    tbl_df 
  
  # select x vars from features data
  xdata <- xdata[,features$V1]

  # make syntactic correct features names
  feature_names <- make.names(features$V2)
  
  # rename x vars by features data with 
  names( xdata ) <- feature_names
  
  # add type, subject and activity column
  xdata <- mutate( xdata, subject = subjects$V1, activity = ydata$V1)
}

run_analysis <- function()
{
  # load features and filter rows with std and mean
  features <- 
    read.table("UCI HAR Dataset/features.txt") %>% 
    tbl_df %>%
    filter( grepl("std\\(\\)|mean\\(\\)", V2))
  
  # read label names
  labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

  # make tidy data for test data
  test <- read_data( 
    "UCI HAR Dataset/test/X_test.txt",
    "UCI HAR Dataset/test/y_test.txt",
    "UCI HAR Dataset/test/subject_test.txt",
    features,
    labels
    )

  # make tide data for train data
  train <- read_data( 
    "UCI HAR Dataset/train/X_train.txt",
    "UCI HAR Dataset/train/y_train.txt",
    "UCI HAR Dataset/train/subject_train.txt",
    features,
    labels
  )

  # merge into one data set
  bind_rows(train, test) %>%
  # group data by activity and subject
  group_by( activity, subject) %>%
  # summarise each variable
  summarise_each( funs(mean)) %>%
  # write table
  write.table("means.txt", row.name=FALSE)
}