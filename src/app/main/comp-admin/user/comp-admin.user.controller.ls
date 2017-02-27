angular.module 'app.comp-admin.user'
.controller 'compAdminUserController', comp-admin-user-controller
compAdminUserController.$inject = ['$scope', '$mdDialog']
!function comp-admin-user-controller $scope,$mdDialog
	console.log 'hello comp-admin-user-controller'
	dtOptions = {
		dom       : '<"top"f>rt<"bottom"<"left"<"length"l>><"right"<"info"i><"pagination"p>>>',
		pagingType: 'simple',
		autoWidth : false,
		responsive: true
	}

	vm = this
	vm.dtOptions = dtOptions
	vm.people = [{
		name : '纳特',
		userName : 'Knut',
		createdTime : '2016-10-13-下午4:45:23'
	},{
		name : '西可',
		userName : 'Sickle',
		createdTime : '2016-10-13-下午4:35:45'
	},{
		name : '加隆',
		userName : 'Galleon',
		createdTime : '2016-10-13-下午4:33:28'
	},{
		name : '节墨',
		userName : 'JieMeo',
		createdTime : '2016-10-13-下午4:30:10'
	}]

	vm.deletePerson = deletePerson
	vm.showAddDialog = showAddDialog

	!function deletePerson index
		vm.people.splice(index,1)

################################################
	!function showAddDialog(ev)
		vm.StaffNumber = [0]
		vm.count = 0
		option = {
			controller: AddStaffController,
			templateUrl: 'app/main/comp-admin/user/comp-admin-create.tmpl.html',
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
	AddStaffController.$inject = ['$scope', '$mdDialog']
	!function AddStaffController $scope,$mdDialog
		
		$scope.cancel = cancel
		$scope.commit = commit
		$scope.addRow = addRow
		$scope.deleteRow = deleteRow

		!function addRow
			vm.count++
			vm.StaffNumber.push(vm.count)

		!function deleteRow index
			vm.StaffNumber.splice(index,1)

		!function cancel
			$mdDialog.cancel!

		!function commit msg
			
			formData = new FormData document.getElementById 'edit-plan-form'
			name = []
			userName = []
			($ 'input[name=\'name\']').each (!-> name.push @value )
			($ 'input[name=\'userName\']').each (!-> userName.push @value )
			console.log name
			console.log userName
			newStaff = []
			len = if name.length < userName.length then name.length else userName.length
			console.log len
			i=0
			while i<len
				if(validProfile(name[i]) && validProfile(userName[i]))
					console.log 'in While and valid'
					newStaff.push({fullname: name[i].trim!, username: userName[i].trim!, createdAt: getCurrentTime!})
				i++

			console.log newStaff

			for item in newStaff
				vm.people.push(item)
			$mdDialog.hide 'close edit dialog'

		function validProfile inputData
			inputData = inputData.trim!
			if inputData is ''
				false
			else
				true

		function getCurrentTime
			myDate = new Date();
			year = myDate.getFullYear()
			month =	myDate.getMonth()
			date = myDate.getDate()
			time = myDate.toLocaleTimeString()
			[year,month,date,time].join '-'
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

