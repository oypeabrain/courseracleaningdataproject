#Course Project

#Read in the data (assuming it is saved to working directory)
testsubject <- read.table(file = file.path("UCI HAR Dataset/test", "subject_test.txt"))
testx <- read.table(file = file.path("UCI HAR Dataset/test", "X_test.txt"))
testy <- read.table(file = file.path("UCI HAR Dataset/test", "y_test.txt"))
trainsubject <- read.table(file = file.path("UCI HAR Dataset/train", "subject_train.txt"))
trainx <- read.table(file = file.path("UCI HAR Dataset/train", "X_train.txt"))
trainy <- read.table(file = file.path("UCI HAR Dataset/train", "y_train.txt"))
signals <- read.table(file = file.path("UCI HAR Dataset", "features.txt"))

#Find the columns for the 66 mean and sd variables
signals <- as.character(signals[,2])
colsubset <- sort(c(grep("-mean\\(\\)", signals), grep("-std\\(\\)", signals)))

#Subset the train and test data sets using our colsubset variable
trainx <- trainx[,colsubset]
testx <- testx[,colsubset]

#Create trainset & testset by binding columns together
traindat <- cbind(trainsubject, trainx, trainy)
testdat <- cbind(testsubject, testx, testy)

#Check that the variables are the same in both sets
sum(names(testx) == names(trainx)) #this should equal 66

#Merge training and test sets to create 1 data set
fulldata <- rbind(traindat, testdat)
dim(fulldata) #this should be 10299 rows with 68 columns, including labels

#Rename variables and activity names
varnames <- signals[colsubset]
varnames <- gsub("-", "", varnames)
varnames <- gsub("mean\\()", "Mean", varnames)
varnames <- gsub("std\\()", "StDev", varnames)
names(fulldata) = c("Subject", varnames, "Activity")
library(plyr)
fulldata$Activity = mapvalues(fulldata$Activity, from = c(1,2,3,4,5,6), to = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

#Reshape the data frame to be more concise
library(reshape2)
tidydata <- melt(fulldata, id = c("Subject", "Activity"))
	#This will expand the data to list observations by their subject and activity
tidydata <- dcast(tidydata, Subject + Activity ~ variable, mean)
	#This will reform the data using unique combos of subject&activity for rows
	#The mean of the observations of each variable, grouped by unique subject and
	#activity combination, will fill in the columns
	
#Export data to file
write.table(tidydata, "UCIHarTidyset.txt", sep=",", col.names = T)
