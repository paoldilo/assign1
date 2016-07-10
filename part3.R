
############
####parte 1
############
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.news.txt.ab3_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
#mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

dictMatrix <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix) <- c("BI","Value")
dictMatrix <- as.data.table(dictMatrix,key=BI)

############
####parte 2
############
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.blogs.txt.ab3_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
#mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")
dictMatrix2 <- as.data.table(dictMatrix2,key=BI)

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
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.twitter.txt.ab3_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus <- tm_map(mainCorpus, rmSpecialChars2, "'")
#mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

dictMatrix2 <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
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

##################
###final assembly
##################
write.table(dictMatrix,file="dictionary_3w_full.txt",quote=F,sep=";")
dictMatrix <- dictMatrix[dictMatrix$Value>1,]
#dictMatrix <- as.data.frame(cbind(word(dictMatrix$BI,1),word(dictMatrix$BI,2),word(dictMatrix$BI,3),as.numeric(dictMatrix$Value)),stringsAsFactors=FALSE)
#colnames(dictMatrix) <- c("C2","C3","C4","Value")

write.table(dictMatrix,file="dictionary_3w_1.txt",quote=F,sep=";")
rm(TDM_3words)
gc()