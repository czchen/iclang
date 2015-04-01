require! zmq
require! uuid

{conf} = require '../lib/config'

RUNTIME_SOCKETS_DIR = conf.get 'RUNTIME_SOCKETS_DIR'

export class Socket 

  (direction, port) ->
    @id = uuid.v4!
    @name = port.name
    @direction = direction
    @addr = null
    @sock = null
    @connected = false

    switch direction
      | 'in' => 
        @sock = zmq.socket 'pull'
      | 'out' => 
        @sock = zmq.socket 'push'
        @addr = "ipc://#{RUNTIME_SOCKETS_DIR}/#{@id}"
        @sock.bindSync @addr
      | _ => throw new Error 'invalid direction'

  is-connected: ->
    @connected == true

  connect: -> 
    @connected = true
    @sock.connect it

  disconnect: ->
    @connected = false

  close: ->
    @sock.close!

  send: (data) ->
    if @direction is 'out'
      @sock.send JSON.stringify data
    else 
      throw new Error 'try to send data on in socket.'

  on: (event-name, handler) ->
    @sock.on event-name, (msg) -> 
      data = JSON.parse msg
      handler data
