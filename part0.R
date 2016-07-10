set.seed(5150)
sample <- function(filename, prob,num){
     original <- file(paste(filename),"r")
     file <- readLines(original)
     file <- stringi::stri_trans_general(file, "latin-ascii")
     # sampling with rbinom()
     set.seed(5150)
     reduced <- file[rbinom(n = length(file), size = 1, prob = prob) == 1]
     close(original)
     conn <- file(paste(filename, num,"_reduced", ".txt",sep=""), "w")
     writeLines(reduced, con = conn)
     close(conn)}
percentage <- .25
sample(filename = "./en_US/en_US.blogs.txt.ab",prob = percentage,"2")
sample(filename = "./en_US/en_US.news.txt.ab",prob = percentage,"2")
percentage <- .25
sample(filename = "./en_US/en_US.twitter.txt.ab",prob = percentage,"2")
percentage <- .24
sample(filename = "./en_US/en_US.blogs.txt.ab",prob = percentage,"3")
sample(filename = "./en_US/en_US.news.txt.ab",prob = percentage,"3")
percentage <- .25
sample(filename = "./en_US/en_US.twitter.txt.ab",prob = percentage,"3")
percentage <- .18
sample(filename = "./en_US/en_US.blogs.txt.ab",prob = percentage,"4")
sample(filename = "./en_US/en_US.news.txt.ab",prob = percentage,"4")
percentage <- .20
sample(filename = "./en_US/en_US.twitter.txt.ab",prob = percentage,"4")
