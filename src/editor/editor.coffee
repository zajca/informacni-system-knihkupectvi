require "./../common/titleService"

module = angular.module("editor.editor.ctrl", ["titleService"])
module.controller "EditorEditorCtrl",
[
  "$scope"
(
  $scope
) ->

  $scope.init=->
    console.log "init"
]