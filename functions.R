library(rtweet)
library(tidyverse)
library(lubridate)
library(writexl)
library(readxl)
library(tidytext)
library(ggplot2)

varNames <- c("created_at",
    "user_id", 
    "status_id",
    "screen_name",
    "text",
    "favorite_count",
    "retweet_count" 
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
scoreTweets <- function(t){
  tokenWords <- unlist(strsplit(t, " "))
  tokenVector <- as.vector(tokenWords)
  scores <- sapply(tokenWords, scoreWord)
  scores <- unlist(scores)
  tweetScore <- sum(scores)
  return (tweetScore)
}
