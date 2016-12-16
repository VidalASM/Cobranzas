<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.zs.models.Organizer" %>
<%@ page import="com.zs.models.Comite" %>
<%@ page import="com.zs.utils.Utils" %>
<%@ page import= "com.google.appengine.api.datastore.KeyFactory"%>
<% 
	int flag = (Integer) request.getAttribute("flag");
	Organizer o = (Organizer) request.getAttribute("organizer");
	Comite c = (Comite) request.getAttribute("comite");
%>

<html>
	<body>
	
		<%
			if(flag == -1){
		%>
			
			Usted ha sido eliminado de la organización. Comuníquese con su superior para resolver el inconveniente.
			
			<button type="button" id = "Init" onclick = "location.href='/'">Regresar</button>
			
		<%
			}
			else if(flag == -2){
		%>
					
			Usted ya ha verificado su cuenta.
			
			<button type="button" id = "Init" onclick = "location.href='/'">Regresar</button>
					
					
		<%
			}
			else if(flag == 1 || flag == -3){
				if(flag == -3){
				
		%>
				
				Las contraseñas no coinciden.
				
		<%
				}
		%>
				
		<form method = "post" action = "<%=KeyFactory.keyToString(o.getId())%>">
			Usted está en el siguiente comité: <%=Utils.firstToUpperCase(c.getName())%> </br>
			Descripción del comité: <%=c.getDescripcion()%> </br>
			Usted es <%=o.getCategory()%> de este comité. </br>
			Verifique sus datos e ingrese su password: </br>
			Nombre: <input type = "text" name = "firstName" id = "firstName" value = "<%=o.getFirstName()%>"></br>	
			Apellido: <input type = "text" name = "lastName" id = "lastName" value = "<%=o.getLastName()%>"></br>
			Contraseña: <input type = "password" name = "pass" id = "pass"> </br>
			Repetir Contraseña: <input type = "password" name = "passRep" id = "passRep"> </br>
			<input type="submit" name = "Save" id = "Save" value = "Guardar">
		</form>
		
		<%
			}
			else if(flag == 2){
		%>
		
			Sus datos han ido guardados correctamente.
			
			<button type="button" id = "Init" onclick = "location.href='/login/'">Continuar</button>
			
		<%
			}
		%>
		
	</body>
</html>