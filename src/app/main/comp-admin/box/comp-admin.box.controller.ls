angular.module 'app.comp-admin.box'
.controller 'compAdminBoxController', comp-admin-box-controller

!function comp-admin-box-controller $scope,$mdDialog
	console.log 'hello comp-admin-box-controller'
	dtOptions = {
		dom       : '<"top"f>rt<"bottom"<"left"<"length"l>><"right"<"info"i><"pagination"p>>>',
		pagingType: 'simple',
		autoWidth : false,
		responsive: true
	}

	vm = this

	vm.dtOptions = dtOptions

	vm.boxes = [{
		boxName : '测试盒001',
		boxId : '001'
	},
	{
		boxName : '测试盒002',
		boxId : '002'
	},
	{
		boxName : '测试盒003',
		boxId : '003'
	},
	{
		boxName : '测试盒004',
		boxId : '004'
	},
	{
		boxName : '测试盒005',
		boxId : '005'
	},
	{
		boxName : '测试盒006',
		boxId : '006'
	},
	{
		boxName : '测试盒007',
		boxId : '007'
	},
	{
		boxName : '测试盒008',
		boxId : '008'
	},
	{
		boxName : '测试盒009',
		boxId : '009'
	},
	{
		boxName : '测试盒010',
		boxId : '010'
	}]


	vm.editBoxName = editBoxName

##############################################################
	!function editBoxName (index,ev)
		console.log index
		vm.operateIndex = index

		option = {
			controller: EditBoxController,
			templateUrl: 'app/main/comp-admin/box/comp-admin-edit.tmpl.html',
			parent: angular.element(document.body),
			scope: $scope.$new(),
			targetEvent: ev,
			clickOutsideToClose:false
		}

		$mdDialog
		.show option
		.then PreConnect!,AfterCancel!

		function PreConnect
			fnc = (msg) !->
				console.log 'at PreConnect'
				vm.status = 'You said the information was "' + 'msg' + '".'

		function AfterCancel
			fnc = !->
				console.log 'at AfterCancel'
				vm.status = 'You cancelled the creation.'
		#-----------------------------------------------------
		EditBoxController.$inject = ['$scope', '$mdDialog']
		!function EditBoxController $scope,$mdDialog
			$scope.boxName = vm.boxes[vm.operateIndex].boxName
			$scope.cancel = cancel
			$scope.commit = commit

			!function cancel
				console.log '点击了取消'
				$mdDialog.cancel!

			!function commit msg
				console.log '确认修改'

				vm.boxes[vm.operateIndex].boxName = $scope.boxName

				$mdDialog.hide msg

