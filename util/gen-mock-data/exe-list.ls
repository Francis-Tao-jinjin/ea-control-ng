casual = require 'casual'
fs = require 'fs'

config = require './config' .config

casual.define 'executionList', ->
  exe-list = 
    execution-id: config.id++
    execution-name: casual.random_element config.exes
    plan-name: casual.random_element config.plans
    box-name: '测试盒' + casual.integer(from=1, to=15)
    creator: casual.username
    status: casual.random_element config.exe-status
    start-time: new Date! - parseInt(2000000 * Math.random!)
    end-time: new Date! - parseInt(200000 * Math.random!)


!function gen-exe-list-fake
  exe-list = []
  if config.id is not 1 then config.id := 1
  for i from 1 to config.exe-count
    exe-list.push casual.execution-list

  result = 
    data: exe-list
    timestamp: new Date! - parseInt(190000 * Math.random!)
  
  data = JSON.stringify result

  fs.write-file '../../src/app/data/exe-list.json', data, (err) !->
    if err
      throw err
    else
      console.log '成功写入exe-list数据' 

gen-exe-list-fake!

