load_dict <- function(){
     dict <- read.table("dictionary_FINAL_6_new_red.txt",sep=";", stringsAsFactors = FALSE, colClasses = c("numeric","character","character","character","character","character","character","numeric"))
     #dict[is.na(dict)]<- ""
}

predict_word <- function (x){
     
     library(stringr)   
     dict <- load_dict()
     
     ##transform the string
     stringa <- tolower(x)
     stringa <- gsub("/|@|\\|#|€|£|$", " ", stringa)
     stringa <- gsub("'", "", stringa)
     stringa <- gsub('[0-9]+', '', stringa)
     stringa <- gsub('[[:punct:]]', '', stringa)
     stringa <- gsub("\\s+", " ", str_trim(stringa))
     parole <- str_split(stringa,pattern = " ")[[1]]
     len <- length(parole)
     ##if words >1 take last word
     if (len >1) {
          last_W <- parole[len]
          subset_dict <- dict[dict$W5==last_W,]
          found <- dim(subset_dict)[1]>0
     }
     if (len>2 & found) {
          last_2W <- parole[len-1]
          if (found <-dim(subset_dict[subset_dict$W4==last_2W,])[1]>0) {
          subset_dict <- subset_dict[subset_dict$W4==last_2W,]}
     }
     if (len>3 & found) {
          last_3W <- parole[len-2]
          if (found <-dim(subset_dict[subset_dict$W3==last_3W,])[1]>0) {
          subset_dict <- subset_dict[subset_dict$W3==last_3W,]}
     }    
     if (len>4 & found) {
          last_4W <- parole[len-3]
          if (found <- dim(subset_dict[subset_dict$W2==last_4W,])[1]>0) {
          subset_dict <- subset_dict[subset_dict$W2==last_4W,]}
     }    
     if (len>5 & found) {
          last_5W <- parole[len-4]
          if (found <- dim(subset_dict[subset_dict$W1==last_5W,])[1]>0) {
          subset_dict <- subset_dict[subset_dict$W1==last_5W,]}
     }    
     ## take the highest value in probability
     next_word_subset <- subset_dict[subset_dict$Value==max(subset_dict$Value),]
     next_word <- next_word_subset[1,6]
}