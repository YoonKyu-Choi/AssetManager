package com.eseict.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.EmployeeVO;
import com.eseict.service.EmployeeService;

@Controller
public class UserController {

	@Autowired
	private EmployeeService service;
		
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model) {
		List<EmployeeVO> list = service.getEmployeeList();
		for(EmployeeVO vo : list) {
			System.out.println(vo.getRankVO());
			System.out.println(vo.getDepartmentVO());
		}
		model.addAttribute("employeeList", list);
		return "userList";
	}
	
	
	@RequestMapping(value="/userDetail")
	public ModelAndView userDetail(@RequestParam int employeeSeq) {
		System.out.println("상세보기 오나요");
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		System.out.println(evo);
		return new ModelAndView("userDetail","employeeVO",evo);
	}

	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpSession session) {
		if(session.getAttribute("isUser") != "TRUE")
			return "redirect:/";
		return "loginGet";
	}
	
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDelete(@RequestParam("employeeSeq") int employeeSeq, @RequestParam("checkAdminPw") String checkAdminPw) {
		int check = service.checkRegistered("admin", checkAdminPw);
		if(check == 1) {
			service.deleteEmployee(employeeSeq);
			return "redirect:/userList";
		} else {
			return "redirect:/userList";
		}
	}
}
