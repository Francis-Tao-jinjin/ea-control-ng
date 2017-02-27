angular.module 'app.ea-admin.box'
.controller 'eaAdminBoxController', ea-admin-box-controller

ea-admin-box-controller.$inject = ['$state','GetFakeData']
!function ea-admin-box-controller $state,GetFakeData
	console.log 'hello ea-admin-box-controller'
	dtOptions = {
		dom       : '<"top"f>rt<"bottom"<"left"<"length"l>><"right"<"info"i><"pagination"p>>>',
		pagingType: 'simple',
		autoWidth : false,
		responsive: true
	}

	vm = this
	vm.dtOptions = dtOptions

	vm.CompanyInfo = GetFakeData.CompanyInfo

	vm.goToBoxesDetail = goToBoxesDetail

	!function goToBoxesDetail companyId
		console.log 'Click and in function go to boxes details with id : '+ companyId
		$state.go 'app.ea-admin.box-details', {'companyId': companyId}
