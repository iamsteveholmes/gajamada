<!DOCTYPE html>
<html>
	<head>
		<!--<meta name="layout" content="main"/>-->
		<title>Gajamada</title>
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
      });

      grailsEvents.on("gorm://afterInsert.com.gajamada.JobState", function(data){
              <!--var model = Todos.get(data.id);
              if(model){
                  Todos.remove(model);
              }-->
      });
    });
  </r:script>
	</head>
	<body>
	</body>
</html>
