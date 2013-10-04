assert = require 'assert'
async = require 'async'
_     = require 'underscore'
understream = require "#{__dirname}/../index"
_.mixin understream.exports()
Readable = require 'readable-stream'

describe 'custom mixins', ->
  it 'works', (done) ->
    myawt = require './myawt'
    understream.mixin myawt.MyAwesomeTransform, 'myawt'
    _([1,2,3]).stream().myawt({}).run (err, result) ->
      assert.ifError err
      assert.deepEqual result, [11, 12, 13]
      done()

describe 'use your favorite dominctarr streams', ->
  it 'works', (done) ->
    through = require 'through'
    understream.mixin through, 'through', true
    _([1,2,3]).stream().through((data) -> @push data+10).run (err, result) ->
      assert.ifError err
      assert.deepEqual result, [11, 12, 13]
      done()
