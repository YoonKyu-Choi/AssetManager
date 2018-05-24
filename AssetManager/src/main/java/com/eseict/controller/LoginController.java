package com.eseict.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eseict.service.EmployeeService;

@Controller
public class LoginController {
	
	@Autowired
	private EmployeeService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login(HttpSession session) {
		if(session.getAttribute("isUser") == "TRUE")
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
			if(inputId.equals("admin")) {
				session.setAttribute("isAdmin", "TRUE");
			}
			session.setAttribute("isUser", "TRUE");
		}
		return Integer.toString(check);
	}
	
	@RequestMapping(value = "/checkId")
	@ResponseBody
	public String checkId(@RequestParam(value="id", required=false) String inputId, HttpServletResponse response) throws IOException{
		try {
			if(!inputId.isEmpty()) {
				if(service.checkIdDuplication(inputId)==null) {
					return "new";
				} else { return "deplicated";}
			}else {	return "empty"; }
		} catch(Exception e) {
			System.out.println(e);
			response.sendRedirect("redirect:/");
			return "";
		}
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
