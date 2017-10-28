## R script called run_analysis.R that does the following.
## ------------------------------------------------------------------------------------------
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
## ------------------------------------------------------------------------------------------

## First Read file from source
Dataurl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "


## Download file to local directory
ZipDatafile <- "download_zip_data.zip"

download.file(url = Dataurl,destfile = ZipDatafile, mode = 'wb', cacheOK = FALSE)

## Unzip zip file.
unzip(ZipDatafile)

## Read Test Data
X_TestData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/test/X_test.txt")
Y_TestData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/test/y_test.txt")
subject_testData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/test/subject_test.txt")

## Read training Data
X_TrainData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/train/X_train.txt")
Y_TrainData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/train/y_train.txt")
subject_trainData <- read.table("~/R/DataCleaningWeek4/UCI HAR Dataset/train/subject_train.txt")

## Read other files, feature, activity, 
featuresData <- read.table('~/R/DataCleaningWeek4/UCI HAR Dataset/features.txt')
activityLabelData = read.table('~/R/DataCleaningWeek4/UCI HAR Dataset/activity_labels.txt')

## Assign column names to Traning Data
colnames(X_TrainData) <- featuresData[,2]
colnames(Y_TrainData) <-"activityId"
colnames(subject_trainData) <- "subjectId"

## Assign column names to Testing Data Data
colnames(X_TestData) <- featuresData[,2] 
colnames(Y_TestData) <- "activityId"
colnames(subject_testData) <- "subjectId"

## Assign column names to Activity Data
colnames(activityLabelData) <- c('activityId','activityType')

## 1. 1.Merges the training and the test sets to create one data set.
trainmrg <- cbind(Y_TrainData, subject_trainData, X_TrainData)
testmrg <- cbind(Y_TestData, subject_testData, X_TestData)
mrgall <- rbind(trainmrg, testmrg)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
colExt <- colnames(mrgall)
## Mean and Standard
stdmean <- (grepl("activityId" , colExt) | 
                         grepl("subjectId" , colExt) | 
                         grepl("mean.." , colExt) | 
                         grepl("std.." , colExt) 
)

## Subset of merged data
mrgallSet <- mrgall[ , stdmean == TRUE]

## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
ActivityNames <- merge(mrgallSet, activityLabelData,
                              by='activityId',
                              all.x=TRUE)
## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
TidySet <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId),]

## Write new Tidy data set into a text file.
write.table(TidySet, "NewTidySet.txt", row.name=FALSE)
