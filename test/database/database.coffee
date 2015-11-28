describe "Database", ->
  database = require '../../src/main/database'
  mongoose = require 'mongoose'
  
  it "should exist", ->
    expect(database).to.be.ok
  
  it "shouldn't error on starting", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).to.eql(1)
      done()
    
    start = -> database.init end
    
    expect(mongoose.connections[0]._readyState).to.eql(0)
    expect(start).not.to.throw()
  
  it "should error when starting twice", ->
    start = -> database.init()
    
    expect(mongoose.connections[0]._readyState).to.eql(1)
    expect(start).to.throw()
  
  it "should stop cleanly", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).to.eql(0)
      done()
    
    stop  = -> database.stop end
    
    expect(mongoose.connections[0]._readyState).to.eql(1)
    expect(stop).not.to.throw()
  
  it "shouldn't error when starting after being stopped", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).to.eql(1)
      done()
    
    start = -> database.init end
    
    expect(mongoose.connections[0]._readyState).to.eql(0)
    expect(start).not.to.throw()
  
  it "should stop cleanly", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).to.eql(0)
      done()
    
    stop  = -> database.stop end
    
    expect(mongoose.connections[0]._readyState).to.eql(1)
    expect(stop).not.to.throw()



describe "Model", ->
  database = require '../../src/main/database'
  
  # beforeEach (done) ->
  #   database.init done
  #
  # afterEach ->
  #   database.stop()
  
  it "list should exist", ->
    expect(database.models).to.be.ok
  
  types = ["user", "authKey", "channel", "video"]
  
  testIsNull = (t) ->
    it "#{t} should be null", ->
      expect(database.models[t]).not.to.be.undefined
      expect(database.models[t]).to.be.null
  
  testIsNull t for t in types
  
  it "registration should not error", ->
    go = -> database.registerModels()
    
    expect(go).not.to.throw()
  
  testIsntNull = (t) ->
    it "#{t} shouldn't be null", ->
      expect(database.models[t]).to.be.ok
  
  testIsntNull t for t in types