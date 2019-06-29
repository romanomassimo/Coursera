# CodeBook

## Dimensions
|activity code | activity |
|--------------|--------------|
|1| WALKING|
|2| WALKING_UPSTAIRS|
|3| WALKING_DOWNSTAIRS|
|4| SITTING|
|5| STANDING|
|6| LAYING|

|Subject Id|
|----------|
|[1,30]

## Measurments
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.The body linear acceleration and angular velocity were derived in time to obtain Jerk signals.Fast Fourier Transform (FFT) was applied to frequency measurments.

Features are normalized and bounded within [-1,1].

|features|
|--------------------------------------|
|timeBodyAccelerometer-XYZ|
|timeGravityAccelerometer-XYZ|
|timeBodyAccelerometerJerk-XYZ|
|timeBodyGyroscope-XYZ|
|timeBodyGyroscopeJerk-XYZ|
|timeBodyAccelerometerMagnitude|
|timeGravityAccelerometerMagnitude|
|timeBodyAccelerometerJerkMagnitude|
|timeBodyGyroscopeMagnitude|
|timeBodyGyroscopeJerkMagnitude|
|frequencyBodyAccelerometer-XYZ|
|frequencyBodyAccelerometerJerk-XYZ|
|frequencyBodyGyroscope-XYZ|
|frequencyBodyAccelerometerMagnitude|
|frequencyBodyAccelerometerJerkMagnitude|
|frequencyBodyGyroscopeMagnitude|
|frequencyBodyGyroscopeJerkMagnitude|

## runanalysis.R code
### I. Set WD and download data folder
The code sets the working directory, checks if the necessary folder is already downloaded and if not, downloads the folder with the required datasets.

    setwd("working directory path")

    if (!file.exists("CourseraWK4.zip")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, "CourseraWK4.zip", method="curl")
    }  
    if (!file.exists("UCI HAR Dataset")) { 
    unzip("CourseraWK4.zip") 
    }

### II. Merges the training and the test sets to create one data set
"subject_test", "X_test" and "Y_test", and "subject_train", "X_train" and "Y_train" are loaded into R, named with "features.txt" and merged into "test" and "train" dataframes. "test" and "train" are then unioned into "alldata".

    feature <- read.csv("UCI HAR Dataset/features.txt", sep="", header = FALSE)
    subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject")
    X_test <- read.csv("UCI HAR Dataset/test/X_test.txt", 
                     sep="", 
                     header = FALSE,
                     col.names = feature$V2)
    Y_test <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header = FALSE, col.names = "ActivityCode")

    subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "Subject")
    X_train <- read.csv("UCI HAR Dataset/train/X_train.txt",
                      sep="",
                      header = FALSE,
                      col.names = feature$V2)
          
    Y_train <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header = FALSE, col.names = "ActivityCode")

### III. Extracts only the measurements on the mean and standard deviation for each measurement.
Subject ID, activity code and mean and standard deviation for each measurements are then selected.

### IV. Uses descriptive activity names to name the activities in the data set
Activity name is added to the dataset.

### V. Appropriately labels the data set with descriptive variable names.




