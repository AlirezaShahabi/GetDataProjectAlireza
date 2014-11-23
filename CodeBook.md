### General information about the data in 'UCI HAR Dataset' folder:

30 Individuals have performed 6 different kinds of activity in a period of time. A smart phone on their waist has recorded hundreds of different measurements in that period of time. The recorded data is stored within multiple text files. In this codebook, you can find a brief explanation about the files and the data stored in them. 

### There are 4 text files and two folders inside 'UCI HAR Dataset' as listed below:

* README.txt
* activity_labels.txt
* features.txt
* features_info.txt
* folder test
* folder train

### README.txt

It's a guidance for all the data included in 'UCI HAR Dataset' folder. It has some explanation on what the data are and how they are recorded. It has some useful information about other files in 'UCI HAR Dataset' as well.

### activity_labels.txt

This file includes the name of all the 6 activities performed by the individuals during the experiment:

1  WALKING

2  WALKING_UPSTAIRS

3  WALKING_DOWNSTAIRS

4  SITTING

5  STANDING

6  LAYING

Throuout the files in 'UCI HAR Dataset', these activities are represented by their corresponding IDs.

### features.txt

This file includes the names of 561 different measurements recorded by the smartphones. The names are self explanatory. Each measurement is reffered to as a feature throughout the files in 'UCI HAR Dataset'. For instance, feature number 4, tBodyAcc-std()-Y, is the stansard deviation of body accelaeration. t in the begining means it is recorded in time domain.

### features_info.txt

This file explains all the features stored in feature.txt. The information is self explanatory. Some important parts of the file are presented below:



The following are the signals recorded during the activities:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

t denotes time domain and f denotes frequency domain. The following are the estimation performed on the signals above:

* mean(): Mean value
* std() : Standard deviation
* mad() : Median absolute deviation 
* max() : Largest value in array
* min() : Smallest value in array
* sma() : Signal magnitude area
* energy()  : Energy measure. Sum of the squares divided by the number of values. 
* iqr()     : Interquartile range 
* entropy() : Signal entropy
* arCoeff() : Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds()    : index of the frequency component with largest magnitude
* meanFreq()   : Weighted average of the frequency components to obtain a mean frequency
* skewness()   : skewness of the frequency domain signal 
* kurtosis()   : kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle()      : Angle between to vectors.


### folder test

All the measured data is devided into two groups: 27% in test and 73% train. The description for the files and data in these two folders are the same.

Test folder includes three text files that we need for our analysis:

* subject_test.txt
* y_test.txt
* X_test.txt

In subject_test.txt, each row identifies the subject who performed an activity in a given time window. Range of subject IDs is from 1 to 30. Number of rows is 2947 which indicates all the activity done by 30 subjects in all the time (test section).

File y_test.txt has the same number of rows as subject_test.txt. Here, each row identifies the type of activity was performed in the given time window. Activity IDs are explained in activity_labels.txt in the main directory.

X_test include all the measured data. It has 2947 rows, the same as the other two files. It has 561 columns for 561 different measurements. Each column stores the measurement of one feature. Name of the columns can be read from features.txt file in the main directory.

### folder train

The explanation is the same as that for folder test. The only difference is the number of rows:7352 



