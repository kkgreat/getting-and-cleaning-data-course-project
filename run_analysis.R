setwd("C:/Users/e9906576/Documents/study material/Coursera/Data Science JH/getting and clearning data")
testX<-read.table("course project/UCI HAR Dataset/test/X_test.txt")
testY<-read.table("course project/UCI HAR Dataset/test/Y_test.txt")
testSubject<-read.table("course project/UCI HAR Dataset/test/subject_test.txt")

trainX<-read.table("course project/UCI HAR Dataset/train/X_train.txt")
trainY<-read.table("course project/UCI HAR Dataset/train/Y_train.txt")
trainSubject<-read.table("course project/UCI HAR Dataset/train/subject_train.txt")

X<-rbind(testX,trainX)
Y<-rbind(testY, trainY)
Subject<-rbind(testSubject, trainSubject)

feature<-read.table("course project/UCI HAR Dataset/features.txt")
activity<-read.table("course project/UCI HAR Dataset/activity_labels.txt")

indexM<-grep("mean", feature[,2])
indexS<-grep("std", feature[,2])
index<-c(indexM, indexS)
index<-sort(index, decreasing=FALSE)

Xsort<-X[,index]
names(Xsort)<-feature[index,2]

Y[,1]<-activity[Y[,1],2]
names(Y)<-"Activity"

names(Subject)<-"SubjectID"
Data<-cbind(X, Y, Subject)

melted <- melt(Data, id=c("SubjectID","Activity"))
tidy <- dcast(melted, SubjectID+Activity ~ variable, mean)

write.csv(tidy, "tidy.csv", row.names=FALSE)
