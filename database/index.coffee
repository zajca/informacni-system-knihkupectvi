mongoose = require("mongoose")
acl = require('acl')

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
  acl: ->
    #init ACL
    acl = new acl(new acl.mongodbBackend(mongoose.connection.db, 'acl_'))


    #set up acl
    acl.allow [
      {
        roles: "guest"
        allows: [
          {
            resources: "books"
            permissions: "get"
          }
          {
            resources: [
              "books.coments"
            ]
            permissions: [
              "put"
            ]
          }
        ]
      }
      {
        roles: "member"
        allows: [
          {
            resources: "books"
            permissions: [
              "buy"
              "read"
              "vote"
            ]
          }
          {
            resources: [
              "books.comnets"
            ]
            permissions: [
              "get"
              "put"
              "delete"
            ]
          }
        ]
      }
      {
        roles: [
          "admin"
        ]
        allows: [
          {
            resources: "*"
            permissions: "*"
          }
        ]
      }
    ]

    acl
    
  user: require "./schema/user"
  book: require "./schema/book"