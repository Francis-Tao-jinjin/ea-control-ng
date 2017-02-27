angular.module 'app.plan'
.controller 'PlanController' PlanController

PlanController.$inject = ['$state','$mdDialog','$window','$scope','idleBoxService','$rootScope','GetPlanFakeData']
!function PlanController $state, $mdDialog, $window, $scope, idleBoxService, $root-scope,GetPlanFakeData
	
	# console.log $root-scope.TheRootData

	# console.log 'enter plan-list'

	dtOptions = {
		dom       : '<"top"f>rt<"bottom"<"left"<"length"l>><"right"<"info"i><"pagination"p>>>',
		pagingType: 'simple',
		autoWidth : false,
		responsive: true
	}

	vm = this

	vm.userId = '李兕'
	vm.showCreateDialog = showCreateDialog
	vm.goCreateNewEx = goCreateNewEx
	vm.dtOptions = dtOptions
	vm.goToPlanDetail = goToPlanDetail
	vm.fetchReady = fetchReady
	vm.fetchWaiting = fetchWaiting
	vm.fetchOthers = fetchOthers
	vm.checkSelectedNav = checkSelectedNav
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
	
	vm.checkSelectedNav!

	!function fetchReady
		console.log 'fetchReady'
		vm.ReadyPlans = GetPlanFakeData.ReadyList
		console.log 'vm.ReadyPlans'
		console.log vm.ReadyPlans
		
		vm.ReadyPlans.forEach ((ele) !->
			console.log ele._id + ' ' + ele.planname
		)

	!function fetchWaiting
		console.log 'fetchWaiting'
		vm.WaitingPlans = GetPlanListSvc.getPlansList(1).query()

	!function fetchOthers
		console.log 'fetchOthers'
		vm.OthersPlans = GetPlanListSvc.getPlansList(1).query()


##############################################################
	!function goCreateNewEx (index,ev)
		console.log index
		vm.prepareExeIndex = index
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
			vm.currentState = 2
			vm.new-execution.plan.plan-name = vm.ReadyPlans[vm.prepareExeIndex].planname
			console.log vm.new-execution.plan.plan-name
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

			#$state.go 'app.exe-list.running'
####################################################################
	!function showCreateDialog (ev)
		option = {
			controller: MyDialogController,
			templateUrl: 'app/main/plan/list/plan.create.html',
			parent: angular.element(document.body),
			targetEvent: ev,
			clickOutsideToClose:false
		}
		$mdDialog
		.show option
		.then AfterOK!, AfterCancel!
		
		function AfterOK
			fnc = (msg) !->
				console.log 'at AfterOK'
				vm.status = 'You said the information was "' + 'msg' + '".'

		function AfterCancel
			fnc = !->
				console.log 'at AfterCancel'
				vm.status = 'You cancelled the creation.'
	#-----------------------------------------------------
	MyDialogController.$inject = ['$scope', '$mdDialog','GetPlanFakeData']
	!function MyDialogController $scope,$mdDialog,GetPlanFakeData
		plan-data = {
			planname: '',
			creator: '',
			file-name: '',
			comment: ''
		}

		$scope.cancel = cancel
		$scope.commit = commit
		$scope.plan-data = plan-data

		function isFormComplete
			if $scope.plan-data.plan-name is '' or $scope.plan-data.creator is '' or $scope.plan-data.file-name is '' or $scope.plan-data.comment is '' 
				$scope.alertMSG = '有未填写的数据'
				false 
			else 
				console.log $scope.plan-data
				$scope.alertMSG = ''
				true

		!function cancel
			$mdDialog.cancel!

		!function commit msg

			formData = new FormData document.getElementById 'new-plan-form'
			$scope.plan-data.file-name = (formData.get 'file').name

			GetPlanFakeData.ReadyList
			newItem = {
				_id: '00'+ GetPlanFakeData.ReadyList.length+1,
				assumeTime: 20+Math.round(Math.random()*20),
				creator: 	'李兕',
				comment: 	$scope.plan-data.comment,
				doc: 	[{
					filename: 	$scope.plan-data.file-name,
					url: 		'http://www.qcenglish.com/download.php?id=3675&site=1&filetype=pdf'
				}],
				docHistory: 	[{
					lastModify: GetPlanFakeData.getCurrentTime!,
					operate: 	'新建测试计划',
					reason: 	'',
					feedback: 	'暂无'
				}], 
				exeHistory: 	[{
					exename: 	'',
					box: 		'',
					operator: 	'',
					StartTime: 	'',
					type: 		''
				}],
				lastModify:	GetPlanFakeData.getCurrentTime!,
				planname: 	$scope.plan-data.planname,,
				script: {
					filename: 	'test_1.js',
					url: 		'https://code.jquery.com/jquery-3.1.1.min.js'	
				},
				type: 		1	
			}

			if isFormComplete!
				console.log '确认创建该计划' + msg
				console.log 'commit create'
				msg = $scope.plan-data
				console.log 'msg now is '
				console.log msg
				GetPlanFakeData.ReadyList.push newItem
				PostHandle!
				$mdDialog.hide msg

		function PostHandle
			console.log 'at PostHandle'
			vm.checkSelectedNav!
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	!function checkSelectedNav
		currentState = $state.current.name
		console.log $state.current.name
		switch currentState
		case 'app.plan-list.ready'
			console.log 'Need to fetch ready data'
			vm.fetchReady!
			vm.selectedNavItem = 'tableReady'
		case 'app.plan-list.waiting'
			console.log 'Need to fetch waiting data'
			vm.fetchWaiting!
			vm.selectedNavItem = 'tableWaiting'
		case 'app.plan-list.others'
			vm.selectedNavItem = 'tableOthers'
			vm.fetchOthers!
		default vm.selectedNavItem = 'tableReady'


	!function goToPlanDetail(planId)
		console.log 'Click and in function go to plandetails with id : '+ planId
		$state.go 'app.plan-details', {'planId': planId}
