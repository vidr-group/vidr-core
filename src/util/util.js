var fs = require("fs")
var path = require("path")

module.exports = {
	err: err,
	requireAll: requireAll
}

function err(req, res, code, msg) {
	if (!exists(msg) && exists(httpMessages[code])) {
		msg = "Error "+code+": "+httpMessages[code]
	}
	if (!exists(msg)) {
		msg = "Unknown error code: "+code
	}
	
	res.status(code).send(
		JSON.stringify({ type:"error", path:req._parsedUrl.pathname, code:code, message:msg })
	);
}

function exists(obj) {
	return obj != null && obj != undefined
}

function requireAll(dir, handler) {
	var relPath = path.join(__dirname, "../"+dir)
	var files = fs.readdirSync(relPath)
	
	console.log(files)
	
	for (i = 0; i < files.length; i++) {
		console.log(files[i])
		var obj = require("../"+dir+"/"+files[i])
		if (exists(handler)) { handler(obj) }
	}
}


var httpMessages = {
	// 1xx: Informational
  100: "Continue",
  101: "Switching Protocols",
  102: "Processing",
	
	// 2xx: Success
  200: "OK",
  201: "Created",
  202: "Accepted",
  203: "Non-Authoritative Information",
  204: "No Content",
  205: "Reset Content",
  206: "Partial Content",
  207: "Multi-Status",
	208: "Already Reported",
	226: "IM Used",
	
	// 3xx: Redirection
  300: "Multiple Choices",
  301: "Moved Permanently",
  302: "Found",
  303: "See Other",
  304: "Not Modified",
  305: "Use Proxy",
  306: "Switch Proxy",
  307: "Temporary Redirect",
	308: "Perminant Redirect",
	
	// 4xx: Client Error
  400: "Bad Request",
  401: "Unauthorized",
  402: "Payment Required",
  403: "Forbidden",
  404: "Not Found",
  405: "Method Not Allowed",
  406: "Not Acceptable",
  407: "Proxy Authentication Required",
  408: "Request Timeout",
  409: "Conflict",
  410: "Gone",
  411: "Length Required",
  412: "Precondition Failed",
  413: "Request Entity Too Large",
  414: "Request-URI Too Long",
  415: "Unsupported Media Type",
  416: "Requested Range Not Satisfiable",
  417: "Expectation Failed",
  418: "I\"m a teapot",
	421: "Misdirected Request",
  422: "Unprocessable Entity",
  423: "Locked",
  424: "Failed Dependency",
  426: "Upgrade Required",
	428: "Precondition Required",
	429: "Too many requests",
	431: "Request Header Fields Too Large",
	
	// 5xx: Server Error
  500: "Internal Server Error",
  501: "Not Implemented",
  502: "Bad Gateway",
  503: "Service Unavailable",
  504: "Gateway Timeout",
  505: "HTTP Version Not Supported",
  506: "Variant Also Negotiates",
  507: "Insufficient Storage",
  509: "Bandwidth Limit Exceeded",
  510: "Not Extended",
	511: "Network Authentication Required"
}