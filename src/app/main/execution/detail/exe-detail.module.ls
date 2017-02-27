angular.module 'app.execution.detail', []
  
.config ($state-provider) !->

  $state-provider
  .state 'app.exe-detail', {
    url: '/exe-detail/:exeId'
    views: 
      'content@app':
        template-url: 'app/main/execution/detail/exe-detail.html'
        controller: 'ExecutionDetailController as vm'
  }


.factory 'genWaveForm', ->

  config: {}
  line-data: {}

  init: (pin-info, pin-data) ->
    @init-config pin-info
    @fill-data pin-data
    @gen!

  update-data: (data) ->
    @fill-data [data]

  init-config: (pin-info) ->
    console.log 'pin-info: ', pin-info
    for item in pin-info
      @config[item.pin] = {}
      @config[item.pin]{name, unit, type, mode} = item

      @line-data[item.pin] = []

  fill-data: (pin-data) ->
    for data in pin-data
      x = data.time
      y = Number data.value
      @line-data[data.pin].push {x, y}

      # 实现折现效果
      for key,value of @line-data
        if key is not data.pin and value.length is not 0 and key[0] is 'D'
          value.push {x: x, y: value[value.length - 1].y}

  dynamic-y-scale: (data) ->
    svg = d3.select '#waveform'
    console.log 'svg:', svg
    y-scale = d3.scale.ordinal!
    y-scale.domain([-2, d3.max(data, (d) -> d.y) + 3])
    y-axis = d3.svg.axis! .scale(y-scale)

  gen: ->
    result = []
    console.log '@config: ', @config
    for key,value of @config
      tmp = {}
      if value.type is 2
        tmp = 
          values: @line-data[key]
          key: value.name + '('+ value.unit + ')'
      else
        tmp = 
          values: @line-data[key]
          key: value.name + '(' + value.unit.true + '/' + value.unit.false + ')'
          # area: true
          # y-domain: [-1, 2]
      result.push tmp

    result
