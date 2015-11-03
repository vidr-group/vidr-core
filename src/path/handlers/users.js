var app = require("../../core/server.js").app
var util = require("../../util/util.js")

module.exports = main

function main() {
	app.route("/u(ser)?/:username")
		.get(get)
		.post(post)
		.put(put)
}

function get(req, res) {
	if (req.params.username !== "thislooksfun") {
		util.err(req, res, 404, "Can't find user '"+req.params.username+"'")
	}
	res.send("[get] User found: "+req.params.username)
}

function post(req, res) {
	res.send("[post] User found: "+req.params.username)
}

function put(req, res) {
	res.send("[put] User found: "+req.params.username)
}