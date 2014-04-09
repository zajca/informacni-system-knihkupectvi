m = angular.module("i18n", ["pascalprecht.translate"])
m.config ["$translateProvider",($translateProvider) ->
  $translateProvider.translations "cz",
    MENU: "menu"

  $translateProvider.preferredLanguage "cz"
]
module.exports = m