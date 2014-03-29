require "./../common/titleService"
require "./../../vendor/angular-ui-ace/ui-ace"

module = angular.module("editor.editor.ctrl", ["titleService","ui.ace"])
module.controller "EditorEditorCtrl",
  [
    "$scope"
  (
    $scope
  ) ->
    titleService.setTitle "EDITOR"

    $scope.init = ->
      console.log "init"

    getNum = ->
      num++
    createSubTree = (level) ->
      if level > 0
        [
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
        ]
      else
        []
    num = 1
    $scope.treedata = createSubTree(3)
    $scope.showSelected = (sel) ->
      $scope.selected = sel.label
      return

    $scope.addRoot = ->
      $scope.treedata.push
        label: "New Node " + getNum()
        id: "id"
        children: []

      return

    $scope.addChild = ->
      $scope.treedata[0].children.push
        label: "New Node " + getNum()
        id: "id"
        children: []

      return
  ]