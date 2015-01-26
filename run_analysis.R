library(plyr)

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL & destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./data/activity.zip"

# download file and record time
download.file(fileUrl, destfile, method = "curl")
dateDownloaded <- date()

# read test and training data sets and labels
test <- read.table("./data/activity/UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./data/activity/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./data/activity/UCI HAR Dataset/test/subject_test.txt")

training <- read.table("./data/activity/UCI HAR Dataset/train/X_train.txt")
trainingLabel <- read.table("./data/activity/UCI HAR Dataset/train/y_train.txt")
trainingSubject <- read.table("./data/activity/UCI HAR Dataset/train/subject_train.txt")

activityLabel <- read.table("./data/activity/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/activity/UCI HAR Dataset/features.txt")

# removing extra brackets and underscores
features <- gsub("\\()", "", features$V2)

activityLabel <- activityLabel$V2
activityLabel <- tolower(activityLabel)
activityLabel <- sub("_", " ", activityLabel)

# rename of columns
names(test) <- features; names(training) <- features
names(testLabel) <- "activity"; names(trainingLabel) <- "activity"
names(testSubject) <- "participant"; names(trainingSubject) <- "participant"

# create a df & bind the training data to the bottom of the test data
df <- rbind(test, training)

# extract columns containing standard deviation and mean
criteria <- grep("mean|std", names(df))

# create a new, separate df that holds only identifiers initially
df_test <- data.frame(testLabel, testSubject)
df_training <- data.frame(trainingLabel, trainingSubject)
df_new <- rbind(df_test, df_training)

# add the df criteria column to a new data frame
for (each in criteria){
  df_new <- cbind(df_new, df[each])
}

# replace activity numbers with their respective labels
df_new$activity <- mapvalues(df_new$activity, 
                             from = levels(factor(df_new$activity)), 
                             to = activityLabel)

# create new tidy data frame with the average of each variable for each activity and subject
df_tidy <- aggregate(df_new, list(df_new$participant, df_new$activity), mean)

# clean up the columns and column names after aggregating
df_tidy$participant <- NULL; df_tidy$activity <- NULL
names(df_tidy)[1] <- "participant"; names(df_tidy)[2] <- "activity"

# write out the dataframe to a new file
write.table(file = "activitydata.txt", x = df_tidy, row.names = FALSE)
