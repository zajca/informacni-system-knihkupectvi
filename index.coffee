###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
passport = require('passport')
LocalStrategy = require('passport-local').Strategy

app = express()

# READ CONFIG
config = require("./config").getConfig(app,process.env.ENV)

# setup express
require("./config").setUpExpress(app,config)

# config db
db = require('./database')
db.setUp config
User = db.user

#setup passport
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()

###
REQUIRE ROUTES
###
router = require("./routes")

app.get "/partials/:partial", (req, res, next) ->
  res.render "assets/partials/#{req.params.partial}"

#VIEWS ROUTES
app.get "/", router.store
app.get "/editor", router.editor
app.get "/admin", router.admin
app.get "/finance", router.finance
app.get "/create", router.create
app.get "/storage", router.storage

#API ROUTES
app.get "/users", router.user.list

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")