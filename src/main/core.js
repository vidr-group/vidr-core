// NOTE:This file is to be used ONLY to co-ordinate the boot sequence. No logic should be placed in here.

// Allow coffeescript files to be used
require("coffee-script/register")

var server =   require("./server")
var paths =    require("../path/paths")
var database = require("./database")

database.init()
database.registerModels()
server.start()

paths.register()