var app = require("../core/server.js").app
var util = require("../util/util.js")

module.exports = {
	register: register
}

function register()
{
	app.get("/", function(req, res) {
		res.send("Hello World!")
	})
	
	util.requireAll("path/handlers", function(obj) { obj() })
	
	registerErrHandlers()
}

function registerErrHandlers() {
	// 404: page not found
	app.use(function(req, res, next) {
	  util.err(req, res, 404)
	});

	// 500: internal server error
	app.use(function(err, req, res, next) {
	  console.error(err.stack);
		util.err(req, res, 500)
	});
}