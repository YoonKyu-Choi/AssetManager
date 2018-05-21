package com.eseict.controller;

import java.util.List;

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
	
	@RequestMapping(value = "/userList")
	public String userList(Model model) {
		List<EmployeeVO> list = service.getEmployeeList();
		for(EmployeeVO vo: list) {
			System.out.println(vo.getEmployeeId());
		}
		model.addAttribute("employeeList", service.getEmployeeList());
		return "userList";
	}
}
