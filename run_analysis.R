# ====================
# run_analysis
# --------------------
# The run_analysis function loads source files from the UCI HAR data set. It
# process the data in said files and returns a tidy data set of averages for
# the mean and standard deviation measures present in the source data set.
#
# NOTE: it is assumes all source data files are in the same directory as this script.
# ====================
run_analysis <- function () {

    # utility function loads a dictionary of activity names and cleans the values to be usable in R
    loadFeatureNames <- function(namesFile) {
        # read textual dictionary file
        features <- read.table(namesFile,stringsAsFactors=F)
        # create a vector of string replacement functions
        replacements <- c(function(v) { gsub("\\(\\)",""     ,v) }  # '()' are illegal in R variable names
                         ,function(v) { gsub("-"     ,"_"    ,v) }  # '-' are illegal in R variable names
                         ,function(v) { gsub("^f"    ,"freq_",v) }  # frequency variables begin with 'f'
                         ,function(v) { gsub("^t"    ,"time_",v) }) # timimg variables begin with 't'
        # map each dictionary value
        lapply(features[,2]
               ,function(name){
                   # apply each "cleaning" function, in turn, to the current measurement name
                   cleaned <- Reduce(function(nm,swap){ swap(nm) }, replacements, name)
                   # convert the final result to lower case
                   tolower(cleaned)
               }
        )
    }

    # utility function to take 3 seperate files and merge them into one data frame
    # NOTE: the records are one line per file, and the line number is the implicit 'data key'
    assembleData <- function (subjectFile,xDataFile,yDataFile,activityMap,featureNames) {
        # read in all the raw data files
        subjs <- read.table(subjectFile)  # subject identifers
        ydata <- read.table(yDataFile)    # activity identifiers
        xdata <- read.table(xDataFile)    # actual measurement data
        frame <- data.frame(subjs,ydata,xdata)
        # replace column names with human-readable values
        colnames(frame) <- c("subject","activity",featureNames)
        # replace activity values with textual equivalents
        frame$activity <- lapply(frame$activity,function(x){ activityMap[x,2] })
        # reduce data set to be only those column about which we are interested
        mean_std_names <- grep("_(mean(?!f)|std)",featureNames,perl=T,value=T)
        frame[,c("subject","activity",mean_std_names)]
    }

    # read textual dictionary mapping activity identifier to textal name
    activities <- read.table("activity_labels.txt",stringsAsFactors=F)
    # load (processed) list of measurement labels
    features <- loadFeatureNames("features.txt")
    # merge data files for "training" subset of all records
    training <- assembleData("subject_train.txt"
                            ,"x_train.txt"
                            ,"y_train.txt"
                            ,activities
                            ,features)
    # merge data files for "testing" subset of all records
    testing <- assembleData("subject_test.txt"
                           ,"x_test.txt"
                           ,"y_test.txt"
                           ,activities
                           ,features)
    # combine "training" and "testing" data into a single dataframe
    combined <- rbind(training,testing)
    combined <- combined[order(combined$subject),]

    # calculate averages for selected measures (as a spererate dataset)
    colCount <- length(colnames(combined))
    averages <- data.frame()

    # NOTE: averages are calculated for each measure for each activity for each subject
    for (subject in unique(combined$subject)) {
        for (activity in activities[,2]) {
            # measured (filtered by activity and subject)
            segment  <- combined[ combined$subject  == subject
                                & combined$activity == activity,]
            # NOTE: colMeans gets the averages, but the data must be transposed to match the shape of the output data frame
            measures <- t(colMeans(segment[3:colCount]))
            # update outout data frame with latest row of data
            averages <- rbind(averages,cbind(subject,activity,measures))
        }
    }
    # return averaged data
    averages
}
