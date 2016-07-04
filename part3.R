library(RWeka)
library(tm)
library(plyr)
library (stringr)
options(mc.cores=1)
options(java.parameters = "-Xmx4g")
UnigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 1, max = 1))}
BigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
TrigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
FourgramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))}

####parte 1
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.news.txt_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

dictMatrix <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
#dictMatrix <- as.data.frame(cbind(TDM_3words$dimnames$Terms,word(TDM_3words$dimnames$Terms,1),word(TDM_3words$dimnames$Terms,2),word(TDM_3words$dimnames$Terms,3),as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
#colnames(dictMatrix) <- c("BI","One","Two","Three","Value")
colnames(dictMatrix) <- c("BI","Value")

####parte 2
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.blogs.txt_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

#dictMatrix2 <- as.data.frame(cbind(TDM_3words$dimnames$Terms,word(TDM_3words$dimnames$Terms,1),word(TDM_3words$dimnames$Terms,2),word(TDM_3words$dimnames$Terms,3),as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
dictMatrix2 <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
#colnames(dictMatrix2) <- c("BI","One","Two","Three","Value")
colnames(dictMatrix2) <- c("BI","Value")

dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
#dictMatrix3$One.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$One.y[is.na(dictMatrix3$Value.x)]
#dictMatrix3$Two.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$Two.y[is.na(dictMatrix3$Value.x)]
#dictMatrix3$Three.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$Three.y[is.na(dictMatrix3$Value.x)]
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)==TRUE]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)==TRUE]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[1:2]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)

####parte 3
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "en_US.twitter.txt_reduced"))
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
mainCorpus <- tm_map(mainCorpus, rmSpecialChars, "/|@|\\|#|€|£|$")
mainCorpus<- tm_map(mainCorpus, stemDocument, language = "english")
mainCorpus<-tm_map(mainCorpus, stripWhitespace)

TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

#dictMatrix <- as.data.frame(cbind(TDM_3words$dimnames$Terms,word(TDM_3words$dimnames$Terms,1),word(TDM_3words$dimnames$Terms,2),word(TDM_3words$dimnames$Terms,3),as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
#colnames(dictMatrix2) <- c("BI","One","Two","Three","Value")
dictMatrix2 <- as.data.frame(cbind(TDM_3words$dimnames$Terms,as.numeric(TDM_3words$v)),stringsAsFactors=FALSE)
colnames(dictMatrix2) <- c("BI","Value")

dictMatrix3 <- merge(dictMatrix,dictMatrix2,by="BI",all = TRUE)
#dictMatrix3$One.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$One.y[is.na(dictMatrix3$Value.x)]
#dictMatrix3$Two.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$Two.y[is.na(dictMatrix3$Value.x)]
#dictMatrix3$Three.x[is.na(dictMatrix3$Value.x)] <- dictMatrix3$Three.y[is.na(dictMatrix3$Value.x)]
dictMatrix3$Value.x[is.na(dictMatrix3$Value.x)==TRUE]<-0
dictMatrix3$Value.y[is.na(dictMatrix3$Value.y)==TRUE]<-0
dictMatrix3$Value.x <-  as.numeric(dictMatrix3$Value.x) + as.numeric(dictMatrix3$Value.y)
dictMatrix <- dictMatrix3[1:2]
colnames(dictMatrix) <- c("BI","Value")
rm(dictMatrix3)
rm(dictMatrix2)

dictMatrix <- dictMatrix[dictMatrix$Value>1,]
rm(dictMatrix)

write.table(dictMatrix3,file="dictionary.txt",quote=F)

