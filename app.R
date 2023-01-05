## CODENAME: ELEUTHIA ##

api_key <- "SCBRcB3yXBX7DQv5PiQyBBeAW"
api_secret_key <- "lfqh7IULSZrVrjW3OqO6QFdI0d9WtEpogx7HqWhXHOL5zTh7C0"
access_token <- "1359353656559214599-9Vo0fjbRsdLv9MyZNHx29RDMcR8yOl"
access_token_secret <- "H76PEEOwOCy3Qgl8MwKeBoB4VXuRJhBT2nQ1zZrPry1at"

token <- doToken()
main <- rbind(grabTweets(1, "Petro"), grabTweets(2, "ELN"))
afinn <- read_xlsx("./data/afinn.xlsx") %>% as.data.frame() 

tweetsForUse <- 
  main %>%
  select(all_of(varNames)
) 
affinnedTweets <- tweetsForUse %>%
  unnest_tokens(input = "full_text", output = "palabra") %>%
  inner_join(afinn, ., by = "palabra")  %>% 
  mutate(type = ifelse(points > 0, "Positiva", "Negativa")
)

## Needs refitting:

# palabras <- tweets_afinn %>%
#   count(Palabra, Tipo, sort = TRUE) %>%
#   top_n(15) %>%
#   mutate(Palabra=reorder(Palabra,n)
# )

# plot1 <- palabras %>% 
#   ggplot(aes(x=Palabra, y=n)) + 
#   geom_col() +
#   xlab(NULL) +
#   coord_flip() +
#   theme_classic() +
#   labs(x = "Conteo",
#        y = "Palabras",
#        title= "Palabras mas usada en B/quilla")
# plot1

# datoswrite <- datos[,1:7]
# write_csv(datoswrite, "C:/Users/Juan Jose/Documents/JJ/UN/5to Semestre/Side Projects/Caribe en Datos/CED/writedata.csv")
# write_csv(palabras, "C:/Users/Juan Jose/Documents/JJ/UN/5to Semestre/Side Projects/Caribe en Datos/CED/write.csv")
