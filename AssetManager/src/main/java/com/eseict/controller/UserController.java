package com.eseict.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
	
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model) {
		List<EmployeeVO> list = service.getEmployeeList();
		ArrayList<Object> employeeHSMList = new ArrayList<Object>();
		for(EmployeeVO vo: list) {
			HashMap<String, Object> employeeHSM = new HashMap<String, Object>();
			employeeHSM.put("vo", vo);
			employeeHSM.put("dep", service.getDepartment(vo.getEmployeeDepartment()));
			employeeHSM.put("rank", service.getRank(vo.getEmployeeRank()));
			employeeHSMList.add(employeeHSM);
		}
		model.addAttribute("employeeList", employeeHSMList);
		return "userList";
	}
}
