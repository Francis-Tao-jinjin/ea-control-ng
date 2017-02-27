angular.module 'app.execution.list'

  .controller 'ExecutionListController', Execution-list-controller

/** @ngInject **/
!function Execution-list-controller $root-scope, $state, execution-service

  vm = @
  current-state = $state.current.name
  # 切换选中的tab
  vm.current-nav-item = current-state.split('.')[2]
  $root-scope.$on '$stateChangeStart', (event, to-state, from-state) !->
    switch to-state.name
    case 'app.exe-list.active'   then vm.current-nav-item = 'active'
    case 'app.exe-list.finished'  then vm.current-nav-item = 'finished'
    case 'app.exe-list.all'       then vm.current-nav-item = 'all'
    default then vm.current-nav-item = 'active'


  # dataTable option
  vm.dt-options =
    dom         : '<"top"f>rt<"bottom"<"left"<"length"l>><"right"<"info"i><"pagination"p>>>'      
    paging-type : 'simple'
    auto-width  : false
    responsive  : true


  # 按不同state进行API操作
  if current-state == 'app.exe-list.all'            then param = 3
  else if current-state == 'app.exe-list.finished'  then param = 2
  else if current-state == 'app.exe-list.active'   then param = 1


  execution-service.retrieve-execution-list param
    .then (result) -> 
      vm.executions = result.data
      vm.timestamp  = result.timestamp



  