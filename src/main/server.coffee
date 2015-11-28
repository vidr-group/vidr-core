app =  require("express")()
util = require "../util/util"

start = -> app.listen(3000)

module.exports =
  app: app
  start: start