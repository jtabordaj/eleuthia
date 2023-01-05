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

grabTweets <- function(subsetNumber, keyword){
    assign(paste("subset",subsetNumber, sep=""),
    search_tweets(keyword, n=1000, include_rts = FALSE)
)}