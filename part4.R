
############
####parte 1
############
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.news.txt4_reduced"))
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_4words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = FourgramTokenizer))

dictMatrix <- as.data.frame(cbind(TDM_4words$dimnames$Terms,as.numeric(TDM_4words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("BI","Value")
dictMatrix <- as.data.table(dictMatrix,key=BI)

############
####parte 2
############
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.blogs.txt4_reduced"))
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_4words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = FourgramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_4words$dimnames$Terms,as.numeric(TDM_4words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")
dictMatrix2 <- as.data.table(dictMatrix2,key=BI)
rm(TDM_4words)

##WARNING
#dictMatrix2 <- dictMatrix2[dictMatrix2$Value>1,]

dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[,1:2,with=FALSE]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)
############
####parte 3
############
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.twitter.txt4_reduced"))
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_4words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = FourgramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_4words$dimnames$Terms,as.numeric(TDM_4words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")
dictMatrix2 <- as.data.table(dictMatrix2,key="BI")

rm(TDM_4words)
dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)==TRUE]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)==TRUE]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[,1:2,with=FALSE]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)

##################
###final assembly
##################

dictMatrix <- dictMatrix[dictMatrix$Value>1,]
dictMatrix <- as.data.frame(cbind(word(dictMatrix$BI,1),word(dictMatrix$BI,2),word(dictMatrix$BI,3),word(dictMatrix$BI,4),as.numeric(dictMatrix$Value)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("C1","C2","C3","C4","Value")

write.table(dictMatrix,file="dictionary_4w.txt",quote=F,sep=";")