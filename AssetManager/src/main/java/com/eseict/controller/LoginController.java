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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.service.EmployeeService;

@Controller
public class LoginController {

	@Autowired
	private EmployeeService eService;
	
	@RequestMapping(value = "/")
	public String login(HttpSession session) {
		if (session.getAttribute("isUser") == "TRUE") {
			return "redirect:/assetList";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/loginSubmit", method = RequestMethod.POST)
	@ResponseBody
	public String loginSubmit(RedirectAttributes redirectAttributes, HttpSession session, HttpServletResponse response, @RequestParam("inputId") String inputId, @RequestParam("inputPw") String inputPw) throws IOException {
		try {
			int check = eService.loginReact(inputId, inputPw);
			if(check == 1) {
				if (inputId.equals("admin")) {
					session.setAttribute("isAdmin", "TRUE");
				}
				session.setAttribute("isUser", "TRUE");
			}
			session.setAttribute("Id", inputId);
			return Integer.toString(check);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/";
	}

	@RequestMapping(value = "/checkId")
	@ResponseBody
	public String checkId(@RequestParam(value = "id", required = false) String inputId, HttpServletResponse response) throws IOException {
		try {
			if (!inputId.isEmpty()) {
				if (eService.checkIdDuplication(inputId) == null) {
					return "new";
				} else {
					return "duplicated";
				}
			} else {
				return "empty";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
