angular.module 'app.execution.list', []

  .config ($state-provider) !->

    $state-provider
    .state 'app.exe-list', {
      url: '/exe-list',
      views:
        'content@app':
          template-url: 'app/main/execution/list/exe-list.html',
          controller: 'ExecutionListController as vm'
    }

    .state 'app.exe-list.active', {
      url: '/active',
      views:
        'tabContent@app.exe-list':
          template-url: 'app/main/execution/list/tabs/active.html'
          controller: 'ExecutionListController as vm'
    }

    .state 'app.exe-list.finished', {
      url: '/finished',
      views:
        'tabContent@app.exe-list':
          template-url: 'app/main/execution/list/tabs/finished.html'
          controller: 'ExecutionListController as vm'
    }

    .state 'app.exe-list.all', {
      url: '/all',
      views:
        'tabContent@app.exe-list':
          template-url: 'app/main/execution/list/tabs/all.html',
          controller: 'ExecutionListController as vm'
    }









