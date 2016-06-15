set.seed(5150)
sample <- function(filename, prob){
     original <- file(paste(filename),"r")
     file <- readLines(original)
     # sampling with rbinom()
     set.seed(5150)
     reduced <- file[rbinom(n = length(file), size = 1, prob = prob) == 1]
     close(original)
     conn <- file(paste(filename, "_red", ".txt",sep=""), "w")
     writeLines(reduced, con = conn)
     close(conn)}
percentage <- .04
sample(filename = "./en_US/en_US.blogs.txt",prob = percentage)
sample(filename = "./en_US/en_US.news.txt",prob = percentage)
sample(filename = "./en_US/en_US.twitter.txt",prob = percentage)
#aa <- Corpus(DirSource("./"),readerControl = list(reader = readPlain,language = "la",load = TRUE))
# countLines("./en_US/en_US.blogs.txt")
# countLines("./en_US/en_US.news.txt")
# countLines("./en_US/en_US.twitter.txt")
set.seed(5150)

## sample blogs at text percentage
original <- file("./en_US/en_US.blogs.txt","r")
file_blog <- readLines(original)
blogs_words <- sum(stri_count_words(file_blog))
reduced <- file_blog[rbinom(n = length(file_blog), size = 1, prob = percentage) == 1]
close(original)
conn <- file("./en_US/en_US.blogs_reduced.txt", "w")
writeLines(reduced, con = conn)
close(conn)
## sample news at text percentage
original <- file("./en_US/en_US.news.txt","r")
file_news <- readLines(original)
reduced <- file_news[rbinom(n = length(file_news), size = 1, prob = percentage) == 1]
close(original)
conn <- file("./en_US/en_US.news_reduced.txt", "w")
writeLines(reduced, con = conn)
close(conn)
## sample twitter at text percentage
original <- file("./en_US/en_US.twitter.txt","r")
file_twit <- readLines(original)
reduced <- file_twit[rbinom(n = length(file_twit), size = 1, prob = percentage) == 1]
close(original)
conn <- file("./en_US/en_US.twitter_reduced.txt", "w")
writeLines(reduced, con = conn)
close(conn)
#save memory resources
rm(file_news)
rm(file_blog)
rm(file_twit)
rm(reduced)
