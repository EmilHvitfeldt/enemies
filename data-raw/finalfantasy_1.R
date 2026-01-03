library(tidyverse)
library(rvest)

source("data-raw/ff_fandom.R")

folder <- "data-raw/finalfantasy_1"

base <- "https://finalfantasy.fandom.com"

## Download Sources ------------------------------------------------------------

if (FALSE) {
  all_links <- base |>
    paste0("/wiki/Bestiary_(Final_Fantasy)") |>
    read_html() |>
    html_element("div.multicolumn") |>
    html_elements("a") |>
    html_attr("href") |>
    unique()

  names <- basename(all_links)
  all_links <- paste0(base, all_links)

  fs::dir_create(folder)

  walk2(all_links, names, ff_fandom_source, folder = folder, .progress = TRUE)
}

## Parse Sources ---------------------------------------------------------------

all_files <- fs::dir_ls(folder)

get_all_info <- function(file) {
  info <- get_enemy(file)["name"]
  stats <- get_enemy_stats(file)

  stats <- stats[names(stats) != "name"]
  res <- vctrs::vec_cbind(info, stats)
  res$url <- basename(file)
  res
}

all_stats <- map(all_files, get_all_info) |>
  purrr::list_rbind() |>
  select(
    -prev,
    -starts_with("next"),
    -starts_with("psp"),
    -starts_with("ps"),
    -starts_with("pr"),
    -starts_with("="),
    -starts_with("nes"),
    -starts_with("1"),
    -starts_with("2"),
    -starts_with("prev"),
    -hit,
    -resistance
  ) |>
  mutate(
    bestiary = as.integer(bestiary),
    url = paste0(base, "/wiki/", url)
  ) |>
  janitor::clean_names() |>
  arrange(bestiary)

clean_numerics <- function(x) {
  x |>
    str_remove_all(",") |>
    str_remove("_$") |>
    str_split(" *- *") |>
    map_int(\(x) {
      if (length(x) == 1) {
        as.integer(x)
      } else {
        floor(mean(as.integer(x)))
      }
    })
}

clean_affinities <- function(x) {
  x <- str_remove(x, "\\_")
  case_when(
    is.na(x) ~ "None",
    x == "" ~ "None",
    x == "-" ~ "None",
    x == "Resist" ~ "Resists",
    str_detect(x, "note\\|reference") ~ "Resists",
    .default = x
  )
}

finalfantasy_1 <- all_stats |>
  mutate(time = NA) |>
  select(
    name,
    bestiary,
    exp,
    gil,

    hp,
    defense,
    evasion,
    magic_defense,
    attack,
    accuracy,
    hits,
    crit,

    fire,
    ice,
    lightning,
    earth,
    spirit,
    poison_element,
    time,
    instant_death,
    dia,

    silence,
    sleep,
    paralysis,
    darkness,
    poison_status,
    stone,
    confuse
  ) |>
  mutate(
    across(
      exp:crit,
      clean_numerics
    ),
    across(
      fire:confuse,
      clean_affinities
    ),
    hits = if_else(is.na(hits), 1L, hits),
    crit = if_else(is.na(crit), 0L, crit)
  )

finalfantasy_1_info <- all_stats |>
  select(
    name,
    bestiary,
    type,
    location,
    drop,
    abilities,
    url
  ) |>
  mutate(
    type = str_remove_all(type, "<small>.*?</small>"),
    type = str_trim(type),
    type = str_replace_all(type, " *<br>", ", "),
    location = str_remove_all(location, "<small>.*?</small>"),
    location = str_remove_all(location, "</small>"),
    location = str_replace_all(location, "<br>", ", "),
    location = str_replace_all(location, "#", ", "),
    location = str_replace_all(location, ", and ", ", "),
    location = str_remove_all(location, "\\(?Final Fantasy\\)?"),
    location = str_remove_all(location, "[\\[\\]|]"),
    drop = str_remove(drop, " \\(?Final Fantasy.*"),
    drop = str_remove(drop, "\\[\\["),
    drop = str_remove(drop, "\\].*"),
    drop = if_else(
      drop == "Final Fantasy items#Golden Apple|Golden Apple",
      "Golden Apple",
      drop
    ),
    drop = if_else(drop == "N/A", NA, drop),
    abilities = str_remove_all(abilities, "\\[\\[.*\\|"),
    abilities = str_remove_all(abilities, "\\]\\]"),
    abilities = str_remove_all(abilities, "\\[\\["),
    abilities = str_remove_all(abilities, "[_\\.]$"),
    abilities = str_replace_all(abilities, ", *", ", "),
    abilities = str_replace_all(abilities, "May", "may"),
    abilities = if_else(abilities == "", NA, abilities),
    abilities = if_else(abilities == "N/A", NA, abilities),
  )

usethis::use_data(finalfantasy_1, overwrite = TRUE)
usethis::use_data(finalfantasy_1_info, overwrite = TRUE)
