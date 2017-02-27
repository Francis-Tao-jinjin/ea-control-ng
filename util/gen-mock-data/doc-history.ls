casual = require 'casual'
fs = require 'fs'

config = require './config' .config

casual.define 'docHistory', ->
    doc-history = 
        last-modified: new Date! - parseInt(2000000 * Math.random!)
        op-type: casual.random_element config.op-type
        reason: casual.random_element config.op-reason
        manager: "ea管理员" + casual.integer(from=1,to=10)
        last-submitted: new Date! - parseInt(2000000 * Math.random!)


!function gen-doc-history-fake
    doc-history = []
    if config.id is not 1 then config.id := 1
    for i from 1 to casual.integer(from=1, to=5)
        doc-history.push casual.doc-history

    result = 
        data: doc-history
        tiemstamp: new Date! - parseInt(2000000 * Math.random!)

    data = JSON.stringify result

    fs.write-file '../../src/app/data/doc-history.json', data, (err) !->
        if err
            throw err
        else
            console.log '成功写入doc-history数据'

gen-doc-history-fake!