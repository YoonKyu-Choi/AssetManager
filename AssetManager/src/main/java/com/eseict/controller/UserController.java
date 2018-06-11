package com.eseict.controller;

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
	private EmployeeService eService;

	// 회원가입 등록
	@RequestMapping(value = "/registerSend")
	public String registerSend(HttpSession session, @ModelAttribute EmployeeVO vo, RedirectAttributes redirectAttributes) {
		try {
			eService.newEmployee(vo);
			redirectAttributes.addFlashAttribute("msg", "회원가입되었습니다.");
			if (session.getAttribute("isAdmin") == "TRUE")
				return "redirect:/userList";
			else
				return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(HttpSession session) {
		return "employeeRegister";
	}

	// 사용자 목록
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public ModelAndView userList(RedirectAttributes redirectAttributes, Model model, @RequestParam(required = false) String employeeName) {
		try {
			if(employeeName == null) {
				return eService.userListMnV(null);
			} else {
				return eService.userListMnV(employeeName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/userList");
	}

	// 사용자 상세보기
	@RequestMapping(value = "/userDetail")
	public ModelAndView userDetail(RedirectAttributes redirectAttributes, @RequestParam int employeeSeq) {
		try {
			EmployeeVO evo = eService.selectEmployeeByEmployeeSeq(employeeSeq);
			return new ModelAndView("userDetail.tiles", "employeeVO", evo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/userList");
	}

	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public String loginGet(HttpSession session) {
		return "loginGet.tiles";
	}

	// 사용자 삭제
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String userDelete(@RequestParam("employeeSeq") int employeeSeq, @RequestParam("checkAdminPw") String checkAdminPw, RedirectAttributes redirectAttributes) {
		try {
			int check = eService.checkRegistered("admin", checkAdminPw);
			if (check == 1) {
				eService.deleteEmployee(employeeSeq);
				redirectAttributes.addFlashAttribute("msg", "삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("msg", "비밀번호가 맞지 않아 삭제에 실패했습니다.");
			}
			return "redirect:/userList.tiles";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/userList";
	}

	// 사용자 수정 페이지 이동
	@RequestMapping(value = "/userModify")
	public ModelAndView userModify(RedirectAttributes redirectAttributes, @RequestParam int employeeSeq) {
		try {
			EmployeeVO evo = eService.selectEmployeeByEmployeeSeq(employeeSeq);
			return new ModelAndView("userModify.tiles", "employeeVO", evo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/userList");
	}

	// 사용자 수정
	@RequestMapping(value = "/userModifyConfirm")
	public String userModifyConfirm(RedirectAttributes redirectAttributes, @ModelAttribute EmployeeVO evo) {
		try {
			eService.updateEmployee(evo);
			redirectAttributes.addFlashAttribute("msg", "수정되었습니다.");
			return "redirect:/userList.tiles";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/userList";
	}

}
