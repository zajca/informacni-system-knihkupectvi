###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
# passport = require('passport')
LocalStrategy = require('passport-local').Strategy
mongooseRestEndpoints = require('mongoose-rest-endpoints')
mongooseRestEndpoints.log.verbose(true)
# restify = require('express-restify-mongoose')
access = require('./lib/auth/middleware/access')

app = express()

# READ CONFIG
config = require("./config").getConfig(app,process.env.ENV)

# setup express
require("./config").setUpExpress(app,config)
# config db
db = require('./database')
db.setUp config
User = db.user
Book = db.book

acl = db.acl()
console.log acl

#socket.io
io = require('socket.io').listen(app.listen(config.app.socket))

#setup passport
# passport.serializeUser User.serializeUser()
# passport.deserializeUser User.deserializeUser()

###
REQUIRE ROUTES
###
router = require("./routes")

app.get "/partials/:partial", (req, res, next) ->
  res.render "assets/partials/#{req.params.partial}"

#VIEWS ROUTES
app.get "/", router.store
app.get "/book", router.store
app.get "/book/*", router.store
app.get "/editor", router.editor
app.get "/admin", router.admin
app.get "/finance", router.finance
app.get "/create", router.create
app.get "/storage", router.storage

#API ROUTES
#BOOKS
apiPrefix="/api/v1"
# app.get "#{apiPrefix}/books/type/:type", router.books.listType

#USER
app.post('#{apiPrefix}/users/login', require('./lib/auth/login')())
app.post('#{apiPrefix}/users/logout', require('./lib/auth/logout')())

new mongooseRestEndpoints.endpoint('/api/v1/users', 'User').register(app);
new mongooseRestEndpoints.endpoint('/api/v1/books', 'Book').register(app);
# restify.serve app, User
# restify.serve app, Book

# console.log app.routes

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")