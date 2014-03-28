module = angular.module("preventScroll",[])
module.directive "preventScroll", ["$swipe", ($swipe) ->
  restrict: "AC"
  link: (scope, ele) ->
    $swipe.bind ele,
      start: (pos,e) ->
        e.preventDefault()
]