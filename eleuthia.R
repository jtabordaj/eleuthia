## CODENAME: ELEUTHIA ##
# START OF FILE

# auths
api_key <- "SCBRcB3yXBX7DQv5PiQyBBeAW"
api_secret_key <- "lfqh7IULSZrVrjW3OqO6QFdI0d9WtEpogx7HqWhXHOL5zTh7C0"
access_token <- "1359353656559214599-9Vo0fjbRsdLv9MyZNHx29RDMcR8yOl"
access_token_secret <- "H76PEEOwOCy3Qgl8MwKeBoB4VXuRJhBT2nQ1zZrPry1at"
token <- doToken()

# grab tweet datasets and clean it
main <- rbind(grabTweets(5000, "Petro"), grabTweets(5000, "ELN")) %>%
    select(all_of(varNames))

# load trained word set
afinn <- read_xlsx("./data/afinn.xlsx") %>% as.data.frame() 

# get keywords
keywordsTweets <- main %>%
    unnest_tokens(input = "full_text", output = "palabra") %>%
    inner_join(afinn, ., by = "palabra")  %>% 
    mutate(type = ifelse(points > 0, "Positiva", "Negativa"))

keywords <- keywordsTweets %>%
    count(palabra, type, sort = TRUE) %>%
    top_n(15) %>% 
    mutate(palabra=reorder(palabra,n))
# score tweets

afinnedTweets <- main 
afinnedTweets <- afinnedTweets %>%  mutate(sentimentScore = apply(afinnedTweets, 1, scoreTweets))

# may be of interest: https://shiny.rstudio.com/articles/html-ui.html

# END OF FILE
## CODENAME: ELEUTHIA ##