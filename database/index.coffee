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

    dbTimeout = setTimeout(errorConnecting, 1000 * 30)

    errorConnecting = ->
      console.error "Error connecting to mongodb"
      process.exit(1)
      
    db.on "open", -> clearTimeout(dbTimeout)

  user: require "./schema/user"