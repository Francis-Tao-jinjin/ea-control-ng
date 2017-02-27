angular.module 'app.comp-admin.user', []

.config ($state-provider) !->
	$state-provider
	.state 'app.c-admin.user', {
		url: '/comp-admin/user'
		views: 
			'content@app':
				template-url: 'app/main/comp-admin/user/comp-admin.user.html'
				controller: 'compAdminUserController as vm'
	}


