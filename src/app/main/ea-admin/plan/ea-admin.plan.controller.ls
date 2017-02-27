angular.module 'app.ea-admin.plan'

.controller 'eaAdminPlanController', ea-admin-plan-controller

!function ea-admin-plan-controller ea-admin-service, $root-scope
  
  vm = @

  ea-admin-service.retrieve-plan-to-finish()
    .then (result) ->
      vm.plans-to-finish = result.data
