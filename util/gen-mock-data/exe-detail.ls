casual = require 'casual'
fs = require 'fs'

config = require './config' .config

casual.define 'stepInfo', ->
  step-id: config.id++
  step-name: casual.random_element config.steps
  estimated-time: casual.integer(from=100, to=2000)

casual.define 'pinInfo', ->
  t-type = casual.random_element([1,2])
  if t-type is 1
    pin: casual.random_element(config.d-pins)
    name: casual.random_element(config.d-pin-names)
    type: t-type
    unit: casual.random_element(config.d-units)
  else
    pin: casual.random_element(config.a-pins)
    name: casual.random_element(config.a-pin-names)
    type: t-type
    unit: casual.random_element(config.a-units)

gen-step-info = ->
  result = []
  if config.id is not 1 then config.id = 1
  for i from 1 to config.step-count
    result.push casual.step-info
  result

gen-pin-info = ->
  result = []
  for i from 1 to 5
    result.push casual.pin-info
  result

casual.define 'pinData', ->
  t-pin = casual.random_element config.pins
  if t-pin[0] is 'D'
    pin: casual.random_element config.d-pins
    name: casual.random_element config.d-pin-names
    time: new Date! - parseInt(2000000 * Math.random!)
    value: casual.boolean
  else
    pin: casual.random_element config.a-pins
    name: casual.random_element config.a-pin-names
    time: new Date! - parseInt(2000000 * Math.random!)
    value: casual.integer(from=3, to=40)

gen-pin-data = ->
  result = []
  for i from 1 to 20
    result.push casual.pin-data
  result

gen-exe-detail = ->
  result = []
  if config.id is not 1 then config.id = 1
  for i from 1 to config.step-count - 3
    result.push casual.exe-detail
  result

casual.define 'exeDetail', ->
  step-id: config.id++
  step-name: casual.random_element config.steps
  time-used: casual.integer(from=23, to=100)
  reason: casual.random_element config.reasons
  status: casual.random_element config.step-status
  pin-data: gen-pin-data!


casual.define 'executionDetail', ->
  exe-detail = 
    execution-id: casual.integer(from=1, to=25)
    execution-name: casual.random_element config.exes
    plan-name: casual.random_element config.plans
    box-name: '测试盒' + casual.integer(from=1, to=15)
    creator: casual.username
    status: casual.random_element config.exe-status
    start-time: new Date! - parseInt(2000000 * Math.random!)
    end-time: new Date! - parseInt(200000 * Math.random!)
    exe-detail: gen-exe-detail!
    plan: 
      steps: gen-step-info!
      pins: gen-pin-info!

gen-execution-detail-fake = !->
  result = 
    data: execution-detail = casual.executionDetail
    timestamp: new Date! - parseInt(190000 * Math.random!)

  data = JSON.stringify result
  fs.write-file '../../src/app/data/exe-detail.json', data, (err) !->
    if err
      throw err
    else
      console.log '成功写入exe-detail数据'


gen-execution-detail-fake!
