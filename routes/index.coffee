#
# * GET home page.
#
module.exports =
  editor: (req, res) ->
    res.render "editor"
    
  user: require "./user"