module.exports = [
  "$http","CONF","$log","FlashService","$translate",
  ($http,CONF,$log,FlashService,$translate)->

    fetch:(type)->  
      n = FlashService.show($translate("FLASH_REQUEST_FOR_BOOKS"))

      http = $http.get("#{CONF.apiUrl}book")
      if type?
        http = $http.get("#{CONF.apiUrl}book/type/#{type}")

      http.then (res)->
        $log.debug res
        FlashService.done(n)
      ,(res)->
        $log.debug res
        FlashService.err(n,res.flash)

      http

    query:(params)->  
      n = FlashService.show($translate("FLASH_REQUEST_FOR_BOOKS"))

      params = params||{}
      http = $http.get("#{CONF.apiUrl}book",params)
      http.then (res)->
        $log.debug res
        FlashService.done(n)
      ,(res)->
        $log.debug res
        FlashService.err(n,res.flash)

      http
]