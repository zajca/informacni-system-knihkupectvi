
module = angular.module("editor.ctrl", [])

module.controller "EditorCtrl", ["$scope","$state","$rootScope",($scope,$state,$rootScope) ->
  $scope.init =->
#    API.csrf()

  $scope.menu=[
    name:"vyberte přání"
    ulr:"/vyberte-prani"
    state:"vyberte-prani"
    active:false
  ,
    name:"ozdobte přání"
    ulr:"/ozdobte-prani"
    state:"ozdobte-prani"
    active:false
  ,
    name:"zvolte text"
    ulr:"/zvolte-text"
    state:"zvolte-text"
    active:false
  ,
    name:"sdílejte"
    ulr:"/sdilejte"
    state:"sdilejte"
    active:false
  ]

  $rootScope.$on('$stateChangeSuccess',
  (event, toState)->
    angular.forEach($scope.menu, (value)->
      if value.state == toState.name
        value.active = true
      else
        value.active = false
    )
  )

]