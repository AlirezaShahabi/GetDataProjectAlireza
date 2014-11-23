### The assumption is that the folder 'UCI HAR Dataset' is in your current working directory. Running the code may take about 1 minute depending on your system.

run_analysis.R code is made of 5 parts Each part produce the answer to one of the 5 questions asked in the project webpage. 

### Part 1: Merges the training and the test sets to create one data set.

read the following three files from "./UCI HAR Dataset/test/"

- test.subject
- test.type
- test.data

write the data into 3 separate data frames

* number of rows of every data frame is 2947 which is the total number of actions performed
by all the 30 individuals (subjects)
* number of columns of test.data is 561 which equals the total number of features measured during 
each activity. Feature are explained in feature_info.txt in 'UCI HAR Dataset' folder

Combine the three data frames into 1 data frame, called test.df. follow the same steps for train data and create train.df. At the end, merge test.df and train.df into 1 data frame called all.df, using all the common columns.

all.df has 10299 rows where each row corresponds to one activity performed by one subject. all.df
has 563 columns where first and second columns are "Subject" and "Activity", respectively. Columns 3 to Column 563 are all the features measured during each activity. The name of features are 
in file: features.txt.

* all.df is the answer to Part 1.


### Part 2: Extracts only the measurements on the mean and standard deviation for each measurment

At first, read the names of all the 561 features from "./UCI HAR Dataset/features.txt". Save the data into a data frame called 'featNames'. Use grepl() function in a for loop to extract the names that include: "-mean()" and "-std()". This will result in 33 mean and 33 std od measurements. So, the new 
data frame should have only 66 columns.

* Note: I have ignored the meanFrequency features

Inside the for loop, extract the columns of 'all.df' that corespond to these 66 features. Write them
into a new data frame called 'Mean.Std.df'. 

* Mean.Std.df data frame is the answer to Part 2.

### Part 3: Uses descriptive activity names to name the activities in the data set

Read the activity labels from "./UCI HAR Dataset/activity_labels.txt" and create a data frame called
ActLabel. Replace the numbers in the Activity column in Mean.Std.df from Part 2 with the corresponding 
activity name from ActLabel data frame inside a for loop. 

* Updated Mean.Std.df is the answer to Part 3.

### Part 4: Appropriately labels the data set with descriptive variable names

In Mean.Std.df from Question 3, only the first two columns are appropriately labeled as: 
"Subject" and "Activity". We need to label column 3 to 68 with the correct name of the activity 
they represent. These names are saved into Mean.Std.names in Pat 2. So use the colNames command
to add Mean.Std.names as column names of Mean.Std.df.

* Updated Mean.Std.df is the answer to Part 4.

### Part 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Split the Mean.Std.df data frame from question 4 into a list based on two columns: Subject and Activity. The result is a list with 180 elements (180 = 30 subject * 6 activity) . Each element is a data frame that only includes the observation of 1 Activity performed by 1 subject.

Measure the mean of each column from every element of generated list above useing sapply fuction.
After doing final modifications, save the result into a data frame called Average.df.

* Average.df is a WIDE TIDY tidy data set we are asked for. 
* It has 180 rows. Each row is one activity performed by 1 subject
* It has 68 columns (each column represent only one kind of variable)
* Column 1 is the name of the subject.
* Column 2 is the name of activity.
* Column 3 to 68 are the average of the 66 features, measured for the Subject and activity.

### Average.df is the final tidy data set. It is written to the current working directory as tidy.dataset.txt. Since it is made of 68 columns, it does not look good on the screen! (It's a wide tidy data set) But you can view, say, its first 5 columns by typing: Average.df[,1:5]


