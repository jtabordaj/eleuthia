library(rtweet)
library(tidyverse)
library(lubridate)
library(writexl)
library(readxl)
library(tidytext)
library(ggplot2)

varNames <- c("created_at",
    "id", 
    "full_text", 
    "text",
    "retweet_count", 
    "favorite_count"
)

doToken <- function(){
    create_token(
  app = "APP",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)
}

grabTweets <- function(sampleSize, keyword){
    assign(paste("subset",keyword, sep=""),
    search_tweets(keyword, n=sampleSize, include_rts = FALSE)
)}

scoreWord <- function(w){
    wordOfInterest <- afinn$palabra==w
    score <- afinn$points[wordOfInterest]
    return (score)
}
scoreTweets <- function(text){
  words <- unlist(strsplit(text, " "))
  words <- as.vector(words)
  scores <- sapply(words, Score_word)
  scores <- unlist(scores)
  Score_tweet <- sum(scores)
  return (Score_tweet)
}
