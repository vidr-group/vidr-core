describe "Database", ->
  database = require '../../src/main/database'
  mongoose = require 'mongoose'
  
  it "should exist", ->
    expect(database).toBeDefined()
    expect(database).not.toBeNull()
  
  it "shouldn't error on starting", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).toBe(1)
      done()
    
    start = -> database.init end
    
    expect(mongoose.connections[0]._readyState).toBe(0)
    expect(start).not.toThrow()
  
  it "should error when starting twice", ->
    start = -> database.init()
    
    expect(mongoose.connections[0]._readyState).toBe(1)
    expect(start).toThrow()
  
  it "should stop cleanly", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).toBe(0)
      done()
    
    stop  = -> database.stop end
    
    expect(mongoose.connections[0]._readyState).toBe(1)
    expect(stop).not.toThrow()
  
  it "shouldn't error when starting after being stopped", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).toBe(1)
      done()
    
    start = -> database.init end
    
    expect(mongoose.connections[0]._readyState).toBe(0)
    expect(start).not.toThrow()
  
  it "should stop cleanly", (done) ->
    end = ->
      expect(mongoose.connections[0]._readyState).toBe(0)
      done()
    
    stop  = -> database.stop end
    
    expect(mongoose.connections[0]._readyState).toBe(1)
    expect(stop).not.toThrow()



describe "Model", ->
  database = require '../../src/main/database'
  
  # beforeEach (done) ->
  #   database.init done
  #
  # afterEach ->
  #   database.stop()
  
  it "list should exist", ->
    expect(database.models).toBeDefined()
    expect(database.models).not.toBeNull()
  
  types = ["user", "authKey", "channel", "video"]
  
  testIsNull = (t) ->
    it "#{t} should be null", ->
      expect(database.models[t]).toBeDefined()
      expect(database.models[t]).toBeNull()
  
  testIsNull t for t in types
  
  it "registration should not error", ->
    go = -> database.registerModels()
    
    expect(go).not.toThrow()
  
  testIsntNull = (t) ->
    it "#{t} shouldn't be null", ->
      expect(database.models[t]).toBeDefined()
      expect(database.models[t]).not.toBeNull()
  
  testIsntNull t for t in types