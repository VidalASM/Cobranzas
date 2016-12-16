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
            <li><a href="#">Acerca</a></li>
            <li><a href="#">Contacto</a></li>
            <li class="active"><a href="#">Iniciar Sesión</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="jumbotron">
	  <div class="container">
	   <h2>Iniciar Sesión<h2>
	   <p> Inicie sesión como organizador o trabajador del evento.</p>
	  </div>
	</div>
		<%
			if(flag != 0){
				if(flag == -1){				
		%>
				<div class="alert alert-danger">
    			<strong>Oh my!</strong> El correo no está asociado a ningún organizador.
  				</div>
			
		<%
				}
				else if(flag == -2){
		%>
				<div class="alert alert-danger">
    			<strong>Oh my!</strong> La contraseña es incorrecta.
  				</div>
		<%
				}
			}
		%>
		<div class="container">
			<form class="form-horizontal" method = "post" action = "/login/getLogin">
				<div class="form-group">		
					<label class="control-label col-sm-2" for="email">Correo:</label>
					<div class="col-sm-10"> 
						<input type = "text" class="form-control" name = "email" id = "email" placeholder="Ingrese su e-mail">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">Contraseña:</label>
					<div class="col-sm-10"> 
						<input type = "password" class="form-control" name = "pass" id = "pass" placeholder="Agrege un nombre">
					</div>
				</div>
				<div class="form-group">        
      				<div class="col-sm-offset-2 col-sm-10">				
						<button class="btn btn-default" type = "submit" name = "ingresar" id = "ingresar">Ingresar</button>
						<button class="btn btn-default" type="button" id = "Init" onclick = "location.href='/login/forgotPass'">Olvidé mi contraseña</button>
					</div>
				</div>	
			</form>
		</div>
		
		<div class="container col-sm-4">
		<div class="alert alert-info">
  			<strong>Coordinador General</strong> xnpiochv@gmail.com -> pass.</br>
  			<strong>Jefe de Comité</strong> stratwonder2@gmail.com -> 1234.</br>
  			<strong>Trabajador</strong> cristo2014f@outlook.es -> pass.</br>
		</div>
		</div>
		
	</body>
</html>