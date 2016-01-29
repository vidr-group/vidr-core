utils = require '../../src/util/util'

describe "Util", ->
  
  describe "err()", ->
    
    testRequest = null
    testResponse = null
    
    before "build helpers", ->
      testRequest =
        _parsedUrl:
          pathname: "--pathname--"
      
      testResponse =
        status: (@code) -> return @
        send: (@json) -> # Empty function
    
    
    it "should create a message without one given", ->
      utils.err(testRequest, testResponse, 404)
      expect(testResponse.code).to.eql(404)
      expect(testResponse.json).to.exist
      json = null
      parseJson = -> json = JSON.parse(testResponse.json)
      expect(parseJson).to.not.throw(SyntaxError)
      expect(json).to.exist
      expect(json.type).to.eql("error")
      expect(json.path).to.eql(testRequest._parsedUrl.pathname)
      expect(json.code).to.eql(404)
      expect(json.message).to.eql("Error 404: Not Found")
    
    it "should handle unknown error codes", ->
      utils.err(testRequest, testResponse, 599)
      expect(testResponse.code).to.eql(599)
      expect(testResponse.json).to.exist
      json = null
      parseJson = -> json = JSON.parse(testResponse.json)
      expect(parseJson).to.not.throw(SyntaxError)
      expect(json).to.exist
      expect(json.type).to.eql("error")
      expect(json.path).to.eql(testRequest._parsedUrl.pathname)
      expect(json.code).to.eql(599)
      expect(json.message).to.eql("Unknown error code: 599")
    
    it "should use the given message", ->
      utils.err(testRequest, testResponse, 404, "Custom message!")
      expect(testResponse.code).to.eql(404)
      expect(testResponse.json).to.exist
      json = null
      parseJson = -> json = JSON.parse(testResponse.json)
      expect(parseJson).to.not.throw(SyntaxError)
      expect(json).to.exist
      expect(json.type).to.eql("error")
      expect(json.path).to.eql(testRequest._parsedUrl.pathname)
      expect(json.code).to.eql(404)
      expect(json.message).to.eql("Custom message!")
  
  
  
  describe "requireAll()", ->
    
    before "add uncache function", ->
      
      # Code taken from http://stackoverflow.com/a/14801711/3438793
      require.uncache = (moduleName) ->
        require.searchCache moduleName, (mod) -> delete require.cache[mod.id]
        
        Object.keys(module.constructor._pathCache).forEach (cacheKey) ->
          delete module.constructor._pathCache[cacheKey] if cacheKey.indexOf(moduleName) > 0

      require.searchCache = (moduleName, callback) ->
        mod = null
        try mod = require.resolve(moduleName)
        return unless mod?
        
        if mod and (mod = require.cache[mod])?
          run = (mod) ->
            mod.children.forEach (child) -> run(child)
            callback(mod)
          
          run mod
    
    toLoad = []
    
    describe "non-recursive", ->
      
      beforeEach "unload test modules", ->
        toLoad =
          "moduleA.normal": ""
          "moduleB.normal": ""
          "moduleC.normal": ""
        
        require.uncache("../../testResources/requireTest/normal/moduleA.normal")
        require.uncache("../../testResources/requireTest/normal/moduleB.normal")
        require.uncache("../../testResources/requireTest/normal/moduleC.normal")
      
      it "should load all modules, and nothing more, and pass them to the callback handler", ->
        utils.requireAll "testResources/requireTest/normal", (obj) ->
          expect(obj).to.exist
          expect(toLoad[obj]).to.exist
          delete toLoad[obj]
        
        expect(Object.keys(toLoad).length).to.eql(0)
    
    
    describe "recursive", ->
      
      beforeEach "unload test modules", ->
        toLoad =
          "moduleA.recursive": ""
          "moduleB.recursive": ""
          "moduleC.recursive": ""
        
        require.uncache("../../testResources/requireTest/recursive/moduleA.recursive")
        require.uncache("../../testResources/requireTest/recursive/moduleB.recursive")
        require.uncache("../../testResources/requireTest/recursive/sub/moduleC.recursive")
      
      it "should properly handle recursive requirements", ->
        utils.requireAll "testResources/requireTest/recursive", (obj) ->
          expect(obj).to.exist
          expect(obj).to.be.a('string')
          expect(toLoad[obj], obj).to.exist
          delete toLoad[obj]
        
        expect(Object.keys(toLoad).length).to.eql(0)
    