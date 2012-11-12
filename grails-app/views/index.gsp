<!DOCTYPE html>
<html ng-app="gujamada">
	<head>
		<!--<meta name="layout" content="main"/>-->
		<title>Gajamada</title>
				<style>
			/* 
			  Allow angular.js to be loaded in body, hiding cloaked elements until 
			  templates compile.  The !important is important given that there may be 
			  other selectors that are more specific or come later and might alter display.  
			 */
			[ng\:cloak], [ng-cloak], .ng-cloak {
			  display: none !important;
			}
			.content {
				padding-top:89px;
			}
			.job-category,.cluster-category{
				opacity:0.6;
			}
			.job-row,.cluster-row{
				opacity:0.6;
			}
			.control{
				opacity:0.5;
			}
			.job-logs{
				padding-left:8px;
				padding-top:8px;
			}
		    body,
		    p,
		    li{
		      font-size: 14px;
		      line-height: 20px;
		    }
		    h1, h2, h3, h4, h5, h6 {
		      text-rendering: optimizeLegibility;
		    }
		</style>
		<r:require module="gajamada"/>
  <r:script disposition="head">
    var gajamada = <%=gajamada%>;
  </r:script>
  <r:script>
    $(function(){
      window.grailsEvents = new grails.Events('${createLink(uri: '')}', {transport:'sse'});

      grailsEvents.on("gorm://afterInsert.com.gajamada.ClusterState", function(data){
            <!--var model = Todos.get(data.id);
            if(!model){
                Todos.add(new Todo(data));
            }-->
            window.clusterState = JSON.parse(data);
      });

      grailsEvents.on("gorm://afterInsert.com.gajamada.JobState", function(data){
              <!--var model = Todos.get(data.id);
              if(model){
                  Todos.remove(model);
              }-->
              window.jobState = JSON.parse(data);
      });
    });
    <script src="/js/toastr.js"></script>
    <script type="text/javascript">
		var app = angular.module('gujamada', []);
		
		app.factory('data', function() {
		    return {
		        jobDetail:null
		    };
		});

		app.directive ('jobState', function() { 
			return {
		  		link: function (scope, element, attribs) {
					if(scope.job.state == 'RUNNING'){
						element.addClass("label-info");
					}
					else if(scope.job.state == 'COMPLETED'){
						element.addClass("label-success");
					}
				}
			}
		});
		
		app.directive ('clusterState', function() { 
			return {
		  		link: function (scope, element, attribs) {
					if(scope.cluster.state == 'RUNNING'){
						element.addClass("label-info");
					}
					else if(scope.cluster.state == 'COMPLETED'){
						element.addClass("label-success");
					}
				}
			}
		});
		
		app.directive('slideDown', function() {
			return {
		    	compile: function(elm) {
		        	return function(scope, elm, attrs) {
			        		$(elm).addClass("animated");
							$(elm).addClass("fadeInDown");
		       	 	};
		     	}
		   	};
		});
		
		function JobsCtrl($scope,$http,data){
			$scope.getJobs = function(){
				/*$http.get("").success(function(d){
					$scope.jobs = d;
				});*/
				var oldJobs = $scope.jobs;
				$scope.jobs = [
					{state:'RUNNING',name:'Job 1',startedAt:new Date(),logUri:'http://www.google.com',instanceId:1},
					{state:'RUNNING',name:'Job 2',startedAt:new Date(),logUri:'http://www.google.com',instanceId:2},
					{state:'COMPLETED',name:'Job 3',startedAt:new Date(),logUri:'http://www.google.com',instanceId:1,finishedAt:new Date()}
				];
				
				setTimeout(function(){
					toastr.success($scope.jobs[0].name + " is " + $scope.jobs[0].state);
				},1000);
				setTimeout(function(){
					toastr.info($scope.jobs[2].name + " is " + $scope.jobs[2].state);
				},3000);
				setTimeout(function(){
					toastr.error($scope.jobs[1].name + " is " + $scope.jobs[1].state);
				},4000);
			}
			$scope.getJobs();
			$scope.data = data;
			$scope.data.jobDetail = null;
			$scope.jobState = window.jobState;
		}
		
		function ClustersCtrl($scope,$http){
			$scope.getClusters = function(){
				/*$http.get("").success(function(d){
					$scope.jobs = d;
				});*/
				var oldClusters = $scope.clusters;
				$scope.clusters = [
					{state:'RUNNING',name:'Cluster 1',startedAt:new Date(),readyAt:new Date()},
					{state:'RUNNING',name:'Cluster 2',startedAt:new Date(),readyAt:new Date()}
				];
				
				/*var smoothie1 = new SmoothieChart();
				smoothie.streamTo(document.getElementById("canvas0"));
				
				var smoothie2 = new SmoothieChart();
				smoothie.streamTo(document.getElementById("canvas1"));*/
				
				setTimeout(function(){
					toastr.success($scope.clusters[0].name + " is " + $scope.clusters[0].state);
				},1000);
				setTimeout(function(){
					toastr.error($scope.clusters[1].name + " is " + $scope.clusters[1].state);
				},4000);
			}
			$scope.getClusters();
			$scope.clusterState = window.clusterState;
		}
		
		function JobListCtrl($scope,data){
			$scope.data = data;
		}
	</script>
  </r:script>
	</head>
	<body ng-cloak>
    	<div class="container">
			<div class="navbar navbar-fixed-top">
		  		<div class="navbar-inner">
		  			<div class="container-fluid">
		  				<a class="brand" href="#">Gujamada </a>
		  			</div>
		    	</div>
		 	 </div>
		  	<div class="content" ng-cloak>
	      		<div class="row-fluid" ng-include src="'partials/jobs.html'" ng-controller="JobsCtrl">
	      		<div class="row">
