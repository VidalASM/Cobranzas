package com.zs.controllers;

import java.util.ArrayList;

import javax.jdo.PersistenceManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zs.models.Organizer;
import com.zs.models.Task;
import com.zs.session.User;
import com.zs.singleton.PersistenceManagerFact;
import com.zs.utils.Utils;
import com.zs.utils.Types;

@Controller
@Scope("request")
@RequestMapping("/")
@ComponentScan("com.zs.session")
public class RootController {

	@Autowired
	private User user;
	
	@RequestMapping(method=RequestMethod.GET)
	  public String index(ModelMap model)
	  {
		/*
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Organizer o = new Organizer();
		o.setFirstName("Christofer");
		o.setLastName("Chávez");
		o.setEmail("xnpiochv@gmail.com");
		o.setComite("comite organizador");
		o.setCategory("Coordinador General");
		o.setPassword(Utils.cifrar("pass", Utils.C_PO_C));
		o.setTasks(new ArrayList<Task>());
		pm.makePersistent(o);
		pm.close();
		*/
		model.addAttribute("organizer",user.getOrganizer());
		model.addAttribute("loginFlag",user.getLoginFlag());
		System.out.println(user.getLoginFlag());
		if(user.getLoginFlag() == 1) model.addAttribute("type", Types.TypeOrganizerMapping(user.getOrganizer().getCategory()));
		else model.addAttribute("type",-1);
	    return "index";
	  }
	
}
