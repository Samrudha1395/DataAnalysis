# Import train.csv

df<-read.csv("train.csv",header = T)
View(df)

#Number of passengers according to class

df$Pclass = as.factor(df$Pclass)
summary(df$Pclass)

#Number of passengers according to sex

df$Sex = as.factor(df$Sex)
summary(df$Sex)

# Passenger's age 

summary(df$Age)

# There is a fractional value for age less than one.

# Passenger's stats based on where they embarked.

levels(df$Embarked)[levels(df$Embarked)==""] <- "S"
summary(df$Embarked)

# Number of passengers who survived and didnt 
a<-as.factor(df$Survived)
summary(a)

# First n records 

head(df)

# Summary of the dataset

summary(df)
View(df)

# Slicing the dataset

df = df[,c(2,3,5,6,12)]
View(df)

# Data cleaning
df = na.omit(df)
rownames(df) <- 1:nrow(df)
View(df)

# Group the age variable 
df$Age = ifelse(df$Age<=18,"child",
                ifelse(df$Age>18 & df$Age<=60,"adult","senior"))
df$Age<-as.factor(df$Age)
summary(df$Age)
# Validate the above steps.
head(df)

# Bar Plots

# Age Bar Plot

surv_age<-table(df$Survived,df$Age)
barplot(surv_age,col = c("red","blue"),
        legend = c("Dead","Survived"),
        main="Titanic Age Bar Plot")

# Class Bar Plot

surv_class <- table(df$Survived,df$Pclass)
barplot(surv_class,col = c("red","blue"),
        legend = c("Dead","Survived"),
        main="Titanic Class Bar Plot")


# Gender Bar Plot

surv_gender <- table(df$Survived,df$Sex)
barplot(surv_gender,col = c("red","blue"),
        legend = c("Dead","Survived"),
        main="Titanic Gender Bar Plot")

# Port of embarkation Bar Plot

surv_port <- table(df$Survived,df$Embarked)
barplot(surv_port,col = c("red","blue"),
        legend = c("Dead","Survived"),
        main="Titanic Class Bar Plot")

# Converting categorical into numeric dataframe

df$Pclass = as.integer(df$Pclass)
df$Sex = as.integer(df$Sex)
df$Age = as.integer(df$Age)
df$Embarked = as.integer(df$Embarked)
df$Survived = as.integer(df$Survived)


# Average of survivors from each class and their plots

me_pclass = c(0,0,0)
me_pclass[1] = mean(df$Survived[df$Pclass==1])
me_pclass[2] = mean(df$Survived[df$Pclass==2])
me_pclass[3] = mean(df$Survived[df$Pclass==3])
me_pclass
plot(me_pclass, type="o", main="Main Effect of Passenger Class", xlab="Passenger Class", ylab="Main Effect",
     xaxt="n")
axis(1, at=c(1,2,3), labels=c("1st", "2nd", "3rd"))




me_sex = c(0,0)
me_sex[1] = mean(df$Survived[df$Sex==1])
me_sex[2] = mean(df$Survived[df$Sex==2])
plot(me_sex, type="o", main="Main Effect of Sex", xlab="Sex", ylab="Main Effect", xaxt="n")
axis(1, at=c(1,2), labels=c("Female", "Male"))


me_emb = c(0,0,0)
me_emb[1] = mean(df$Survived[df$Embarked==1])
me_emb[2] = mean(df$Survived[df$Embarked==2])
me_emb[3] = mean(df$Survived[df$Embarked==3])
plot(me_emb, type="o", main="Main Effect of Port of Embarkment", xlab="Port of Embarkment", ylab="Main Effect",
     xaxt="n")
axis(1, at=c(1,2,3), labels=c("Cherbourg", "Queenstown", "Southampton"))

# Validating the plots with ANOVA function

me1 = aov(df$Survived ~ df$Pclass)
anova(me1)

me2 = aov(df$Survived ~ df$Sex)
anova(me2)

me4 = aov(df$Survived ~ df$Embarked)
anova(me4)






