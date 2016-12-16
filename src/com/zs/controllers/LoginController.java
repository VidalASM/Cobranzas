package com.zs.controllers;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.KeyFactory;
import com.zs.models.Organizer;
import com.zs.session.User;
import com.zs.singleton.PersistenceManagerFact;
import com.zs.utils.EmailSendService;
import com.zs.utils.Types;
import com.zs.utils.Utils;

@Controller
@Scope("request")
@RequestMapping("/login")
@ComponentScan("com.zs.session")
public class LoginController {
	
	@Autowired
	private User user;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getLoginPage(HttpServletRequest request, ModelMap model){
		int flag = user.getLoginFlag();
		if(flag == 1) return "redirect:/";
		model.addAttribute("flag", flag);
		return "login/loginPage";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, ModelMap model){
		user.setLoginFlag(0);
		user.setOrganizer(null);
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/getLogin" , method = RequestMethod.POST)
	public ModelAndView getLogin(HttpServletRequest request, ModelMap model){
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		String email = request.getParameter("email");
		email = email.toLowerCase();
		String pass = request.getParameter("pass");
		Query q = pm.newQuery(Organizer.class);
		q.setFilter("email == emailParam");
		q.declareParameters("String emailParam");
		int flag = 0;
		try{
			List<Organizer> or = (List<Organizer>) q.execute(email);
			if(or.size() == 0){
				flag = -1;
				user.setLoginFlag(flag);
				return new ModelAndView("redirect:/login/");
			}
			Organizer o = or.get(0);
			if(pass.equals(Utils.descifrar(o.getPassword(), Utils.C_PO_C)) == false){
				flag = -2;
				user.setLoginFlag(flag);
				return new ModelAndView("redirect:/login/");
			}
			flag = 1;
			user.setOrganizer(o);
			user.setLoginFlag(flag);
			int type = Types.TypeOrganizerMapping(o.getCategory());
			
			if(type == Types.ORGANIZER_BOSS_TYPE) return new ModelAndView("redirect:/organizer/getBossInterface");
			else if(type == Types.ORGANIZER_WORKER_TYPE) return new ModelAndView("redirect:/organizer/getWorkerInterface");
			else if(type == Types.ORGANIZER_COORDINATOR_TYPE) return new ModelAndView("redirect:/coordinator/interface");
		}finally{
			pm.close();
		}
		return null;
	}
	
	
	@RequestMapping(value = "/forgotPass" , method = RequestMethod.GET)
	public String getForgotForm(ModelMap model){
		model.addAttribute("flag",0);
		return "login/forgotPassForm";
	}
	
	@RequestMapping(value = "/forgotPass" , method = RequestMethod.POST)
	public String sendForgotEmail(HttpServletRequest request, ModelMap model){
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		EmailSendService em = new EmailSendService();
		String email = request.getParameter("email");
		email = email.toLowerCase();
		String pass = request.getParameter("pass");
		Query q = pm.newQuery(Organizer.class);
		q.setFilter("email == emailParam");
		q.declareParameters("String emailParam");
		int flag = 0;
		try{
			List<Organizer> or = (List<Organizer>) q.execute(email);
			if(or.size() == 0) flag = -1;
			else{
				String msg = Utils.MSG_FORGOT_PASS_HEADER + Utils.URL_ROOT + "/login/forgotPass/changePass/" + KeyFactory.keyToString(or.get(0).getId());
				em.send(msg, email, Utils.FORGOT_PASS_SUBJECT);
				flag = 1;
			}
		}finally{
			model.addAttribute("flag",flag);
			pm.close();
		}
		return "login/forgotPassForm";
	}
	
	@RequestMapping(value = "/forgotPass/changePass/{id}", method = RequestMethod.GET)
	public String getChangeForgotPassForm(@PathVariable String id, ModelMap model){
		model.addAttribute("id", id);
		model.addAttribute("flag",0);
		return "login/changeForgotPassForm";
	}
	
	@RequestMapping(value = "/forgotPass/changePass/{id}" , method = RequestMethod.POST)
	public String changeForgotPass(@PathVariable String id, HttpServletRequest request, ModelMap model){
		PersistenceManager pm = PersistenceManagerFact.get().getPersistenceManager();
		String pass = request.getParameter("pass");
		String passRep = request.getParameter("passRep");
		int flag = 0;
		model.addAttribute("id",id);
		if(pass.equals(passRep) == false){
			flag = -1;
			model.addAttribute("flag",flag);
			return "login/changeForgotPassForm";
		}
		try{
			Organizer o = pm.getObjectById(Organizer.class,id);
			o.setPassword(Utils.cifrar(pass, Utils.C_PO_C));
			flag = 1;
		}finally{
			pm.close();
			model.addAttribute("flag",flag);
		}
		return "login/changeForgotPassForm";
	}
	
}
