
####parte 1
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.news.txt2_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_2words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = BigramTokenizer))

dictMatrix <- as.data.frame(cbind(TDM_2words$dimnames$Terms,as.numeric(TDM_2words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("BI","Value")
dictMatrix <- as.data.table(dictMatrix,key=BI)

####parte 2
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.blogs.txt2_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_2words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = BigramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_2words$dimnames$Terms,as.numeric(TDM_2words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")
dictMatrix2 <- as.data.table(dictMatrix2,key=BI)

dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)==TRUE]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)==TRUE]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[,1:2,with=FALSE]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)

####parte 3
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.twitter.txt2_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_2words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = BigramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_2words$dimnames$Terms,as.numeric(TDM_2words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")
dictMatrix2 <- as.data.table(dictMatrix2,key=BI)

dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)==TRUE]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)==TRUE]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[,1:2,with=FALSE]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)

#dictMatrix2 <- dictMatrix[dictMatrix$Value>1,]


write.table(dictMatrix,file="dictionary_2w.txt",quote=F,sep=";")
rm(dictMatrix)
