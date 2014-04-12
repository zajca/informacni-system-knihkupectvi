###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
app = express()

# READ CONFIG
config = require("./config").getConfig(app,process.env.ENV)

# setup express
require("./config").setUpExpress(app,config)

# config db
db = require('./database')
db.setUp config

###
REQUIRE ROUTES
###
router = require("./routes")

app.get "/partials/:partial", (req, res, next) ->
  res.render "assets/partials/#{req.params.partial}"

app.get "/", router.editor
app.get "/editor", router.editor
app.get "/users", router.user.list

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")