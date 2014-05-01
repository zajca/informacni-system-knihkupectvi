#VENDOR
require "angular"
require "angular-ui-router"
require "./../../vendor/angular-animate/angular-animate"
require "./../../vendor/angular-touch/angular-touch"
require "./../../vendor/angular-translate/angular-translate"
require "./../../libs/cs_cz"
require "./../../vendor/angular-carousel/dist/angular-carousel"
require "./../../vendor/angular-strap/dist/angular-strap"
require "./../../vendor/angular-strap/dist/angular-strap.tpl"
require "./../../vendor/angular-xeditable/dist/js/xeditable"

#COMMON
require "./../common/device"
require "./../common/flashService"
require "./../common/preventScrollDirective"
require "./../common/randomHelper"
require "./../common/sessionService"
require "./../common/spinnerService"
require "./../common/titleService"
require "./../common/bind-html-unsafe"
require "./../common/matchDirective"
#CTRL
require "./storeCTRL"
require "./../storeIndex/routes"
require "./../user"

#i18n
require "./../i18n"

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
  "match"
  "user"
  "mgcrea.ngStrap"
  "xeditable"
])

module.constant "CONF", require("./store_dev.json")

module.run (editableOptions) ->
  editableOptions.theme = 'bs3'

module.config ["$urlRouterProvider","$locationProvider","$logProvider","CONF",($urlRouterProvider,$locationProvider,$logProvider,conf)->
  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
  $logProvider.debugEnabled conf.debug
]

module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Store"
]
