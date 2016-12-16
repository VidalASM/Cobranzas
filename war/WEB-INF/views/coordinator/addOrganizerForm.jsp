<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.zs.models.Comite" %>
<%@ page import="com.zs.utils.Utils" %>
<%@ page import="com.zs.utils.Types" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
	int flag = (Integer) request.getAttribute("flag");
	int type = (Integer) request.getAttribute("type");
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
	   <h2>Añadir Organizador</h2>
	   <p> En este panel podrá añadir algún organizador.</p>
	  </div>
	</div>
	<div class="container">
		<form class="form-horizontal" method="post" action = "/coordinator/addOrganizer">
			
			<%
				if(flag != 0){
					if(flag == 1){
			%>
		
			<div class="alert alert-success">
    		<strong>Correcto!</strong> Su organizador ha sido agregado exitosamente.
  			</div> 
			
			<%
					}
					else if(flag == -1){
			%>
			
			<div class="alert alert-danger">
    			<strong>Oh my!</strong> El correo ya está asociado al organizador.
  			</div>
			
			<%
					}
					else if(flag == -2){
			%>
			
			<div class="alert alert-danger">
    			<strong>Oh my!</strong> Usted debe ingresar un correo válido.
  			</div>
  			
  			<%
					}
				}
  			%>
			
			<div class="form-group">		
				<label class="control-label col-sm-2" for="email">Nombre:</label>
				<div class="col-sm-10"> 
					<input type = "text" class="form-control" name = "firstName" id = "firstName" placeholder="Ingrese un nombre">
				</div>
			</div>
			
			<div class="form-group">		
				<label class="control-label col-sm-2" for="email">Apellido:</label>
				<div class="col-sm-10"> 
					<input type = "text" class="form-control" name = "lastName" id = "lastName" placeholder="Ingrese un apellido">
				</div>
			</div>
			
			<div class="form-group">		
				<label class="control-label col-sm-2" for="email">E-mail:</label>
				<div class="col-sm-10"> 
					<input type = "text" class="form-control" name = "email" id = "email" placeholder="Ingrese el e-mail">
				</div>
			</div>
			
			<div class="form-group">		
				<label class="control-label col-sm-2" for="email">Comité:</label>
				<div class="col-sm-10"> 
					<select class="form-control" name = "comite" id = "comite" placeholder="Seleccione un comité" >
						<%
							if(type == Types.ORGANIZER_COORDINATOR_TYPE){
								for(Comite c : comites){
						%>
						
								<option value="<%=c.getName()%>"><%=util.firstToUpperCase(c.getName())%></option>
						
						<%
								}
							}
							else if(type == Types.ORGANIZER_BOSS_TYPE){
						%>
								<option value="<%=comites.get(0).getName()%>"><%=Utils.firstToUpperCase(comites.get(0).getName())%></option>
						<%
							}
						%>
						
					</select>
				</div>
			</div>
			
			<div class="form-group">		
				<label class="control-label col-sm-2" for="email">Categoría:</label>
				<div class="col-sm-10"> 
					<select class="form-control" name = "category" id = "category" placeholder="Seleccione una categoría">
							<option value="Jefe">Jefe</option>
							<option value="Trabajador">Trabajador</option>
						</select>
				</div>
			</div>
									
			<div class="form-group">        
      		<div class="col-sm-offset-2 col-sm-10">
        		<button type="submit" class="btn btn-default" id = "Crear">Crear</button>
        		<button type="button" class="btn btn-default" id = "Back" 
        			
        				<%
							if(type == Types.ORGANIZER_COORDINATOR_TYPE){
						%>
							onclick = "location.href='/coordinator/interface'"	
						<%
							}
							else if(type == Types.ORGANIZER_BOSS_TYPE){
						%>			
							onclick = "location.href='/organizer/getBossInterface'"
						<%
							}
						%>
						>Atrás</button>
      		</div>
    	</div>
		</form>
		<hr></hr>
      <footer><p>© 2016 ZealotSoft</p></footer>
	</body>
</html>