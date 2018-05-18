package com.eseict.assetmanager;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eseict.domain.EmployeeVO;
import com.eseict.service.EmployeeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private EmployeeService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String id = "kangsj";
		int checkDuplicate = service.checkIdDuplication(id);
		String dup1;
		if(checkDuplicate == 1)
			dup1 = "Already exists";
		else
			dup1 = "Available";

		id = "choiyk";
		checkDuplicate = service.checkIdDuplication(id);
		String dup2;
		if(checkDuplicate == 1)
			dup2 = "Already exists";
		else
			dup2 = "Available";

		model.addAttribute("dup1", dup1 );
		model.addAttribute("dup2", dup2 );
		
		return "home";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		
		return "login";
	}
	
	@RequestMapping(value = "/loginSubmit", method = RequestMethod.POST)
	public void loginSubmit(HttpServletResponse response, @RequestParam("inputId") String inputId, @RequestParam("inputPw") String inputPw) throws IOException {
		int check = service.checkRegistered(inputId, inputPw);
		response.getWriter().println(check);			
	}
	
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public void checkId(HttpServletResponse response, @RequestParam("checkId") String inputId) throws IOException {
		int check = service.checkIdDuplication(inputId);
		response.getWriter().println(check);
	}
	
	@RequestMapping(value = "/registerSend", method = RequestMethod.POST)
	public String registerSend(@ModelAttribute("employee") EmployeeVO vo) {
		service.newEmployee(vo);
		return "redirect:/";
	}
		
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {
		return "employeeRegister";
	}
}
