angular.module( 'AgeService', [])
.factory("AgeService", ->
  age = undefined
  observerCallbacks = []

  registerObserverCallback: (callback) ->
    observerCallbacks.push callback

  notifyObservers: ->
    angular.forEach observerCallbacks, (callback) ->
      callback()

  setOld: ->
    this.age = "old"
    this.notifyObservers()

  setYoung: ->
    this.age = "young"
    this.notifyObservers()

  reset: ->
    this.age = undefined
    this.notifyObservers()
)