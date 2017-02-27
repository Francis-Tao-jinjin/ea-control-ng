angular.module 'fuse'

  .filter 'duration', ->
    (dur, unit) ->
      if unit is 's'
        dur = dur * 1000
      obj = moment.duration dur
      result = ''
      if (y = obj.years!) >= 1   then result += y + '年'
      if (m = obj.months!) >= 1  then result += m + '月'
      if (d = obj.days!) >= 1    then result += d + '天'
      if (h = obj.hours!) >= 1   then result += h + '时'
      if (M = obj.minutes!) >= 1 then result += M + '分'
      if (s = obj.seconds!) >= 1 then result += s + '秒'
      result

  .filter 'humanize', ->
    (timestamp) ->
      t = moment timestamp
      result = t.year! + '年' + (t.month!+1) + '月' + t.date! + '日 ' + t.hour! + '点' + t.minute! + '分' + t.second! + '秒'

  .filter 'transformStatus', ->
    (status) ->
      result = ''
      if status is 'active'
        result = '进行中'
      else if status is 'pass'
        result = '通过'
      else if status is 'fail'
        result = '失败'
      else
        result = status
      result