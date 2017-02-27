angular.module 'app.plan'

.service 'GetPlanFakeData' !->
	@.getCurrentTime = getCurrentTime
	@.getRandomDocUrl = getRandomDocUrl
	@.getPlanById = getPlanById
	@.UpdateDocData = UpdateDocData

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

	function getRandomDocUrl
		Urls = [
			'http://www.qcenglish.com/download.php?id=3675&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3674&site=1&filetype=pdfs',
			'http://www.qcenglish.com/download.php?id=3678&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3677&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3498&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3603&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3595&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3556&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3531&site=1&filetype=pdf',
			'http://www.qcenglish.com/download.php?id=3520&site=1&filetype=pdf'
		];
		i = Math.ceil(Math.random()*10)
		if(i >= 10)
			i = 0
		Urls[i]

	function getCurrentTime
		myDate = new Date();
		year = myDate.getFullYear()
		month =	myDate.getMonth()
		date = myDate.getDate()
		time = myDate.toLocaleTimeString()
		[year,month,date,time].join '-'

	function getPlanById planId
		for item in @.ReadyList
			if item._id is planId
				console.log item
				item
	
	@.ReadyList = [{
		_id: '001',
		assumeTime: 23,
		creator: 	'李兕',
		comment: 	'临时测试_1',
		doc: 	[{
			filename: 	'洗衣机临时测试－1.pdf',
			url: 		'http://www.qcenglish.com/download.php?id=3675&site=1&filetype=pdf'
		}],
		docHistory: 	[{
			lastModify: '2016-11-23-下午15:33',
			operate: 	'新建测试计划',
			reason: 	'第一个新建的计划',
			feedback: 	'暂无'
		}], 
		exeHistory: 	[{
			exename: 	'',
			box: 		'',
			operator: 	'',
			StartTime: 	'',
			type: 		''
		}],
		lastModify:	'2016-11-23-15:33',
		planname: 	'洗衣机临时测试_1',
		script: {
			filename: 	'test_1.js',
			url: 		'https://code.jquery.com/jquery-3.1.1.min.js'	
		},
		type: 		1	
	}];