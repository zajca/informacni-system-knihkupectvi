mongoose = require 'mongoose'
Schema = mongoose.Schema
 
User = new Schema
  user_id: String
  content: String
  updated_at: Date


exports.user = mongoose.model 'User', User