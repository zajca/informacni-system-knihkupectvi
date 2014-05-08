mongoose = require("mongoose")

# Enable Query::paginate
require "./plugins/paginate"

module.exports =
  #setupDB
  setUp: (config)->
    connectionString = "mongodb://#{config.db.host}:#{config.db.port}/#{config.db.name}"
    console.log connectionString
    db = mongoose.connect(config.db.host,config.db.name)

    # dbTimeout = setTimeout(errorConnecting, 1000)

    # errorConnecting = ->
    #   console.error "Error connecting to mongodb"
    #   process.exit(1)

    # # console.log db
    # db.once 'open', (argument)->
    #   console.log('Database connection established!')
    #   clearTimeout(dbTimeout)
    # # db.on "open", (e)->
    # #   console.log "open",e
    # #   clearTimeout(dbTimeout)
    # db.on "error", (e)->
    #   clearTimeout(dbTimeout)
    #   errorConnecting

  user: require "./schema/user"
  book: require "./schema/book"