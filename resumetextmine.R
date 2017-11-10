
# Load all Libraries needed -----------------------------------------------
install.packages("quanteda")
install.packages("tidytext")



if("RCurl" %in% rownames(installed.packages()) == FALSE) {install.packages("RCurl")}
library(RCurl)
if("XML" %in% rownames(installed.packages()) == FALSE) {install.packages("XML")}
library(XML)
if("tm" %in% rownames(installed.packages()) == FALSE) {install.packages("tm")}
library(tm)
if("stringi" %in% rownames(installed.packages()) == FALSE) {install.packages("stringi")}
library(stringi)
if("proxy" %in% rownames(installed.packages()) == FALSE) {install.packages("proxy")}
library(proxy)
if("SnowballC" %in% rownames(installed.packages()) == FALSE) {install.packages("SnowballC")}
library(SnowballC)
if("wordcloud" %in% rownames(installed.packages()) == FALSE) {install.packages("wordcloud")}
library(wordcloud)
if("RColorBrewer" %in% rownames(installed.packages()) == FALSE) {install.packages("RColorBrewer")}
library(RColorBrewer)
if("rvest" %in% rownames(installed.packages()) == FALSE) {install.packages("rvest")}
library(rvest)
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr")}
library(stringr)
if("tidyr" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyr")}
library(tidyr)


# Preprocessing -----------------------------------------------------------


setwd("~/R/textmineRemory")
path = getwd()
dir = DirSource(paste(path,"/data/",sep=""), encoding = "UTF-8")
#corpus = Corpus(dir, readerControl=list(reader=readPDF))
corpus = Corpus(dir)
summary(corpus)
docs <- corpus #safety feature, so we don't have to reload in our data
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)

###
docs2 <- tidy(corpus)
library(exploratory)
library(readr)
library(dplyr)
library(stringr)

docs2 <- tidy(corpus)
docs2 %>%
  exploratory::clean_data_frame() %>%
  mutate(name = str_sub(name, 1, 50)) %>%
  do_tokenize(text) %>%
  filter(!is_stopword(token) & is_alphabet(token)) %>%
  select(-document_id) %>%
  mutate(token_stem = stem_word(token)) %>%
  group_by(name, sentence_id) %>%
  do_ngram(token_stem, n=1:2)

# Acknowledgements --------------------------------------------------------
# Used sample code from the following sources:
#   Dr. Erinc Sonmezer
#   http://uc-r.github.io/scraping 
#   https://eight2late.wordpress.com/2015/07/22/a-gentle-introduction-to-cluster-analysis-using-r/
#   