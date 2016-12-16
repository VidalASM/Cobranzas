package com.zs.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.JDOFatalUserException;
import javax.jdo.JDOUserException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.zs.models.Comite;
import com.zs.models.Organizer;
import com.zs.models.Task;
import com.zs.session.User;
import com.zs.singleton.PersistenceManagerFact;
import com.zs.utils.Utils;
import com.zs.utils.Types;

@Controller
@Scope("request")
@RequestMapping("/organizer")
@ComponentScan("com.zs.session")
public class OrganizerController {
	
	@Autowired
	private User user;
	
	@RequestMapping(value = "/verifyAccount/{id}" , method = RequestMethod.GET)
	public String getVerifyAccountForm(@PathVariable String id, ModelMap model){
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		int flag = 0;
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			String pass = Utils.descifrar(o.getPassword(), Utils.C_PO_C);
			if(pass.equals(id)){
				Query q = pm.newQuery(Comite.class);
				q.setFilter("name == comiteName");
				q.declareParameters("String comiteName");
				List<Comite> res = (List<Comite>) q.execute(o.getComite());
				model.addAttribute("organizer",o);
				if(res.size() == 0) model.addAttribute("comite",Utils.getOrganizerComite());
				else model.addAttribute("comite", res.get(0));
				flag = 1;
			}
			else flag = -2;
		}
		catch(JDOUserException e){
			flag = -1;
		}
		catch(JDOFatalUserException e){
			flag = -1;
		}
		finally{
			pm.close();
			model.addAttribute("flag",flag);
		}
		return "organizer/verifyAccountForm";
	}
	
	@RequestMapping(value = "/verifyAccount/{id}" , method = RequestMethod.POST)
	public String verifyAccountForm(@PathVariable String id, HttpServletRequest request, ModelMap model){
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String pass = request.getParameter("pass");
		String passRep = request.getParameter("passRep");
		int flag = 0;
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			if(pass.equals(passRep) == false){
				Query q = pm.newQuery(Comite.class);
				q.setFilter("name == comiteName");
				q.declareParameters("String comiteName");
				List<Comite> res = (List<Comite>) q.execute(o.getComite());
				model.addAttribute("organizer",o);
				if(res.size() == 0) model.addAttribute("comite",Utils.getOrganizerComite());
				else model.addAttribute("comite", res.get(0));
				flag = -3;
			}
			else{
				o.setFirstName(firstName);
				o.setLastName(lastName);
				o.setPassword(Utils.cifrar(pass, Utils.C_PO_C));
				flag = 2;
				user.setLoginFlag(0);
				user.setOrganizer(null);
			}
		}
		catch(JDOUserException e){
			flag = -1;
		}
		finally{
			pm.close();
			model.addAttribute("flag",flag);
		}
		return "organizer/verifyAccountForm";
	}
	
	@RequestMapping(value = "/getBossInterface" , method = RequestMethod.GET)
	public String getBossInterface(HttpServletRequest request, ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Jefe") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		model.addAttribute("organizer",o);
		return "organizer/bossInterface";
	}
	
	@RequestMapping(value = "/getWorkerInterface", method = RequestMethod.GET)
	public String getWorkerInterface(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Trabajador") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		model.addAttribute("organizer",o);
		return "organizer/workerInterface";
	}
	
	@RequestMapping(value = "/addWorker", method = RequestMethod.GET)
	public String getAddWorkerForm(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Jefe") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		model.addAttribute("type",Types.ORGANIZER_BOSS_TYPE);
		List<Comite> com = new ArrayList<Comite>();
		Comite c = new Comite();
		c.setName(o.getComite());
		com.add(c);
		model.addAttribute("comites",com);
		model.addAttribute("flag",0);
		return "coordinator/addOrganizerForm";
	}
	
	@RequestMapping(value = "/addTask/{id}" , method = RequestMethod.GET)
	public String getAddTaskForm(@PathVariable String id, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || (oo.getCategory().equals("Coordinador General") == false && oo.getCategory().equals("Jefe") == false)){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		model.addAttribute("id",id);
		model.addAttribute("type", Types.TypeOrganizerMapping(oo.getCategory()));
		model.addAttribute("flag",0);
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			model.addAttribute("organizer",o);
		}finally{
			pm.close();
		}
		return "organizer/addTaskForm";
	}
	
	
	@RequestMapping(value = "/addTask/{id}" , method = RequestMethod.POST)
	public String addTask(@PathVariable String id, HttpServletRequest request, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || (oo.getCategory().equals("Coordinador General") == false && oo.getCategory().equals("Jefe") == false)){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		String title = request.getParameter("title");
		String priority = request.getParameter("priority");
		String descripcion = request.getParameter("descripcion");
		model.addAttribute("id",id);
		model.addAttribute("type", Types.TypeOrganizerMapping(oo.getCategory()));
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			//if(o.getTasks() == null) o.setTasks(new ArrayList<Task>());
			Task t = new Task();
			t.setTitle(title);
			t.setPriority(priority);
			t.setDescripcion(descripcion);
			t.setDone(0);
			t.setOrganizer(o);
			t = pm.makePersistent(t);
			
			List<Task> ts = o.getTasks();
			ts.add(t);
			o.setTasks(ts);
			model.addAttribute("organizer",o);
			model.addAttribute("flag", 1);
		}finally{
			pm.close();
		}
		return "organizer/addTaskForm";
		
	}
	
	@RequestMapping(value = "/showWorkers", method = RequestMethod.GET)
	public String showWorkers(ModelMap model){
		Organizer o = user.getOrganizer();
		if(o == null || o.getCategory().equals("Jefe") == false){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		Query q = pm.newQuery(Organizer.class);
		q.setFilter("category == 'Trabajador' && comite == comiteParam");
		q.declareParameters("String comiteParam");
		//q.setOrdering("firstName asc");
		try{
			List<Organizer> or = (List<Organizer>) q.execute(user.getOrganizer().getComite());
			model.addAttribute("result",or);
			model.addAttribute("type", Types.ORGANIZER_BOSS_TYPE);
		}finally{
			pm.close();
		}
		return "coordinator/showAllOrganizers";
	}
	
	@RequestMapping(value = "/showTasks/{id}/{del}" , method = RequestMethod.GET)
	public String showTasks(@PathVariable String id, @PathVariable int del, ModelMap model){
		if(user.getLoginFlag() != 1){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		model.addAttribute("type",Types.TypeOrganizerMapping(user.getOrganizer().getCategory()));
		model.addAttribute("id",id);
		model.addAttribute("flag",del);
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			List<Task> t = o.getTasks();
			model.addAttribute("tasks",t);
			model.addAttribute("organizer",o);
		}finally{
			pm.close();
		}
		return "organizer/showTasks";
	}
	
	@RequestMapping(value = "/deleteTask/{id}/{tId}/{del}" , method = RequestMethod.GET)
	public String deleteTask(@PathVariable String id, @PathVariable String tId, @PathVariable String del, ModelMap model){
		Organizer oo = user.getOrganizer();
		if(oo == null || (oo.getCategory().equals("Coordinador General") == false && oo.getCategory().equals("Jefe") == false)){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		try{
			Task t = pm.getObjectById(Task.class,tId);
			pm.deletePersistent(t);
		}finally{
			pm.close();
		}
		return "redirect:/organizer/showTasks/" + id + "/" + del; 
	}
	
	@RequestMapping(value = "/setDoneTask/{id}/{tId}/{tDone}/{del}" , method = RequestMethod.GET)
	public String setDoneTask(@PathVariable String id, @PathVariable String tId, @PathVariable int tDone, @PathVariable String del,ModelMap model){
		if(user.getLoginFlag() != 1){
			if(user.getLoginFlag() != 0 && user.getLoginFlag() != 1) user.setLoginFlag(0);
			return "redirect:/login/";
		}
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		try{
			Task t = pm.getObjectById(Task.class,tId);
			t.setDone(tDone);
		}finally{
			pm.close();
		}
		return "redirect:/organizer/showTasks/" + id + "/" + del;
	}
	
	
}
