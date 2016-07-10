dict1 <- read.table("dictionary_6w_full_1.txt",sep=";",stringsAsFactors = F)
colnames(dict1) <- c("BI","Value")
dict1 <- as.data.table(dict1,key=BI)

dict2 <- read.table("dictionary_6w_full.txt",sep=";",stringsAsFactors = F)
colnames(dict1) <- c("BI","Value")
dict2 <- as.data.table(dict2,key=BI)

dict2 <- merge(dict1,dict2,by="BI",all = TRUE)
dict2$Value.x[is.na(dict2$Value.x)==TRUE]<-0
dict2$Value.y[is.na(dict2$Value.y)==TRUE]<-0
dict2$Value.x <-  as.numeric(dict2$Value.x) + as.numeric(dict2$Value.y)
dict2 <- dict2[,1:2,with=FALSE]                        
colnames(dict2) <- c("BI","Value")

write.table(dict2,file="dictionary_6word.txt",quote=F,sep=";")

#6
dict2<-read.table(file="dictionary_6word.txt",sep=";",colClasses=c("numeric","character","numeric"),stringsAsFactors = FALSE)
dict2<- dict2[dict2$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dict2$BI,1),word(dict2$BI,2),word(dict2$BI,3),word(dict2$BI,4),word(dict2$BI,5),word(dict2$BI,6),as.numeric(dict2$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("W1","W2","W3","W4","W5","W6","Value")
write.table(dictMatrix,file="dictionary_6word_split_nostem.txt",quote=F,sep=";")
rm(dict2)
dictmatrix <-aggregate(Value ~ W1+W2+W3+W4+W5, dictMatrix, max)
dict2 <- merge(dictmatrix,dictMatrix,by=c("W1","W2","W3","W4","W5","Value"),all.x = TRUE)
dict2 <- subset(dict2, select=c(W1,W2,W3,W4,W5,W6,Value))
write.table(dict2,file="dictionary_6word_red_nostem.txt",quote=F,sep=";")
#5
dict2<-read.table(file="dictionary_5word.txt",sep=";",colClasses=c("numeric","character","numeric"),stringsAsFactors = FALSE)
dict2<- dict2[dict2$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dict2$BI,1),word(dict2$BI,2),word(dict2$BI,3),word(dict2$BI,4),word(dict2$BI,5),as.numeric(dict2$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("W1","W2","W3","W4","W5","Value")
write.table(dictMatrix,file="dictionary_5word_split_nostem.txt",quote=F,sep=";")
rm(dict2)
dictmatrix <-aggregate(Value ~ W1+W2+W3+W4, dictMatrix, max)
dict2 <- merge(dictmatrix,dictMatrix,by=c("W1","W2","W3","W4","Value"),all.x = TRUE)
dict2 <- subset(dict2, select=c(W1,W2,W3,W4,W5,Value))
write.table(dict2,file="dictionary_5word_red_nostem.txt",quote=F,sep=";")
#4
dict2<-read.table(file="dictionary_4word.txt",sep=";",colClasses=c("numeric","character","numeric"),stringsAsFactors = FALSE)
dict2<- dict2[dict2$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dict2$BI,1),word(dict2$BI,2),word(dict2$BI,3),word(dict2$BI,4),as.numeric(dict2$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("W1","W2","W3","W4","Value")
write.table(dictMatrix,file="dictionary_4word_split_nostem.txt",quote=F,sep=";")
rm(dict2)
dictmatrix <-aggregate(Value ~ W1+W2+W3, dictMatrix, max)
dict2 <- merge(dictmatrix,dictMatrix,by=c("W1","W2","W3","Value"),all.x = TRUE)
dict2 <- subset(dict2, select=c(W1,W2,W3,W4,Value))
write.table(dict2,file="dictionary_4word_red_nostem.txt",quote=F,sep=";")
#3
dict2<-read.table(file="dictionary_3word.txt",sep=";",colClasses=c("numeric","character","numeric"),stringsAsFactors = FALSE)
dict2<- dict2[dict2$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dict2$BI,1),word(dict2$BI,2),word(dict2$BI,3),as.numeric(dict2$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("W1","W2","W3","Value")
write.table(dictMatrix,file="dictionary_3word_split_nostem.txt",quote=F,sep=";")
rm(dict2)
dictmatrix <-aggregate(Value ~ W1+W2, dictMatrix, max)
dict2 <- merge(dictmatrix,dictMatrix,by=c("W1","W2","Value"),all.x = TRUE)
dict2 <- subset(dict2, select=c(W1,W2,W3,Value))
write.table(dict2,file="dictionary_3word_red_nostem.txt",quote=F,sep=";")
#2
dict2<-read.table(file="dictionary_2word.txt",sep=";",colClasses=c("numeric","character","numeric"),stringsAsFactors = FALSE)
#dict2<- dict2[dict2$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dict2$BI,1),word(dict2$BI,2),as.numeric(dict2$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("W1","W2","Value")
write.table(dictMatrix,file="dictionary_2word_split_nostem.txt",quote=F,sep=";")
rm(dict2)
dictmatrix <-aggregate(Value ~ W1, dictMatrix, max)
dict2 <- merge(dictmatrix,dictMatrix,by=c("W1","Value"),all.x = TRUE)
dict2 <- subset(dict2, select=c(W1,W2,Value))
write.table(dict2,file="dictionary_2word_red_nostem.txt",quote=F,sep=";")