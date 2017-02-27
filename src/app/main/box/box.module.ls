'use strict'

angular.module 'app.box', ['app.execution.new']
  .config ($state-provider) !->
    console.log 'box config'
    $state-provider
    .state 'app.box', {
      url: '/box'
      views:
        'content@app':
          template-url: 'app/main/box/box.html'
          controller: 'boxListController as vm'
    }
    .state 'app.box.busy' , {
      url: '/busy',
      views:
        'boxTabContent@app.box':
          templateUrl: 'app/main/box/tabs/busy.html'
    }
    .state 'app.box.idle' , {
      url: '/idle',
      views:
        'boxTabContent@app.box':
          templateUrl: 'app/main/box/tabs/idle.html'
    }
    .state 'app.box.all' , {
      url: '/all',
      views:
        'boxTabContent@app.box':
          templateUrl: 'app/main/box/tabs/all.html'
    }

  .service 'boxService', ($resource, api) ->
    retrieve-box-list: (type) ->
      box-list = $resource('app/data/box-list.json')
      box-list.get({type: type}).$promise
        .then (result) ->
          result
