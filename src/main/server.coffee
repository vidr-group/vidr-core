app =  require("express")()

start = -> app.listen(3000)

module.exports =
  app: app
  start: start