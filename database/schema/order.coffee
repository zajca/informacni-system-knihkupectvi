mongoose = require 'mongoose'
Schema = mongoose.Schema

Promise = require('bluebird')
uuid = require('node-uuid')

###
SCHEMA
###
Order = new Schema
  _id:
    type: String,
    default: ->
      uuid.v4().replace(/-/g, '')
  user:
  price:
  items:
  pay_method:
  confirmed:
  payed:
  bill_address:
  destination_address:
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
Order.plugin(passportLocalMongoose)

Order.create = ->

Order.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'Order', Order