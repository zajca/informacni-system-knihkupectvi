require "./editor"

module = angular.module("editor.editor", ["editor.editor.ctrl"])

module.config(
  ["$stateProvider",($stateProvider) ->
    console.log "config"
#    $stateProvider.state("index",
#      url: "/directory"
#      abstract: true
#      views:
#        main:
#          templateUrl: "directory/directory.tpl.html"

    $stateProvider.state("editor",
      url: "/editor"
      controller: "EditorEditorCtrl"
      views:
        main:
          templateUrl: "editor/editor.html"
    )
  ]
)