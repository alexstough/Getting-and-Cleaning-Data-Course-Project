# 1. Merge the training and the test sets to create one data set.

      # Set working directory. This will need to be updated to correspond to each user's local directory in use.
      filepath <- "C:/Users/alex.stough/Documents/4 Training/R Programming/Coursera/Projects/Getting-and-Cleaning-Data-Course-Project"
      setwd(filepath)

      # For naming variables in the test and train datasets, read in features.txt file.
      var_labels <- read.table(file = paste0(filepath,"/UCI HAR Dataset/features.txt"))
    
    ########################################
    #          Read in test data           #
    ########################################
    
      # Read in necessary files
      test_data <- read.table(file = paste0(filepath,"/UCI HAR Dataset/test/X_test.txt"))
      test_subject <- read.table(file = paste0(filepath,"/UCI HAR Dataset/test/subject_test.txt"))
      test_activity <- read.table(file = paste0(filepath,"/UCI HAR Dataset/test/y_test.txt"))
      
      # Apply variable names from the features.txt document.
      colnames(test_data) <- var_labels$V2
      colnames(test_subject) <- "subject"
      colnames(test_activity) <- "activity"
      
      # Apply row labels to each record.
      test_data <- cbind(test_subject, test_activity, test_data)
      
      
    ########################################
    #        Read in training data         #
    ########################################
    
      # Read in necessary files.
      train_data <- read.table(file = paste0(filepath,"/UCI HAR Dataset/train/X_train.txt"))
      train_subject <- read.table(file = paste0(filepath,"/UCI HAR Dataset/train/subject_train.txt"))
      train_activity <- read.table(file = paste0(filepath,"/UCI HAR Dataset/train/y_train.txt"))
      
      # Apply variable names from the features.txt document.
      colnames(train_data) <- var_labels$V2
      colnames(train_subject) <- "subject"
      colnames(train_activity) <- "activity"
      
      # Apply row labels to each record.
      train_data <- cbind(train_subject, train_activity, train_data)
      
      
    ########################################
    #   Merge test and training data sets #
    ########################################
      
      # Test whether or not the variable names are consistent. If they are, use rbind(), otherwise return an error message.
      if(all(names(test_data) == names(train_data))){
        combined_data <- rbind(test_data, train_data)
      } else {
        print("Error: Check the consistency of variable names between the test and training datasets")
      }
      
      # Clean global environment.
      rm(test_data, test_subject, test_activity, train_data, train_subject, train_activity, var_labels)
      
      
# 2. Extract only the measurements on the mean and standard deviation for each measurement.

    library(dplyr)  
    
    # Determine a vector of variable names corresponding to mean or standard deviation.
    variables <- names(combined_data)
    variables <- c("subject", "activity", sort(variables[grep("mean[(]|std[(]", variables)]))
    
    # Subset the combined_data by keeping only columns which contain mean or standard deviation.
    extracted_data <- combined_data[,variables]
    
    # Clean global environment.
    rm(variables, combined_data)

# 3. Use descriptive activity names to name the activities in the data set
    
    # Read in table linking activity numbers and activity labels.
    activity_labels <- read.table(file = paste0(filepath, "/UCI HAR Dataset/activity_labels.txt"))
    colnames(activity_labels) <- c("activity", "activity_name")
    
    # Join activity labels to the extracted data. Then reorder the columns in a logical order.
    labeled_data <- left_join(extracted_data, activity_labels, by = "activity")
    labeled_data <- labeled_data[,c(1:2, 69, 3:68)]

    # Clean global environment.
    rm(extracted_data)

# 4. Appropriately labels the data set with descriptive variable names.
    
    # Clean up variable names based on the descriptions included in features_info.txt.
    tidy_names <- names(labeled_data)
    tidy_names <- gsub("fB", "FreqB", tidy_names)
    tidy_names <- gsub("fG", "FreqG", tidy_names)
    tidy_names <- gsub("tB", "TimeB", tidy_names)
    tidy_names <- gsub("tG", "TimeG", tidy_names)
    tidy_names <- gsub("mean[(][)]", "Mean", tidy_names)
    tidy_names <- gsub("std[(][)]", "StdDev", tidy_names)

    # Assign tidy_names to the data set.
    tidy_data <- labeled_data
    colnames(tidy_data) <- tidy_names
    
    # Clean global environment.
    rm(tidy_names, labeled_data)
    

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    tidy_data_averages <- aggregate(select(tidy_data, -activity_name), by = list(tidy_data$subject, tidy_data$activity), FUN = mean) %>%
      select(-Group.1, -Group.2) %>%
      left_join(y = activity_labels, by = "activity") # This reapplies the activity names that are lost as a part of the aggregate function (cannot perform mean function on characters).
      
    # Reorder activity_name to the right of the activity number variable.
    tidy_data_averages <- tidy_data_averages[,c(1:2, 69, 3:68)]
    
    # Clean global environment for everything except the original tidy_data data.frame, the new tidy_data_averages data.frame, and the filepath value.
    rm(activity_labels, filepath)
    
    # Create a .txt file containing the 'tidy_data' and 'tidy_data_averages' datasets.
    write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
    write.table(tidy_data_averages, file = "tidy_data_averages.txt", row.names = FALSE)
    