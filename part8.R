coeff_2 <- 0.5
coeff_3 <- .75
coeff_4 <- 1
coeff_5 <- 0.7
#start from 6 and 5
# dict<-read.table(file="dictionary_6word_split_nostem.txt",sep=";",colClasses=c("numeric","character","character","character","character","character","character","numeric"),stringsAsFactors = FALSE)
# colnames(dict) <- c("W1","W2","W3","W4","W5","W6","Value")
# aa <- rowSums(cbind(dict$Value))
# aa <- as.data.frame(SimpleGT(table(aa)))
# dict <- merge(dict[,c("W1","W2","W3","W4","W5","W6","Value")],aa[,c("r","p")],by.x = "Value",by.y = "r",all=TRUE)
# dict <- subset(dict, select=c(W1,W2,W3,W4,W5,W6,p))
# colnames(dict) <- c("W1","W2","W3","W4","W5","W6","Value")
# 
# dict2<-read.table(file="dictionary_5word_split_nostem.txt",sep=";",colClasses=c("numeric","character","character","character","character","character","numeric"),stringsAsFactors = FALSE)
# colnames(dict2) <- c("W2","W3","W4","W5","W6","Value")
# aa <- rowSums(cbind(dict2$Value))
# aa <- as.data.frame(SimpleGT(table(aa)))
# dict2 <- merge(dict2[,c("W2","W3","W4","W5","W6","Value")],aa[,c("r","p")],by.x = "Value",by.y = "r",all=TRUE)
# dict2 <- subset(dict2, select=c(W2,W3,W4,W5,W6,p))
# colnames(dict2) <- c("W2","W3","W4","W5","W6","Value")
# 
# dictsum <- merge(dict,dict2,by=c("W2","W3","W4","W5","W6"),all = TRUE)
# dictsum$Value.x[is.na(dictsum$Value.x)]<-0
# dictsum$Value.y[is.na(dictsum$Value.y)]<-0
# dictsum$Value.x <-  as.numeric(dictsum$Value.x) + as.numeric(dictsum$Value.y)*coeff_5
# colnames(dictsum) <- c("W2","W3","W4","W5","W6","W1","Value")
# dictsum <- subset(dictsum, select=c(W1,W2,W3,W4,W5,W6,Value))
# rm(dict)
#add 4
dict<-read.table(file="dictionary_4word_red_nostem.txt",sep=";",colClasses=c("numeric","character","character","character","character","numeric"),stringsAsFactors = FALSE)
colnames(dict) <- c("W1","W2","W3","W4","Value")
aa <- rowSums(cbind(dict$Value))
aa <- as.data.frame(SimpleGT(table(aa)))
dict<- merge(dict[,c("W1","W2","W3","W4","Value")],aa[,c("r","p")],by.x = "Value",by.y = "r",all=TRUE)
dict<- subset(dict, select=c(W1,W2,W3,W4,p))
colnames(dict) <- c("W1","W2","W3","W4","Value")

# dictsum <- merge(dictsum,dict2,by=c("W1","W1","W5","W6"),all = TRUE)
# dictsum$Value.x[is.na(dictsum$Value.x)]<-0
# dictsum$Value.y[is.na(dictsum$Value.y)]<-0
# dictsum$Value.x <-  as.numeric(dictsum$Value.x) + as.numeric(dictsum$Value.y)*coeff_4
# colnames(dictsum) <- c("W3","W4","W5","W6","W1","W2","Value")
# dictsum <- subset(dictsum, select=c(W1,W2,W3,W4,W5,W6,Value))

#add 3
dict2<-read.table(file="dictionary_3word_red_nostem.txt",sep=";",colClasses=c("numeric","character","character","character","numeric"),stringsAsFactors = FALSE)
colnames(dict2) <- c("W2","W3","W4","Value")
aa <- rowSums(cbind(dict2$Value))
aa <- as.data.frame(SimpleGT(table(aa)))
dict2 <- merge(dict2[,c("W2","W3","W4","Value")],aa[,c("r","p")],by.x = "Value",by.y = "r",all=TRUE)
dict2 <- subset(dict2, select=c(W2,W3,W4,p))
colnames(dict2) <- c("W2","W3","W4","Value")

dictsum <- merge(dict,dict2,by=c("W2","W3","W4"),all = TRUE)
dictsum$Value.x[is.na(dictsum$Value.x)]<-0
dictsum$Value.y[is.na(dictsum$Value.y)]<-0
dictsum$Value.x <-  as.numeric(dictsum$Value.x) + as.numeric(dictsum$Value.y)*coeff_3
colnames(dictsum) <- c("W2","W3","W4","W1","Value")
dictsum <- subset(dictsum, select=c(W1,W2,W3,W4,Value))
#add 2
dict2<-read.table(file="dictionary_2word_split_nostem_new.txt",sep=";",colClasses=c("numeric","character","character","numeric"),stringsAsFactors = FALSE)
colnames(dict2) <- c("W3","W4","Value")
aa <- rowSums(cbind(dict2$Value))
aa <- as.data.frame(SimpleGT(table(aa)))
dict2 <- merge(dict2[,c("W3","W4","Value")],aa[,c("r","p")],by.x = "Value",by.y = "r",all=TRUE)
dict2 <- subset(dict2, select=c(W3,W4,p))
colnames(dict2) <- c("W3","W4","Value")

dictsum <- merge(dictsum,dict2,by=c("W3","W4"),all = TRUE)
dictsum$Value.x[is.na(dictsum$Value.x)]<-0
dictsum$Value.y[is.na(dictsum$Value.y)]<-0
dictsum$Value.x <-  as.numeric(dictsum$Value.x) + as.numeric(dictsum$Value.y)*coeff_2
colnames(dictsum) <- c("W3","W4","W1","W2","Value")
dictsum <- subset(dictsum, select=c(W1,W2,W3,W4,Value))
##write file
dictsum$Value <- dictsum$Value*100
dictsum <- dictsum[order(dictsum$W3),]
dictsum[is.na(dictsum)]<- ""
write.table(dictsum,file="dictionary_FINAL_4full.txt",quote=F,sep=";")
