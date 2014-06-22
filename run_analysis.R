#setting up the working directory
setwd("UCI HAR Dataset/")

#reading from test directory
s_test <- read.table("test/subject_test.txt")

x_test <- read.table("test/X_test.txt")

y_test <- read.table("test/y_test.txt")

#reading from features.txt and activity_labels.txt
features <- read.table("features.txt")
labels <- read.table("activity_labels.txt")


#reading from the train directory
s_train <- read.table("train//subject_train.txt")

x_train <- read.table("train//X_train.txt")

y_train <- read.table("train//y_train.txt")

#joing the data from test and train directories
#s_total is the subject_id
#y_total is the activity number
#x_total contains the 561 features
x_total <- rbind(x_test,x_train)
s_total <- rbind(s_test,s_train)
y_total <- rbind(y_test,y_train)

#using the data from features.txt and activity_labels.txt
names(x_total) <- features[,2]
names(s_total) <- c("Subject")

# extracting the column names with only mean and std
mean_colnames <- grep(".*mean.*",names(x_total))
std_colnames <- grep(".*std.*",names(x_total))
req_colnames_index <- c(mean_colnames,std_colnames)
req_colnames <- names(x_total)[req_colnames_index]


#generating the descriptive names for the columns/variables using sub
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

#extracting the activity names 
y_total <- labels[y_total[,1],2]

#subsetting the x_total dataset for only mean and std
x_total <- x_total[,req_colnames_index]
names(x_total) <- req_colnames
names(y_total) <- c("Activity")

#creating the intial dataframe using s_total, y_total and a subset of x_total
data_set <- data.frame(s_total,Activity = y_total,x_total[,req_colnames] )

#using aggregate function to get the tidy data from the initial data_set
tidy_data_set_means <- aggregate(data_set[c(-1,-2)],by = data_set[c("Subject","Activity")],FUN=mean)




