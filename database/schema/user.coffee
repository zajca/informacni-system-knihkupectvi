mongoose = require 'mongoose'
Schema = mongoose.Schema
# passportLocalMongoose = require('passport-local-mongoose')
gridfs = require '../plugins/gridfs'

Promise = require('bluebird')
uuid = require('node-uuid')
bcrypt = require('bcryptjs')
crypto = require('crypto')

bcrypt.genSalt = Promise.promisify(bcrypt.genSalt)
bcrypt.hash = Promise.promisify(bcrypt.hash)
bcrypt.compare = Promise.promisify(bcrypt.compare)

###
SCHEMA
###
User = new Schema
  _id:
    type: String,
    default: ->
      uuid.v4().replace(/-/g, '')
  email:
    type: String
    required: true
    unique: true
    index: true
  img:
    type: Schema.Types.Mixed
  locale:
    type: String
  name:
    type:String
    required:false
  surname:
    type:String
    required:false
  address:
    [
      state: String
      city: String
      street: String
      postal: Number
      home_number: Number
      type: String
    ]
  phone:
    type:String
    required:false
  orders:
    [
      type: Schema.Types.ObjectId
      ref: "Order"
    ]
  projects:
    [
      type: Schema.Types.ObjectId
      ref: "Project"
    ]
  whished_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  payed_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  roles:
    type: [String]
    default: ['anonymous']
  special:
    canRead:
      projects:[
        type: Schema.Types.ObjectId
        ref: "Project"
      ]
    canEdit:
      projects:[
        type: Schema.Types.ObjectId
        ref: "Project"
      ]
  meta: [
    key: String
    value: String
  ]
  updated_at:
    type:Date
    default: Date.now
  created_at:
    type:Date
    default: Date.now

# PLUGINS
# User.plugin(passportLocalMongoose)

User.addImg = (file, options, fn) ->
  gridfs.putFile file.path, file.filename, options, (err, result) ->
    this.img = result
    this.save fn

User.getImg = (file, options, fn) ->
  gridfs.get req.params.id, (err, file) ->
    res.header "Content-Type", file.type
    res.header "Content-Disposition", "attachment; filename=#{file.filename}"
    file.stream(true).pipe(res)

User.create = ->

User.canDownloadBook = (id, options, fn) ->
  if id in this.payed_books
    true

# EXPORT
module.exports = mongoose.model 'User', User