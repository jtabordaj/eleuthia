# NO LONGER WORKS
# START OF FILE
source('./functions.R')
# auths
api_key <- ""
api_secret_key <- ""
access_token <- ""
access_token_secret <- ""
token <- doToken()

# grab tweet datasets and clean it
main <- rbind(
    grabTweets(2500, "Query"), 
    grabTweets(2500, "Query")
)
main <- main %>% select(any_of(varNames))
main <- main %>% mutate(text = tolower(text))

# load trained word set
afinn <- read_xlsx("./data/afinn.xlsx") %>% as.data.frame() 

# get keywords
keywordsTweets <- main %>%
    unnest_tokens(input = "text", output = "palabra") %>%
    inner_join(afinn, ., by = "palabra")  %>% 
    mutate(type = ifelse(points > 0, "Positiva", "Negativa"))

keywords <- keywordsTweets %>%
    count(palabra, type, sort = TRUE) %>%
    top_n(15) %>% 
    mutate(palabra=reorder(palabra,n))
# score tweets

afinnedTweets <- main 
afinnedTweets <- afinnedTweets %>%  mutate(sentimentScore = apply(afinnedTweets, 1, scoreTweets))

hist(afinnedTweets$sentimentScore)

# may be of interest: https://shiny.rstudio.com/articles/basics.html

# END OF FILE