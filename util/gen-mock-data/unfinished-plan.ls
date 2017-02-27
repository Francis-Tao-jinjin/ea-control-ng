casual = require 'casual'
fs = require 'fs'

config = require './config' .config

casual.define 'unfinishedPlan', ->
    unfinished-plan = 
        plan-name: casual.random_element config.plans
        company-name: casual.random_element config.company-name
        creator: "测试员" + casual.integer(from=1, to=15)
        last-modified: new Date! - parseInt(2000000 * Math.random!)
        op-type: casual.random_element config.op-type
        reason: casual.random_element config.op-reason

!function gen-unfinished-plan-fake
    unfinished-plan = []
    if config.id is not 1 then config.id := 1
    for i from 1 to casual.integer(from=1, to=10)
        unfinished-plan.push casual.unfinished-plan

    result = 
        data: unfinished-plan
        tiemstamp: new Date! - parseInt(2000000 * Math.random!)

    data = JSON.stringify result

    fs.write-file '../../src/app/data/unfinished-plan.json', data, (err) !->
        if err
            throw err
        else
            console.log '成功写入ea-unfinished-plan数据'

gen-unfinished-plan-fake!