# getting-and-cleaning-data-project
So, part of  the assignment is explaining how to get de dataframe tidy, so here is my work in steps, part of the path of the functions will be omited, the requires packages are plyr, dplyr and tidyr:
# Get the Numbered activities from 1 to 6
ytest <- read.table("//UCI HAR Dataset//test//y_test.txt")
# Get the 561 variable names
xtest <- read.table("C//UCI HAR Dataset//test//X_test.txt")
# Get a Table with the test subjects
subtest <- read.table("//UCI HAR Dataset//test//subject_test.txt")
# Get the info for the 561 variables
features <- read.table("//UCI HAR Dataset//features.txt")
#  list to modify colnames from features
listf <- as.list(features[,2])
# Change column names of features
colnames(xtest) <- c(listf)
# Read activity labels
activitylabels <- read.table("//UCI HAR Dataset//activity_labels.txt")
# Get names from activity labels
aclabels <- as.list(activitylabels[,2])
# "Merge" of subjects ID with xtest 
testdf <- cbind.data.frame(subtest, xtest)
# Union of activity names from ytest with activity labels, the join function is so much better than merge because join won't change the order of the variables
labeledytest<- join(ytest, activitylabels)
# union of activities and subjects dataframes
testdf2 <- cbind.data.frame(labeledytest, testdf)
# Rearrangement to get subject as the first column
testdf2 <- testdf2[,c(3,1,2,4:564)]

# table reading from the test inertial signals folder

bacxtestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_acc_x_test.txt")
ISbacxtest <- read.table(bacxtestpath)
bacytestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_acc_y_test.txt")
ISbacytest <- read.table(bacytestpath)
bacztestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_acc_z_test.txt")
ISbacztest <- read.table(bacztestpath)
bgxtestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_gyro_x_test.txt")
ISbgxtest <- read.table(bgxtestpath)
bgytestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_gyro_y_test.txt")
ISbgytest <- read.table(bgytestpath)
bgztestpath <- ("//UCI HAR Dataset//test//Inertial Signals//body_gyro_z_test.txt")
ISbgztest <- read.table(bgztestpath)
taxtestpath <- ("//UCI HAR Dataset//test//Inertial Signals//total_acc_x_test.txt")
IStaxtest <- read.table(taxtestpath)
taytestpath <- ("//UCI HAR Dataset//test//Inertial Signals//total_acc_y_test.txt")
IStaytest <- read.table(taytestpath)
taztestpath <- ("//UCI HAR Dataset//test//Inertial Signals//total_acc_z_test.txt")
IStaztest <- read.table(taztestpath)
#Name change of columns 1 , 2 and 3
testdf3 <- rename(testdf2, replace = c("V1" = "Subjects"))
testdf3 <- rename(testdf3, replace = c("V1.1" = "activityid"))
testdf3 <- rename(testdf3, replace = c("V2" = "activitylabel"))
# Get first 3 columns from testdf3
idcols <- testdf3[,1:3]

# cbind everything into testdf4
testdf4 <- cbind.data.frame(testdf3, ISbacxtest)
testdf4 <- cbind.data.frame(testdf4, ISbacytest)
testdf4 <- cbind.data.frame(testdf4, ISbacztest)
testdf4 <- cbind.data.frame(testdf4, ISbgxtest)
testdf4 <- cbind.data.frame(testdf4, ISbgytest)
testdf4 <- cbind.data.frame(testdf4, ISbgztest)
testdf4 <- cbind.data.frame(testdf4, IStaxtest)
testdf4 <- cbind.data.frame(testdf4, IStaytest)
testdf4 <- cbind.data.frame(testdf4, IStaztest)
### Test info is now tidy, repeat procedure for train folder, comments will be in spanish, but the meaning is pretty much the same as the previous ones

