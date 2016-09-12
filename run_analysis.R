##Set workspace and create special file to store data
setwd("D:\\Rworkspace");
if(!file.exists("./data")){
  dir.create("./data")
}

## download project data set and unzip it
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
download.file(fileUrl, destfile = "./data/Dataset.zip");

unzip("./data/Dataset.zip", exdir = "./data")

##load data into R
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

feature <-read.table("./data/UCI HAR Dataset/features.txt")
activityNames <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


##1. Merges the training and the test sets to create one data set.
## 1)Merge training and testing data together

mDataX <- rbind(trainX,testX);
mDataY <- rbind(trainY, testY);
mDataSub <- rbind(subjectTrain, subjectTest); 

#mDataSet <- cbind(cbind(mDataSub, mDataX), mDataY);

## 2) Set the feature name of mDataX
 names(mDataX) <- feature[,2];

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

temp <- feature[,2];
selectCol <- grepl("(*mean*)|(*std*)", temp)
selMDataX <- mDataX[, selectCol]

## 3. Uses descriptive activity names to name the activities in the data set
mDataY$V1 = as.factor(mDataY$V1)
levels(mDataY$V1)
levels(mDataY$V1) <- activityNames[,2]
head(mDataY)

## 4. Appropriately labels the data set with descriptive variable names.
names(mDataY) <- "activity"
names(mDataSub) <- "subject"



## 5. From the data set in step 4, creates a second, independent tidy data 
##    set with the average of each variable for each activity and each subject.

## step 1: combine all the data together
mData <- cbind(mDataSub,selMDataX, mDataY);

stat <- by(mData[,2:80], mData[, c("subject", "activity")], colMeans)

arrayData <- as.data.frame.array(stat)
res <- array(,dim = c(180,81))
arrayNames <- names(arrayData)

for (i in c(1:6)){
  for(j in c(1:30)){
    tmp <- arrayData[[i]][[j]]
    res[(i-1) * 30 + j, 1] = j;
    res[(i-1) * 30 + j, 81] = arrayNames[i];
    res[(i-1) * 30 + j, 2:80] = tmp
  }
}

cleanData <- as.data.frame(res)

variableNames <- names(arrayData[[1]][[1]])

## Set the names of data frame
cleanDataNames <- names(cleanData)
cleanDataNames[1] <- "subject-no";
cleanDataNames[81] <- "activity"
cleanDataNames[2:80] <- variableNames;
names(cleanData) <- cleanDataNames

## write data to file
write.table(cleanData, "./data/UCI HAR Dataset/average_group_by_activity_and_subject.txt", row.name=FALSE)




