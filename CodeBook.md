Overview

Source of the original data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full Description at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Process :

The script run_analysis.R performs the following process to clean up the data and create tidy data sets:
1. Merge the training and test sets to create one data set.
- First Read file from source

- Download file to local directory

- Unzip zip file.

- Read Test Data

- Read training Data

- Read other files, feature, activity, 

- Assign column names to Traning 

- Assign column names to Testing Data Data

- Assign column names to Activity Data

- Merge data using cbind and rbind
2. Extracts only the measurements on the mean and standard deviation for each measurement

- User grepl to get mean and standard deviation
3. Uses descriptive activity names to name the activities in the data set using merge command.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is NewTidySet.txt


## Variables:
- Dataurl - URL file
- ZipDatafile - Zip file name  
- X_TestData - table contents of X_test.txt
- Y_TestData - table contents of y_test.txt
- X_TrainData - table contents of X_train.txt
- Y_TrainData - table contents of y_train.txt
- subject_testData - table contents of subject_test.txt
- subject_trainData - table contents of subject_train.txt
- featuresData - table content of features.txt
- activityLableData - table contents of activitylables.txt
- trainmrg - merge training data from Y_trainData, subject_trainData and X_TrainData
- testmrg - merge test data from Y_TestData, subject_testData and X_TestData
- mrgall - merge rows of testmrg and trainmrg
- colExt - column names of mrgall data
- stdmean - tidy data of Mean and standard columnsalong with activity ID and subject ID
- mrgallset - subset of mrgall data
- ActivityNames - activity names data 
- TidySet - Tidy data set of Subject ID, Activity ID, Activity Names and mean

## Output
#NewTidyData.txt

- The first column contains subject IDs.
- The second column contains activity names.
- The last 66 columns are measurements.

