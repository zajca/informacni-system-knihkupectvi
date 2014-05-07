mongoose = require( 'mongoose' )
User = mongoose.model( 'User' )

#
# * GET users listing.
#
module.exports =
  list: (req, res) ->
    res.send "respond with a resource"
    
  login:(req, res) ->
    res.send "respond with a resource"

  logout:(req, res) ->
    res.send "respond with a resource"

  create:(req, res) ->
    res.send "respond with a resource"

  update:(req, res) ->
    res.send "respond with a resource"

  confirm:(req, res) ->
    res.send "respond with a resource"

  createOrder:(req, res) ->
    res.send "respond with a resource"

  confirmOrder:(req, res) ->
    res.send "respond with a resource"