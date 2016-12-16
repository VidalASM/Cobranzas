<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.zs.models.Organizer" %>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%
	Organizer o = (Organizer) request.getAttribute("organizer");
%>

<html>
	<body>
		<a href="/organizer/addWorker">Añadir Organizador</a> </br>
		<a href="/organizer/showWorkers">Ver Trabajadores</a> </br>
		<a href="/organizer/showTasks/<%=KeyFactory.keyToString(o.getId())%>/0">Ver Mis Tareas</a></br>
		<a href = "/login/logout">LogOut</a>
	</body>
</html>
