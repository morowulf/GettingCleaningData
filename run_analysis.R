# David Goble
# 09/19/2014
# Getting and Cleaning Data

# run_analysis - Merges training and test data together into a single tidy data set
#                and then creates an independant tidy data set from the merged data
#                set which contains the averages of all the relevant variables for
#                each activity and each subject.
run_analysis <- function( ) {
    
    base_dir <- "./UCI HAR Dataset";
    activity_labels_file <- paste(base_dir, "activity_labels.txt", sep = "/");
    features_labels_file <- paste(base_dir, "features.txt", sep = "/");

    if ( file.exists(base_dir) )
    {
        # Part 1: Merge training and test sets to create one data set.
        # ------------------------------------------------------------
    
        # Process the test data
        file_type <- "test";
        sub_dir <- paste(base_dir, file_type, sep = "/");
        subject_file <- paste(sub_dir, paste("subject_", file_type, ".txt", sep = ""), sep = "/");
        act_file <- paste(sub_dir, paste("y_", file_type, ".txt", sep = ""), sep = "/");
        obs_file <- paste(sub_dir, paste("X_", file_type, ".txt", sep = ""), sep = "/");
    
        # If the necessary files exist
        if ( file.exists(subject_file) && file.exists(act_file) && file.exists(obs_file) )
        {
            # Read in activity listing
            act_list <- read.csv(act_file, header = FALSE);
            # Read in subject listing
            subject_list <- read.csv(subject_file, header = FALSE);
            # Read in observation listing
            obs_list <- read.table(obs_file);
            # Create a combined dataframe
            combined_list1 <- cbind(subject_list, act_list, obs_list);
            # Clear temporary variables from memory
            remove(act_list, obs_list, subject_list);
        }

        # Process the train data
        file_type <- "train";
        sub_dir <- paste(base_dir, file_type, sep = "/");
        subject_file <- paste(sub_dir, paste("subject_", file_type, ".txt", sep = ""), sep = "/");
        act_file <- paste(sub_dir, paste("y_", file_type, ".txt", sep = ""), sep = "/");
        obs_file <- paste(sub_dir, paste("X_", file_type, ".txt", sep = ""), sep = "/");
    
        # If the necessary files exist
        if ( file.exists(subject_file) && file.exists(act_file) && file.exists(obs_file) )
        {
            # Read in activity listing
            act_list <- read.csv(act_file, header = FALSE);
            # Read in subject listing
            subject_list <- read.csv(subject_file, header = FALSE);
            # Read in observation listing
            obs_list <- read.table(obs_file);
            # Create a combined dataframe
            combined_list2 <- cbind(subject_list, act_list, obs_list);
            # Clear temporary variables from memory
            remove(act_list, obs_list, subject_list);
        }
    
        # Merge the dataframes for the train and test data
        combined_list <- rbind(combined_list1, combined_list2);
        # Clear temporary variables from memory
        remove(combined_list1, combined_list2);
    
        # Part 4: Appropriately label the data set with descriptive variable nanmes.
        # --------------------------------------------------------------------------
    
        # Label columns of the combined data frame
        colnames(combined_list)[1] <- "Subject";
        colnames(combined_list)[2] <- "Activity";
        if ( file.exists(features_labels_file) )
        {
            obs_labels <- read.table(features_labels_file);
        
            for ( i in seq_len(dim(obs_labels)[1]) )
            {
                if ( obs_labels[i,1] + 2 <= dim(combined_list)[2] )
                {
                    colnames(combined_list)[obs_labels[i,1]+2] <- as.character(obs_labels[i,2]);
                }
            }
        }
    
        # Part 3: Use descriptive activity names to name the activities in the
        #         data set.
        # ---------------------------------------------------------------------
        
        if ( file.exists(activity_labels_file) )
        {
            activity_labels <- read.table(activity_labels_file);
            
            for ( i in seq_len(dim(combined_list)[1]) )
            {
                if ( any (activity_labels[,1] == combined_list$Activity[i]) )
                {
                    combined_list$Activity[i] <- as.character(activity_labels[activity_labels[,1] == combined_list$Activity[i],2]);
                }
                else
                {
                    combined_list$Activity[i] <- NA;
                }
            }
        }
        
        
        # Part 2: Extract only the measurements on the mean and standard deviation
        #         for each measurment.
        # -------------------------------------------------------------------------

        filtered_list <- combined_list[,grep("Subject|Activity|-mean|-std", gsub("meanFreq", "", as.character(attributes(combined_list)$names)), ignore.case=TRUE)];
    

        # Part 5: Create a second, independent tidy data set with the average of each variable for each
        #         activity and each subject.
        # ---------------------------------------------------------------------
    
        new_list <- data.frame();
    
        # Put together the averages for all activities
        activities = sort(unique(filtered_list$Activity));
    
        for ( i in seq_len(length(activities)) )
        {
            new_list <- rbind(new_list, data.frame(t(apply(filtered_list[filtered_list["Activity"] == activities[i], 3:dim(filtered_list)[2]], 2, mean))));
            rownames(new_list)[dim(new_list)[1]] <- paste("Avg...Activity:", as.character(activities[i]));
        }
    
        # Put together the averages for all subjects
        subjects <- sort(unique(combined_list$Subject));
    
        for ( i in seq_len(length(subjects)) )
        {
            new_list <- rbind(new_list, data.frame(t(apply(filtered_list[filtered_list["Subject"] == subjects[i], 3:dim(filtered_list)[2]], 2, mean))));
            rownames(new_list)[dim(new_list)[1]] <- paste("Avg...Subject:", as.character(subjects[i]));
        }
    
        # Output tidy merged dataset
        write.table(new_list, file="merged_data.txt", row.name=FALSE);
    }
    else
    {
        print(paste("Unable to find:", base_dir));
    }
}
