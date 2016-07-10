library(RWeka)
library(tm)
library(plyr)
library (stringr)
library (data.table)
options(mc.cores=1)
options(java.parameters = "-Xmx4g")
UnigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 1, max = 1))}
BigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
TrigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
FourgramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))}
FivegramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 5, max = 5))}
SixgramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 6, max = 6))}
rmSpecialChars <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
rmSpecialChars2 <- content_transformer(function(x, pattern) gsub(pattern, "", x))
