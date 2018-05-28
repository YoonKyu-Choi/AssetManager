package com.eseict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		return "categoryList.tiles";
	}

	
	@RequestMapping(value="/categoryRegister")
	public String categoryRegister() {
		return "categoryRegister.tiles";
	}
}
