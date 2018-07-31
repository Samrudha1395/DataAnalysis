#Import the Iris dataset

iris_data<-read.csv("iris.csv",stringsAsFactors = FALSE)
View(iris_data)

#Exploratory Analysis

#Print first 3 records 

head(iris_data,3)


#Finding the dimensions
dim(iris_data)

# The dimensions are 150 rows and 5 coloumns

#Names,Class & Feature of the dataset
print(names(iris_data))


# The names are:- sepal_length,sepal_width,petal_length,
# petal_width & species.

 class(iris_data)


class(iris_data$sepal_length)


class(iris_data$petal_length)


class(iris_data$sepal_width)


class(iris_data$petal_width)


class(iris_data$species)

# The class of the dataset is a dataframe, the classess 
# of the first 4 features are numeric, and the class of species
# is a character.

# Missing values

is.na(iris_data)

#There are no missing values

#Structure of the data

str(iris_data)

# Summary of the data

summary(iris_data)

# Sepal length: Min - 4.3, Max - 7.9, Mean - 5.843, Median - 5.8
# 1st Quantile - 5.1, 3rd Quantile - 6.4

#Sepal width: Min - 2, Max - 4.4, Mean - 3.054, Median - 3,
# 1st Quantile - 2.8, 3rd Quantile - 3.3

#Petal length: Min - 1, Max - 6.9, Mean - 3.759, Median - 4.35,
# 1st Quantile - 1.6, 3rd Quantile - 1.8

#Petal width: Min - 0.1, Max - 2.5, Mean - 1.199, Median - 1.3,
# 1st Quantile - 0.3, 3rd Quantile - 1.8

# Boxplot 
iris_setosa<-subset(iris_data,species=="setosa")
boxplot(iris_setosa[1:4], xlab = "Features",
        ylab = "Scale", main = "Boxplot of features of Iris Setosa")

summary(iris_setosa)
iris_virginica<-subset(iris_data,species=="virginica")
boxplot(iris_virginica[1:4], xlab = "Features",
        ylab = "Scale", main = "Boxplot of features of Iris Virginica")

iris_versicolor<-subset(iris_data,species="versicolor")
boxplot(iris_versicolor[1:4],xlab="Features",ylab="Scale",
        main="Boxplot of features of Iris Versicolor")

#Pie chart
specs<-iris_data$species
specs.df<-data.frame(table(specs))
cols<-c('red','blue','green')
Cnvrt2Percent<-round(100*specs.df$Freq/sum(specs.df$Freq),1)
pielabel=paste(Cnvrt2Percent,"%",sep = "")
pie(specs.df$Freq,labels = pielabel,col = cols,main = "Distribution")
legend("topright",c("Setosa","Versica","Virginica"),fill = cols,cex = 0.8)

# There are 3 equally distributed species in the Iris Dataset

# Subset tuples based on species

iSetosa<-subset(iris_data,species=="setosa")

iVersicolor<-subset(iris_data,species=="versicolor")

iVirginica<-subset(iris_data,species=="virginica")


#Boxplots of individual features
boxplot(iris_data$sepal_length)
boxplot(iris_data$sepal_width)
boxplot(iris_data$petal_length)
boxplot(iris_data$petal_width)

#Histogram of petal lengths

hist(iris_data$petal_length)
hist(iSetosa$petal_length)
hist(iVersicolor$petal_length)
hist(iVirginica$petal_length)

#Correlation and scatterplot
corr_iris<-cor(iris_data[1:4])
print(corr_iris)
pairs(iris[1:4], main = "Iris Scatterplots", pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

#Decision tree
library(party)
i_tree<-read.csv("iris.csv")
iris_tree <- ctree( 
  species ~ sepal_length + sepal_width + petal_length+petal_width,  
  data = i_tree)
plot(iris_tree)
View(iris_data)

