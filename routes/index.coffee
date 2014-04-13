#
# * GET home pages.
#
module.exports =
  editor: (req, res) ->
    res.render "editor"
  store: (req, res)->
    res.render "store"
  admin: (req, res)->
    res.render "admin"
  create: (req, res)->
    res.render "create"
  finance: (req, res)->
    res.render "finance"
  storage: (req, res)->
    res.render "storage"

  user: require "./v1/user"