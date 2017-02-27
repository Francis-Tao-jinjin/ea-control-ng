casual = require 'casual'
fs = require 'fs'

config = require './config' .config

casual.define 'planInfo', ->
  plan-info = 
    plan-id: casual.integer(from=11111111, to=99999999)
    plan-name: casual.random_element config.plans
    creator: casual.username
    status: casual.random_element config.plan-status
    comment: '这是备注。。。'


!function gen-plan-info-fake
  result = 
    data: casual.plan-info
    timestamp: new Date! .get-time!

  data = JSON.stringify result
  fs.write-file '../../src/app/data/plan-info.json', data, (err) ->
    if err
      throw err
    else
      console.log '成功写入plan-info数据'


gen-plan-info-fake!

