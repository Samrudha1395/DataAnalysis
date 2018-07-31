getwd()

# Import train and test datasets

bmtr<-read.csv("bmtrain.csv")
bmts<-read.csv("bmtest.csv")
View(bmtr)

# Dimensions of the datasets

dim(bmtr)
dim(bmts)

# Checking for missing values

table(is.na(bmtr))
table(is.na(bmts))

# Checking for missing values by coloumns

colSums(is.na(bmtr))
colSums(is.na(bmts))

# Summary of the datasets

summary(bmtr)
summary(bmts)


library(ggplot2)

#Scatterplot

a<-ggplot(bmtr,aes(bmtr$Item_Visibility,bmtr$Item_Outlet_Sales),
       alpha=0.3)+geom_point()
a+labs(x="Item Visibility",y="Item Outlet sales")
View(bmtr)

#Barplot of Outlet Identifier vs Item Outlet Sales
p<-ggplot(bmtr,aes(bmtr$Outlet_Identifier,bmtr$Item_Outlet_Sales))+geom_bar(stat="identity")+theme(axis.text.x = element_text(angle=45))
require(scales)
p + scale_y_continuous(labels = comma)+ scale_x_discrete(labels=abbreviate)+labs(x="Outlet Identifier",y="Item Outlet Sales")

#Barplot of Item Type vs Item Outlet Sales

q<-ggplot(bmtr,aes(bmtr$Item_Type,bmtr$Item_Outlet_Sales))+geom_bar(stat="identity")+theme(axis.text.x = element_text(angle=45,hjust=1))
require(scales)
q + scale_y_continuous(labels = comma)+labs(x="Item Type",y="Item Outlet Sales")

# Box Plot of Item Type vs Item Outlet Sales

r<-qplot(x=Item_Type,y=Item_MRP,data=bmtr,geom="boxplot")+theme_minimal()+
  theme(axis.text.x = element_text(angle=90),
        axis.text.y = element_text(angle=30))
r+labs(x="Item Type",y="Item MRP")

# Data manipulation and consistency

bmts$Item_Outlet_Sales<-1
b<-rbind(bmtr,bmts)
dim(b)

# Impute missing values with median.

b$Item_Weight[is.na(b$Item_Weight)]<-median(b$Item_Weight,na.rm = T)

# Changing Item visibility 0 values.

b$Item_Visibility <- ifelse(b$Item_Visibility == 0,
                                median(b$Item_Visibility), 
                            b$Item_Visibility)



library(plyr)
library(dplyr)

# Renaming levels of Item Fat Content

b$Item_Fat_Content<-revalue(b$Item_Fat_Content,c("LF"="Low Fat","low fat"="Low Fat","reg"="Regular"))

# Creatinng a new column

b$Year<-2013-b$Outlet_Establishment_Year

# Renaming Outlet Size level. 

levels(b$Outlet_Size)[1] <- "Other"
b$Outlet_Size

# Dropping variables which are not required.

b$Item_Identifier<-NULL
b$Outlet_Identifier<-NULL
b$Outlet_Establishment_Year<-NULL

# Dividing the data into train and test datasets

newbmtr = b[1:nrow(bmtr),]
dim(newbmtr)
newbmts=b[(nrow(bmtr)+1):nrow(b),]
dim(newbmts)
#bmstr<-b[1:8523,]
#bmsts<-b[8524:14204,]


lin_mod<-lm(Item_Outlet_Sales~.,data = newbmtr)
y_pred<-predict(lin_mod,newbmts)
View(y_pred)
y_pred
summary(lin_mod)






