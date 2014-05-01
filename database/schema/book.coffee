mongoose = require 'mongoose'
Schema = mongoose.Schema

Promise = require('bluebird')
uuid = require('node-uuid')

###
SCHEMA
###
Book = new Schema
  _id:
    type: String,
    default: ->
      uuid.v4().replace(/-/g, '')
  name:
    type: String
    required: true
    index: true
  author:
    type: String
    required: true
    index: true
  owner:
  buyers:
  type:
    type: String
    required: true
    index: true
  keywords:
    type:String
    required:false
  number_of_sales:
    type:Number
    required:false
  commets:
  rating:
  on_eshop:
  price:
  price_hystory:
  pages:
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
Book.plugin(passportLocalMongoose)

Book.create = ->

Book.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'Book', Book