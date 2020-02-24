user <- read.csv("E:/001/uwm/STAT628/usernew.csv")
viewcount <- (user$review_count-min(user$review_count))/(max(user$review_count)-min(user$review_count))
fan <- (user$fans-min(user$fans))/(max(user$fans)-min(user$fans))
#sendcool
sc <-  (user$cool-min(user$cool))/(max(user$cool)-min(user$cool))
#senduseful
su <-  (user$useful-min(user$useful))/(max(user$useful)-min(user$useful))
#sendfunny
sf <- (user$funny-min(user$funny))/(max(user$funny)-min(user$funny))
#comcool
cc <- (user$funny-min(user$compliment_cool))/(max(user$compliment_cool)-min(user$compliment_cool))
#comfunny
cf <- (user$compliment_funny-min(user$compliment_funny))/(max(user$compliment_funny)-min(user$compliment_funny))
#complain
cp <- (user$compliment_plain-min(user$compliment_plain))/(max(user$compliment_plain)-min(user$compliment_plain))
data <- cbind(viewcount,fan,sc,su,sf,cc,cf,cp)
E <- c()
W <- c()
n <- -log(1/dim(user)[1])
for (i in 1:8){
  a <- c()
  a <- log(data[,i]/sum(data[,i]))
  a[which(a==-Inf)] <- 0
  E[i] <- n*sum(data[,i]/sum(data[,i])*a)
  W[i] <- (1-E[i])/(8-sum(E))
}
data[is.na(data)] <- 0
weight <- c()
for (j in 1:dim(data)[1]){
  weight[j] <- sum(data[j,]*W)
}
length(weight)
user <- cbind(user,weight)
write.csv(user,file="E:/001/uwm/STAT628/userweight.csv")

user <- read.csv("E:/001/uwm/STAT628/userweight.csv")
plot(user$weight)
plot(density(user$weight),xlim=c(0,0.05))
bar(user$weight)
length(which(user$weight<0.01))
library(ggplot2)
ggplot(user, aes(x=weight)) + geom_density() + xlim(0, 0.02) + xlab("User Weight") + ggtitle("- Density Plot of User Weight (from 0 to 0.02)")+ ylab("Density")
