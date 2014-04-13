m = angular.module("cs_CZ", ["pascalprecht.translate"])
m.config ["$translateProvider",($translateProvider) ->
  $translateProvider.translations "cz",
  MENU: "menu"
  FLASH_UNKNOWN_ERROR: "Neznámá chyba"
  FLASH_REQUEST_FOR_PROJECT:"Stahuji knihu,…"
  FLASH_REQUEST_UPDATE_PROJECT: "Probíhá ukládání,…"
  FLASH_REQUEST_RENDER_PROJECT: "Probíhá render,…"
  MENU_BOOKS: "Knihy"
  MENU_ADMINISTRATION: "Administrace"
  MENU_CREATE: "Tvorba knih"
  MENU_FINANCE: "Finance"
  MENU_STORAGE: "Sklady"
  GENRE: "žánr"
  GENRE_SCIFI: "sci-fi"
  GENRE_COMEDY: "komedie"
  GENRE_DRAMA: "drama"
  SEARCH: "hledání"
]

module.exports = m