'use strict'

angular.module 'fuse' 

.controller 'MainController', ($scope, $root-scope, ms-navigation-service, $state, nav-service) !->
  'ngInject'


  console.log 'main controller'

  # Remove the splash screen
  $scope.$on '$viewContentAnimationEnded', (event)-> $root-scope.$broadcast 'msSplashScreen::remove' if event.target-scope.$id is $scope.$id

  # 硬编码用户信息
  if !$root-scope.current-user 
    then $root-scope.current-user = {
      username: 'wyx', 
      #role: 'c-admin',
      role: 'ea-admin', 
      fullname: '宇翔啊', 
      company-id: 1
    }


    
  user = $root-scope.current-user
  nav-service.delete-all!
  if user 
    nav-service.save 'user',          { title: "用户", group: true, weight: 2, class: 'user' } 
    nav-service.save 'user.profile',  { title : "#{user.fullname}，您好！"   ,   state : 'app.profile', weight   : 2,  class: 'profile' }
    nav-service.save 'user.logout',   { title : '退出'   , icon: 'icon-logout',  state : 'app.login',   weight   : 2,  class: 'login'  }
  else
    nav-service.save 'user',          { title: "用户", group: true, weight: 2, class: 'user' } 
    nav.save-item 'user.login',       { title : '登录',     icon: 'icon-login',   state : 'app.login',   weight   : 2,  class: 'logout' }


  if user.role is 'ea-admin'
    nav-service.save 'ea-admin',       { title: '企业管理',   group: true, weight: 1 }
    nav-service.save 'ea-admin.plan',  { title: '待处理计划', image: '/assets/images/menu/test-plan.svg', state: 'app.ea-admin.plan' }
    nav-service.save 'ea-admin.box',   { title: '测试盒',     image: '/assets/images/menu/test-box.svg', state: 'app.ea-admin.box' }

  else if user.role is 'tester'
    nav-service.save 'test',           { title: '测试',    group: true, weight: 1 }
    nav-service.save 'test.box',       { title: '测试盒',   image: '/assets/images/menu/test-box.svg',  state: 'app.box.busy' }
    nav-service.save 'test.plan',      { title: '测试计划', image: '/assets/images/menu/test-plan.svg', state: 'app.plan-list.ready' }
    nav-service.save 'test.execution', { title: '测试执行', image: '/assets/images/menu/test-plan.svg', state: 'app.exe-list.active' }

  else
    nav-service.save 'test',           { title: '测试',    group: true, weight: 1 }
    nav-service.save 'test.box',       { title: '测试盒',   image: '/assets/images/menu/test-box.svg',  state: 'app.box.busy' }
    nav-service.save 'test.plan',      { title: '测试计划', image: '/assets/images/menu/test-plan.svg', state: 'app.plan-list.ready' }
    nav-service.save 'test.execution', { title: '测试执行', image: '/assets/images/menu/test-plan.svg', state: 'app.exe-list.active' }

    nav-service.save 'c-admin',        { title: '系统管理',  group: true }
    nav-service.save 'c-admin.user',   { title: '测试员管理', image: '/assets/icons/user1.png',           state: 'app.c-admin.user' }
    nav-service.save 'c-admin.box',    { title: '测试盒管理', image: '/assets/images/menu/test-box.svg',  state: 'app.c-admin.box' }

  nav = ms-navigation-service
  nav.set-folded true

  # $root-scope.$on 'destroy', !-> state-change-listener-stop!


.factory 'navService', (ms-navigation-service) ->
  current-item: []
  
  delete-all: ->
    if @current-item.length > 0
      nav = ms-navigation-service
      for item in @current-item
        nav.delete-item item

      @current-item = []

  save: (item-name, config) ->
    nav = ms-navigation-service
    nav.save-item item-name, config

    @current-item.push item-name

