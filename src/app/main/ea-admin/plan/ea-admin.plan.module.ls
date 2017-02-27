angular.module 'app.ea-admin.plan', []

  .config ($state-provider) !->

    $state-provider

    .state 'app.ea-admin.plan', {
      url: '/ea-admin/plan'
      views:
        'content@app':
          template-url: 'app/main/ea-admin/plan/ea-admin.plan.html'
          controller: 'eaAdminPlanController as vm'
    }

    .state 'app.ea-admin.plan.edit', {
      url: '/edit'
      views: 
        'content@app':
          template-url: 'app/main/ea-admin/plan/ea-admin.edit.html'
          controller: 'eaAdminPlanEditController as vm'
    }