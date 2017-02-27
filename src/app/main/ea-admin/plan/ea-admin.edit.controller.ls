angular.module 'app.ea-admin.plan'

  .controller 'eaAdminPlanEditController', ea-admin-plan-edit-controller


!function ea-admin-plan-edit-controller ea-admin-service
  vm = @
  vm.plan-id = 1
  vm.commit = commit
  vm.waitUploadData = {
    file-name: '',
    comment: ''
  }


  !function commit(msg)
    console.log msg
    formData = new FormData document.getElementById 'edit-add-script'
    vm.waitUploadData.file-name = (formData.get 'file').name
    if(vm.waitUploadData.file-name && vm.waitUploadData.comment)
      request = new XMLHttpRequest()
      request.open 'POST', '#', true
      request.onreadystatechange = !->
        $scope.$apply (!->
          if request.readyState is XMLHttpRequest.DONE && request.status is 200
            backData = request.response
            console.log backData
        )
      console.log '已提交请求'
      inputs = document.getElementsByTagName 'input'
      console.log inputs
      inputs[0].value = ''
      vm.waitUploadData.comment = ''
    else
      console.log '有未填写的数据'
    console.log vm.waitUploadData
    
  ea-admin-service.retrieve-plan-info 1, vm.plan-id
    .then (result) ->
      vm.basic = result.data

  ea-admin-service.retrieve-plan-docs 1, vm.plan-id
    .then (result) ->
      vm.plan-docs = result.data

  ea-admin-service.retrieve-plan-doc-history 1, vm.plan-id
    .then (result) ->
      vm.edit-history = result.data

  ea-admin-service.retrieve-plan-scripts 1, vm.plan-id
    .then (result) ->
      vm.plan-scripts = result.data