readCorpus <- function() {
    if (!file.exists("data/corpus.csv")) {
        locales <- list.files("data/final")

        corpus <- map_dfr(locales, ~{
            locale <- .x
            files <- list.files(glue("data/final/{locale}"), full.names = TRUE)
            map_dfr(files, ~{
                data.table(
                    locale = locale,
                    file = .x,
                    text = readLines(.x)
                )
            })
        }) %>%
        .[, n_word := nchar(gsub("[^\\s]", "", text, perl = TRUE)) + 1] %>%
        .[]

        fwrite(corpus, "data/corpus.csv")
    } else {
        corpus <- fread("data/corpus.csv")
    }
}