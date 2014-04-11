m = angular.module("i18n", ["pascalprecht.translate"])
m.config ["$translateProvider",($translateProvider) ->
  $translateProvider.translations "cz",
    MENU: "menu"
    FLASH_UNKNOWN_ERROR: "Neznámá chyba"
    FLASH_REQUEST_FOR_PROJECT:"Stahuji knihu,…"
    FLASH_REQUEST_UPDATE_PROJECT: "Probíhá ukládání,…"
    FLASH_REQUEST_RENDER_PROJECT: "Probíhá render,…"

  $translateProvider.preferredLanguage "cz"
]
module.exports = m