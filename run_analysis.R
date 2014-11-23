rm(list=ls(all=TRUE))


# The assumption is that the folder 'UCI HAR Dataset' is in your current working directory
# running the code may take about 1 minute depending on your system.


# Question 1: Merges the training and the test sets to create one data set. # # # # # # # # # # # #

# reading the test data - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

test.subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
test.type   <-read.table("./UCI HAR Dataset/test/y_test.txt")
test.data   <-read.table("./UCI HAR Dataset/test/X_test.txt")

# number of rows of every data frame is 2947 which is the total number of actions performed
# by all the 30 individuals (subjects)
# number of columns of test.data is 561 which equals the total number of features measured during 
# each activity. Feature are explained in feature_info.txt


# combine the three test data files into 1 data frame: test.df

test.df <- cbind(test.subject,test.type,test.data)

# assigning the column names of test.df

test.colNames <- names(test.df)
test.colNames[1] <- "Subject"
test.colNames[2] <- "Activity"

colnames(test.df) <- test.colNames

# in the test.df, each row represents one activity performed by one of the 30 individuals(subjects)
# first column is the id of person who performed the activity
# second column is the id of action that is performed
# column 3 to 563 are the features recorded during the activity


# reading the train data - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

train.subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
train.type   <-read.table("./UCI HAR Dataset/train/y_train.txt")
train.data   <-read.table("./UCI HAR Dataset/train/X_train.txt")

# explanation for dimension of train data files are similar to test data files, explained before


# combine the three train data files into 1 data frame: train.df

train.df <- cbind(train.subject,train.type,train.data)

# assigning the column names of train.df

train.colNames <- names(train.df)
train.colNames[1] <- "Subject"
train.colNames[2] <- "Activity"

colnames(train.df) <- train.colNames


# Merge test.df and train.df into 1 data frame all.df - - - - - - - - - - - - - - - - - - - - - -

# both data sets have the same columns, so:

all.df <- merge(test.df,train.df,all=TRUE)

# all.df is a tidy dataset; each column of it coresponds to only 1 variable and each row 
# coresponds to only 1 observation

# all.df has 10299 rows where each row corresponds to one activity performed by one subject
# all.df has 563 columns. First and second columns are Subject and activity type, respectively.
# Columns 3 to 563 are all the features measured during each activity. The name of features are 
# in file: features.txt

# Question 1 answer: all.df # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




# Question 2: Extracts only the measurements on the mean and standard deviation for  # # # # # # #
# each measurment 

# read the names of all the 561 features from the file: features.txt

featNames <- read.table("./UCI HAR Dataset/features.txt")

featNames$V2 <- as.character(featNames$V2)

# initialize a vector that will contain the names of new features

Mean.Std.names <- character()

# create a data frame. The first two column are "Subject" and "activity" from all.df of Question 1

Mean.Std.df <- all.df[,1:2]

# read the names of all features in a for loop and choose those that contain "-mean()" and "-std()"
# save the chosen names to Mean.Std.names vector
# Take the all.df from Question 1, choose the columns corresponding to the chosen names above and 
# save them into a newly created data frame: Mean.Std.df
# there are 33 mean and 33 std in the features. I've ignored meanFreq.

counter = 1

for (i in 1:nrow(featNames)){
    
    if ( grepl("-mean()",featNames[i,2],fixed=TRUE) | grepl("-std()",featNames[i,2],fixed=TRUE)  ){
        
       Mean.Std.names[counter] <- featNames[i,2]
       
       Mean.Std.df[,counter+2] <- all.df[,i] 
       
       counter = counter + 1
    }
}


# new data frame, has 68 columns. col1 is "Subject", col2 is "Activity", col3 to col 68 are the 66 
# selected fetures (only mean and standard deviation of measurement)


# Question 2 Answer: Mean.Std.df  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




# Question 3: Uses descriptive activity names to name the activities in the data set # # # # # # #

# read the activity labels from activity_labels.txt

ActLabel <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)

# replace the content of Activity column in Mean.Std.df from question 2 with the corresponding 
# activity name from ActLabel

for (i in 1:nrow(Mean.Std.df)){
    
    Mean.Std.df[i,2] <- ActLabel[Mean.Std.df[i,2],2]
}

# Mean.Std.df now contains the correct name of each activity in its second column

# Question 3 Answer: Mean.Std.df  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




# Question 4: Appropriately labels the data set with descriptive variable names # # # # # # # # #


# In Mean.Std.df from Question 3, only the first two columns are appropriately labeled as: 
# "Subject" and "Activity". We need to label column 3 to 68 with the correct name of the activity 
# they represent. Those names were saved in Question 2 into Mean.Std.names.

NewColNames <- c("Subject","Activity",Mean.Std.names)

colnames(Mean.Std.df) <- NewColNames

# Now, They are all appropriately named.


# Question 4 answer: Mean.Std.df # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




# Question 5: From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject. # # # # # # # # # # # # # # # # # # 

# split the Mean.Std.df from question 4 into a list based on Subject and Activity
# the result is a list with 180 elements (180=30*6)
# each element is a data frame that only includes the observation of 1 Activity performed by 1
# subject

myList <- list(Mean.Std.df$Subject,Mean.Std.df$Activity)
Mean.Std.List <- split(Mean.Std.df,myList)

# measure the mean of each measurement and save the file into a matirx

Average.Matrix <- sapply(Mean.Std.List, function(x){
    
    ans <- c(x$Subject[1],x$Activity[1],colMeans(x[,3:68]))
    ans
    
    })

# transpose the matrix and transfer it into a data frame

Average.Matrix.transpose <- t(Average.Matrix)
Average.df <- data.frame(Average.Matrix.transpose)

# Assign the correct column names to Average.df (NewColNames is obtained from Question 4):

rownames(Average.df) <- NULL
colnames(Average.df) <- NewColNames

# Average.df is the final tidy data frame we are looking for. 
# It has 180 rows. Each row is one activity performed by 1 subject
# It has 68 columns the same as Mean.Std.df from Question 4. (WIDE TIDY DATA SET)
# Column 1 is the name of the subject
# Column 2 is the name of activity
# Column 3 to 68 are the average of the 66 features, measured for the Subject and activity


# Question 5 answer: Average.df # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# ATTENTION: 

# UNCOMMENT THE NEXT LINE TO SEE THE FIRST 5 COLUMNS OF THE TIDY DATASET. TOTAL NUMBER
# OF COLUMNS IS 68. IT DOES NOT LOOK PREtY ON THE SCREEN !!


# Average.df[,1:5]


# write the WIDE TIDY DATA SET to a  text file in your curreny directory

write.table(Average.df,file="./tidy.dataset.txt",row.name=FALSE)
