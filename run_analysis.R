zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}
# Numbered activities from 1 to 6
ytest <- read.table(file.path(dataPath, "test", "y_test.txt"))
# 561 variable names
xtest <- read.table(file.path(dataPath, "test","X_test.txt"))
# Table with test subject
subtest <- read.table(file.path(dataPath, "test","subject_test.txt"))
# 561 variables info
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
#  list to modify colnames from features
listf <- as.list(features[,2])
# Change column names of features
colnames(xtest) <- c(listf)
# Read activity labels
activitylabels <- read.table(file.path(dataPath, "activity_labels.txt"))
# Get names from activity labels
aclabels <- as.list(activitylabels[,2])
# "Merge" of subjects ID with xtest 
testdf <- cbind.data.frame(subtest, xtest)
# Union of activity names from ytest with activity labels
labeledytest<- join(ytest, activitylabels)
# union of activities and subjects dataframes
testdf2 <- cbind.data.frame(labeledytest, testdf)
# Rearrangement to get subject as the first column
testdf2 <- testdf2[,c(3,1,2,4:564)]


#Name change of columns 1 , 2 and 3
testdf3 <- rename(testdf2, replace = c("V1" = "Subjects"))
testdf3 <- rename(testdf3, replace = c("V1.1" = "activityid"))
testdf3 <- rename(testdf3, replace = c("V2" = "activitylabel"))
# Get first 3 columns from testdf3
idcols <- testdf3[,1:3]

# Test info is now tidy, repeat procedure for train folder, comments are now in spanish, but they are pretty much the same as the previous

# Actividades numeradas del 1:6
ytrain <- read.table(file.path(dataPath, "train","y_train.txt"))
# 561 nombres de variables
xtrain <- read.table(file.path(dataPath, "train","X_train.txt"))
# Tabla con sujetos test
subtrain <- read.table(file.path(dataPath, "train","subject_train.txt"))
## Informacion de las 561 variables
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
# lista para modificar nombre de columnas de features
listf <- as.list(features[,2])
# Cambio de nombres a features 
colnames(xtrain) <- c(listf)
# Leer activity labels
activitylabels <- read.table(file.path(dataPath, "activity_labels.txt"))
# Obtener nombres de activity labels
aclabels <- as.list(activitylabels[,2])
# "Merge" de subjects ID con X rain 
traindf <- cbind.data.frame(subtrain, xtrain)
# Union de nombres de actividades de ytest con activity labels
#para no tener numeros
labeledytrain<- join(ytrain, activitylabels)
# union de df de actividades con la de sujetos
traindf2 <- cbind.data.frame(labeledytrain, traindf)
# reordenamiento para que los sujetos sean la primera columna
traindf2 <- traindf2[,c(3,1,2,4:564)]


#Cambiar nombre de la columnas 1 , 2 y 3
traindf3 <- rename(traindf2, replace = c("V1" = "Subjects"))
traindf3 <- rename(traindf3, replace = c("V1.1" = "activityid"))
traindf3 <- rename(traindf3, replace = c("V2" = "activitylabel"))
# Get first 3 columns from traindf3
idcols2 <- traindf3[,1:3]


#Create finaldf by joining testdf4 and traindf4
finaldf <- rbind(traindf3, testdf3 )

#labeling the data set with descriptive variable names
names(finaldf3)<-gsub("^t", "time", names(finaldf3))
names(finaldf3)<-gsub("^f", "frequency", names(finaldf3))
names(finaldf3)<-gsub("Acc", "Accelerometer", names(finaldf3))
names(finaldf3)<-gsub("Gyro", "Gyroscope", names(finaldf3))
names(finaldf3)<-gsub("Mag", "Magnitude", names(finaldf3))
names(finaldf3)<-gsub("BodyBody", "Body", names(finaldf3))

#Extracting only the measurements on the mean and standard deviation for each measurement

#Subset Name of Features by measurements on the mean and standard deviation
#i.e taken Names of Features with “mean()” or “std()”
subfeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
#Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subfeatures), "Subjects", "activitylabel" )
finaldf2<-subset(finaldf,select=selectedNames)
#Check the structures of the data frame
str(finaldf2)

# Creates a second,independent tidy data set and ouput it
finaldf3<-aggregate(. ~Subjects + activitylabel, finaldf2, mean)
finaldf3<-finaldf3[order(finaldf3$Subjects,finaldf3$activitylabel),]
write.table(finaldf3, file = "tidydf.txt",row.name=FALSE)

knit2html("run_analysis.R")
