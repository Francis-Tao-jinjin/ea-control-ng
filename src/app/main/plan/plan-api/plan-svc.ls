angular.module 'app.plan'

.service 'GetPlanListSvc' ($http, $resource) !->
	/*
	@.get-users-ready-plans = ->
		$http.get '/api/company/:company-id/plan/?type=1'

	@.get-users-waiting-plans = ->
		$http.get '/api/company/:company-id/plan/2'

	@.get-company-all-plans = ->
		$http.get '/api/company/:company-id/plan/3'
	*/
	
	/*
	@.get-users-ready-plans = $resource('/api/company/:company-id/plan/?type=1')
	@.get-users-waiting-plans = $resource('/api/company/:company-id/plan/?type=2')
	@.get-company-all-plans = $resource('/api/company/:company-id/plan/?type=3')
	*/

	@.getPlansList = (type) ->
		$resource 'http://localhost:9700/ea-plan'

.service 'CreatePlanSvc' ($resource) !->

	/*
	@.post-create-plan = $resource('/api/company/:company-id/plan/create')
	*/

	@.postNewPlan = (company-id) ->
		$resource 'http://localhost:9700/ea-plan/create'

.service 'GetPlanDetailsSvc' ($resource) !->
	/*
	@.get-basic-info = $resource('/api/company/:companyId/plan/:planId')
	@.get-doc-info = $resource('/api/company/:companyId/plan/:planId/doc')
	@.get-scirpt-info = $resource('/api/company/:companyId/plan/:planId/script')
	@.get-doc-histry = $resource('/api/company/:companyId/plan/:planId/docHistory')
	@.get-exe-histry = $resource('/api/company/:companyId/plan/:planId/exeHistory')
	*/
	@.getBasicInfo = (company-id, plan-id) ->
		$resource('http://localhost:9700/api/company/:companyId/plan/:planId',{companyId:company-id,planId:plan-id})

	@.getDocInfo = (company-id, plan-id) ->
		$resource('http://localhost:9700/api/company/:companyId/plan/:planId/doc',{companyId:company-id,planId:plan-id})

	@.getScriptInfo = (company-id, plan-id) ->
		$resource('http://localhost:9700/api/company/:companyId/plan/:planId/script',{companyId:company-id,planId:plan-id})

	@.getDocHistry = (company-id, plan-id) ->
		$resource('http://localhost:9700/api/company/:companyId/plan/:planId/docHistory',{companyId:company-id,planId:plan-id})

	@.getExeHistry = (company-id, plan-id) ->
		$resource('http://localhost:9700/api/company/:companyId/plan/:planId/exeHistory',{companyId:company-id,planId:plan-id})



























