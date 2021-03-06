#!/usr/bin/env lsc -cj
author:
  name: ['Chen Hsin-Yi']
  email: 'ossug.hychen@gmail.com'
name: 'iclang'
description: 'Yet another coordination language for compositing things of internet.'
version: '0.0.1'
main: 'lib/index.js'
repository:
  type: 'git'
  url: 'git://github.com/hychen/iclang'
scripts:
  test: """
    npm run prepublish && mocha
  """
  prepublish: """
    lsc -cj package.ls &&
    lsc -bc -o lib src
  """
  # this is probably installing from git directly, no lib.  assuming dev
  postinstall: """
    if [ ! -e ./lib ]; then npm i LiveScript@1.2.x; lsc -bc -o lib src; fi
  """
engines: {node: '*'}
devDependencies:
  mocha: '2.2.x'
  chai: '1.10.x'
  'is-my-json-valid':'2.10.x'
  LiveScript: '1.3.x'
  uuid: '2.0.x'
  zmq: '2.10.x'
  mkdirp: '0.5.x'
