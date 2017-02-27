angular.module 'app.ea-admin', ['app.ea-admin.plan', 'app.ea-admin.box']
  
  .config ($state-provider) ->

    $state-provider
    
    .state 'app.ea-admin', abstract: true
  

  .service 'eaAdminService', ($resource, api) ->

    retrieve-plan-doc-history: (company-id, plan-id) ->
      doc-history = api.plan.doc-history
      doc-history.get! .$promise
        .then (result) ->
          result

    retrieve-plan-docs: (company-id, plan-id) ->
      docs = api.plan.docs
      docs.get! .$promise
        .then (result) ->
          result

    retrieve-plan-scripts: (company-id, plan-id) ->
      scripts = api.plan.scripts
      scripts.get! .$promise

    retrieve-plan-to-finish: ->
      unfinished-plan = api.plan.unfinished-plan
      unfinished-plan.get! .$promise
        .then (result) ->
          result

    retrieve-plan-info: (company-id, plan-id) ->
      plan-info = api.plan.basic
      plan-info.get! .$promise
        .then (result) ->
          result
