mongoose = require('mongoose')
Book = mongoose.model('Book')

#
# * GET books listing.
#
module.exports =
  list: (req, res) ->
    res.send "respond with a resource"
    
  listType:(req, res) ->
    res.send "respond with a resource"

  find:(req, res) ->
    res.send "respond with a resource"

  show:(req, res) ->
    res.send "respond with a resource"

  update:(req, res) ->
    res.send "respond with a resource"

  create:(req, res) ->

    console.log("POST: ")
    console.log(req.body)

    book=new Book(req.body)
    p = book.save (err)->
      if !err
        res.send(book)
      else
        console.log "FAIL"+out