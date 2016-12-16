package com.zs.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.JDOUserException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.annotations.Transactional;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.zs.utils.Types;
import com.zs.models.Comite;
import com.zs.models.Organizer;
import com.zs.session.User;
import com.zs.singleton.PersistenceManagerFact;
import com.zs.utils.EmailSendService;
import com.zs.utils.Utils;

@Controller
@Scope("request")
@RequestMapping("/coordinator")
@ComponentScan("com.zs.session")
public class GeneralCoordinatorController {
	
	@Autowired
	private User user;
	
	
	@RequestMapping(value = "/interface", method = RequestMethod.GET)
	public String getGeneralCoordinatorPage(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		return "coordinator/CoordinatorPage"; //TODO Falta ver si se necesita enviear algun dato a la interfaz del coordinador.
	}
	
	@RequestMapping(value = "/addOrganizer" , method = RequestMethod.GET)
	public String getAddOrganizerForm(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		int flag = 0;
		model.addAttribute("flag", flag);
		model.addAttribute("type", Types.ORGANIZER_COORDINATOR_TYPE);
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Query q = pm.newQuery(Comite.class);
		q.setOrdering("name asc");
		List<Comite> comites = new ArrayList<Comite>();
		Utils u = new Utils();
		comites.add(u.getOrganizerComite());
		try{
			comites.addAll((List<Comite>) q.execute());
			model.addAttribute("comites", comites);
		}finally{
			pm.close();
		}
		return "coordinator/addOrganizerForm"; //TODO Falta ver si se necesita enviear algun dato al formulario.
	}
	
	@RequestMapping(value = "/addComite" , method = RequestMethod.GET)
	public String getAddComite(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		int flag = 0;
		model.addAttribute("flag", flag);
		return "coordinator/addComiteForm";
	}
	
	@RequestMapping(value = "/addComite" , method = RequestMethod.POST)
	public String addComite(HttpServletRequest request, ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		String name = request.getParameter("comiteName");
		name = name.toLowerCase();
		String des = request.getParameter("descripcion");
		int flag = -1;
		Query q = pm.newQuery(Comite.class);
		q.setFilter("name == nameParam");
		q.declareParameters("String nameParam");
		List<Comite> comites = new ArrayList<Comite>();
		try{
			comites = (List<Comite>) q.execute(name);
			if(comites.size() == 0){
				Comite c = new Comite();
				c.setName(name);
				c.setDescripcion(des);
				pm.makePersistent(c);
				flag = 1;
				return "coordinator/addComiteForm";
			}
		}
			
		finally{
			pm.close();
			model.addAttribute("flag", flag);
		}
		return "coordinator/addComiteForm";
		
	}
	
	@RequestMapping(value = "/addOrganizer" , method = RequestMethod.POST)
	public String addOrganizer(HttpServletRequest request, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || (oo.getCategory().equals("Coordinador General") == false && oo.getCategory().equals("Jefe") == false)){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Utils u = new Utils();
		EmailSendService ess = new EmailSendService();
		String email = request.getParameter("email");
		email = email.toLowerCase();
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String comite = request.getParameter("comite");
		System.out.print(comite);
		comite = comite.toLowerCase();
		String category = request.getParameter("category");
		if(oo.getCategory().equals("Jefe")) model.addAttribute("type", Types.ORGANIZER_BOSS_TYPE);
		else model.addAttribute("type", Types.ORGANIZER_COORDINATOR_TYPE);
		int flag = -1;
		if(u.validateEmail(email) == false) flag = -2;
		Query q = pm.newQuery(Comite.class);
		q.setOrdering("name asc");
		List<Comite> comites = new ArrayList<Comite>();
		List<Organizer> organizers = new ArrayList<Organizer>();
		comites.add(u.getOrganizerComite());
		Query qq = pm.newQuery(Organizer.class);
		qq.setFilter("email == emailParam");
		qq.declareParameters("String emailParam");
		try{
			comites.addAll((List<Comite>) q.execute());
			if(flag != -2){
				organizers = (List<Organizer>) qq.execute(email);
				if(organizers.size() == 0){
					Organizer o = new Organizer();
					o.setEmail(email);
					o.setFirstName(firstName);
					o.setLastName(lastName);
					o.setComite(comite);
					o.setCategory(category);
					o = pm.makePersistent(o);
					String msg = Utils.MSG_HEADER + Utils.URL_ROOT + "/organizer/verifyAccount/" +  KeyFactory.keyToString(o.getId());
					ess.send(msg, email, Utils.VERIFY_ACOOUNT_SUBJECT);
					o.setPassword(Utils.cifrar(KeyFactory.keyToString(o.getId()), Utils.C_PO_C));
					flag = 1;	
				}
			}
		}
		finally{
			pm.close();
			model.addAttribute("flag", flag);
			if(oo.getCategory().equals("Jefe")){
				List<Comite> com = new ArrayList<Comite>();
				Comite c = new Comite();
				c.setName(oo.getComite());
				com.add(c);
				model.addAttribute("comites",com);
			}
			else model.addAttribute("comites", comites);
			
		}
		
	
		return "coordinator/addOrganizerForm"; 
	}
	
	@RequestMapping(value = "/showAllOrganizers" , method = RequestMethod.GET)
	public String showAllOrganizers(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Query q = pm.newQuery(Organizer.class);
		q.setOrdering("comite asc");
		List<Organizer> result = new ArrayList<Organizer>();
		try{
			result = (List<Organizer>) q.execute();
			model.addAttribute("result", result);
			model.addAttribute("type", Types.ORGANIZER_COORDINATOR_TYPE);
			
		}finally{
			pm.close();
		}
		return "coordinator/showAllOrganizers";
	}
	
	@RequestMapping(value = "/showAllComites" , method = RequestMethod.GET)
	public String showAllComites(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Query q = pm.newQuery(Comite.class);
		q.setOrdering("name asc");
		List<Comite> comites = new ArrayList<Comite>();
		comites.add(Utils.getOrganizerComite());
		try{
			comites.addAll((List<Comite>) q.execute());
			model.addAttribute("comites",comites);
		}finally{
			pm.close();
		}
		return "coordinator/showAllComites";
	}
	
	@RequestMapping(value = "/deleteOrganizer/{id}" , method = RequestMethod.GET)
	public ModelAndView deleteOrganizer(@PathVariable String id, HttpServletRequest request, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || (oo.getCategory().equals("Coordinador General") == false && oo.getCategory().equals("Jefe") == false)){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return new ModelAndView("redirect:/login/");
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		try{
			Organizer o = pm.getObjectById(Organizer.class, id);
			pm.deletePersistent(o);
		}finally{
			pm.close();
		}
		if(oo.getCategory().equals("Coordinador General")) return new ModelAndView("redirect:/coordinator/showAllOrganizers");
		return new ModelAndView("redirect:/organizer/showWorkers");
	}
	
	@RequestMapping(value = "/deleteComite/{id}" , method = RequestMethod.GET)
	public ModelAndView deleteCOmite(@PathVariable String id, HttpServletRequest request, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || oo.getCategory().equals("Coordinador General") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return new ModelAndView("redirect:/login/");
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Query q = pm.newQuery(Organizer.class);
		q.setFilter("comite == comiteParam");
		q.declareParameters("String comiteParam");
		try{
			Comite c = pm.getObjectById(Comite.class,id);
			List<Organizer> or = (List<Organizer>) q.execute(c.getName());
			pm.deletePersistentAll(or);
			pm.deletePersistent(c);
		}finally{
			pm.close();
		}
		return new ModelAndView("redirect:../showAllComites");
	}
	
	
}
