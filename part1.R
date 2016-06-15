

#source("https://bioconductor.org/biocLite.R")
#biocLite("Rgraphviz")
library(Rgraphviz)
library(RWeka)
library(R.utils)
library(tm)

# create a new reduced corpus
mainCorpus<-Corpus(DirSource("./en_US/",pattern = "reduced"))
# clean the data
mainCorpus<-tm_map(mainCorpus,removePunctuation)
mainCorpus<-tm_map(mainCorpus, stripWhitespace)
mainCorpus<-tm_map(mainCorpus, content_transformer(tolower))
mainCorpus<-tm_map(mainCorpus,removeNumbers)

TDM_stopwords <- TermDocumentMatrix(mainCorpus, control = list(stopwords = FALSE))
limit <- 5000
high_stop <-findFreqTerms(TDM_stopwords, limit, Inf)
m_stop <- as.matrix(TDM_stopwords)
v_stop <- sort(rowSums(m_stop), decreasing=TRUE)
#plot(head(v_stop, 15) ,type = 'h',main = "Most frequent words including Stopwords")
#plot(TDM_stopwords,terms=names(v_stop[1:20]), corThreshold = 0.8, weighting = F)

TDM_nostopwords <- TermDocumentMatrix(mainCorpus, control = list(stopwords = TRUE))
high_nostop <-findFreqTerms(TDM_nostopwords, limit, Inf)
m_nostop <- as.matrix(TDM_nostopwords)
v_nostop <- sort(rowSums(m_nostop), decreasing=TRUE)
#plot(head(v_nostop, 15) ,type = 'h',main = "Most frequent words including Stopwords")
#plot(TDM_nostopwords,terms=names(v_nostop[1:25]), corThreshold = 0.8, weighting = F)


#Can I use bigrams instead of single tokens in a term-document matrix?
#Yes. Package NLP provides functionality to compute n-grams which can be used to construct a corresponding tokenizer. E.g.:
     
#BigramTokenizer <- function(x)unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)
#tdm <- NGramTokenizer(mainCorpus, control = list(tokenize = BigramTokenizer))
BigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
TDM_2words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = BigramTokenizer))

TrigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
TDM_3words <- TermDocumentMatrix(mainCorpus, control = list(tokenize = TrigramTokenizer))

inspect(removeSparseTerms(TDM_2words[, 1:10], 0.7))