setwd("C:/Users/apoorva/Desktop/Analytics/test-repo//UCI HAR Dataset/")

s_test <- read.table("test/subject_test.txt")
#head(s_test)

x_test <- read.table("test/X_test.txt")
#head(x_test)

y_test <- read.table("test/y_test.txt")


features <- read.table("features.txt")
#head(features)
labels <- read.table("activity_labels.txt")



s_train <- read.table("train//subject_train.txt")
#head(s_train)

x_train <- read.table("train//X_train.txt")
#head(x_train)

y_train <- read.table("train//y_train.txt")

x_total <- rbind(x_test,x_train)
s_total <- rbind(s_test,s_train)
y_total <- rbind(y_test,y_train)

names(x_total) <- features[,2]
names(s_total) <- c("Subject")

#activity.factor <- ordered(y_total,levels = as.character(labels[,2]))

mean_colnames <- grep(".*mean.*",names(x_total))
std_colnames <- grep(".*std.*",names(x_total))
req_colnames_index <- c(mean_colnames,std_colnames)
req_colnames <- names(x_total)[req_colnames_index]

for( i in 1:length(req_colnames)) {
        req_colnames[i] <- sub("t","Time_",req_colnames[i] )
        req_colnames[i] <- sub("f","Frequency_",req_colnames[i] )
        req_colnames[i] <- sub("Body","Body_",req_colnames[i])
        req_colnames[i] <- sub("Acc","Acceleration_",req_colnames[i])
        req_colnames[i] <- sub("Gyro","Gyroscope_",req_colnames[i])
        req_colnames[i] <- sub("-sTime_d()","Std",req_colnames[i])
        req_colnames[i] <- sub("Mag","Magnitude_",req_colnames[i])
        req_colnames[i] <- sub("-std()","Std_",req_colnames[i])
        req_colnames[i] <- sub("\\(\\)","",req_colnames[i])
        req_colnames[i] <- sub("-X","_Xaxis",req_colnames[i])
        req_colnames[i] <- sub("-Y","_Yaxis",req_colnames[i])
        req_colnames[i] <- sub("-Z","_Zaxis",req_colnames[i])
        req_colnames[i] <- sub("-mean","mean",req_colnames[i])
        req_colnames[i] <- sub("Jerk","Jerk_",req_colnames[i])
        req_colnames[i] <- sub("Time","Avg_Time",req_colnames[i])
        req_colnames[i] <- sub("Frequency","Avg_Frequency",req_colnames[i])
      
        
}

y_total <- labels[y_total[,1],2]
x_total <- x_total[,req_colnames_index]
names(x_total) <- req_colnames
names(y_total) <- c("Activity")

data_set <- data.frame(s_total,Activity = y_total,x_total[,req_colnames] )

tidy_data_set_means <- aggregate(data_set[c(-1,-2)],by = data_set[c("Subject","Activity")],FUN=mean)




