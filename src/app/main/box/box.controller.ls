'use strict'
angular.module 'app.box'
.controller 'boxListController', box-list-controller

/** @ngInject **/
!function box-list-controller $root-scope, $state, new-execution-data, box-service
  vm = @

  console.log 'box controller'
  vm.current-box-list = $state.current.name.split('.')[2] + 'List'
  $root-scope.$on '$stateChangeStart', (event, to-state, from-state) !->
    console.log 'to-state: ', to-state.name
    switch to-state.name
    case 'app.box.busy'  then vm.current-box-list = 'busyList'
    case 'app.box.idle'  then vm.current-box-list = 'idleList'
    case 'app.box.all'   then vm.current-box-list = 'allList'
    default then vm.current-box-list = 'busyList'

  # 获取所有测试盒
  box-service.retrieve-box-list(1)
    .then (result) ->
      vm.boxes = result.data
      vm.timestamp  = result.timestamp

  vm.new-execution = (box)!->
    console.log "new-exe,box"
    newExecutionData.type = 1
    newExecutionData.data.box.id = box.box-id
    newExecutionData.data.box.name = box.box-name
    console.log  "new-exe", new-execution-data 
    console.log 'go to new exe'
    $state.go 'app.new-exe'
