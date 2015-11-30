{app} =    require "../../main/server"
util =     require "../../util/util"
database = require "../../main/database"

main = ->
  UserSchema = database.userSchema
  
  app.route("/u(ser)?/:username")
    .get(get)
    .post(post)
    .put(put)

get = (req, res) ->
  if (req.params.username isnt "thislooksfun")
    util.err(req, res, 404, "Can't find user #{req.params.username}")
  res.send("[get] User found: #{req.params.username}")

post = (req, res) -> res.send("[post] User found: #{req.params.username}")
put = (req, res) -> res.send("[put] User found: #{req.params.username}")

module.exports = main