'use strict'

module.exports = [() ->
  scope:true
  replace:false
  restrict: 'A'
  template:'<a href><i class="fa fa-shopping-cart" data-animation="am-flip-x" data-template="partials/basket/dropdown.tpl.html" bs-dropdown="dropdown"></i></a>'
  controller: ["$scope",($scope)->
   
    ]
]