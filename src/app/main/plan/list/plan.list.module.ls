angular.module 'app.plan'

.filter 'range' ->
	(input, total) ->
		total = parseInt total
		[i for i from 0 to total-1]

.directive 'plansearchinput', -> 
	!function appendFn ($scope, elem, attrs)
		console.log 'linkFunction'
		elem.prepend '<div class="search-container ng-scope">
        	<form id="search" action="#" method="get" autocomplete="off" class="ng-pristine ng-valid">
				<input name="q" type="text" placeholder="Search Plan" value="" tabindex="1" autocomplete="off" maxlength="240">
			</form>
			</div>'
    
	{
		restrice: 'A'
		template: ''
		link: appendFn
		scope: false
	}

/*
.filter('range', function() {
			return function(input, total) {
			    total = parseInt(total);
			    for (var i=0; i<total; i++) {
				    input.push(i);
			    }
			    return input;
			};
		})
*/