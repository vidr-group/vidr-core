mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports =
  models:
    user:    null
    authKey: null
    channel: null
    video:   null
  
  init: (cb) ->
    if cb?
      mongoose.connect 'mongodb://localhost/vidr', cb
    else
      mongoose.connect 'mongodb://localhost/vidr'
  
  registerModels: ->
    userSchema = new Schema(
      username:
        type: String
        required: true
        unique: true
      password:
        type: String
        required: true
      # TODO: more settings and things here?
    )
    @models.user = mongoose.model "User", userSchema
    
    authKeySchema = new Schema(
      user:
        type: userSchema
        required: true
      key:
        type: String
        required: true
        unique: true
    )
    @models.authKey = mongoose.model "AuthKey", authKeySchema
    
    channelSchema = new Schema(
      title:
        type: String
        required: true
      user:
        type: String
        required: true
      uuid:
        type: String
        required: true
        unique: true
    )
    @models.channel = mongoose.model "Channel", channelSchema
    
    videoSchema = new Schema(
      title:
        type: String
        required: true
      channel:
        type: channelSchema
        required: true
      uuid:
        type: String
        required: true
        unique: true
    )
    @models.video = mongoose.model "Video", videoSchema
  
  stop: (cb) ->
    mongoose.disconnect cb