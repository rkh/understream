assert = require 'assert'
async  = require 'async'
_      = require 'underscore'
_.mixin require("#{__dirname}/../index").exports()
sinon  = require 'sinon'
stream = require 'stream'
util = require 'util'

describe '_.reduce', ->
  it 'works on numbers', (done) ->
    _([1, 2, 3]).stream().reduce({fn: ((a,b) -> a + b), base: 0}).value (data) ->
      assert.deepEqual data, [6]
      done()
    .run assert.ifError

  it 'works on objects', (done) ->
    _([{a: 1, b: 2}, {a: 1, b: 3}, {a: 1, b: 4}]).stream().reduce(
      base: {}
      fn: (obj, new_obj) ->
        obj = { a: new_obj.a, b: [] } unless obj.b?
        obj.b.push new_obj.b
        obj
    ).value (data) ->
      assert.deepEqual data, [{ a: 1, b: [2,3,4] }]
      done()
    .run assert.ifError