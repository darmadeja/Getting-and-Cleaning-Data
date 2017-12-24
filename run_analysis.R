library(zip)
library(data.table)
library(dplyr)
#Download the Raw data Zip file onto "dataset.zip" file in the current working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip", method = "curl")
#unzip the file in the same directory
unzip("dataset.zip")

# the unzip will create a folder called "UCI HAR Dataset" - that should be used for future references. So set file path to read the file
file_path <- file.path("./", "UCI HAR Dataset")

#read files with attribute names onto Data.Frames Data.tables
featurenames <- fread(file.path(file_path, "features.txt"))$V2
trainfeaturesdata <- fread(file.path(file_path, "train", "x_train.txt"), col.names = featurenames)
testfeaturesdata <- fread(file.path(file_path, "test", "x_test.txt"), col.names = featurenames)
combinedfeaturesdata <- rbind(trainfeaturesdata, testfeaturesdata)

#read all files onto Data.Frames Data.tables
## Read Subject files
trainsubjectdata <- fread(file.path(file_path, "train", "subject_train.txt"), col.names = "subject")
testsubjectdata <- fread(file.path(file_path, "test", "subject_test.txt"), col.names = "subject")
## Combine the subject tables
combinedsubjectdata <- rbind(trainsubjectdata, testsubjectdata)

## Read Activity files
trainactivitydata <- fread(file.path(file_path, "train", "y_train.txt"), col.names = "activity")
testactivitydata <- fread(file.path(file_path, "test", "y_test.txt"), col.names = "activity")
## Combine activity tables
combinedactivitydata <- rbind(trainactivitydata, testactivitydata)

# Combine all the data tables (Features, Activity, Subject) on to one table
data <- cbind(combinedfeaturesdata, combinedsubjectdata, combinedactivitydata)

#Print before subsetting
#print(str(data))

#######################################################################################
#### Question 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
#######################################################################################

# Extract data for column names of featurenames which contains "Mean" & "Std" in it
data <- subset(data, select = c(featurenames[grep("mean|std", featurenames)], "subject", "activity"))
#Print after subsetting
#print(str(data))

#######################################################################################
#### Question 3 - Uses descriptive activity names to name the activities in the data set
#######################################################################################

# Extract column names of data which contains "Mean" & "Std" in it
activityLabels <- fread(file.path(file_path, "activity_labels.txt"))
#Assign the activity Labels to Level of 'activity' parameter in data
data$activity <- factor(data$activity, labels = activityLabels$V2)
#print(data$activity)

#######################################################################################
#### Question 4 - Appropriately labels the data set with descriptive variable names.
#######################################################################################
#Substitute the following abbrevated names of the data table to it full descriptive names
 ## t --> time
 ## f --> frequency
 ## Acc --> accelerometer
 ## Gyro --> gyroscope
 ## Mag --> magnitude
 ## BodyBody --> body

names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "accelerometer", names(data))
names(data) <- gsub("Gyro", "gyroscope", names(data))
names(data) <- gsub("Mag", "magnitude", names(data))
names(data) <- gsub("BodyBody", "body", names(data))
#print(names(data))

#######################################################################################
#### Question 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#######################################################################################
tidydata<-aggregate(. ~subject + activity, data, mean)
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)