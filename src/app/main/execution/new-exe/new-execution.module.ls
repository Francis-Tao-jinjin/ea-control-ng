angular.module 'app.execution.new', []
  
.config ($state-provider) !->

  $state-provider
  .state 'app.new-exe', {
    url: '/new-exe'
    views: 
      'content@app':
        template-url: 'app/main/execution/new-exe/new-execution.html'
        controller: 'newExecutionController as vm'
  }

.service 'completePlanService', ($resource, api) ->
  get-complete-plan-name-id:  ->
    plan-list = $resource('app/data/complete-plan-name-id-list.json')
    plan-list.get().$promise
      .then (result) ->
        result

.service 'idleBoxService', ($resource, api) ->
  get-idle-box-name-id:  ->
    plan-list = $resource('app/data/idle-box-name-id-list.json')
    plan-list.get().$promise
      .then (result) ->
        result

.service 'newExeService', ($resource, api) ->
  new-execution:(exe)  ->
    console.log "post:", exe
    new-exe = $resource('app/company/:company-id/new-execution')
    new-exe.save({company-id:1},
      {
        execution-name:exe.name
        box:{
          name: exe.box.name
          id: exe.box.id
        }
        plan:{
          name:exe.plan.name
          id:exe.plan.id
          script-url:exe.plan.script-url
        }
        comment:exe.comment
        user:exe.user
      })

.service 'circuitService', ($resource, api) ->
  get-pins:(plan-id) ->
    pins = $resource('app/data/pins.json')
    pins.get().$promise
      .then (result) ->
        result

