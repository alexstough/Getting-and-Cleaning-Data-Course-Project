## Getting and Cleaning Data Course Project README

### Data Obtained

Data used for this analysis is taken from the Human Activity Recognition Using Smartphones Dataset ("UCI HAR Dataset") Version 1.0. The source data files were taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and are located within this repository at /UCI HAR Dataset. 

A summary of the variables and data contained is detailed below in the excerpt from the file located at /UCI HAR Dataset/README.txt:

    1. 'features.txt': List of all variable names for the relevant datasets.
    
    2. 'activity_labels.txt': Labels for each class of activities.
    
    3. 'train/X_train.txt': Training data set.
    
    4. 'train/y_train.txt': Training activity labels.
    
    5. 'test/X_test.txt': Test data set.
    
    6. 'test/y_test.txt': Test activity labels.
    
    7. 'train/subject_test.txt': Identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    
    8. 'train/subject_train.txt': Identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


### Mechanics of 'run_analysis.R' Script

The script contained within this repository operates in the following manner:

  1. Utilizes the read.table() function to read in the necessary .txt files as detailed above. Generation of column names, certain data labels, and the first steps of    creating a tidy data set are completed using the colnames() and cbind() functions. This process is completed for both the test and training data sets as located        within the /UCI HAR Dataset file path. 
  
  Once the necessary test and training data sets are prepared, the script makes use of the rbind() function. This is appropriate given that both datasets contain the     same variable names in the appropriate sequence. This is checked by use of an if/else evaluation starting at row 51. In the case that any step of lines 1 - 50 are not   completed appropriately, an error message will prompt a user to ensure appropriate variable names. The results of this process create a table titled 'combined_data'.

  2. With the combined test and training data sets in the data.frame 'combined_data', the next section of the script makes use of the "dplyr" package of functions to     begin cleaning the data. Using the grep() function and subsetting of variable names, the purpose of this section is to select only those variables which relate to      mean and standard deviation. The resulting data.frame is titled 'extracted_data'.

  3. With the 'extracted_data' set, the following section reads in the /UCI HAR Dataset/activity_labels.txt for purposes of labeling the types of activities performed    in the dataset (e.g. WALKING, STANDING, etc.). Using the left_join() function, these activity names are added to the dataset to allow a user to more readily            understand the nature of each observation. The resulting data.frame is titled 'labeled_data'.
  
  4. The next section performs several more tidy data procedures, namely the renaming of variables. For the purpose of adding descriptive value for a user, this section uses the gsub() function to replace usage of the identifiers "f" and "t" which correspond to "frequency" and "time". These letter nomenclatures are replaced with the terms "Freq" and "Time" to allow a user to more easily interpret the nature of these variables. Additionally, usage of the strings "mean()" and "std()" are replaced with "Mean" and "StdDev" to better inform a user of the meaning of each variable. The resulting data.frame is titled 'tidy_data'.
  
  5. The final section of the script performs a mean() function calculation upon all variables of the 'tidy_data', aggregated by the 'subject' and 'activity' variables.   This is accomplished through use of the aggregate() function that takes the 'tidy_data' data.frame and performs the mean() function on each of the variables with a     'by' argument of the 'subject' and 'activity' variables. The resulting data.frame is titled tidy_data_averages.

