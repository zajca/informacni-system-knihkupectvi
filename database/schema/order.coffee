mongoose = require 'mongoose'
Schema = mongoose.Schema

Promise = require('bluebird')
uuid = require('node-uuid')

###
SCHEMA
###
Order = new Schema
  user:
    name:
      type:String
      required: true
    surname:
      type:String
      required: true
    tel:
      type:String
      required: true
    email:
      type:String
      required: true
    user:
      type: Schema.Types.ObjectId
      ref: "User"
  price:
    type:Number
    required: true
  items:[
    name:
      type: String
      required: true
      index: true
    author:
      type: String
      required: true
    price:
      type:Number
      required: true
    released:Date
    description:String
    pages:
      type: Number
  ]
  pay_method:
    name:
      type:String
      required: true
    card_number:
      type:Number
  delivery_method:
    name:
      type:String
      required: true
    price:
      type:Number
      required: true
    branche:
      name: String
      city: String
      street: String
      postal: Number
      home_number: Number
      tel: Number
  confirmed:Boolean
  states:[
    name:String
    description:String
    date:Date
    default: Date.now
  ]
  custom_id:String
  custom_description:String
  payed:Boolean
  billing_address:
    state: String
    city: String
    street: String
    postal: Number
    home_number: Number
    type: String
  destination_address:
    state: String
    city: String
    street: String
    postal: Number
    home_number: Number
    type: String
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
# Order.plugin(passportLocalMongoose)

Order.create = ->

Order.update = ->

# Order.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'Order', Order