angular.module 'app.execution.detail'
  
  .controller 'ExecutionDetailController', ExecutionDetailController

!function ExecutionDetailController gen-circuit-picture, execution-service, $state-params, gen-wave-form

  vm = @

  execution-service.retrieve-execution-detail $state-params.exe-id
    .then (result) ->

      # 拼装数据
      vm := Object.assign vm, seperate-api-data(vm, result.data)

      # 生成line chart
      vm.wave-data = gen-wave-form.init vm.pin-info, vm.pin-data
      
      # 生成电控板抽象图
      gen-circuit-picture.init vm.pin-info, vm.circuit-config, 1


      # 插入电控板抽象图数据
      socket-data = {
        pin: 'DI1',
        name: '进水阀',
        value: false
      };
      socket-data1 = {
        pin: 'AO1',
        name: '温度',
        value: '34'
      };
      gen-circuit-picture.fill-data socket-data
      gen-circuit-picture.fill-data socket-data1

  # line chart 配置
  vm.wave-options = 
    chart:
      type: "lineWithFocusChart"
      height: 450
      margin:
        top: 20
        right: 20
        bottom: 60
        left: 40
      duration: 100
      useInteractiveGuideline: true
      xAxis:
        axisLabel: '时间',
        tickFormat: (d) -> d3.time.format('%H:%M/%d')(new Date(d))
      x: (d) -> d.x
      y: (d) -> d.y
      x2Axis:
        axisLabel: '时间',
        tickFormat: (d) -> d3.time.format('%H:%M/%d')(new Date(d))

  # 电控板抽象图 配置
  vm.circuit-config = {
    font-size: 18,
    y-start: 80,
    height: 150,
    line-length: 45
  };


function gen-step-detail exe-data, step-info
  result = []
  for step, index in step-info
    tmp = {}
    tmp{ step-id, step-name, estimated-time } = step
    if index + 1 <= exe-data.length
      tmp{ time-used, status, reason } = exe-data[index]
    else
      tmp.status = 'pending'
    result.push tmp
  result


function seperate-api-data vm, data 
  vm.basic = {}
  vm.basic{
    execution-id,
    execution-name,
    plan-name,
    box-name, 
    creator, 
    status, 
    start-time, 
    end-time
  } = data
  vm.step-info = data.plan.steps
  vm.pin-info = data.plan.pins
  vm.timestamp = data.timestamp
  vm.exe-detail = data.exe-detail
  vm.step-detail = gen-step-detail data.exe-detail, vm.step-info

  if data.status is 'active'
    vm.basic.left-duration = data.end-time - vm.timestamp
    vm.basic.run-duration = vm.timestamp - data.start-time

  vm.pin-data = []
  for details in data.exe-detail
    for detail in details.pin-data
      vm.pin-data.push detail

  vm.pin-data.sort (a, b) -> a.time - b.time


  vm





