source("global.R")

corpus <- readCorpus()


### QUIZ 1 —————————————————————————————————————————————————————————————————————
en_US <- corpus[locale == "en_US"]

en_US[max(nchar(text))]
en_US[order(-nchar(text))]
en_US[grepl("twitter", file) & grepl("love", text), .N] / en_US[grepl("twitter", file) & grepl("hate", text), .N]
en_US[grepl("twitter", file) & grepl("biostats", text), text]

en_US[grepl("twitter", file) & grepl("A computer once beat me at chess, but it was no match for me at kickboxing", text), .N]
