# Load libraries
library(data.table)

# set directory, test and train should be subdirectories of this one
dir <- "/UCI HAR Dataset/"

# function to pull the txt files into R and merge testing and training groups
get.data <- function(var) {
    train.file <- paste0(dir, "train/", var, "_train.txt")
    test.file <-  paste0(dir, "test/",  var, "_test.txt")
    rbindlist(list(fread(train.file), fread(test.file)))
}

# pull the subject ids into R as factors and name this column "subject"
subject <- get.data("subject")
colnames(subject) <- "subject"
subject <- subject[, subject:=factor(subject)]

# pull the activity data into R as factors and name this column "activity"
activity <- get.data("y")
colnames(activity) <- "activity"
activity.list <- fread(paste0(dir, "activity_labels.txt"))
activity <- activity[, activity:=factor(activity,
                           levels = activity.list[, V1],
                           labels = activity.list[, V2])]

# pull the data into R and add descriptive column names
features <- get.data("X")
colnames(features) <- unlist(fread(paste0(dir, "features.txt"))[, 2])

# combine subject, activity, and features into one data.table
merged <- cbind(subject, activity, features)
setkeyv(merged, c("subject", "activity"))

# identify and extract those columns with mean data
means.cols <- grep("[M|m]ean", colnames(merged), value = TRUE)
means <- merged[, ..means.cols]

# identify and extract those columns with standard deviation data
stds.cols <- grep("[S|s]td", colnames(merged), value = TRUE)
stds <- merged[, ..stds.cols]

# recombine identifying data with mean and standard deviation data
mean.and.standard.deviation <- cbind(subject, activity, means, stds)
setorder(mean.and.standard.deviation, subject, activity)

# create a data.table containing only the overall means by subject and activity
means.cols <- grep("[M|m]ean",colnames(mean.and.standard.deviation),
                   value = TRUE)
means.cols <- c("subject", "activity", means.cols)
tidy <- mean.and.standard.deviation[, ..means.cols]
tidy <- tidy[, lapply(.SD, mean), by=c("subject", "activity")]
write.table(tidy, "summarydata.txt", row.names = FALSE)