<h2>Jobs</h2>
</div>
<div class="row" style="padding-bottom:13px;">
	<div class="span3">
		<p>A brief summary of your jobs.</p>
	</div>
	<div class="span9">
		<p>
			<input type="text" class="input search-query" placeholder="Filter jobs..." ng-model="jobSearch ">
		</p>
	</div>
</div>
<div class="row">
	<div class="span2">
		<table class="table table-hover">
			<tr>
				<td><h4>{{(jobs | filter:{state:'RUNNING'}).length}}</h4></td>
				<td><h5 class="job-category">Jobs Running</h5></td>
			</tr>
			<tr>
				<td><h4>{{(jobs | filter:{state:'COMPLETED'}).length}}</h4></td>
				<td><h5 class="job-category">Jobs Completed</h5></td>
			</tr>
			<tr>
				<td><h4>{{(jobs | filter:{state:'FAILED'}).length}}</h4></td>
				<td><h5 class="job-category">Jobs Failed</h5></td>
			</tr>
		</table>
	</div>
	<div class="span9 offset1">
		<table class="table">
			<thead>
			<tr style="border="none;">
				<th>Name</th>
				<th>Started</th>
				<th>State</th>
				<th>Finished</th>
				<th>Instance</th>
				<th>Logs</th>
				<th>Total Time</th>
			</tr>
			</thead>
			<tr ng-repeat="job in jobs | filter:jobSearch" class="job-row" ng-mouseover="job.hovering=true" ng-mouseleave="job.hovering=false">
				<th>{{job.name}}</th>
				<th>{{job.startedAt | date:'medium'}}</th>
				<th><span class="label" job-state src="job.id">{{job.state}}</span></th>
				<th>{{job.finishedAt | date:'medium'}}</th>
				<th>{{job.instanceId}}</th>
				<th><a ng-href="{{job.logUri}}" target="_new">Logs</a></th>
				<th></th>
				<th style="width:5%;" ng-controller="JobListCtrl">
					<span ng-show="(job.hovering && data.jobDetail == null) || data.jobDetail == job">
						<div ng-switch on="data.jobDetail">
							<div ng-switch-when="null">
								<a ng-click="data.jobDetail = job">
									<i class="icon-tasks control"></i>
								</a>
							</div>
							<div ng-switch-default>
								<a ng-click="data.jobDetail = null">
									<i class="icon-tasks control"></i>
								</a>
							</div>
						</div>
					</span>
				</th>
			</tr>
		</table>
		<div class="job-logs" ng-show="data.jobDetail" slide-down>
			<h4>{{data.jobDetail.name}} History</h4>
			<hr/>
			Jan 12, 2012 {{data.jobDetail.state}} -> {{data.jobDetail.state}}<br/>
		</div>
	</div>
</div>
	      		</div>
				<div class="row-fluid" ng-include src="'partials/clusters.html'" ng-controller="ClustersCtrl">
				<div class="row">
<h2>Clusters</h2>
</div>
<div class="row" style="padding-bottom:13px;">
	<div class="span3">
		<p>A brief summary of clusters.</p>
	</div>
	<div class="span9">
		<p>
			<input type="text" class="input search-query" placeholder="Filter clusters..." ng-model="clusterSearch ">
		</p>
	</div>
</div>
<div class="row">
	<div class="span2">
		<table class="table">
			<tr>
				<td><h4>{{(clusters | filter:{state:'RUNNING'}).length}}</h4></td>
				<td><h5 class="cluster-category">Clusters Running</h5></td>
			</tr>
			<tr>
				<td><h4>{{(clusters | filter:{state:'COMPLETED'}).length}}</h4></td>
				<td><h5 class="cluster-category">Clusters Completed</h5></td>
			</tr>
			<tr>
				<td><h4>{{(clusters | filter:{state:'FAILED'}).length}}</h4></td>
				<td><h5 class="cluster-category">Clusters Failed</h5></td>
			</tr>
		</table>
	</div>
	<div class="span9 offset1">
		<!--<ul class="unstyled">
			<li ng-repeat="cluster in clusters | filter:clusterSearch"><canvas id="canvas+{{$index}}" width="400" height="100"></canvas></li>
		</ul>-->
		<table class="table table-hover">
			<thead>
			<tr>
				<th>Name</th>
				<th>Started</th>
				<th>State</th>
				<th>Finished</th>
				<th>Ready</th>
			</tr>
			</thead>
			<tr ng-repeat="cluster in clusters | filter:clusterSearch" class="cluster-row">
				<th>{{cluster.name}}</th>
				<th>{{cluster.startedAt | date:'medium'}}</th>
				<th><span class="label" cluster-state src="cluster.id">{{cluster.state}}</th>
				<th>{{cluster.finishedAt | date:'medium'}}</th>
				<th>{{cluster.instanceId}}</th>
			</tr>
		</table>
	</div>
</div>
				
				</div>
		  	</div>
		</div>
    </body>
</html>
