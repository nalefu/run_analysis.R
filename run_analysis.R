library(reshape2)
subject_text <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

feature <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

subjects <- rbind(subject_text, subject_train)
colnames(subjects) <- "subjects"
labels <- rbind(y_test, y_train)
labels <- merge(labels, activity_labels, by=1)[,2]

dat <- rbind(x_test, x_train)
colnames(dat) <- feature[, 2]

dat <- cbind(subjects, labels, dat)

std_prep <- grep("-mean|-std", colnames(dat))
std_mean_dat <- dat[,c(1,2,std_prep)]
melts  = melt(std_mean_dat, id.var = c("subjects", "labels"))
averages = dcast(melts, subjects + labels ~ variable, mean)
write.table(averages, file="./data/tidy_data.txt", row.name=FALSE)

averages