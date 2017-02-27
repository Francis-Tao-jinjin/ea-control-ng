angular.module 'app.ea-admin.box'

.service 'GetFakeData' !->
	@.getCurrentTime = getCurrentTime
	@.getRandomExeName = getRandomExeName
	@.getCompanyById = getCompanyById
	@.UpdateDocData = UpdateDocData
	@.generateBoxesData = generateBoxesData

	function UpdateDocData docToDel, planId, planData
		for item in @.ReadyList
			if item._id is planId
				console.log item
				if docToDel isnt 0
					temp = []
					i = 0
					while i < item.doc.length
						different = true
						j = 0
						while j < docToDel.length and different is true
							different = false if item.doc[i].filename is docToDel[j]
							j++
						if different is true then temp.push item.doc[i]
						i++
					item.doc = temp
				if(planData.newDoc.filename)
					item.doc.push(planData.newDoc)
				docHistory = {
					lastModify: @.getCurrentTime!,
					operate: 	'编辑测试计划',
					reason: 	planData.reason,
					feedback: 	'暂无'
				}
				item.docHistory.unshift(docHistory)
				console.log item
				item

	function getRandomExeName
		ExeName = [
			'洗碗机XW自动洗测试',
			'洗衣机滚桶测试',
			'洗衣机甩干测试',
			'烤箱加热测试',
			'洗碗机烘干测试',
			'风扇自动调节',
			'洗碗机自动堆叠测试',
			'微波炉混合模式测试',
			'洗衣机混合调节测试',
			'烤箱定时测试'
		];
		i = Math.ceil(Math.random()*10)
		if(i >= 10)
			i = 0
		ExeName[i]

	function getCurrentTime
		myDate = new Date();
		year = myDate.getFullYear()
		month =	myDate.getMonth()
		date = myDate.getDate()
		time = myDate.toLocaleTimeString()
		[year,month,date,time].join '-'

	function generateBoxesData numbers
		i = 0
		boxes = []
		while i < numbers
			box = {
				_id : '',
				boxName : '',
				boxStatus :  (Math.ceil(Math.random()*2) === 1 ? 'busy' : 'idle'),
				executionStatus : (Math.ceil(Math.random()*2) === 1 ? 'pass' : 'fail'),
				executionName : @.getRandomExeName!,
				executionId : Math.ceil(Math.random()*(numbers*2)),
				startTime : Date.now(),
				endTime : Date.now() + Math.ceil(Math.random()*200)+40,
				lastExecuteStepId : Math.ceil(Math.random()*30),
				stepName : "step name",
				reason : 'reason'
			}
			boxes.push(box)
			i++
		boxes

	function getCompanyById companyId
		for item in @.CompanyInfo
			if item._id is companyId
				console.log item
				item

	@.CompanyInfo = [{
		_id: '001',
		company: '美的',
		boxes: ['001','002','003','004','005','006','007','008'],
		earlistEndDate: '2017-01-13',
		latstStartDate:	'2016-10-23'
	},{
		_id: '002',
		company: '三星',
		boxes: ['009','001','011','012','013','014','015','016'],
		earlistEndDate: '2017-01-24',
		latstStartDate:	'2016-11-09'
	},{
		_id: '003',
		company: '格力',
		boxes: ['017','018','019','020','021','022','023','024'],
		earlistEndDate: '2017-01-13',
		latstStartDate:	'2016-10-23'
	},{
		_id: '004',
		company: '松下',
		boxes: ['025','026','027','028','029','030','031','032'],
		earlistEndDate: '2017-01-13',
		latstStartDate:	'2016-10-23'
	}]