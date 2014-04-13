#VENDOR
require "./../../vendor/angular/angular.js"
require "./../../vendor/angular-ui-router/release/angular-ui-router"
require "./../../vendor/angular-animate/angular-animate"
require "./../../vendor/angular-touch/angular-touch"
#require "./../../vendor/angular-easyfb/angular-easyfb"
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
require "./storeCTRL"
require "./../storeIndex/routes"
#i18n
require "./../i18n/index"

module = angular.module("store", [
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
  "store.ctrl"
  "store.router"
])

module.config ["$urlRouterProvider","$locationProvider","$logProvider",($urlRouterProvider,$locationProvider,$logProvider)->
  conf = require("./store_dev.json")
  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
  $logProvider.debugEnabled conf.debug
]

module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Store"
]