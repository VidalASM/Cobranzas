<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	   <h1>Panel de Coordinador</h1>
	   <p> En este panel podra añadir o visualizar algún comité u organizador.</p>
	  </div>
	 </div>
	 <div class="container">
      <!-- Example row of columns -->
      <div class="row">
	 	<div class="col-md-4" style="background-color:lavender;">
	 	 <h2>Añadir</h2>
	 	 <a class="btn btn-default" role="button" href="/coordinator/addComite">Añadir Comite</a></br></br>
	 	 <a class="btn btn-default" role="button" href="/coordinator/addOrganizer">Añadir Organizador</a>
	 	</div>
		<div class="col-md-4" style="background-color:lavenderblush;">
		 <h2>Visualizar</h2>
		 <a class="btn btn-default" role="button" href="/coordinator/showAllOrganizers">Ver Organizadores</a></br></br>
		 <a class="btn btn-default" role="button" href="/coordinator/showAllComites">Ver Comites</a>
		</div>
	   </div>
	   <a class="btn btn-default" role="button" href="/login/logout">LogOut</a></br></br>
      <hr></hr>
      <footer><p>© 2016 ZealotSoft</p></footer>
    </div>	
	</body>
</html>
