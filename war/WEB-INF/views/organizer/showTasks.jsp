<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.zs.models.Task" %>
<%@ page import="com.zs.models.Organizer" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zs.utils.Types" %>
<%@ page import="com.zs.utils.Utils" %>
<%
	int type = (Integer) request.getAttribute("type");
	int flag = (Integer) request.getAttribute("flag");
	String id = (String) request.getAttribute("id");
	List<Task> tasks = (List<Task>) request.getAttribute("tasks");
	Organizer o = (Organizer) request.getAttribute("organizer");
%>

<html>
	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>
	<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Eventus 2.0</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
          	<li><a href="/">Inicio</a></li>
            <li class="active"><a href="#">Mi Panel</a></li>
            <li><a href="#">Acerca</a></li>
            <li><a href="#">Contacto</a></li>
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Mi cuenta<span class="caret"></span></a>
            <li class="dropdown">
              <ul class="dropdown-menu">
				<li class="dropdown-header">Cuenta</li>              
                <li><a href="#">Cambiar contraseña</a></li>
                <li><a href="#">Cambiar e-mail</a></li>
                <li><a href="#">Cambiar nombre</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Avanzadas</li>
                <li><a href="#">Configuración</a></li>
                <li><a href="#">Ayuda</a></li>
              </ul>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="jumbotron">
	  <div class="container">
	   <h2>Tareas de <%=o.getFirstName()%> <%=o.getLastName()%></h2>
	   <p> <%=o.getCategory()%> del comité de <%=Utils.firstToUpperCase(o.getComite())%></p>
	  </div>
	</div>
	<div class="container">
		<h2>Comités Actuales</h2>
		<div class="table-responsive">
		<table class="table table-striped">
		<tr>
		<th>Título</th>
		<th>Prioridad</th>
		<th>Descripcion</th>
		<th>Realizado</th>
		</tr>
		
		<%
			if(tasks != null){
				for(Task t : tasks){
		%>
				<tr>
				<td><%=t.getTitle()%></td>
				<td><%=t.getPriority()%></td>
				<td><%=t.getDescripcion()%></td>
				<td><%=t.getDone()%></td>
				<td>
		<%
		if(type == Types.ORGANIZER_COORDINATOR_TYPE || (type == Types.ORGANIZER_BOSS_TYPE && flag == 1)){
		%>
					<a href="/organizer/deleteTask/<%=id%>/<%=KeyFactory.keyToString(t.getId())%>/1">Eliminar</a>
		<%
					}
					if(t.getDone() == 0){
		%>
					<a href="/organizer/setDoneTask/<%=id%>/<%=KeyFactory.keyToString(t.getId())%>/1/<%=flag%>">Marcar Cumplida</a>
		<%
					}
					else if(t.getDone() == 1){
		%>
					<a href="/organizer/setDoneTask/<%=id%>/<%=KeyFactory.keyToString(t.getId())%>/0/<%=flag%>">Desmarcar Cumplida</a>
		<%
					}
		%>
				</td>
		<%
				}
			}
		%>
		</table>
		</div>
		<button type="button" class="btn btn-default" id = "Back"
		<%
			if(type == Types.ORGANIZER_COORDINATOR_TYPE){
		%>
			onclick = "location.href='/coordinator/showAllOrganizers'"
		<%
			}
			else if(type == Types.ORGANIZER_BOSS_TYPE){
				if(flag == 1){
		%>
			onclick = "location.href='/organizer/showWorkers'"	
		<%
				}
				else if(flag == 0){
		%>
			onclick = "location.href='/organizer/getBossInterface'"
		<%
				}
			}
			else if(type == Types.ORGANIZER_WORKER_TYPE){
		%>
			onclick = "location.href='/organizer/getWorkerInterface'"
		
 		<%
 			}
 		%>
		
		>Atrás</button>
		<hr></hr>
      	<footer><p>© 2016 ZealotSoft</p></footer>
		</div>
	</body>
</html>