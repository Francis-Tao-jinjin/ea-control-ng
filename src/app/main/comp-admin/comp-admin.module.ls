angular.module 'app.comp-admin', ['app.comp-admin.box', 'app.comp-admin.user']

  .config ($state-provider) !->

    $state-provider

    .state 'app.c-admin', abstract: true
