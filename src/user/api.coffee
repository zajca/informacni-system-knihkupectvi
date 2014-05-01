m = angular.module("user.api",[])
m.factory("userApi",["CONF","FlashService","$translate","$http","$log",(CONF,FlashService,$translate,$http,$log)->
  
  usernameCheck:(name)->
    $http.get(
      loading:false
      url:"#{CONF.apiUrl}/user/check/username/#{name}"
    )

  getProject:(id)->
    n = FlashService.show($translate("FLASH_REQUEST_FOR_PROJECT"))
    http = $http.get("#{CONF.apiUrl}/project/#{id}")
    http.then (res)->
      $log.debug res
      FlashService.done(n)
    ,(res)->
      $log.debug res
      FlashService.err(id,res.flash)
    http

  updateProject:(id)->

  renderProject:(id)->

]
)