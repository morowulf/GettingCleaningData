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


Code Book:
----------
* activity_labels_file:  (Character)       Path to the file which contains the labels for the different activities
* activity_list:         (Character)       Array of unique activities in the merged dataset
* base_dir:              (Character)       Path to the Samsung data
* combined_list:         (Dataframe)       Structure for the merged dataset
* combined_list1:        (Dataframe)       Temporary structure for the test dataset
* combined_list2:        (Dataframe)       Temporary structure for the training dataset
* features_labels_file:  (Character)       Path to the file which contains the labels for the different variables
* new_list:              (Dataframe)       Structure which contains the dataset with the variables averaged
* subject_list:          (Character)       Array of unique subject in the merged dataset
