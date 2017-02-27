angular.module 'app.execution.new'
.controller 'newExecutionController', new-execution-controller

!function new-execution-controller $state, $scope, $md-dialog, new-execution-data, gen-circuit-picture, 
idle-box-service, complete-plan-service, circuit-service, new-exe-service 
  vm = @
  console.log 'new-exe-1', new-execution-data

  vm.start = false
  vm.type = new-execution-data.type
  vm.plan-name = ''
  vm.box-name = ''

  if vm.type == 1
    vm.box-name = new-execution-data.data.box.name
    
    #获取所有可执行测试计划的名字和id
    complete-plan-service.get-complete-plan-name-id()
    .then (result) ->
      vm.complete-plans = result.data
  else
    vm.plan-name = new-execution-data.data.plan.name
    
    #获取所有闲置测试盒的名字和id
    idle-box-service.get-idle-box-name-id()
    .then (result) ->
      vm.idle-boxes = result.data
   
  # 填写信息完成，获取接线图
  vm.get-circuit-pic = !->
    new-execution-data.data.name = vm.execution-name
    new-execution-data.data.comment = vm.execution-comment
    if vm.type == 1
        new-execution-data.data.plan.id = vm.selectedPlan.plan-id
        new-execution-data.data.plan.name = vm.selectedPlan.plan-name
        new-execution-data.data.plan.script-url = vm.selectedPlan.script-url
    else
        new-execution-data.data.box.id = vm.selectedBox.box-id
        new-execution-data.data.box.name = vm.selectedBox.box-name
   
    $md-dialog.show ({
      controller: dialog-controller-circuit
      scope: $scope.$new()
      template-url: 'app/main/execution/new-exe/new-execution-circuit.tmpl.html'
      parent: angular.element document.body
      fullscreen: $scope.custom-fullscreen
    })
    
    !function dialog-controller-circuit $scope,$md-dialog
      $scope.execute-button = "确认完成接线"  
      $scope.plan-name = new-execution-data.data.plan.name

      #获取planid对应的引脚信息
      circuit-service.get-pins(new-execution-data.data.plan.id) 
      .then (result) ->
        vm.pin-info = result.data
        console.log 'pin-info', vm.pin-info
        gen-circuit-picture.init vm.pin-info, new-execution-data.circuit-config, 2

      $scope.hide = !->
        $md-dialog.hide()
      $scope.cancel = !->
        $md-dialog.cancel()
      $scope.answer = (answer) !->
        $md-dialog.hide(answer)

      $scope.start-execution = !->
        console.log 'wait to start'
        $scope.execute-button = "请在测试盒上确认开始执行"
        #收到开始执行的消息
        if vm.start == true
          console.log '收到测试盒开始执行消息-》创建执行-》收到exeid'
          #创建执行
          #获得exeId
          #去执行详细页面
          new-exe-service.new-execution(new-execution-data.data)
          go-to-execution-detail new-execution-data.data.plan.id
        else vm.start = true

    !function goToExecutionDetail(index)
      console.log 'Click and in function go to execution details #index'
      $state.go 'app.exe-detail', index
