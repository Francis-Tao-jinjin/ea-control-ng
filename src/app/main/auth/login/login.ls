'use strict'
angular.module 'app.auth.login', []

.config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)->
  $translate-partial-loader-provider.add-part 'app/main/auth/login'
  console.log 'login config'
  $state-provider.state 'app.login', { 
    url               : '/login'
    body-class        : 'login'
    views             :   
      'main@':
        template-url  : 'app/core/layouts/content-only.html'
        controller    : 'MainController as vm'

      'content@app.login':
        template-url  : 'app/main/auth/login/login.html'
        controller-as : 'vm'
        controller    : ($scope, $root-scope, authService, $state)->
          
          login: -> 
            if !$root-scope.current-user 
              then $root-scope.current-user = {
                username: 'wyx', 
                role: 'ea-admin', 
                fullname: '宇翔啊', 
                company-id: 1
              }


            authService.auth @form 
            .then (result) ~> 
              if result.status is 'SUCCESS'
                @invalid-user = false
                if result.data.role is 'ea-admin'
                  $state.go 'app.ea-admin.plan'
                else
                  $state.go 'app.box.busy'
              else
                alert result.msg
                @invalid-user = true
  }

.factory 'authService',  (api, $root-scope)-> 
  service = 
    current-user: null
    auth: ({username, password})-> api.auth.login {username, password} .then (result)->
      if result.status is 'SUCCESS'
        service.current-user = $root-scope.current-user = result.data
      result


.run ($root-scope, $state, authService)!->
  $root-scope.$on '$stateChangeStart', (event, to-state)!->
    return true # 注意：开发时使用，避免每次都要登录
    #return if !!authService.current-user or to-state.name is 'app.login'

    event.prevent-default!
    $state.go 'app.login'

  $root-scope.$on '$logout', (event)!->
    authService.current-user = $root-scope.current-user = null
    $state.go 'app.login'
