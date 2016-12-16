<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
	int flag = (Integer) request.getAttribute("flag");
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
	   <h2>Añadir Comité</h2>
	   <p> En este panel podrá añadir algún comité.</p>
	  </div>
	</div>
	<div class="container">
		<form class="form-horizontal" method = "post" action = "addComite">
			
			<%
				if(flag != 0){
					if(flag == 1){
			%>
		
			<div class="alert alert-success">
    		<strong>Correcto!</strong> Su comité ha sido creado exitosamente.
  			</div>
		
			<%
					}
					else if(flag == -1){
			%>
		
			<div class="alert alert-danger">
    			<strong>Oh my!</strong> El comité ya existe, pruebe con uno diferente.
  			</div>
			
			<%
					}
				}
			%>
		<div class="form-group">		
			<label class="control-label col-sm-6" for="email">Nombre:</label>
			<div class="col-sm-4"> 
				<input type = "text" class="form-control" name = "comiteName" id = "comiteName" placeholder="Agrege un nombre">
			</div>
		</div>
		<div class="form-group">		
			<label class="control-label col-sm-6" for="email">Descripción</label>
			<div class="col-sm-4"> 
				<textarea class="form-control" rows="5" name = "descripcion" id = "descripcion" placeholder="Escriba aquí la descripción"></textarea> </br>
			</div>
		</div>
    	<div class="form-group">        
      		<div class="col-sm-offset-2 col-sm-4">
        		<button type="submit" class="btn btn-default" id = "Crear">Crear</button>
        		<button type="button" class="btn btn-default" id = "Back" onclick = "location.href='/coordinator/interface'">Atrás</button>
      		</div>
    	</div>
		</form>
		</div>
		<hr></hr>
     	<footer><p>© 2016 ZealotSoft</p></footer>
	</body>
</html>