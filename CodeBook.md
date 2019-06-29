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
I. The code sets the working directory, checks if the necessary folder is already downloaded and if not, downloads the folder with the required datasets.

II. Merges the training and the test sets to create one data set.


