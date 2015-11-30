{app} = require "../main/server"
util = require "../util/util"

register = ->
  app.get "/", (req, res) -> res.send("Hello World!")
  
  util.requireAll "path/handlers", (obj) -> obj()
  
  registerErrHandlers()

registerErrHandlers = ->
  # 404: page not found
  app.use (req, res, next) -> util.err(req, res, 404)

  # 500: internal server error
  app.use (err, req, res, next) ->
    console.error(err.stack)
    util.err(req, res, 500)
    
module.exports =
  register: register