library("data.table")
library("reshape2")

curPath<-getwd()

srcUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(srcUrl, file.path(curPath, "dataFiles.zip"))

unzip(zipfile="dataFiles.zip")

## Load the activity labels and features - 

activityLabels<-fread(file.path(curPath,"UCI HAR Dataset/activity_labels.txt"), col.names = c("Labels", "activityName"))

features<-fread(file.path(curPath,"UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))

wantedFeatures<-grep("(mean|std)\\(\\)", features[, featureNames])

measurements<-features[wantedFeatures, featureNames]

measurements<-gsub('[()]', '', measurements)





## Load train datasets - 

tr<-fread(file.path(curPath, "UCI HAR Dataset/train/X_train.txt"))[, wantedFeatures, with = FALSE]

data.table::setnames(tr, colnames(tr), measurements)

trActivities<-fread(file.path(curPath, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))


trSubjects<-fread(file.path(curPath, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNumber"))

tr<-cbind(trSubjects, trActivities, tr)


## Load test datasets -

tt<-fread(file.path(curPath, "UCI HAR Dataset/test/X_test.txt"))[, wantedFeatures, with = FALSE]

data.table::setnames(tt, colnames(tt), measurements)


ttActivities<-fread(file.path(curPath, "UCI HAR Dataset/test/Y_test.txt"),col.names = c("Activity"))

ttSubjects<-fread(file.path(curPath, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNumber"))

tt<-cbind(ttSubjects, ttActivities, tt)

## merge datasets -

combined<-rbind(tr, tt)

## conversion from ActivityLabels to activityName -

combined[["Activity"]]<-factor(combined[, Activity], levels = activityLabels[["Labels"]],labels = activityLabels[["activityName"]])

combined[["SubjectNumber"]]<-as.factor(combined[, SubjectNumber])

combined<-reshape2::melt(data=combined, id = c("SubjectNumber","Activity"),na.rm=TRUE)

combined<-reshape2::dcast(data=combined,SubjectNumber + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "tidyDataSet.txt", quote = FALSE,row.names = FALSE)


