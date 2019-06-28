# Peer-graded Assignment: Getting and Cleaning Data Course Project

# set working directory
setwd("working directory path")


# Download Zip File
if (!file.exists("CourseraWK4.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "CourseraWK4.zip", method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip("CourseraWK4.zip") 
}

# 1.Merges the training and the test sets to create one data set.
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

# merge X_train, Y_train, X_test and Y_test
test <- cbind(X_test, Y_test, subject_test)
train <- cbind(X_train, Y_train, subject_train)
alldata <- rbind(test,train) %>%
  tbl_df()

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
alldata <- select(alldata,contains("std"), contains("mean..."), contains("Subject"), ActivityCode)
                                                         

# 3.Uses descriptive activity names to name the activities in the data set
activity <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE,
                      col.names = c("ActivityCode","ActivityName"))

nrow(alldata)
alldata <- merge(alldata,activity, by.x = "ActivityCode", by.y = "ActivityCode", all = TRUE)
alldata <- select(alldata, -ActivityCode)

# 4.Appropriately labels the data set with descriptive variable names.
nam <- names(alldata)
desc.names <- sub("^t","time", nam)
desc.names <- sub("Acc","Accelerometer", desc.names)
desc.names <- sub("Gyro","Gyroscope", desc.names)
desc.names <- sub("^f","frequency", desc.names)
desc.names <- sub("Mag","Magnitude", desc.names)
desc.names <- sub("BodyBody","Body", desc.names)
names(alldata) <- desc.names


# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
tidy.alldata <- tbl_df(alldata) %>%
  group_by(Subject,ActivityName) %>%
  summarise_all(mean)

write.table(tidy.alldata, "tidy.alldata.txt", sep=",")






