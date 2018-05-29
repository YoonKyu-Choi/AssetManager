package com.eseict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.CategoryVO;
import com.eseict.VO.EmployeeVO;
import com.eseict.service.CategoryService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService service;

	@RequestMapping(value="/categoryList")
	public String categoryList(Model model) {
		List<CategoryVO> volist = service.getCategoryList();
		HashMap<String,List<String>> categoryItemList = new HashMap<String,List<String>>();
		int columnSize = 0;
		for(CategoryVO vo: volist) {
			if(categoryItemList.containsKey(vo.getAssetCategory())) {
				categoryItemList.get(vo.getAssetCategory()).add(vo.getAssetItem());
			} else {
				List<String> itemList = new ArrayList<String>();
				itemList.add(vo.getAssetItem());
				categoryItemList.put(vo.getAssetCategory(), itemList);
			}
		}
		for(String key: categoryItemList.keySet()) {
			int items = categoryItemList.get(key).size();
			if(columnSize < items)
				columnSize = items;
		}
		model.addAttribute("categoryItemList", categoryItemList);
		model.addAttribute("columnSize", columnSize);
		model.addAttribute("categoryCount", service.getCategoryCount());
		return "categoryList.tiles";
	}

	
	@RequestMapping(value="/categoryDetail")
	public ModelAndView categoryDetail(@RequestParam String categoryName) {
		List<String> cvo = service.getCategoryByName(categoryName);
		HashMap<String, Object> categoryData = new HashMap<String, Object>();
		categoryData.put("name", categoryName);
		categoryData.put("items", cvo);
		return new ModelAndView("categoryDetail.tiles", "categoryData", categoryData);
	}
	
	
	@RequestMapping(value="/categoryRegister")
	public String categoryRegister() {
		return "categoryRegister.tiles";
	}
	
	@RequestMapping(value="/categoryRegisterSend")
	public String categoryRegisterSend(RedirectAttributes redirectAttributes, @RequestParam String categoryName, @RequestParam String[] items) {
		for(String i: items) {
			if(i != "") {
				CategoryVO vo = new CategoryVO();
				vo.setAssetCategory(categoryName);
				vo.setAssetItem(i);
				service.newCategory(vo);
			}
		}
		redirectAttributes.addFlashAttribute("msg", "등록되었습니다.");
		return "redirect:/categoryList";
	}
	
	@RequestMapping(value="/categoryDelete")
	public String categoryDelete(RedirectAttributes redirectAttributes, @RequestParam String categoryName) {
		service.deleteCategory(categoryName);
		redirectAttributes.addFlashAttribute("msg", "삭제되었습니다.");
		return "redirect:/categoryList";
	}
	
	@RequestMapping(value="/categoryModify")
	public ModelAndView categoryModify(@RequestParam String categoryName) {
		List<String> cvo = service.getCategoryByName(categoryName);
		HashMap<String, Object> categoryData = new HashMap<String, Object>();
		categoryData.put("name", categoryName);
		categoryData.put("items", cvo);
		categoryData.put("itemSize", cvo.size());
		return new ModelAndView("categoryModify.tiles", "categoryData", categoryData);
	}
}
