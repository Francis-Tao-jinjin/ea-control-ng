angular.module 'fuse'

.factory 'genCircuitPicture', ->
  
  d-pins: null
  config: null
  ctx: null


  /**
   * @brief     init(generate) circuit or ATS borad picture
   * 
   * @param     [array]   pin information
   * @param     [object]  canvas configuration
   * @param     [number]  1 for circuit board | 2 for ATS board
   *
   */
  init: (pins, config, type) !->
    @d-pins = @divide-pins pins

    pic-config = @generate-x-ordinate!
    @config = Object.assign config, pic-config
    @ctx = document.get-element-by-id('canvas').get-context('2d');
    window.onload = !->
      alert('load')
    @ctx.font = @config.font-size + 'px Arial'

    console.log '@config: ', @config
    if type is 1
      @draw-circuit-pic @ctx, @config
    else
      @draw-ATS-pic @ctx, @config



  /**
   * @brief       fill and display pin data on picture
   *
   * @param       [array]   pin data array
   *
   */
  fill-data: (data) ->
    if !@config or !@ctx or !@d-pins
      console.log '抽象图未初始化'

    arr = @config.t-coor.concat @config.b-coor
    coor = arr.find (item) -> item.pin === data.pin

    if !coor
      console.log '找不到' + data.pin + '引脚'
      return

    if data.pin[0] == 'D' then text = coor.unit[data.value]
    else text = data.value + coor.unit

    if coor.type is 1
      x = coor.x + @config.x-start - @config.font-size / 2
    else
      x = coor.x + @config.x-start - @config.font-size

    if coor.mode is 1
      y = @config.y-start - (@config.line-length / 2 + @config.font-size * 0.5)
    else
      y = @config.y-start + @config.height + @config.line-length / 2 + @config.font-size * 1.5

    @ctx.fill-text text, x, y



  /**
   * @brief       automatically calculate and generate x ordinate of both top and bottom direction pins
   *
   * @return      [object]  x ordinate array of top and bottom pins and some caculated configuration of pic
   */
  generate-x-ordinate: ->

    in-pins-num = @d-pins.in-pins.length
    out-pins-num = @d-pins.outPins.length
    pins = if in-pins-num > out-pins-num then in-pins-num else out-pins-num
    pic-length = pins * 200

    if pic-length > 1000 then pic-length = 1000
    if pic-length < 600 then pic-length = 600

    top-interval = pic-length / in-pins-num
    btm-interval = pic-length / out-pins-num
    tx-start-point = top-interval / 2
    bx-start-point = btm-interval / 2


    @d-pins.in-pins.for-each (ele, index, arr) !->
      arr[index].x = tx-start-point + index * top-interval

    @d-pins.out-pins.for-each (ele, index, arr) !->
      arr[index].x = bx-start-point + index * btm-interval

    t-coor = @d-pins.in-pins
    b-coor = @d-pins.out-pins

    x-start = (1000 - pic-length) / 2

    config = { pic-length, top-interval, btm-interval, t-coor, b-coor, x-start }



  /**
   * @brief      generate coordinate of start and end point of every pin line
   *
   * @return     [object]   every pin line's "from" and "to" coordinates seperated as top and bottom arrays
   */
  generate-line-coordinate: ->
    result = 
      top-line-coor: [],
      btm-line-coor: []

    for item in @config.t-coor
      top-draw =
        from:
          x: @config.x-start + item.x
          y: @config.y-start - @config.line-length / 2

        to:
          x: @config.x-start + item.x
          y: @config.y-start + @config.line-length / 2

      result.top-line-coor.push top-draw

    for item in @config.b-coor
      btm-draw =
        from:
          x: @config.x-start + item.x,
          y: @config.y-start + @config.height - @config.line-length / 2

        to:
          x: @config.x-start + item.x,
          y: @config.y-start + @config.height + @config.line-length / 2

      result.btm-line-coor.push btm-draw

    result



  /**
   * @brief      Draws an ats picture.
   */
  draw-ATS-pic: !->
    @ctx.stroke-rect @config.x-start, @config.y-start, @config.picLength, @config.height
    pin-line-coor = @generate-line-coordinate!
    console.log 'ATS-pic', @config
    for item,index in pin-line-coor.top-line-coor
      @draw-pin-line @ctx, item.from, item.to
      @fill-text @ctx, item,
        @config.t-coor[index].name,
        @config.t-coor[index].pin,
        @config.font-size, 'top', 2

    for item,index in pin-line-coor.btm-line-coor
      @draw-pin-line @ctx, item.from, item.to
      @fill-text @ctx, item,
        @config.b-coor[index].pin,
        @config.b-coor[index].name,
        @config.font-size, 'bottom', 2



  /**
   * @brief      Draws a circuit picture.
   */
  draw-circuit-pic: !->
  
    @ctx.stroke-rect @config.x-start, @config.y-start, @config.picLength, @config.height

    pin-line-coor = @generate-line-coordinate!

    for item,index in pin-line-coor.top-line-coor

      @draw-pin-line @ctx, item.from, item.to

      @fill-text @ctx, item, '',
        @config.t-coor[index].name, @config.font-size, 'top', 1

      
    for item,index in pin-line-coor.btm-line-coor
      @draw-pin-line @ctx, item.from, item.to

      @fill-text @ctx, item,
        @config.b-coor[index].name, '', @config.font-size, 'bottom', 1



  /**
   * @brief      divide pin into input and output (top and bottom direction) group
   *
   * @return     [object]   input and output pin arrays
   */
  divide-pins: (pins) ->
    result =
      in-pins: []
      outPins: []
    for pin in pins
      if pin.mode is 1
        result.in-pins.push pin
      else
        result.outPins.push pin 

    result


  /**
   * @brief      Calculates the word number in a string
   * 
   * @param      [string]   str you want to calculate
   *
   * @return     The number
   */
  calculate-word-number: (words) ->
    num = words.split '' .length



  /**
   * @brief      Draws a pin line.
   * 
   * @param      [object]   canvas dom
   * @param      [object]   coordinate of pin line's start point
   * @param      [object]   coordinate of pin line's end point
   *
   */
  draw-pin-line: (ctx, from, to) ->
    ctx.move-to from.x, from.y 
    ctx.line-to to.x, to.y
    ctx.stroke!
  


  /**
   * @brief      put text into right place of correct pin line relate to pin information
   *  
   * @param      [object]   canvas dom
   * @param      [object]   coordinate of start and end point of pin line
   * @param      [string]   start point text content
   * @param      [string]   end point text content
   * @param      [number]   text font size
   * @param      [string]   "top" for top dierction | "bottom" for bottom direction
   * @param      [number]   1 for digital signal | 2 for analogue signal
   *  
   */
  fill-text: (ctx, pin-line-coor, from-text, to-text, font-size, direc, type) !->
    n1 = @calculate-word-number from-text
    n2 = @calculate-word-number to-text
    if type is 1
      if direc is 'top'
        ctx.fill-text from-text,
          pin-line-coor.from.x - font-size * n1 / 2,
          pin-line-coor.from.y - font-size * 0.5
        ctx.fill-text to-text,
          pin-line-coor.to.x - font-size * n2 / 2,
          pin-line-coor.to.y + font-size * 1.5
      else
        ctx.fill-text from-text, 
          pin-line-coor.from.x - font-size * n1 / 2,
          pin-line-coor.from.y - font-size * 0.5
        ctx.fill-text to-text,
          pin-line-coor.to.x - font-size * n2 / 2,
          pin-line-coor.to.y + font-size * 1.5
    else
      if direc is 'top'
        ctx.fill-text from-text,
          pin-line-coor.from.x - font-size * n1 / 2,
          pin-line-coor.from.y - font-size * 0.5
        ctx.fill-text to-text,
          pin-line-coor.to.x - font-size * n2 / 3,
          pin-line-coor.to.y + font-size * 1.5
      else
        ctx.fill-text from-text, 
          pin-line-coor.from.x - font-size * n1 / 3,
          pin-line-coor.from.y - font-size * 0.5
        ctx.fill-text to-text,
          pin-line-coor.to.x - font-size * n2 / 2,
          pin-line-coor.to.y + font-size * 1.5

.factory 'newExecutionData', ->
  
  type:1  #1选定盒子，2选定测试计划
  # 新测试执行数据
  data: {
      name:''
      box: {
        id:''
        name:''
      }
      plan: {
        id:''
        name:''
        script-url:''
      }
      user:''
      comment:''
  }

  circuit-config: {
    font-size: 18,
    y-start: 80,
    height: 150,
    line-length: 45
  }
