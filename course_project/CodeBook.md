## From raw to tidy data
The tidy data table "means.txt" contains for each activity and each subject the means of all recorded mean and standard deviation observations. From the raw data only the mean and standard deviation observations are selected and the test and train data sets are joined. Variables are named according to the label and subject files. All observations for each group are accumulated to means. Following variables are available:
- activity: categorical data with the 6 levels:
  - LAYING
  - SITTING
  - STANDING
  - WALKING
  - WALKING_DOWNSTAIRS
  - WALKING_UPSTAIRS
- subject: ordinal data enumerating the observed subject from 1 to 30
- 66 continuous observed acceleration  variables [m/s^2]
