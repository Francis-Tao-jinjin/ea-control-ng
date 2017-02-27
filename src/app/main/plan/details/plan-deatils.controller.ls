angular.module 'app.plan'
.controller 'PlanDeatilsController' PlanDeatilsController

PlanDeatilsController.$inject = ['$scope','$mdDialog','$state','$stateParams','$window','GetPlanDetailsSvc','idleBoxService','GetPlanFakeData','$rootScope']
!function PlanDeatilsController $scope,$mdDialog,$state,$stateParams,$window,GetPlanDetailsSvc,idleBoxService,GetPlanFakeData,$root-scope
	vm = this
	vm.fetchLatestData = fetchLatestData
	vm.goCreateNewEx = goCreateNewEx
	vm.showEaBoardPin = showEaBoardPin
	vm.editPlan = editPlan
	vm.userId = '李兕'
	vm.thePlan
	vm.docInfo
	vm.scriptInfo
	vm.docHistory
	vm.exeHistory
	vm.pickInfoData = pickInfoData
	vm.currentState = 2
	vm.new-execution = {
		name:''
		box: {
			box-id:''
			box-name:''
		}
		plan: {
			plan-id:''
			plan-name:''
			script-url:''
		}
		user:''
		comment:''
	}

	vm.planId = $stateParams['planId']
	console.log 'plan id is ' + vm.planId
	
	vm.fetchLatestData!
	
	!function fetchLatestData
		console.log 'at fetchLatestData'
		item = (GetPlanFakeData.getPlanById vm.planId)
		vm.thePlan = item[0]
		console.log vm.thePlan
		pickInfoData!

	!function pickInfoData
		vm.docInfo = vm.thePlan.doc
		vm.docHistory = vm.thePlan.docHistory
		vm.scriptInfo = vm.thePlan.script
		vm.exeHistory = vm.thePlan.exeHistory
		console.log vm.docInfo
		console.log vm.docHistory
		console.log vm.scriptInfo
		console.log vm.exeHistory


	@.details = 'This is details page'
##############################################################
	!function goCreateNewEx (ev)
		vm.start = false

		idleBoxService.get-idle-box-list()
		.then (result) !->
			vm.boxes = result.data

		option = {
			controller: CreateExController,
			templateUrl: 'app/main/execution/new-exe/new-execution.tmpl.html',
			parent: angular.element(document.body),
			scope: $scope.$new(),
			targetEvent: ev,
			clickOutsideToClose:false,
			closeTo: {
				top: $window.innerHeight/2,
				left:-100,
				width: 30,
				height: 80
			}
		}

		$mdDialog
		.show option
		.then PreConnect!#, AfterCancel!

		function PreConnect
			fnc = (msg) !->
				console.log 'at PreConnect'
				vm.status = 'You said the information was "' + 'msg' + '".'
				vm.showEaBoardPin!

		function AfterCancel
			fnc = !->
				console.log 'at goCreateNewEx.AfterCancel'
				vm.status = 'You cancelled the creation.'
		#-----------------------------------------------------
		CreateExController.$inject = ['$scope', '$mdDialog']
		!function CreateExController $scope,$mdDialog
			vm.new-execution.plan.plan-name = vm.thePlan.planname
			vm.currentState = 2
			$scope.cancel = cancel
			$scope.answer = commit

			!function ping box
				console.log 'ping function' 

			!function cancel
				$mdDialog.cancel!

			!function commit msg
				console.log '确认创建该计划' + msg
				msg = vm.new-execution
				console.log 'msg now is '
				console.log msg
				$mdDialog.hide msg
