angular.module 'app.box'

  .filter 'findIdleBox', ->
    (boxes) ->
      if boxes instanceof Array is false then return
      out = []
      for box in boxes
        if box.boxStatus == 'idle'
          out.push box

      out

  .filter 'findBusyBox', ->
    (boxes) ->
      if boxes instanceof Array is false then return
      result = []
      for box in boxes
        if box.boxStatus == 'busy' && box.executionStatus != null
          result.push box

      result

