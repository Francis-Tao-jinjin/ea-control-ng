# ea-control-client
本项目用于构建ea-control的前端部分。

## 分支
| 分支           | 描述          |
| ------------- | ------------- |
| `master`      | 经过测试，bug修复并稳定的分支。|
| `dev`         | 开发的主分支。当完成一个大的迭代时将`dev`分支并入`master`分支。|
| `apidoc`      | 用于修改、生成、查看API文档的分支。|

---

## 运行
```bash
> git clone git@code.deepfocus.cn:ecc-ats/ea-control-client.git -b dev
> npm install | bower install | gulp serve
```

## 开发规范
  1. 每人按照功能模块的名字建立分支进行开发
  2. 文件命名和变量命名都使用`-`连接，尽量不要出现`_`

  待补充