##############################################################
	!function showEaBoardPin (ev)
		option = {
			controller: ShowPinController,
			templateUrl: 'app/main/execution/new-exe/new-execution-circuit.tmpl.html',
			parent: angular.element(document.body),
			targetEvent: ev,
			clickOutsideToClose:false,
			closeTo: {
				top: $window.innerHeight/2,
				left:-100,
				width: 30,
				height: 80
			}
		}
		$mdDialog
		.show option
		.then ConfirmConnect!, AfterCancel!

		function ConfirmConnect
			fnc = (msg) !->
				console.log 'at ConfirmConnect'
				vm.status = 'You said the information was "' + 'msg' + '".'

		function AfterCancel
			fnc = !->
				console.log 'at showEaBoardPin.AfterCancel'
				vm.status = 'You cancelled the creation.'
	#-----------------------------------------------------
	ShowPinController.$inject = ['$scope', '$state', '$mdDialog','circuitService','newExeService','genCircuitPicture']
	!function ShowPinController $scope,$state,$mdDialog,circuit-service,new-exe-service,genCircuitPicture
		
		$scope.execute-button = "确认完成接线"
		
		circuit-service.get-pins(vm.new-execution.plan.plan-id) 
		.then (result) ->
			vm.pin-info = result.data
			vm.circuit-config = {
				font-size: 18,
				y-start: 80,
				height: 150,
				line-length: 45
			}
			gen-circuit-picture.init vm.pin-info, vm.circuit-config, 2

		$scope.cancel = cancel
		$scope.startExecution = startExecution

		!function goToExecutionDetail(index)
			console.log 'Click and in function go to execution details #index'
			$state.go 'app.exe-detail', index

		!function cancel
			$mdDialog.cancel!

		!function startExecution msg
			console.log '确认创建该计划' + msg
			msg = vm.new-execution

			$scope.execute-button = "请在测试盒上确认开始执行"
			#收到开始执行的消息
			if vm.start == true
				console.log '收到测试盒开始执行消息-》创建执行-》收到exeid'
				#创建执行, 获得exeId, 去执行详细页面
				console.log 'msg now is '
				console.log msg
				$mdDialog.hide msg
				new-exe-service.new-execution(vm.new-execution)
				goToExecutionDetail vm.new-execution.plan.plan-id
			else
				vm.start = true

#########################################################
	!function editPlan(ev)
		option = {
			controller: EditPlanController,
			templateUrl: 'app/main/plan/details/edit-plan-tmpl.html',
			parent: angular.element(document.body),
			targetEvent: ev,
			scope: $scope.$new(),
			clickOutsideToClose:false
		}
		$mdDialog.show option .then AfterOK!, AfterCancel!
		
		function AfterOK
			fnc = (msg) !->
				console.log 'at AfterOK'
				vm.status = 'You said the information was "' + 'msg' + '".'

		function AfterCancel
			fnc = !->
				console.log 'at AfterCancel'
				vm.status = 'You cancelled the creation.'

	#-----------------------------------------------------
	EditPlanController.$inject = ['$scope', '$mdDialog','GetPlanFakeData']
	!function EditPlanController $scope,$mdDialog,GetPlanFakeData
		planData = {
			newDoc : {
				filename: '',
				url: ''
			}
			reason: ''
		}

		$scope.cancel = cancel
		$scope.commit = commit
		$scope.planData = planData

		!function cancel
			$mdDialog.cancel!

		!function commit msg
			formData = new FormData document.getElementById 'edit-plan-form'
			doc = []
			($ 'input[name=\'docToDel\']:checked').each (!-> doc.push @value )
			$scope.planData.newDoc.filename = (formData.get 'file').name

			if($scope.planData.newDoc.filename)
				$scope.planData.newDoc.url = GetPlanFakeData.getRandomDocUrl!

			result = GetPlanFakeData.UpdateDocData doc,vm.planId,$scope.planData
			vm.thePlan = result[0]
			console.log '返回的Plan值'
			console.log vm.thePlan
			vm.pickInfoData!
			$mdDialog.hide 'close edit dialog'
		
		function PostHandle
			console.log 'at PostHandle'	
			vm.fetchLatestData!
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

