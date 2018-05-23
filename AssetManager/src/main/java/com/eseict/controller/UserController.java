package com.eseict.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eseict.VO.EmployeeVO;
import com.eseict.service.EmployeeService;

@Controller
public class UserController {

	@Autowired
	private EmployeeService service;
		
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model) {
		List<EmployeeVO> list = service.getEmployeeList();
		model.addAttribute("employeeList", list);
		System.out.println(list);
		return "userList";
	}
	
	/*
	@RequestMapping(value="/userDetail")
	public ModelAndView userDetail(@RequestParam int employeeSeq) {
		System.out.println("상세보기 오나요");
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		System.out.println(evo);
		return new ModelAndView("userDetail","evo",evo);
	*/
	
	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpSession session) {
		if(session.getAttribute("isUser") != "TRUE")
			return "redirect:/";
		return "loginGet";
	}
}
