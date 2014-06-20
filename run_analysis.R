  # Set your working directory
  # setwd("C:/coursera")
  
  # Package data.table is used
    if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table")}
    require(data.table)
  
  # Download and unzip the data
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    dest <- "data.zip"
    if (!file.exists(dest)) {download.file(fileUrl, dest,method="auto")}
    unzip(dest)
  
  # List the files that needs to be read for the analysis
    files <- c("./UCI HAR Dataset/features.txt","./UCI HAR Dataset/activity_labels.txt", 
               "./UCI HAR Dataset/train/X_train.txt","./UCI HAR Dataset/train/y_train.txt",
               "./UCI HAR Dataset/train/subject_train.txt", 
               "./UCI HAR Dataset/test/X_test.txt","./UCI HAR Dataset/test/y_test.txt",
               "./UCI HAR Dataset/test/subject_test.txt")
    
  # Read the files into a single list containing all  data.tables
    DT <- lapply(files, function(x) {as.data.table(read.table(x))})
  
  # Assign names to the elements of the list
    tmp <-  tolower(gsub("./UCI HAR Dataset/|test/|train/|.txt|", "", files)) 
    names(DT) <- tmp
  
  
  # Set proper names
    setnames(DT$subject_train, "V1","subject.id"); setnames(DT$subject_test, "V1","subject.id")
    setnames(DT$y_train, "V1","activity"); setnames(DT$y_test, "V1","activity")   
    feat.names <- gsub("[(),-]",".", as.character(DT$features$V2))
    feat.names <- gsub("\\.\\.","", feat.names)
    setnames(DT$x_train, old=paste0("V", 1:561), new=feat.names) 
    setnames(DT$x_test, old=paste0("V", 1:561), new=feat.names) 
  
  # Merge the data
    # Training Data
    TR <- cbind(DT$subject_train, DT$x_train, DT$y_train)
    # Test Data
    TT <- cbind(DT$subject_test, DT$x_test, DT$y_test)
    # Coombine Training and Test Data
    dt <- rbind(TR,TT)
  
  # Keep only the columns of interets - subject, activity and all the mean and sd variables   
    keep <- c("subject.id","activity",feat.names[grepl("mean|std",feat.names)])
    dt2 <- dt[,keep, with=F ]
  
  # Get the activity lables
    act <- DT$activity_labels[,list(activity=V1,activity.description=V2)]
    setkey(dt2,activity);setkey(act,activity)
    dt3 <- act[dt2]
    dt3[, activity :=NULL]
  
  # Produce the final tidy data set
   final <- dt3[,lapply (.SD, mean), by=list(subject.id,activity.description)]
  
  # Export the data
    write.table(final, "tidy.dataset.txt", row.names=FALSE)
  
