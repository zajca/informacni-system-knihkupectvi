'use strict'
require "./spinnerService"
require "./flashService"

module.exports = ["$httpProvider",($httpProvider) ->

  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

  $httpProvider.interceptors.push ["$q","$log","FlashService","SpinnerService",($q,$log,FlashService,SpinnerService) ->
    request: (config) ->

      if !config.loading
        SpinnerService.set()

      $log.debug "REQUEST"
      $log.debug config

      if config.method == "POST" or config.method == "PUT"
        $log.debug csrfService.token
        config.headers["X-CSRF-Token"] = csrfService.token

      if config.method == "POST"
        $log.debug "POST"

      config or $q.when(config)
    requestError: (rejection) ->
      $log.debug "REQUEST ERROR"
      $log.debug rejection
      $q.reject rejection
    response: (response) ->
      SpinnerService.unset()
      msg="RESPONSE OK"
      msg+" POST" if response.config.method == "POST"
      $log.debug msg
      $log.debug response
      response or $q.when(response)
    responseError: (rejection) ->
      SpinnerService.unset()
      $log.debug "RESPONSE ERROR"
      $log.debug rejection
      FlashService.show(rejection,"error")
      $q.reject rejection
  ]
]