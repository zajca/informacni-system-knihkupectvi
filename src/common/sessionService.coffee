module = angular.module( 'SessionService', [])
module.factory("SessionService", ->
  get: (key) ->
    sessionStorage.getItem key

  set: (key, val) ->
    sessionStorage.setItem key, val

  unset: (key) ->
    sessionStorage.removeItem key
)