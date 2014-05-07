mongoose = require 'mongoose'
Schema = mongoose.Schema

# Promise = require('bluebird')
# uuid = require('node-uuid')

###
SCHEMA
###
Book = new Schema
  name:
    type: String
    required: true
    index: true
  author:
    type: String
    required: true
  owner:
    type: Schema.Types.ObjectId
    ref: "User"
  buyers:[
    type: Schema.Types.ObjectId
    ref: "User"
  ]
  genres:[
    {
      type: String
      index: true
    }
  ]
  keywords:
    type:String
    required:false
  number_of_sales:
    type:Number
    required:false
  commets:[
    {
      author:
        type: String
        require: true
      coment:
        type: String
        require: true
      user:
        type: Schema.Types.ObjectId
        ref: "User"
    }
  ]
  rating:[
    {
      value:
        type: Number
        require: true
      user:
        type: Schema.Types.ObjectId
        ref: "User"
    }
  ]
  avaible:Boolean
  delivery_days:String
  price:
    type:Number
  released:Date
  public_from:Date
  buy_allowed_from:Date
  description:String
  price_hystory:[
    {
      date:
        type:Date
        default: Date.now
      value:
        type:Number
    }
  ]
  pages:
    type: Number
    required: true
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

# Book.create = ->

# Book.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'Book', Book