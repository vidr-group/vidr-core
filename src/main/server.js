var app = require("express")()
var util = require("../util/util.js")

module.exports = {
	app: app,
	start: start
}

function start() {
	app.listen(3000)
}