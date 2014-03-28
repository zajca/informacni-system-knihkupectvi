module = angular.module("i18n", ["pascalprecht.translate"])
module.config ["$translateProvider",($translateProvider) ->
  $translateProvider.translations "cz",
    MENU: "menu"

  $translateProvider.preferredLanguage "cz"
]