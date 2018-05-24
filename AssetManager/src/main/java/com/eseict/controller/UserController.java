package com.eseict.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	// 회원가입 등록
	@RequestMapping(value = "/registerSend")
	public String registerSend(HttpSession session, @ModelAttribute EmployeeVO vo) {
		service.newEmployee(vo);
		System.out.println(session.getAttribute("isAdmin"));
		if(session.getAttribute("isAdmin") == "TRUE")
			return "redirect:/userList";
		else
			return "redirect:/";
	}
		
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session) {
		if(session.getAttribute("isUser") == "TRUE" && session.getAttribute("isAdmin") != "TRUE")
			return "redirect:/loginGet";
		else
			return "employeeRegister";
	}
	
	// 사용자 목록
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(Model model) {
		List<EmployeeVO> list = service.getEmployeeList();
		model.addAttribute("employeeList", list);
		return "userList.tiles";
	}
	
	// 사용자 상세보기
	@RequestMapping(value="/userDetail")
	public ModelAndView userDetail(@RequestParam int employeeSeq) {
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		return new ModelAndView("userDetail","employeeVO",evo);
	}

	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpSession session) {
		return "loginGet";
	}
	
	// 사용자 삭제
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDelete(@RequestParam("employeeSeq") int employeeSeq, @RequestParam("checkAdminPw") String checkAdminPw) {
		int check = service.checkRegistered("admin", checkAdminPw);
		if(check == 1) {
			service.deleteEmployee(employeeSeq);
		}
		return "redirect:/userList";
	}
	
	// 사용자 수정 페이지 이동
	@RequestMapping(value="/userModify")
	public ModelAndView userModify(@RequestParam int employeeSeq) {
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		return new ModelAndView("userModify","employeeVO",evo);
	}
	
	// 사용자 수정 
	@RequestMapping(value="/userModifyConfirm")
	public String userModifyConfirm(@ModelAttribute EmployeeVO evo) {
		int employeeSeq = evo.getEmployeeSeq();
		service.updateEmployee(evo);
		return "redirect:/userDetail?employeeSeq="+employeeSeq;
	}
	
}
