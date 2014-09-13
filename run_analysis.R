## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.

# Clear workspace
rm(list=ls())
# Set working directory to where files are stored
setwd("/home/grace/Dropbox/Development/Coursera 03_Getting Data/project/UCI HAR Dataset")

## 1. Merge the training and the test sets to create one data set.
# Import training data
features     <- read.table('./features.txt',header=FALSE)   #imports features.txt
activityType <- read.table('./activity_labels.txt',header=FALSE)    #imports activity_labels.txt
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)    #imports subject_train.txt
xTrain       <- read.table('./train/X_train.txt',header=FALSE)  #imports X_train.txt
yTrain       <- read.table('./train/y_train.txt',header=FALSE)  #imports y_train.txt

# Assign column names to data
colnames(activityType)  <- c('activityId','activityType')
colnames(subjectTrain)  <- "subjectId"
colnames(xTrain)        <- features[,2]
colnames(yTrain)        <- "activityId"

# Merge yTrain, subjectTrain, xTrain to get training dataset
trainingData <- cbind(yTrain,subjectTrain,xTrain)

# Import testing data
subjectTest  <- read.table('./test/subject_test.txt',header=FALSE)  #imports subject_test.txt
xTest        <- read.table('./test/X_test.txt',header=FALSE)    #imports X_test.txt
yTest        <- read.table('./test/y_test.txt',header=FALSE)    #imports y_test.txt

# Assign column names to data
colnames(subjectTest)  <- "subjectId"
colnames(xTest)        <- features[,2]
colnames(yTest)        <- "activityId"

# Merge yTest, subjectTest, xTest to get training dataset
testingData <- cbind(yTest, subjectTest, xTest)

# Combine training and test data to create a final data set
combinedData <- rbind(trainingData, testingData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
colNames <- names(combinedData)
# Keep column names containing "activity", "subject", "-mean()" and "-std()"
colIdx <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean\\(\\)",colNames) | grepl("-std\\(\\)",colNames))
combinedData <- combinedData[colIdx == TRUE]

## 3. Use descriptive activity names to name the activities in the data set
# Merge combinedData with activityType to include descriptive activity names
combinedData <- merge(combinedData, activityType, by="activityId", all.x=TRUE)

## 4. Appropriately labels the data set with descriptive variable names. 
colNames <- names(combinedData)

# Clean up col names
for (i in 1:length(colNames)) {
    colNames[i] <- gsub("-std\\()","StdDev",colNames[i])
    colNames[i] <- gsub("-mean\\()","Mean",colNames[i])
    colNames[i] <- gsub("\\()","",colNames[i])
    colNames[i] <- gsub("^(t)","time",colNames[i])
    colNames[i] <- gsub("^(f)","freq",colNames[i])
    colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}
names(combinedData) <- colNames

## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.
combinedData <- combinedData[, colNames != 'activityType']
colNames <- names(combinedData)
grpd <- with(combinedData, aggregate(combinedData, by=list(activityId, subjectId), FUN=mean, na.rm=TRUE))
result <- merge(grpd, activityType, by="activityId", all.x=TRUE)

# Export the tidy data set 
write.table(result, './tidy_data.txt',row.name=FALSE,sep='\t')