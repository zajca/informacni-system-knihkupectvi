mongoose = require 'mongoose'
Schema = mongoose.Schema
passportLocalMongoose = require('passport-local-mongoose')

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
  buyed_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  whished_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  owned_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  roles:
    type: [String]
    default: ['anonymous']
  meta: [
      {
        key: String
        value: String
      }
    ]
  updated_at:
    type:Date
    default: Date.now
  created_at:
    type:Date
    default: Date.now

# PLUGINS
User.plugin(passportLocalMongoose)

User.create = ->

User.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'User', User