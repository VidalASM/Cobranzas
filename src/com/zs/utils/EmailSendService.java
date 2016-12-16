package com.zs.utils;


import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.errors.MailjetSocketTimeoutException;
import com.mailjet.client.resource.Email;

import javax.servlet.ServletException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class EmailSendService {

	//private static final String MAILJET_API_KEY = System.getenv("MAILJET_API_KEY");
	private static final String MAILJET_API_KEY = "307ee54ec2832b81d4117953c49ee7bb";
	//private static final String MAILJET_SECRET_KEY = System.getenv("MAILJET_SECRET_KEY");
	private static final String MAILJET_SECRET_KEY = "77c3ff1040f31259e2262e6c2cd25702";
	private MailjetClient client = new MailjetClient(MAILJET_API_KEY, MAILJET_SECRET_KEY);
	private static final String sender = "zealotsoft17@gmail.com";
	
	
	public void send(String men, String TO, String subject){
		
		try{
		MailjetRequest email = new MailjetRequest(Email.resource)
		        .property(Email.FROMEMAIL, sender)
		        .property(Email.FROMNAME, "EVENTUS 2.0")
		        .property(Email.SUBJECT, subject)
		        .property(Email.HTMLPART,
		            men)
		        .property(Email.RECIPIENTS, new JSONArray().put(new JSONObject().put("Email", TO)));
		
		      MailjetResponse response = client.post(email);
		}
		catch (MailjetException e) {
			e.printStackTrace();
		} catch (MailjetSocketTimeoutException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
