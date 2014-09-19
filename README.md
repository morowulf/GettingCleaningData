Getting and Cleaning Data Project
=================================

The run_analysis.R script checks that a directory called "UCI HAR Dataset" exists in the current working
directory.   If the directory does not exist, then the script outputs an error message.   If the directory does
exist, then the script proceeds to contruct a merged dataset using the test and training data contained in the
directory of interest (per requirement #1).   In order to construct the merged dataset, the script
relies upon the existence of the following files:

* UCI HAR Dataset/test/subject_test.txt
* UCI HAR Dataset/test/y_test.txt
* UCI HAR Dataset/test/X_test.txt
* UCI HAR Dataset/train/subject_train.txt
* UCI HAR Dataset/train/y_train.txt
* UCI HAR Dataset/train/X_train.txt

Once all the data has been merged into a single dataset, the script labels the variables (i.e. the columns of
the merged dataframe) with descriptive variable names (per requirement #4).  With the exception of "Subject"
and "Activity", many of these names are retrieved from the following file:

* UCI HAR Dataset/features.txt

After the script names all the variables in the merged dataset, it extracts the measurements of mean and
standard deviation for each measurement by subsetting the merged dataset (per requirement #2).

Next, the script replaces the activity numbers which are contained in the raw data with descriptive labels
(per requirement #3) which it determines using the following file:

* UCI HAR Dataset/activity_labels.txt

Finally, the script creates a new dataset which contains the averages of the different variables contained
in the raw dataset for each Activity and each Subject (as required by requirement #5).


Script Variables:
-----------------
* act_file:               (Character)       Path to the file which lists the activity for each observation
* act_list:               (Dataframe)       Structure which maps the activity to each observation
* activity_labels_file:   (Character)       Path to the file which contains the labels for the different activities
* activity_list:          (Character)       Array of unique activities in the merged dataset
* base_dir:               (Character)       Path to the Samsung data
* combined_list:          (Dataframe)       Structure for the merged dataset
* combined_list1:         (Dataframe)       Temporary structure for the test dataset
* combined_list2:         (Dataframe)       Temporary structure for the training dataset
* features_labels_file:   (Character)       Path to the file which contains the labels for the different variables
* file_type:              (Character)       String which specifies whether the data is test data or training data
* new_list:               (Dataframe)       Structure which contains the dataset with the variables averaged
* obs_file:               (Character)       Path to a file which lists all the observations
* obs_labels:             (Dataframe)       Structure which contains the variable names
* sub_idx:                (Numeric)         Array of column numbers which contain the desired data
* sub_dir:                (Character)       Path to the subdirectory which contains either the test or training data
* subject_file:           (Character)       Path to a file which lists the subject for each observation
* subject_list:           (Character)       Structure which maps the subject to each observation
* subject_list:           (Character)       Array of unique subject in the merged dataset

Code Book:
----------

Variable Names, Units, Description, etc.
* 1:   "tBodyAcc.mean...X" 
* 2:   "tBodyAcc.mean...Y" 
* 3:   "tBodyAcc.mean...Z"
* 4:   "tBodyAcc.std...X"
* 5:   "tBodyAcc.std...Y"
* 6:   "tBodyAcc.std...Z"
* 7:   "tGravityAcc.mean...X"
* 8:   "tGravityAcc.mean...Y"
* 9:   "tGravityAcc.mean...Z"
* 10:  "tGravityAcc.std...X"
* 11:  "tGravityAcc.std...Y"
* 12:  "tGravityAcc.std...Z"
* 13:  "tBodyAccJerk.mean...X"
* 14:  "tBodyAccJerk.mean...Y"
* 15:  "tBodyAccJerk.mean...Z"
* 16:  "tBodyAccJerk.std...X"
* 17:  "tBodyAccJerk.std...Y"
* 18:  "tBodyAccJerk.std...Z"
* 19:  "tBodyGyro.mean...X"
* 20:  "tBodyGyro.mean...Y"
* 21:  "tBodyGyro.mean...Z"
* 22:  "tBodyGyro.std...X"
* 23:  "tBodyGyro.std...Y"
* 24:  "tBodyGyro.std...Z"
* 25:  "tBodyGyroJerk.mean...X"
* 26:  "tBodyGyroJerk.mean...Y"
* 27:  "tBodyGyroJerk.mean...Z"
* 28:  "tBodyGyroJerk.std...X"
* 29:  "tBodyGyroJerk.std...Y"
* 30:  "tBodyGyroJerk.std...Z"
* 31:  "tBodyAccMag.mean.."
* 32:  "tBodyAccMag.std.."
* 33:  "tGravityAccMag.mean.."
* 34:  "tGravityAccMag.std.."
* 35:  "tBodyAccJerkMag.mean.."
* 36:  "tBodyAccJerkMag.std.."
* 37:  "tBodyGyroMag.mean.."
* 38:  "tBodyGyroMag.std.."
* 39:  "tBodyGyroJerkMag.mean.."
* 40:  "tBodyGyroJerkMag.std.."
* 41:  "fBodyAcc.mean...X"
* 42:  "fBodyAcc.mean...Y"
* 43:  "fBodyAcc.mean...Z"
* 44:  "fBodyAcc.std...X"
* 45:  "fBodyAcc.std...Y"
* 46:  "fBodyAcc.std...Z"
* 47:  "fBodyAcc.meanFreq...X"
* 48:  "fBodyAcc.meanFreq...Y"
* 49:  "fBodyAcc.meanFreq...Z"
* 50:  "fBodyAccJerk.mean...X"
* 51:  "fBodyAccJerk.mean...Y"
* 52:  "fBodyAccJerk.mean...Z"
* 53:  "fBodyAccJerk.std...X"
* 54:  "fBodyAccJerk.std...Y"
* 55:  "fBodyAccJerk.std...Z"
* 56:  "fBodyAccJerk.meanFreq...X"
* 57:  "fBodyAccJerk.meanFreq...Y"
* 58:  "fBodyAccJerk.meanFreq...Z"
* 59:  "fBodyGyro.mean...X"
* 60:  "fBodyGyro.mean...Y"
* 61:  "fBodyGyro.mean...Z"
* 62:  "fBodyGyro.std...X"
* 63:  "fBodyGyro.std...Y"
* 64:  "fBodyGyro.std...Z"
* 65:  "fBodyGyro.meanFreq...X"
* 66:  "fBodyGyro.meanFreq...Y"
* 67:  "fBodyGyro.meanFreq...Z"
* 68:  "fBodyAccMag.mean.."
* 69:  "fBodyAccMag.std.."
* 70:  "fBodyAccMag.meanFreq.."
* 71:  "fBodyBodyAccJerkMag.mean.."
* 72:  "fBodyBodyAccJerkMag.std.."
* 73:  "fBodyBodyAccJerkMag.meanFreq.."
* 74:  "fBodyBodyGyroMag.mean.."
* 75:  "fBodyBodyGyroMag.std.."
* 76:  "fBodyBodyGyroMag.meanFreq.."
* 77:  "fBodyBodyGyroJerkMag.mean.."
* 78:  "fBodyBodyGyroJerkMag.std.."
* 79:  "fBodyBodyGyroJerkMag.meanFreq.."
* 80:  "angle.tBodyAccMean.gravity."
* 81:  "angle.tBodyAccJerkMean..gravityMean."
* 82:  "angle.tBodyGyroMean.gravityMean."
* 83:  "angle.tBodyGyroJerkMean.gravityMean."
* 84:  "angle.X.gravityMean."
* 85:  "angle.Y.gravityMean."
* 86:  "angle.Z.gravityMean."


