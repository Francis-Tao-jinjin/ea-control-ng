angular.module 'app.comp-admin.box', []

  .config ($state-provider) !->

    $state-provider

    .state 'app.c-admin.box', {
      url: '/comp-admin/box'
      views: 
        'content@app':
          template-url: 'app/main/comp-admin/box/comp-admin.box.html'
          controller: 'compAdminBoxController as vm'
    }