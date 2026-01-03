ff_fandom_source <- function(url, name, folder) {
  url <- paste0(url, "?veaction=editsource")
  rate <- rate_delay(10)

  call <- insistently(
    \(x) {
      res <- read_html_live(url) |>
        html_elements("div.ext-codemirror-wrapper") |>
        html_elements("div p") |>
        html_text() |>
        paste(collapse = "\n")

      if (identical(res, "")) {
        stop("empty")
      }
      res
    },
    quiet = FALSE,
    rate = rate
  )

  cat(name, "\n")

  writeLines(call(), fs::path(folder, name))
}

get_enemy_stats <- function(file) {
  readLines(file) |>
    paste0(collapse = "_") |>
    str_extract("\\{\\{infobox enemy stats.*?\\}\\}") |>
    parse_block()
}

get_enemy <- function(file) {
  readLines(file) |>
    paste0(collapse = "_") |>
    str_extract("\\{\\{infobox enemy_.*?\\}\\}") |>
    parse_block()
}


parse_block <- function(x) {
  res <- x |>
    str_remove("^\\{\\{") |>
    str_remove("\\}\\}$") |>
    str_split_1(" *_\\| *")

  res <- res[-1]

  if (all(str_detect(res, "^[0-9]"))) {
    group <- str_extract(res, "[0-9]* *")
    res <- str_remove(res, "[0-9]* *")
    res <- lapply(split(res, group), parse_fields)
    res <- vctrs::vec_rbind(!!!res)
  } else {
    res <- parse_fields(res)
  }
  res
}

parse_fields <- function(x) {
  x |>
    str_subset("^=", negate = TRUE) |>
    str_split(" *= *") |>
    lapply(\(x) setNames(list(x[2]), x[1])) |>
    unlist(recursive = FALSE) |>
    new_tibble()
}