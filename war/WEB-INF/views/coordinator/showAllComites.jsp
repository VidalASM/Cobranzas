<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.zs.models.Comite" %>
<%@ page import="com.zs.utils.Utils" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	List<Comite> comites = (List<Comite>) request.getAttribute("comites");
	Utils util = new Utils();
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
          	<li><a href="#">Inicio</a></li>
            <li class="active"><a href="/coordinator/interface">Mi Panel</a></li>
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
	   <h2>Visualizar Comités</h2>
	   <p> En este panel podrá visualizar todos los comités existentes.</p>
	  </div>
	</div>
	<div class="container">
		<h2>Comités Actuales</h2>
		<div class="table-responsive">
		 <table class="table table-striped">
			<tr>
				<th>Nombre</th>
				<th>Descripción</th>
				<th>Acciones</th>
			</tr>
			
			<%
				for(Comite c : comites){
			%>
			
			<tr>
				<td><%=util.firstToUpperCase(c.getName())%></td>
				<td><%=c.getDescripcion() %></td>
				<%
					if(c.getName().equals("Comite Organizador") == false){
				%>
					<td><a href="/coordinator/deleteComite/<%=KeyFactory.keyToString(c.getId())%>">Eliminar</a>
					
				<%
					}
				%>
			</tr>
			
			<%
				}
			%>
		 </table>
		 <button type="button" class="btn btn-default" id = "Back" onclick = "location.href='/coordinator/interface'">Atrás</button>
		</div>
		<hr></hr>
      <footer><p>© 2016 ZealotSoft</p></footer>
	</body>
</html>