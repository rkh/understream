{Transform} = require 'readable-stream'
_      = require 'underscore'
debug  = require('debug') 'us:invoke'

# TODO: support args (might be different than underscore API due to arg length logic in lib/understream)
class Invoke extends Transform
  constructor: (@stream_opts, @method) ->
    super @stream_opts
  _transform: (chunk, encoding, cb) =>
    cb null, chunk[@method].apply(chunk)

module.exports = (Understream) ->
  Understream.mixin Invoke, 'invoke'
