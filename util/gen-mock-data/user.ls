casual = require 'casual'
fs = require 'fs'
config = require './config' .config

casual.define 'user', ->
  fname = casual.first_name
  user = 
    user-id: casual.unix_time.toString!
    username: fname
    fullname: fname + ' ' + casual.last_name
    password: '12345678'
    company-id: 1
    role: casual.random_element config.roles
    create-time: new Date! .getTime!
    is-online: casual.boolean
    email: casual.email

!function gen-user-fake
  users = []
  for i from 0 to 9
    users.push casual.user

  data = JSON.stringify users

  fs.write-file '../../src/app/data/user.json', data, (err) !->
    if err then throw err

    else console.log '成功写入user数据'

gen-user-fake!