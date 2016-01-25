{app} =    require "../../main/server"
util =     require "../../util/util"
database = require "../../main/database"

main = ->
  app.route("/u(ser)?/:username")
    .get(get)
    .post(post)
    .put(put)
    .delete(del)

get = (req, res) ->
  User = database.models.User
  
  User.findOne({"username": req.params.username}, "username").then (a) ->
    if a? or b? or c?
      res.send("a = #{a}\nb = #{b}\nc = #{c}")
    else
      User.create {"username": req.params.username, "password": "asdf"}, (err) ->
        if err?
          res.send("Whoops...\n#{err}")
        else
          res.send("Created")
  
  # if (req.params.username isnt "thislooksfun")
  #   util.err(req, res, 404, "Can't find user #{req.params.username}")
  # res.send("[get] User found: #{req.params.username}")

post = (req, res) -> res.send("[post] User found: #{req.params.username}")
put =  (req, res) -> res.send( "[put] User found: #{req.params.username}")
del =  (req, res) -> res.send( "[del] User found: #{req.params.username}")

module.exports = main