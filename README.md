# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project Assignment 

The goal of this project is to accomplish the "Project" of the course "Getting and Cleaning Data" in coursera.

We can get the requirement of "Project" in https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

Our goal is to download and pre-process the data collected from the accelerometers from the Samsung Galaxy S smartphone before the futher analysis. See more can click the link:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

My process steps are as followed:

##Step 1：
  set workspace and create special file (if not exists) to store the data
##Step 2:
  download the raw project data set and unzip it
##Step 3:
  load the data into R workspace
##Step 4:
  According the project requirement, merge the downloaded data of training and testing together
##Step 5:
  extracts only the measurements on the mean and standard deviation for each measurement.
  This process uses 'grepl'command and regular expression to filter the required data
##Step 6:
  Labels the data set with descriptive variable names.
##Step 7：
  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. It includes several sub-steps
  1) combine the subject data, measure data, and label data together use 'cbind' command
  2) use 'by' command to group and calculate average of each column
  3) process the group result and format the data frame structure
  4) save the processed result to disk.

  
