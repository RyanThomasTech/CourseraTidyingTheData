run_analysis <- function(){
  library(data.table)
  subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt", sep = "")
  x_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt", sep = "")
  y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt", sep = "")
  y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt", sep = "")
  x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt", sep = "")
  subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt", sep = "")
  features<-read.table("./data/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
  
  
  #aggregate matching data
  x_agg <- rbind(x_test, x_train)
  y_agg <- rbind(y_test, y_train)
  subject_agg <- rbind(subject_test, subject_train)
  names(subject_agg)<-"Subject ID"
  names(y_agg)<-"Activity"

  #this is step 2, done early for convenience
  colnames(features)<-c("label","measurement")
  features$label <- sapply(features$label, function(x) {sub("^","V",x)})
  keeps<-grep("(mean()|std())",features$measurement)
  x_agg <- x_agg[,keeps]
  features_names <- as.vector(features[keeps,2])
  features_names <- sapply(features_names, function(x){gsub("(\\(|\\)|\\-)","",x)})
  features_names <- sapply(features_names, function(x){gsub("mean","Mean",x)})
  names(features_names) <- NULL
  features_names <- sapply(features_names, function(x){gsub("std","Std",x)})
  names(features_names) <- NULL
  
  #complete step 1
  df <-cbind(y_agg, subject_agg, x_agg)
  
  #step 3
  df$Activity<-gsub("1","walking",df$Activity)
  df$Activity<-gsub("2","walking upstairs",df$Activity)
  df$Activity<-gsub("3","walking downstairs",df$Activity)
  df$Activity<-gsub("4","sitting",df$Activity)
  df$Activity<-gsub("5","standing",df$Activity)
  df$Activity<-gsub("6","laying",df$Activity)
  
  #step 4
  colnames(df)[3:81] <- features_names
  
  #step5
  dt<-data.table(df)
  finaldf<-dt[order(`Subject ID`, Activity), lapply(.SD, mean), by=.(Activity,`Subject ID`)]
  
  write.table(finaldf,"tidydataoutput.txt", row.names=FALSE)
}


