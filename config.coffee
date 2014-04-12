path = require("path")
express = require("express")

module.exports =
  setUpExpress: (app,config)->
    ###
    EXPRESS CONFIG
    ###
    app.set "port", config.app.port
    app.set "views", path.join(__dirname, "views")
    app.set "view engine", "jade"
    app.use express.favicon()
    app.use express.logger("dev")
    app.use express.json()
    app.use express.urlencoded()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static(path.join(__dirname, "assets"))
    app.use express.static(path.join(__dirname, "vendor"))

  getConfig: (app,env)->
    if env is "dev"
      app.use express.errorHandler()
      config=require "./config/appDev"
      console.log "running in development environment"
    else if env is "test"
      app.use express.errorHandler()
      config=require "./config/appTest"
      console.log "running in testing environment"
    else
      config=require "./config/appProd"
      console.log "running in production environment"
    config