# Actividades numeradas del 1:6
ytrain <- read.table("//UCI HAR Dataset//train//y_train.txt")
# 561 nombres de variables
xtrain <- read.table("//UCI HAR Dataset//train//X_train.txt")
# Tabla con sujetos test
subtrain <- read.table("//UCI HAR Dataset//train//subject_train.txt")
## Información de las 561 variables
features <- read.table("//UCI HAR Dataset//features.txt")
## lista para modificar nombre de columnas de features
listf <- as.list(features[,2])
# Cambio de nombres a features 
colnames(xtrain) <- c(listf)
# Leer activity labels
activitylabels <- read.table("//UCI HAR Dataset//activity_labels.txt")
# Obtener nombres de activity labels
aclabels <- as.list(activitylabels[,2])
# "Merge" de subjects ID con X rain 
traindf <- cbind.data.frame(subtrain, xtrain)
# Unión de nombres de actividades de ytest con activity labels
#para no tener números
labeledytrain<- join(ytrain, activitylabels)
# unión de df de actividades con la de sujetos
traindf2 <- cbind.data.frame(labeledytrain, traindf)
# reordenamiento para que los sujetos sean la primera columna
traindf2 <- traindf2[,c(3,1,2,4:564)]

# lectura de archivos de carpeta inertial signals de test, TODAS LLEVAN "IS" al inicio

bacxtrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_acc_x_train.txt")
ISbacxtrain <- read.table(bacxtrainpath)
bacytrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_acc_y_train.txt")
ISbacytrain <- read.table(bacytrainpath)
bacztrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_acc_z_train.txt")
ISbacztrain <- read.table(bacztrainpath)
bgxtrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_gyro_x_train.txt")
ISbgxtrain <- read.table(bgxtrainpath)
bgytrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_gyro_y_train.txt")
ISbgytrain <- read.table(bgytrainpath)
bgztrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//body_gyro_z_train.txt")
ISbgztrain <- read.table(bgztrainpath)
taxtrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//total_acc_x_train.txt")
IStaxtrain <- read.table(taxtrainpath)
taytrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//total_acc_y_train.txt")
IStaytrain <- read.table(taytrainpath)
taztrainpath <- ("//UCI HAR Dataset//train//Inertial Signals//total_acc_z_train.txt")
IStaztrain <- read.table(taztrainpath)
#Cambiar nombre de la columnas 1 , 2 y 3
traindf3 <- rename(traindf2, replace = c("V1" = "Subjects"))
traindf3 <- rename(traindf3, replace = c("V1.1" = "activityid"))
traindf3 <- rename(traindf3, replace = c("V2" = "activitylabel"))
# Get first 3 columns from traindf3
idcols2 <- traindf3[,1:3]
# Add ID columns(idcols2) to each of the inertial signals dataframes to avoid
# having just one giant dataframe
ISbacxtrainfinal <- cbind.data.frame(idcols2, ISbacxtrain)
ISbacytrainfinal <- cbind.data.frame(idcols2, ISbacytrain)
ISbacztrainfinal <- cbind.data.frame(idcols2, ISbacztrain)
ISbgxtrainfinal <- cbind.data.frame(idcols2, ISbgxtrain)
ISbgytrainfinal <- cbind.data.frame(idcols2, ISbgytrain)
ISbgztrainfinal <- cbind.data.frame(idcols2, ISbgztrain)
IStaxtrainfinal <- cbind.data.frame(idcols2, IStaxtrain)
IStaytrainfinal <- cbind.data.frame(idcols2, IStaytrain)
IStaztrainfinal <- cbind.data.frame(idcols2, IStaztrain)
#cbind everything into traindf4
traindf4 <- cbind.data.frame(traindf3, ISbacxtrain)
traindf4 <- cbind.data.frame(traindf4, ISbacytrain)
traindf4 <- cbind.data.frame(traindf4, ISbacztrain)
traindf4 <- cbind.data.frame(traindf4, ISbgxtrain)
traindf4 <- cbind.data.frame(traindf4, ISbgytrain)
traindf4 <- cbind.data.frame(traindf4, ISbgztrain)
traindf4 <- cbind.data.frame(traindf4, IStaxtrain)
traindf4 <- cbind.data.frame(traindf4, IStaytrain)
traindf4 <- cbind.data.frame(traindf4, IStaztrain)

#Create finaldf by joining testdf4 and traindf4
finaldf <- rbind(traindf4, testdf4 )
#get sd and mean
apply(finaldf[,4:1716], 2, sd)
colMeans(finaldf[,4:1716])
