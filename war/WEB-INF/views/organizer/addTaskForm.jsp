<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.zs.utils.Types" %>
<%@ page import="com.zs.utils.Utils" %>
<%@ page import="com.zs.models.Organizer" %>
<%
	String id = (String) request.getAttribute("id");
	int type = (Integer) request.getAttribute("type");
	int flag = (Integer) request.getAttribute("flag");
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
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Mi cuenta<span class="caret"></span></a>
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
	   <h2>Agregar Tarea a <%=o.getFirstName()%> <%=o.getLastName()%></h2>
	   <p> <%=o.getCategory()%> del comité de <%=Utils.firstToUpperCase(o.getComite())%></p>
	  </div>
	</div>
	<div class="container">
	<%
		if(flag != 0){
			if(flag == 1){
	%>	
			<div class="alert alert-success">
    		<strong>Correcto!</strong> Tarea ingresada correctamente.
  			</div>
	<%
			}
		}
	%>
	
	
		<form class="form-horizontal" method = "post" action = "/organizer/addTask/<%=id%>">
		<div class="form-group">		
			<label class="control-label col-sm-2" >Título:</label>
			<div class="col-sm-4"> 
				<input type = "text" class="form-control" name = "title" id = "title" placeholder="Ingrese el nombre de la tarea">
			</div>
		</div>
		<div class="form-group">		
			<label class="control-label col-sm-2" >Prioridad:</label>
			<div class="col-sm-4"> 
			 <select class="form-control" name = "priority" id = "priority">
			 	<option value = "Baja">Baja</option>
			 	<option value = "Media">Media</option>
			 	<option value = "Alta">Alta</option>
			 </select>
			</div>
		</div>
		<div class="form-group">		
			<label class="control-label col-sm-2">Descripción</label>
			<div class="col-sm-4"> 
				<textarea class="form-control" rows="5" name = "descripcion" id = "descripcion" placeholder="Escriba aquí la descripción"></textarea> </br>
			</div>
		</div>	
		<div class="form-group">        
      		<div class="col-sm-offset-2 col-sm-2">
        		<button type="submit" class="btn btn-default" id = "agregar" name = "agregar">Agregar</button>
			 	<button class="btn btn-default" type="button" id = "Back" 
			 <%
			 	if(type == Types.ORGANIZER_COORDINATOR_TYPE){
			 %>
			 onclick = "location.href='/coordinator/showAllOrganizers'"
			 <%
			 	}
			 	else if(type == Types.ORGANIZER_BOSS_TYPE){
			 %>
			 onclick = "location.href='/organizer/showWorkers'"
			 <%
			 	}
			 %>
			 >Atrás</button>
			 </div>
		</div>
		</form>
	</div>
	</body>
</html>