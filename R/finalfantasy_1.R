#' Final Fantasy I Enemy Stats
#'
#' 
#' @description
#' A dataset of the stats of the enemies in Final Fantasy. Specifically those
#' appearning in the Pixel Remaster edition.
#'
#' @format A data frame with `r nrow(finalfantasy_1)` rows and
#' `r ncol(finalfantasy_1)` variables:
#'
#' ## Basic Information
#' \describe{
#'   \item{name}{Character, name of enemy.}
#'   \item{bestiary}{Integer, location in bestiary.}
#'   \item{exp}{Integer, amount of experiance gained when defeated.}
#'   \item{gil}{Integer, amount of gil gained when defeated.}
#' }
#'
#' ## Stats
#' \describe{
#'   \item{hp}{Integer,maximum HP.}
#'   \item{defense}{Integer, reduces the amount of physical damage received.}
#'   \item{evasion}{Integer, affects the success rate of dodging enemy attacks.}
#'   \item{magic_defense}{Integer, reduces the amount of magical damage 
#'         received.}
#'   \item{attack}{Integer, affects the physical damage caused.}
#'   \item{accuracy}{Integer, affects a character's chance to hit with physical 
#'         attacks.}
#'   \item{hits}{Integer, affects the maximum number of hits player characters 
#'         can land.}
#'   \item{crit}{Integer, determines the frequency with which they land a 
#'         critical hit.}
#' }
#'
#' ## Elemental affinities
#' \describe{
#'   \item{fire}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{ice}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{lightning}{Character, its affinity, can be one of `"Misses"`, 
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{earth}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{spirit}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{poison_element}{Character, its affinity, can be one of `"Misses"`, 
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{time}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{instant_death}{Character, its affinity, can be one of `"Misses"`, 
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{dia}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#' }
#' 
#' ## Status affinities
#' \describe{
#'   \item{silence}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{sleep}{Character, its affinity, can be one of `"Misses"`, `"None"`, 
#'         `"Resists"`, `"Weak"`.}
#'   \item{paralysis}{Character, its affinity, can be one of `"Misses"`, 
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{darkness}{Character, its affinity, can be one of `"Misses"`, 
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{poison_status}{Character, its affinity, can be one of `"Misses"`,
#'         `"None"`, `"Resists"`, `"Weak"`.}
#'   \item{stone}{Character, its affinity, can be one of `"Misses"`, `"None"`,
#'         `"Resists"`, `"Weak"`.}
#'   \item{confuse}{Character, its affinity, can be one of `"Misses"`, `"None"`,
#'         `"Resists"`, `"Weak"`.}
#' }
#' 
#' @seealso [finalfantasy_1_info]
#'
#' @source \url{https://finalfantasy.fandom.com/wiki/Bestiary_(Final_Fantasy)#Pixel_Remaster}
#' @source \url{https://finalfantasy.fandom.com/wiki/Final_Fantasy_stats}
"finalfantasy_1"

#' Final Fantasy I Enemy Additional Information
#'
#' A dataset of additional information of the enemies in Final Fantasy. 
#' Specifically those appearning in the Pixel Remaster edition.
#'
#' @format A data frame with `r nrow(finalfantasy_1_info)` rows and
#' `r ncol(finalfantasy_1_info)` variables:
#'
#' \describe{
#'   \item{name}{Character, name of enemy.}
#'   \item{bestiary}{Integer, location in bestiary.}
#'   \item{type}{Character, enemy type, unknown are lsited as `NA`.}
#'   \item{location}{Character, comma separated list of location names.}
#'   \item{drop}{Character, comma separated list of drops.}
#'   \item{abilities}{Character, comma separated list of abilities.}
#'   \item{url}{Character, url of the enemy.}
#' }
#' 
#' @seealso [finalfantasy_1]
#' 
#' @source \url{https://finalfantasy.fandom.com/wiki/Bestiary_(Final_Fantasy)#Pixel_Remaster}
"finalfantasy_1_info"
