<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.zs.models.Organizer" %>
<%@ page import="com.zs.utils.Types" %>

<%
	int loginFlag = (Integer) request.getAttribute("loginFlag");
	int type = (Integer) request.getAttribute("type");
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
          	<li class="active"><a href="#">Inicio</a></li>
            <li><a href="#">Acerca</a></li>
            <li><a href="#">Contacto</a></li>
            <%
			if(loginFlag == 1){
				if(type == Types.ORGANIZER_COORDINATOR_TYPE){
		%>
				<li><a href="/coordinator/interface">Mi Panel</a></li>
		<%
				}
				else if(type == Types.ORGANIZER_BOSS_TYPE){
		%>
				<li><a href="/organizer/getBossInterface">Mi Panel</a></li>
		<%
				}
				else if(type == Types.ORGANIZER_WORKER_TYPE){
		%>
				<li><a href="/organizer/getWorkerInterface">Mi Panel</a></li>
		<%
				}
		%>
			<li><a href="/login/logout">Logout</a></li>
		<%
			}
			else{
		%>
			<li><a href="/login/">Iniciar Sesión</a></li>
		<%
			}
		%>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
    <div class="jumbotron">
      <div class="container">
        <h1>Festival de Música Tradicional y Contemporánea</h1>
        <p>El nuevo festival tradicional esta cerca a la fecha. Inscriba gratis a su banda en el siguiente link: </p>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Inscripciones »</a></p>
      </div>
	</div>
	<div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Música Tradicional</h2>
          <p>Ya llego la mejor música folclórica de todos los rincones del Pedu. Entre nuestros invitados estrellas se encuentra Carmencita Lara y Los Quipus. No se pierda de esta grandiosa oportunidad!</p>
          <p><a class="btn btn-default" href="#" role="button">Ver más »</a></p>
        </div>
        <div class="col-md-4">
          <h2>Chichapop</h2>
          <p>El nuevo centro musical de todo el Pedu. Los increibles fantásticos se encuentran listos para bailar. Desde los éxitos como <em>Campanas de Belén</em> hasta el último hit <em>July no toques</em>.</p>
          <p><a class="btn btn-default" href="#" role="button">Ver más »</a></p>
       </div>
        <div class="col-md-4">
          <h2>Métal Cristiano</h2>
          <p>Desde el inframundo llegan los mejores demonios, los únicos diablishos reformados. Entre las grupos se encuentra el famoso <em>XNPIO</em> que nos deleitará con sus últimos suicidios artísticos.</p>
          <p><a class="btn btn-default" href="#" role="button">Ver más »</a></p>
        </div>
      </div>

      <hr>

      <footer>
        <p>© 2016 ZealotSoft.</p>
      </footer>
    </div>
	
	</body>
</html>