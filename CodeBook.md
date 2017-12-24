#This document provides information about the data, variables used in the code and data transformation logic invovled in the program

#####Data Input:
Input data for the run_analysis.R program come from the site https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Following wesite provide more information about the above mentioned data.
**Website:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#####Variables:
1. Features.txt file is used to identify the list of attributes pertaining to the x_train/x_test feature files. which ideally captured all 561 variable combinations of the featured invovling the following variables & functions.
2. X_test/X_train - provides the Test and Training features data for all the 561 variables listed in the Features.txt file.
3. Y_test/y_train - provides the list of activities conducted on the subject of all the Test and Training data.
4. subject_test/subject_train - provides the subject of appropriate activity Test and Training Data.


#####Program Logic:
1. Download input data from the above mentioned site to the current working directory
2. Read all the input files
3. Read Features data 
4. Collect all the 561 attribute names from the Features.txt file   
5. Read the Test & Training features data for all the 561 attributes   
6. Combine both the Test & Training Feature data   
7. Read Subject data
8. Read the Test & Training Subject for all the Feature records
9. Combine both the Test & Training Subject data
10. Read Activity data
11. Read the Test & Training Activity for all the Feature records
12. Combine both the Test & Training Activity data
13. Combine Feature, Subject and Activity tables into 1 table with 563 attributes **(Question 1)**

14. Extract the subset of above combined data of all Mean & Standart Deviation features on to a new data table **(Question 2)**

15.. Assign Activity Name for each activity number identified in the data set. **(Question 3)**

16.. Substitute the following abbrevated names of the data table to it's full descriptive names **(Question 4)**

Abbrevated Names | Descriptive Names
---------------- | -----------------
t | time
f | frequency
Acc | accelerometer
Gyro | gyroscope
Mag | magnitude
BodyBody | body

6. Create a Tidy data set with the average of each variable for each activity and each subject **(Question 5)**

