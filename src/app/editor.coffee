#VENDOR
require "./../../vendor/angular/angular.js"
require "./../../vendor/angular-ui-router/release/angular-ui-router"
require "./../../vendor/angular-animate/angular-animate"
require "./../../vendor/angular-touch/angular-touch"
require "./../../vendor/angular-easyfb/angular-easyfb"
require "./../../vendor/angular-translate/angular-translate"
require "./../../libs/cs_cz"
#COMMON
require "./../common/device"
require "./../common/flashService"
require "./../common/preventScrollDirective"
require "./../common/randomHelper"
require "./../common/sessionService"
require "./../common/spinnerService"
require "./../common/titleService"
require "./../common/bind-html-unsafe"
#CTRL
require "./editorCTRL"
require "./../editor/routes"
require "./../editor/editor"
require "./../editor/directive"
#i18n
require "./../i18n/cz"

module = angular.module("editor", [
  "ui.router"
  "ngAnimate"
  "ngTouch"
  "bindHtmlUnsafe"
  "device"
  "random"
  "preventScroll"
  "titleService"
  "SessionService"
  "pascalprecht.translate"
  "i18n"
  "FlashService"
  "SpinnerService"
  "editor.ctrl"
])
module.config ["$stateProvider", "$urlRouterProvider","$locationProvider","$logProvider","$provide","$httpProvider",($stateProvider, $urlRouterProvider,$locationProvider,$logProvider,$provide,$httpProvider) ->
  $urlRouterProvider.otherwise "/editor"
  $locationProvider.html5Mode(false).hashPrefix('!')
  $logProvider.debugEnabled true
  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

  $httpProvider.interceptors.push ["$q","$log","FlashService","SpinnerService",($q,$log,FlashService,SpinnerService) ->
    request: (config) ->
      if config.loading!=false
        SpinnerService.set()
      $log.debug "REQUEST"
      $log.debug config
      #        if config.method == "POST" or config.method == "PUT"
      #          $log.debug csrfService.token
      #          config.headers["X-CSRF-Token"] = csrfService.token
      if config.method == "POST"
        $log.debug "POST"
      config or $q.when(config)
    requestError: (rejection) ->
      $log.debug "REQUEST ERROR"
      $log.debug rejection
      $q.reject rejection
    response: (response) ->
      SpinnerService.unset()
      $log.debug "RESPONSE OK"
      $log.debug response
      if response.config.method == "POST"
        $log.debug "POST"
      response or $q.when(response)
    responseError: (rejection) ->
      SpinnerService.unset()
      $log.debug "RESPONSE ERROR"
      $log.debug rejection
      FlashService.show(rejection,"error")
      $q.reject rejection
  ]
]
module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Editor"
]