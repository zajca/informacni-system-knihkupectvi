'use strict'

m = angular.module("match", [])

m.directive "match", [->
  require: "ngModel"
  link: (scope, elem, attrs, ctrl) ->
    scope.$watch "[" + attrs.ngModel + ", " + attrs.match + "]", ((value) ->
      ctrl.$setValidity "match", value[0] is value[1]
      return
    ), true
    return
]

module.exports = m