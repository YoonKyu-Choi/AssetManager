package com.eseict.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eseict.VO.EmployeeVO;
import com.eseict.service.EmployeeService;

@Controller
public class LoginController {
	
	@Autowired
	private EmployeeService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(HttpSession session, Locale locale, Model model) {
		if(session.getAttribute("userLoginInfo") == "Logged")
			return "redirect:/loginGet";
		else
			return "login";
	}
	
	@RequestMapping(value = "/loginSubmit", method = RequestMethod.POST)
	@ResponseBody
	public String loginSubmit(HttpSession session, HttpServletResponse response, @RequestParam("inputId") String inputId, @RequestParam("inputPw") String inputPw) throws IOException {
		int check = service.checkRegistered(inputId, inputPw);
		session.removeAttribute("userLoginInfo");
		if(check == 1) {
			session.setAttribute("userLoginInfo", "Logged");
		}
		return Integer.toString(check);
	}
	
	@RequestMapping(value = "/checkId")
	@ResponseBody
	public String checkId(@RequestParam("id") String inputId) throws IOException {
		if(!inputId.isEmpty()) {
			if(service.checkIdDuplication(inputId)==null) {
				return "new";
			} else { return "deplicated";}
		}else {	return "empty"; }
	}
	
	@RequestMapping(value = "/registerSend")
	public String registerSend(@ModelAttribute EmployeeVO vo) {
		System.out.println(vo.getEmployeeRank());
		service.newEmployee(vo);
		return "redirect:/";
	}
		
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {
		return "employeeRegister";
	}
}
