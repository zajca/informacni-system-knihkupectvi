m = angular.module("store.ctrl", [])

m.controller "StoreCtrl", [
  "$scope"
  "$state"
  "$rootScope"
  "$translate"
  (
    $scope
    $state
    $rootScope
    $translate
  ) ->
    $scope.init =->
  #    API.csrf()
    $scope.menu=[
      name:"MENU_BOOKS"
      state: "index"
    ,
      name:"MENU_ADMINISTRATION"
      route: "/admin"
    ,
      name:"MENU_CREATE"
      route: "/create"
    ,
      name:"MENU_FINANCE"
      route: "/finance"
    ,
      name:"MENU_STORAGE"
      route: "/storage"
    ,
      name:"MENU_REGISTER"
      route: undefined
      special: "register"
      template: "user/register.tpl.html"
    ,
      name:"MENU_LOGIN"
      route: undefined
      special: "login"
      template: "user/login.tpl.html"
    ,
      name:"MENU_BASKET"
      route: undefined
      special: "basket"
      template: "basket/popover.tpl.html"
    ]

    $scope.books=[
      {
        name:"book"
        id: "1"
        img: "test"
      }
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
module.exports = m