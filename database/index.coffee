mongoose = require("mongoose")

# Enable Query::paginate
require "./plugins/paginate"

module.exports =
  #setupDB
  setUp: (config)->
    connectionString = "mongodb://#{config.db.host}:#{config.db.port}/#{config.db.name}"

    db = mongoose.createConnection connectionString,
      server:
        auto_reconnect: true

    dbTimeout = setTimeout(errorConnecting, 100)

    errorConnecting = ->
      console.error "Error connecting to mongodb"
      process.exit(1)

    # console.log db
      
    db.on "open", (e)->
      clearTimeout(dbTimeout)
    db.on "error", (e)->
      clearTimeout(dbTimeout)
      errorConnecting

  user: require "./schema/user"
  book: require "./schema/book"