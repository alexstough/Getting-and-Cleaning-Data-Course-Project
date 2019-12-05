# Getting and Cleaning Data Course Project Code Book

Data used for this analysis is taken from the Human Activity Recognition Using Smartphones Dataset ("UCI HAR Dataset") Version 1.0. The source data files were taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and are located within this repository at /UCI HAR Dataset. 

A summary of the variables and data contained is detailed below in the excerpt from the file located at /UCI HAR Dataset/features_info.txt:

    The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to     denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner            frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)     using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
    
    Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the             magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
    
    Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag,        fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
    
    These signals were used to estimate variables of the feature vector for each pattern:  
    '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

From the initial dataset contained within /UCI HAR Dataset, the following transformations were performed in creating a combined, tidy dataset, as well as a tidy data set containing the mean of each variable summarized by each 'subject' and each 'activity':

    1. Reading in of relevant .txt files from /UCI HAR Dataset.
    2. Assembly and merging of "test_data" and "train_data" data sets into a single, combined dataset.
    3. Selecting only those variables relating to the mean and standard deviation of each observed metric.
    4. Tidying of data by assigning descriptive data names, as well as descriptive variable names.
    5. Creating a subset of the tidy, combined data set that represents the mean of each variable, summarized for each 'subject' and 'activity'
    
    The comments within the file /run_analysis.R provide context to each step and the individual procedures necessary to get and clean the UCI HAR Dataset.