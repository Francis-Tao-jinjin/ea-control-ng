angular.module 'app.ea-admin.box'
.controller 'eaAdminBoxDetailsController', eaAdminBoxDetailsController

eaAdminBoxDetailsController.$inject = ['$state','$stateParams','GetFakeData','boxService']
!function eaAdminBoxDetailsController $state,$stateParams,GetFakeData,boxService
	vm = this

	vm.companyId = $stateParams['companyId']
	console.log 'plan id is ' + vm.companyId
	vm.companyInfo
	vm.boxes
	vm.fetchCompanyInfo = fetchCompanyInfo
	vm.fetBoxesData = fetBoxesData
	
	vm.fetchCompanyInfo!

	#vm.fetBoxesData!
	  # 获取所有测试盒
	boxService.retrieve-box-list(1)
	.then (result) ->
		vm.boxes = result.data
		vm.timestamp  = result.timestamp
	console.log vm.boxes

	!function fetchCompanyInfo
		result = GetFakeData.getCompanyById vm.companyId
		vm.companyInfo = result[0]

	!function fetBoxesData
		number = vm.companyInfo.boxes.length
		result = GetFakeData.generateBoxesData number
		boxesId = vm.companyInfo.boxes
		i = 0
		while i<number
			result[i]._id = boxesId[i]
			result[i].boxName = '测试盒'+result[i]._id
			i++
		vm.boxes = result
