
library(data.table)
library(shiny)
library(datasets)
load_dict <- function(){
     #dict <- fread("curl http://prosociality.esy.es/dictionary.zip | funzip")
     temp <- tempfile()
     download.file("http://prosociality.esy.es/dictionary.zip",temp)
     dict <- read.table(unz(temp, "dictionary.txt"),sep=";", stringsAsFactors = FALSE, colClasses = c("numeric","character","character","character","character","character","character","numeric"))
     unlink(temp)
}
dict <- load_dict()
predict_word <- function (x,dict){
     
     library(stringr)   
     #     dict <- load_dict()
     
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
}
# Define server logic required to summarize and view the selected
# dataset

shinyServer(
     function(input, output,session) {
          next_word=""
          eventReactive(input$do, {
               sentence <- input$text
               next_word_subset <-predict_word(sentence,dict)
               next_word <- next_word_subset[1,6]
               output$value<- next_word
               output$caption <- renderText({
                    input$caption
               })
               output$view <- renderTable({
                    head(next_word_subset[order(next_word_subset$Value),])
               })
          })
})


