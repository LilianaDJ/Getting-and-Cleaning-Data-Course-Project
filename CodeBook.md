## Introduction

First the files are decompressed in the / project / UCI HAR Dataset / train folder
* 1.- In order to carry out step number 1, the files were read according to an order
Activitys
Subject
Features
For each order a Data set was made, to reach only a set of data first with the function rbind and then with cbind.
* 2.- After seeing the names of the file features correctly, the columns of mean and std were extracted.
* 3.- The names of the file "activity_lebels.txt" are taken to accommodate them in the set of data already created.
* 4.- The appropriate names are put for the data set.
* 5.- A new data set is created with the characteristics established in step 5 ("newData.txt")

## Variables

* activityTrainY: Contains the data downloaded from Y_train.txt
* activityTestY: Contains the downloaded test data y_test.txt
* subjectTrain: Contains the data downloaded from subject_train.txt
* subjectTest: Contains the data downloaded from subject_test.txt
* featureTrainX: Contains the data downloaded from subject_test.txt
* featureTestX: Contains the data downloaded from X_test.txt
* activityDF: Activity subject data set
* subjectDF: Features data set
* featuresDF: Subject data set
* namesFeatures: Name of the features
* totalDF: Data frame of the combination of subject and activitys
* dataDf: Data frame of the combination of all data
* subdataSubjectNames <- Get the names of the fatures
* dataDFV2: Data frame of the data sorted with names
* activityLabels: contains the data from the activity_labels.txt file
* finalDataF <- New data frame
