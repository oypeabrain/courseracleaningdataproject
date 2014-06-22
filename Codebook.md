## Coursera Data Science 3 - Getting and Cleaning Data
### Course Project Study Design

The experiment in question concerns measuring physical activity in humans using their smart phones- in this case study, the phones used were all Samsung Galaxy S smartphones. 30 volunteers were observed, each performing 6 activities of daily living while wearing their phones on their waist: walking, walking upstairs, walking downstairs, sitting, standing, and laying down. The data is comprised of readings using the embedded accelerometer and gyroscope in the phones which yields both a 3-axis acceleration and directional movement. The volunteers were split into two groups- 70% trainset and 30% testset- the data for both have been rejoined for the purposes of this project. The original raw signal data was included, but I focused on the processed data, which were processed by applying noise filters and sampled using moving windows with overlap. Essentially, the processing yielded a time signal with reduced noise and the accelerometer signal was split into body and gravity acceleration. Afterwards, the linear acceleration and angular velocity were calculated to obtain Jerk signals, which were then split. In addition, some of these signals were transformed using a Fourier transform and are listed as well. The original dataset contains 561 variables on 10,299 observations (7352 trainset, 2947 test set). In total we have 9 magnitude measurements and 8 acceleration/gyroetric measurements (which were each split into their 3 individual axis signals) making for a total of 33 signal types (9 + 24).

For this dataset, I stripped the data down to mean and standard deviation measures for each of the 33 processed signal types. Because the assignment states “extract only the measurements on the mean and SD for each measurement,” I chose not to include the “meanFreq” measurement, which is only a weighted average of frequency components, not the measurements themselves. In addition, I chose to exclude the additional angle variable vectors, as they only measure the average signal in a window sample- while they do provide the means on certain measurements, this information is not available for all of the measurements, so I took this as a sign that it did not fall under the project guidelines since it asks for the mean variables for each measurement. I left the subject markers as is, since we do not have any additional information by which to distinguish the participants. I chose to utilize a wide-format for my dataset, so that each column would correspond to one variable, following the rules of a tidy data set. The instructions say to create a tidy data set “with the average of each variable for each activity and each subject,” so I took this to mean 30 participants each performing 6 activities = 180 rows/observations.

### Codebook

**Variables**  
Average of the mean values and average of the standard deviation measures for the following 33 signal types, where a 't' prefix denotes time and 'f' prefix indicates frequency domain signals. Acc refers to accerlation, gyro refers to gyrometric measurements. Mean indicates mean, StDev indicates standard deviation. An 'XYZ' suffix in the list below means that there are 3 axial factors (and thus, variables) for that particular signal- X, Y, and Z.

The original acceleration signal was split into body and gravity acceleration signals using a low pass butterworth filter with a corner frequency of 0.3 Hz:  
tBodyAccMeanXYZ, tBodyAccStDevXYZ  
tGravityAccMeanXYZ, tGravityAccStDevXYZ  

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals:
tBodyAccJerkMeanXYZ, tBodyAccJerkStDevXYZ  
tBodyGyroJerkMeanXYZ, tBodyGyroJerkStDevXYZ  

The magnitude of these 3-dimensional signals were calculated using the Euclidian norm:  
tBodyAccMagMean, tBodyAccMagStDev  
tGravityAccMagMean, tGravityAccMagStDev  
tBodyAccJerkMagMean, tBodyAccJerkMagStDev  
tBodyGyroMagMean, tBodyGyroMagStDev  
tBodyGyroJerkMagMean, tBodyGyroJerkMagStDev  

A fast Fourier transform was applied to some of the signals to obtain frequency domain signals:  
fBodyAccMeanXYZ, fBodyAccStDevXYZ  
fBodyAccJerkMeanXYZ, fBodyAccJerkStDevXYZ  
fBodyGyroMeanXYZ, fBodyGyroStDevXYZ  
fBodyAccJerkMagMean, fBodyAccJerkMagStDev  
fBodyGyroMagMean, fBodyGyroMagStDev  
fBodyGyroJerkMagMean, fBodyGyroJerkMagStDev  

**Units**  
The original acceleration signals were measured in standard gravity units 'g' and the gyroscope data was measured in radians/second. However, during the processing of the data, everything was scaled by dividing by the range, meaning that the units are cancelled. So each number in our dataset is essentially a ratio.

Link to original study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
