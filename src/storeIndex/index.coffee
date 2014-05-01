'use strict'

require "./../common/titleService"

m = angular.module("store.index.ctrl", ["titleService"])
m.controller "StoreIndexCtrl",
[
  "$scope"
  "titleService"
  "$log"
(
  $scope
  titleService
  $log
) ->
  titleService.setTitle "Obchod výběr knih"

  $scope.init = ->
    $log.debug "init StoreIndexCtrl"
]
module.exports = m