var coffee =   require("coffee-script/register")
var server =   require("./server")
var paths =    require("../path/paths")
var database = require("./database")

database.init()
database.registerModels()
server.start()

paths.register()