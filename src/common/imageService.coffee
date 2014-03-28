module = angular.module( 'imageService', [])
module.factory("imageService", ->
  img = undefined
  setImg:(name)->
    img = name
  getImg:->
    img
)