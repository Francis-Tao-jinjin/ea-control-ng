exports.config = 
  id: 1
  steps: ['进水','频率检测','排水','浊度检测','高速洗涤']
  pins: ['DI1','DI2','AO1','DO1','DI3']
  d-pins: ['DI1','DI2','DO1','DI3']
  a-pins: ['AO1']
  pin-names: ['进水阀', '排水阀', '分水阀', '温度', '双速管']
  d-pin-names: ['进水阀', '排水阀', '分水阀', '双速管']
  a-pin-names: ['温度']
  d-units: [{true: '开', false: '关'}, {true: '上', false: '下'}]
  a-units: ['°C']
  reasons: ['超时', '频率错误', '阀门位置错误']
  exes: ['自动洗测试-1', '自动洗测试-2', '高速洗涤测试-1', '高速洗涤测试-2']
  plans: ['自动洗测试','高速洗涤测试']
  exe-status: ['active', 'fail', 'pass']
  step-status: ['pending', 'active', 'fail', 'pass']
  plan-status: ['complete', 'incomplete']
  exe-count: 40
  step-count: 10

  op-type: ['create', 'update']
  op-reason: ['删除测试文档2', '新增测试文档3', '更新测试文档1步骤2', '替换测试文档2']
  feedback: ['根据修改的文档更新脚本', '根据更新文档新增脚本内容', '根据更新的文档删除脚本内容']
  company-name: ['美的', '三星', '海尔']

  roles: ['tester', 'c-admin', 'ea-admin']