package com.eseict.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eseict.service.EmployeeService;

@Controller
public class UserController {

	@Autowired
	private EmployeeService service;
	
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model) {
		model.addAttribute("employeeList", service.getEmployeeList());
		return "userList";
	}
}
