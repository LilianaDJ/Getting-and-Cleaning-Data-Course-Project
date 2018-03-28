#_____________________________STEP I________________________________
#Merges the training and the test sets to create one data set.


#Create folder for files
    if (!file.exists("project"))
    {
        dir.create("project")
    }

#Get the Zip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#Download the Zip
download.file(url, destfile = "./project/dirDataR.zip")
#Decompress the  Zip 
unzip(zipfile = "./project/dirDataR.zip", exdir = "./project")

#Read the Activity data
activityTrainY <- read.table("./project/UCI HAR Dataset/train/Y_train.txt")
activityTestY <- read.table("./project/UCI HAR Dataset/test/y_test.txt")
#Make a dataset for the set of Activities
activityDF <- rbind(activityTrainY,activityTestY)

#Read the SUBJECT data
subjectTrain <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")
#Make a day be for the subject set
subjectDF <- rbind(subjectTrain, subjectTest)

#Read the data of Features
featureTrainX <- read.table("./project/UCI HAR Dataset/train/X_train.txt")
featureTestX <- read.table("./project/UCI HAR Dataset/test/X_test.txt")
#Hacer un conjunto de datos para los Features 
featuresDF <- rbind(featureTrainX, featureTestX)

#Accommodate the names
names(subjectDF)<- c("subject")
names(activityDF) <- c("activity")
namesFeaturesDF <- read.table("./project/UCI HAR Dataset/features.txt")
names(featuresDF) <- namesFeaturesDF$V2

#Combine the subject with activities
totalDF <- cbind(subjectDF, activityDF)
#Combine Everything
dataDF <- cbind(featuresDF, totalDF)


#----------------------------STEP 2-----------------------------------
#Extracts only the measurements on the mean and standard deviation for each measurement.


#Get the names of the features  of mean and std
subdataSubjectNames <- namesFeaturesDF$V2[grep("mean\\(\\)|std\\(\\))", namesFeaturesDF$V2)]

#From the names choose the measurements
selectNames <- c(as.character(subdataSubjectNames), "subject", "activity")
#Now I just call what SelectNames has
dataDFV2 <- subset(dataDF, select = selectNames)

#------------------------------STEP 3-----------------------------------
#Uses descriptive activity names to name the activities in the data set

#Get the activity_labels.txt
activityLabels <- read.table("project/UCI HAR Dataset/activity_labels.txt")

#Put the corresponding name by activity
activityDF[,1] <- activityLabels[activityDF[,1],2]
#Put the name of the column as "activity"
names(activityDF) <- "activity"



#---------------------------------step 4----------------------------------
#Appropriately labels the data set with descriptive variable names.
#
names(dataDF)<-gsub("^t", "time", names(dataDF))
names(dataDF)<-gsub("^f", "frequency", names(dataDF))
names(dataDF)<-gsub("Acc", "Acceleromet	er", names(dataDF))
names(dataDF)<-gsub("Gyro", "Gyroscope", names(dataDF))
names(dataDF)<-gsub("Mag", "Magnitude", names(dataDF))
names(dataDF)<-gsub("BodyBody", "Body", names(dataDF))

#----------------------------step 5---------------------------------------
#create independent tidy data set 
#will be created with the average of each variable for
#each activity and each subject based on the data set in step 4.

#Load the package 
library(plyr)
finalDataF <- aggregate(. ~subject + activity, dataDF, mean)
finalDataF <- finalDataF[order(finalDataF$activity),]
write.table(finalDataF, file = "newDatos.txt", row.names = FALSE)

