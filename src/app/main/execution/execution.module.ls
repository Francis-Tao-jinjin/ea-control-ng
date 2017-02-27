angular.module 'app.execution', ['app.execution.list', 'app.execution.detail']

  .service 'executionService', ($resource, api) ->
    retrieve-execution-list: (type) ->
      exe-list = api.execution.list
      exe-list.get({type: type}).$promise
        # .then (result) ->
          # result

    retrieve-execution-detail: (execution-id) ->
      exe-detail = api.execution.detail
      exe-detail.get().$promise
        # .then (result) ->
          # result

