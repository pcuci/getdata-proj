Activity Data
===================================

1. Download the "run_analysis.R" file  
2. Set your working directory to where you downloaded the file  
3. Run the code   
4. Read in the file produced from the code using read.table("activitydata.txt")  

### Study Design
The data was taken from a study conducted by Jorge L. et al. called "Human Activity Recognition Using Smartphones Dataset". There is a paper description at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and all the data is in a zip file at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Raw Data
Their data was obtained from carrying out experiments with 30 participants performing six different activities while wearing a smartphone. The data was randomly split into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. Using the phone's embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  

- subject_test.txt: contains the participant number (1-30) for the test data  
- y_test.txt: contains the activity number (1-6) for the test data  
- X_test.txt: contains the vector information (1-531) for the test data  
- subject_training.txt: contains the participant number (1-30) for the training data  
- y_training.txt: contains the activity number (1-6) for the training data  
- X_trainingt.txt: contains the vector information (1-531) for the training data  
- features.txt: contains the descriptive names of activities

For more detailed information on the original data set consult the README.txt file included in the original project.
 
### Transformations

The data and labels were loaded into R. The identifier column names were given more appropriate labels such as "activity" and "participant". The vector measurement column names were renamed according to the features text file. These names were cleaned up by removed unneccessary brackets.

We then created a summary data frame that displays only mean and standard deviation data. The test and training data sets were merged together into a single data frame and then filtered by searching the column names for "std" and "mean". These filtered columns were combined with the identifier columns to create a new data frame. 

The numeric labels for activities were converted to descriptive ones using the map values function and activity_labels text file. They were then tidied up by changing the characters to lower case and replacing underscores with spaces which produced the following labels.

1. walking  
2. walking upstairs  
3. walking downstairs  
4. sitting  
5. standing  
6. laying  

An independent tidy data frame was created using the aggretate function with the average of each variable for each activity and each subject. As a result of aggregating, new columns were made making some of the old ones unneccessary, some of which got deleted or renamed.

The tidy data frame was written to a file called "activitydata.txt" in the working directory.
