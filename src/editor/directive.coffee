module = angular.module("editor.editor.directive", [])
module.directive "editor",
[
  "$timeout"
(
  $timeout
) ->
  restrict: "E"
  scope:
    input:"="
  replace:true
  template:'<div></div>'
  link: (scope)->
  controller:($scope)->

]