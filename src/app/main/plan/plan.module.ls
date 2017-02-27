angular.module 'app.plan', ['ngResource','datatables']
.config ($state-provider) !->
	$state-provider
	.state 'app.plan-list', {
		url: '/plans'
		views:
			'content@app':
				template-url: 'app/main/plan/list/plan.list.html'
				controller: 'PlanController as vm'
	}
	.state 'app.plan-list.ready' , {
		url  : '/ready',
		views: {
			'tableTabContent@app.plan-list': {
				templateUrl: 'app/main/plan/list/plan.list.ready.html'
			}
		}
	}
	.state 'app.plan-list.waiting' , {
		url  : '/waiting',
		views: {
			'tableTabContent@app.plan-list': {
				templateUrl: 'app/main/plan/list/plan.list.waiting.html'
			}
		}
	}
	.state 'app.plan-list.others' , {
		url  : '/others',
		views: {
			'tableTabContent@app.plan-list': {
				templateUrl: 'app/main/plan/list/plan.list.others.html'
			}
		}
	}
	.state 'app.plan-details', {
		#template-url: 'app/main/plan/details/plan-details.html'
		url: '/plans/details/:planId',
		views:
			'content@app':
				params:      {'planId': null},
				template-url: 'app/main/plan/details/plan-details.html'
				controller: 'PlanDeatilsController as vm'
		
	}
.service 'idleBoxService', ($resource, api) ->
	get-idle-box-list: ->
		box-list = $resource('app/data/idle-box-name-id-list.json')
		box-list.get().$promise
			.then (result) ->
				result
.service 'newExeService', ($resource, api) ->
	new-execution:(new-execution)  ->
		new-exe = $resource('app/company/:company-id/new-execution')
		new-exe.save({company-id:1},
		{
			execution-name:new-execution.name
			box:{
				name: new-execution.box-name
				id: new-execution.box-id
			}
			plan:{
				name:new-execution.plan.plan-name
				id:new-execution.plan.plan-id
				script-url:new-execution.plan.script-url
			}
			comment:new-execution.comment
			user:new-execution.user
		})
		console.log new-exe

.service 'circuitService', ($resource, api) ->
	get-pins:(plan-id) ->
		pins = $resource('app/data/pins.json')
		pins.get().$promise
			.then (result) ->
				result