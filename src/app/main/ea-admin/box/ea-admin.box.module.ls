angular.module 'app.ea-admin.box', []
.config ($state-provider) !->
	$state-provider
	.state 'app.ea-admin.box', {
		url: '/ea-admin/box'
		views:
			'content@app':
				template-url: 'app/main/ea-admin/box/ea-admin.box.html'
				controller: 'eaAdminBoxController as vm'
	}
	.state 'app.ea-admin.box-details', {
		url: '/ea-admin/box/company/:companyId'
		views:
			'content@app':
				params:		{'companyId': null},
				template-url: 'app/main/ea-admin/box/ea-admin.box-details.html'
				controller: 'eaAdminBoxDetailsController as vm'
	}

.service 'boxService', ($resource, api) ->
	retrieve-box-list: (type) ->
		box-list = $resource('app/data/box-list.json')
		box-list.get({type: type}).$promise
		.then (result) ->
			result