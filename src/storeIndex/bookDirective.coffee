m = angular.module("store.book.directive", [])
m.directive "book",
[
  "$timeout"
(
  $timeout
) ->
  restrict: "E"
  scope:
    name:"="
    img:"="
    price:"="
    id:"="
  replace:true
  template:'
    <div class="book">
require "./editor"
      <div>
    </div>'
  link: (scope)->
  controller:($scope)->

]
module.exports = m