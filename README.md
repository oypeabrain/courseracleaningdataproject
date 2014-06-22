courseracleaningdataproject
===========================

Course Project for Coursera Data Science 3- Getting and Cleaning Data

The data can be downloaded and unzipped at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
My script (and explanations) will assume you have downloaded and unzipped this dataset into your working directory.

My first step in dealing with this data was to look at how the data was laid out. I saw that the data was split into testing and training sets. Within each of these sets were the subject labels, the signal data, and the activity markers. After seeing this, I wrote code to read in these 6 files and assign them to clearly named variables, making sure to specify the pathway to each file, since they lie in different folders within the main UCI HAR Dataset folder. I also read in the features file to parse for the mean and SD variables.

I wanted to immediately reduce the size of the data as much as possible to allow things to run faster later, so I next needed to figure out which columns in the training and test sets corresponded with the mean and std variables. To do this, I used the features.txt file included in the dataset. After looking through the file, I noticed that for our 33 main feature variables, mean was written in the variable as “mean()”, and standard deviation as “std()”. The most helpful and critical property of the features file were the parentheses that followed the variables of the main signal types. Without this, it would have been much more difficult to parse the strings. The other angular and meanfreq measurements were not named in this way, so isolating mean() and std() would be enough to ignore these variables.  I isolated the column of feature names and converted it from factor levels to characters so I would be able to parse the names for “mean()” or “std()”. I used the handy grep() function to extract the indices of variable names for mean and std of the signal types and sorted them into a new variable, colsubsets. After this, I quickly subsetted the columns of the train and test X datasets using this index vector.

My next step was to create separate testing and training sets. I used cbind to bind the labels and the data together. Afterwards, as specified in the instructions, I merged the testing and training sets into one large data set by simply binding them by row. I knew that this simpler method would work efficiently and quickly because the testing and training sets are mutually exclusive, since they were split by volunteer into 2 different groups. I made sure to double check that the variables were the same number and in the same order in both sets, so that in this new combined dataset, each variable would have its own column, as per the rules of tidy data. After confirming that the variables in both sets were the same, I recombined the training and test sets into one full data set by binding the rows together. After this, I checked to make sure that my full dataset had all the information necessary- the original 10,299 rows, and my 66 variables plus 2 label columns.

In order to facilitate reshaping the data later, I assigned the full variable names back to their respective columns and used the plyr package to easily assign the full activity name to the 6 activity markers. In order to create easier-to-read variables, I used the gsub() function to take out all the hyphens in the variable names, then replaced mean() and std() with Mean and StDev, to remove the parentheses, and to capitalize the functions for easier reading.

The last step was to reshape the data and obtain just the mean of each variable for each of the 6 activities that each volunteer performed, meaning that the final tidy set should have 180 observations. The first part of doing this was to load the reshape2 package and melt the data using the subject and the activity as the id markers- this means that the data will be melted into a long list of every variable name and value, along with the subject marker and the activity performed. I then took this data and recast it using dcast(), where my formula was Subject + Activity ~ variable, mean. This means that I want just the mean of each variable for only the 180 unique combinations of subject and activity. So for each subject and activity, we have just the average of each variable.

Finally, the code writes the new tidy dataset to a text file using commas as delimiters for reading in as either .csv or .txt.

My Tidy Set
1.) Each variable is in 1 column
2.) Each observation is in 1 row (all the observations in my set are unique combinations of subject/activity)
3.) One table for every kind of variable (all the data in my dataset is derived from the same study and signals)
4.) Column names have readable variable names
