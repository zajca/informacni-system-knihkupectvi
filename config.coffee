path = require("path")
express = require("express")
passport = require("passport")
authConfig = require('./lib/auth/config')
mongoose = require('mongoose')

module.exports =
  setUpExpress: (app,config)->

    #AUTH
    authConfig.set
      'systemCookieSalt': '5GiNxOayeGDEIImNyzsEDspRJLhaIAZsG9vMqnjlXnTgX2ELzk',
      'systemSignedCookieSalt': 'JuOkxMXBquIDQMrojSBz4vGq0EsGLhOQXK78VIri5tPkHH8W3J7Y8t',
      'systemStorageSalt': 'Kjl6LVkXE2XTw3TE84lP5sebXkNPwAOb6Y9ess7ua2MQim6Wv1',
      'systemPasswordSalt': 'nT.31_F!8z.Q[ of^$PEmWSddddY&cG%n#L|]}',
      'cookieIterations': 1000,
      'passwordIterations': 1000,
      'cookieKeylen': 64,
      'passwordKeylen': 64,
      'randomBytesSize': 64,
      'tokenName': 'authToken',
      'httpHeader': 'X-Authorization',
      'maxAge': 3 * 24 * 60 * 60 #3dny

    authConfig.setModel require('./database/schema/user')

    ###
    EXPRESS CONFIG
    ###
    app.set "port", config.app.port
    app.set "views", path.join(__dirname, "views")
    app.set "view engine", "jade"
    app.use express.favicon()
    app.use express.json()
    app.use express.urlencoded()
    app.use express.methodOverride()
    app.use app.router
    app.use express.cookieParser(authConfig.options.systemSignedCookieSalt)
    app.use express.session()
    app.use passport.initialize()
    app.use passport.session()
    app.use express.static(path.join(__dirname, "assets"))
    app.use '/vendor', express.static(path.join(__dirname, "vendor"))

  getConfig: (app,env)->
    if env is "dev"
      app.use express.logger("dev")
      app.use express.errorHandler(
        dumpExceptions: true
        showStack: true
      )
      mongoose.set('debug', true)
      config=require "./config/appDev"
      console.log "running in development environment"
    else if env is "test"
      app.use express.errorHandler()
      config=require "./config/appTest"
      console.log "running in testing environment"
    else
      app.use express.errorHandler()
      config=require "./config/appProd"
      console.log "running in production environment"
    config