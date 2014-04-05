require "./editor"

module = angular.module("editor.editor", ["editor.editor.ctrl"])

module.config(
  ["$stateProvider",($stateProvider) ->
#    $stateProvider.state("index",
#      url: "/directory"
#      abstract: true
#      views:
#        main:
#          templateUrl: "directory/directory.tpl.html"

    $stateProvider.state("editor",
      url: "/editor"
      views:
        main:
          controller: "EditorEditorCtrl"
          templateUrl: "partials/editor/editor.html"
    )
  ]
)