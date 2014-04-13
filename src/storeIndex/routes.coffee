require "./index"

m = angular.module("store.router", ["store.index.ctrl"])

m.config(
  [
    "$stateProvider"
    ($stateProvider) ->
      $stateProvider.state("index",
        url: "/"
        views:
          main:
            controller: "StoreIndexCtrl"
            templateUrl: "partials/store/index.html"
      )
  ]
)
module.exports = m