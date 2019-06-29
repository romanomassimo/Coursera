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

## Measurements
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals.Fast Fourier Transform (FFT) was applied to frequency measurements.

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
"subject_test", "X_test" and "Y_test", and "subject_train", "X_train" and "Y_train" are loaded into R, named with "features.txt" and merged into "test" and "train" dataframes. "test" and "train" are then united into "alldata".

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

    test <- cbind(X_test, Y_test, subject_test)
    train <- cbind(X_train, Y_train, subject_train)
    alldata <- rbind(test,train) %>%
    tbl_df()
    
### III. Extracts only the measurements on the mean and standard deviation for each measurement.
Subject ID, activity code and mean and standard deviation for each measurements are then selected.

    alldata <- select(alldata,contains("std"), contains("mean..."), contains("Subject"), ActivityCode)

### IV. Uses descriptive activity names to name the activities in the data set

    Activity name is added to the dataset.

    activity <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE,
                          col.names = c("ActivityCode","ActivityName"))

    nrow(alldata)
    alldata <- merge(alldata,activity, by.x = "ActivityCode", by.y = "ActivityCode", all = TRUE)
    alldata <- select(alldata, -ActivityCode)

### V. Appropriately labels the data set with descriptive variable names.
I renamed the labels by replacing the "t" with time, "Acc" with Accelerometer, "Gyro" with Gyroscope", first "f" with frequency, "Mag" with Magnitude and "BodyBody" with Body.

    nam <- names(alldata)
    desc.names <- sub("^t","time", nam)
    desc.names <- sub("Acc","Accelerometer", desc.names)
    desc.names <- sub("Gyro","Gyroscope", desc.names)
    desc.names <- sub("^f","frequency", desc.names)
    desc.names <- sub("Mag","Magnitude", desc.names)
    desc.names <- sub("BodyBody","Body", desc.names)
    names(alldata) <- desc.names

### VI. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Finally, using a data table format, I grouped the records by subject and activity and calculated the averages for each measurement, before saving the tidy data into a "txt" file.

    tidy.alldata <- tbl_df(alldata) %>%
      group_by(Subject,ActivityName) %>%
      summarise_all(mean)

    write.table(tidy.alldata, "tidy.alldata.txt", sep=",")


