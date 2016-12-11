========================================================
title: "codebook.md"
output: html_document
========================================================

Data Dictionary - run_analysis.R

========================================================
VARIABLE NAMES AND DESCRIPTIONS
========================================================

activity
    activity performed during data collection
        .laying
        .sitting
        .standing
        .walking
        .walking_downstairs
        .walking_upstairs
        

measurement_type
    -abbreviated description of the specific measurement collected by the phone's instruments
    or extrapolated from the instrument data
    
    -the original names from the dataset were maintained because they are descriptive and this allows
    easier comparison to the original data, if necessary.
    
    -See "MEASUREMENT_TYPE DETAIL" below for detailed definitions of the abbreviations in measurement_type     and background on data collection
		tBodyAcc-mean()-X
		tBodyAcc-mean()-Y
		tBodyAcc-mean()-Z
		tBodyAcc-std()-X
		tBodyAcc-std()-Y
		tBodyAcc-std()-Z
		tGravityAcc-mean()-X
		tGravityAcc-mean()-Y
		tGravityAcc-mean()-Z
		tGravityAcc-std()-X
		tGravityAcc-std()-Y
		tGravityAcc-std()-Z
		tBodyAccJerk-mean()-X
		tBodyAccJerk-mean()-Y
		tBodyAccJerk-mean()-Z
		tBodyAccJerk-std()-X
		tBodyAccJerk-std()-Y
		tBodyAccJerk-std()-Z
		tBodyGyro-mean()-X
		tBodyGyro-mean()-Y
		tBodyGyro-mean()-Z
		tBodyGyro-std()-X
		tBodyGyro-std()-Y
		tBodyGyro-std()-Z
		tBodyGyroJerk-mean()-X
		tBodyGyroJerk-mean()-Y
		tBodyGyroJerk-mean()-Z
		tBodyGyroJerk-std()-X
		tBodyGyroJerk-std()-Y
		tBodyGyroJerk-std()-Z
		tBodyAccMag-mean()
		tBodyAccMag-std()
		tGravityAccMag-mean()
		tGravityAccMag-std()
		tBodyAccJerkMag-mean()
		tBodyAccJerkMag-std()
		tBodyGyroMag-mean()
		tBodyGyroMag-std()
		tBodyGyroJerkMag-mean()
		tBodyGyroJerkMag-std()
		fbodyAcc-mean()-X
		fbodyAcc-mean()-Y
		fbodyAcc-mean()-Z
		fbodyAcc-std()-X
		fbodyAcc-std()-Y
		fbodyAcc-std()-Z
		fbodyAcc-meanFreq()-X
		fbodyAcc-meanFreq()-Y
		fbodyAcc-meanFreq()-Z
		fbodyAccJerk-mean()-X
		fbodyAccJerk-mean()-Y
		fbodyAccJerk-mean()-Z
		fbodyAccJerk-std()-X
		fbodyAccJerk-std()-Y
		fbodyAccJerk-std()-Z
		fbodyAccJerk-meanFreq()-X
		fbodyAccJerk-meanFreq()-Y
		fbodyAccJerk-meanFreq()-Z
		fbodyGyro-mean()-X
		fbodyGyro-mean()-Y
		fbodyGyro-mean()-Z
		fbodyGyro-std()-X
		fbodyGyro-std()-Y
		fbodyGyro-std()-Z
		fbodyGyro-meanFreq()-X
		fbodyGyro-meanFreq()-Y
		fbodyGyro-meanFreq()-Z
		fbodyAccMag-mean()
		fbodyAccMag-std()
		fbodyAccMag-meanFreq()
		fbodyBodyAccJerkMag-mean()
		fbodyBodyAccJerkMag-std()
		fbodyBodyAccJerkMag-meanFreq()
		fbodyBodyGyroMag-mean()
		fbodyBodyGyroMag-std()
		fbodyBodyGyroMag-meanFreq()
		fbodyBodyGyroJerkMag-mean()
		fbodyBodyGyroJerkMag-std()
		fbodyBodyGyroJerkMag-meanFreq()
		

subject
    Unique identifier for each subject participating in the study
        (1:30)
    
    
value_avg
    average of unique measurement within activity and subject
        0.000000000  


========================================================
DATA TRANSFORMATION
========================================================

The run_analysis.R script manipulates the original data in the following way:

-reads the original "test" and "train" datasets into data.frames usint default read.table settings

-assigns descriptive column names and activity ID numbers from the "features" and "activity" files provided with the dataset
    **I kept the original variable names because I feel they are descriptive and because in a real-world
    scenario, it could streamline future comparisons to the original data

-assigns subject identifiers from the "subjects" file provided with the dataset

-mergest the "train" and "test" sets into one

-changes activity ID numbers to descriptive names

-extracts columns that represent mean and standard deviation

-melts the dataset
    **Per Hadley Wickham and the instructors assertion of tidy data, this condenses what were many
    variables across many columns into one variable type with one column for type and a second for
    the numeric value associated with it.

-calculates the average of each variable for each activity and each subject

-re-orders the new columns of data and provides new columns with descriptive names
    **In his "Tidy Data" paper in the Journal of Statistical Software, Hadley Wickham asserted 
    that static variables such as identifiers should be in the left columns of the table and 
    dynamic variables should follow to the right. This table follows that format

-writes the new table into a new .txt file called "run_analysis.txt"


========================================================
MEASUREMENT_TYPE DETAILS
**Copied and modified from "feature selection" file paired with the original "UCI HAR Dataset"
========================================================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The run_analysis dataset contains only variables that contain data on the mean and standard deviation for each of the variables above. Those are denoted by the 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
