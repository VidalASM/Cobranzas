package com.zs.utils;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.zs.models.Comite;

public class Utils {
	
	private static final String PATTERN_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
 
	public static final String MSG_HEADER = "EVENTUS 2.0 Lo invita a usted a ser parte de la organización"
			+ " de un gran evento. </br> Haga click en el siguiente enlace para completar su registro: </br>";
	
	public static final String MSG_FORGOT_PASS_HEADER = "Usted ha solicitado un cambio de contraseña </br>"
			+ "Haga click en el siguiente enlace: </br>";
	
	public static final String URL_ROOT = "www.csunsa.com";
	
	public static final String VERIFY_ACOOUNT_SUBJECT = "EVENTUS 2.0 - Confirmar registro";
	
	public static final String FORGOT_PASS_SUBJECT = "EVENTUS 2.0 - Cambio de Contraseña";
	
	public static final int C_PO_C = 171717;
	
	public static final int C_IDO_C = 131516;
	
	public static final int C_IDC_C = 161513;
	
	public static String cifrar(String original, int clave){
        StringBuilder cifrado = new StringBuilder(original.length());
        int valorASCII = 0;
        for(int i = 0;i < original.length(); i++){
            valorASCII = (int)(original.charAt(i));
            valorASCII = valorASCII + clave % 255;
            cifrado.append((char)(valorASCII));
        }
        return cifrado.toString();
    }

    public static String descifrar(String original, int clave){
        StringBuilder descifrado = new StringBuilder(original.length());
        int ASCIIcifrado = 0, n = 0;
        for(int i = 0;i < original.length(); i++){
            ASCIIcifrado = (int)(original.charAt(i));
            ASCIIcifrado = ASCIIcifrado - clave % 255;
            descifrado.append((char)(ASCIIcifrado));
        }
        return descifrado.toString();
    }
	
	
	public Utils() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean validateEmail(String email) {
		 
        // Compiles the given regular expression into a pattern.
        Pattern pattern = Pattern.compile(PATTERN_EMAIL);
 
        // Match the given input against this pattern
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
 
    }
	
	public static String firstToUpperCase(String cadena){
		if(cadena.length() == 0) return cadena;
		if(cadena.length() == 1) return cadena.toUpperCase();
		String resultado = cadena.substring(0,1).toUpperCase() + cadena.substring(1);
		return resultado;
	}
	
	public static Comite getOrganizerComite(){
		Comite c = new Comite();
		c.setName("Comite Organizador");
		c.setDescripcion("Comité encargado de la organización general y la planificación del evento. Este comité no se puede borrar");
		return c;
	}
	
	public ArrayList<String> getCountries(){
		ArrayList<String> countries = new ArrayList<String>();
		countries.add("Argentina");
		countries.add("Bolivia");
		countries.add("Brasil");
		countries.add("Colombia");
		countries.add("Chile");
		countries.add("Ecuador");
		countries.add("Paraguay");
		countries.add("Peru");
		countries.add("Uruguay");
		countries.add("Venezuela");
	    return countries;
	}
	
	public ArrayList<String> getCategories(){
		ArrayList<String> categories = new ArrayList<String>();
		categories.add("Autor");
		categories.add("Profesional");
		categories.add("Estudiante");
		categories.add("Empresa");
		categories.add("Libre");
	    return categories;
	}
	
}
