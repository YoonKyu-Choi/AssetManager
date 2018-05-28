package com.eseict.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eseict.VO.CategoryVO;
import com.eseict.service.CategoryService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService service;

	@RequestMapping(value="/categoryList")
	public String categoryList(Model model) {
		List<CategoryVO> volist = service.getCategoryList();
		return "categoryList.tiles";
	}

	
	@RequestMapping(value="/categoryRegister")
	public String categoryRegister() {
		return "categoryRegister.tiles";
	}
}
