package com.eseict.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.EmployeeVO;
import com.eseict.service.EmployeeService;

@Controller
public class UserController {

	@Autowired
	private EmployeeService service;

	// 회원가입 등록
	@RequestMapping(value = "/registerSend")
	public String registerSend(HttpSession session, @ModelAttribute EmployeeVO vo,
			RedirectAttributes redirectAttributes) {
		service.newEmployee(vo);
		redirectAttributes.addFlashAttribute("msg", "회원가입되었습니다.");
		if (session.getAttribute("isAdmin") == "TRUE")
			return "redirect:/userList";
		else
			return "redirect:/";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session) {
		return "employeeRegister";
	}

	// 사용자 목록
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public ModelAndView userList(Model model, @RequestParam(required = false) String employeeName) {
		int userCount = service.getUserCount();
		if (employeeName == null) {
			System.out.println("정상 전체 출력");
			List<EmployeeVO> list = service.getEmployeeList();
			model.addAttribute("employeeList", list);
		} else {
			System.out.println("검색!");
			List<EmployeeVO> list = service.getEmployeeListByName(employeeName);
			model.addAttribute("employeeList", list);
		}
		model.addAttribute("userCount", userCount);
		return new ModelAndView("userList.tiles", "list", model);
	}

	// 사용자 상세보기
	@RequestMapping(value = "/userDetail")
	public ModelAndView userDetail(@RequestParam int employeeSeq) {
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		return new ModelAndView("userDetail.tiles", "employeeVO", evo);
	}

	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpSession session) {
		return "loginGet.tiles";
	}

	// 사용자 삭제
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String userDelete(@RequestParam("employeeSeq") int employeeSeq,
			@RequestParam("checkAdminPw") String checkAdminPw, RedirectAttributes redirectAttributes) {
		int check = service.checkRegistered("admin", checkAdminPw);
		if (check == 1) {
			service.deleteEmployee(employeeSeq);
			redirectAttributes.addFlashAttribute("msg", "삭제되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("msg", "비밀번호가 맞지 않아 삭제에 실패했습니다.");
		}
		return "redirect:/userList.tiles";
	}

	// 사용자 수정 페이지 이동
	@RequestMapping(value = "/userModify")
	public ModelAndView userModify(@RequestParam int employeeSeq) {
		EmployeeVO evo = service.selectEmployeeByEmployeeSeq(employeeSeq);
		return new ModelAndView("userModify.tiles", "employeeVO", evo);
	}

	// 사용자 수정
	@RequestMapping(value = "/userModifyConfirm")
	public String userModifyConfirm(@ModelAttribute EmployeeVO evo, RedirectAttributes redirectAttributes) {
		// int employeeSeq = evo.getEmployeeSeq();
		service.updateEmployee(evo);
		redirectAttributes.addFlashAttribute("msg", "수정되었습니다.");
		return "redirect:/userList.tiles";
	}

}
