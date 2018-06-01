package com.eseict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.CategoryVO;
import com.eseict.service.CategoryService;
import com.eseict.service.EmployeeService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService service;
	
	@Autowired
	private EmployeeService eservice;

	@RequestMapping(value="/categoryList")
	public String categoryList(Model model, @RequestParam(required = false) String searchMode, @RequestParam(required = false) String searchKeyword) {
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
		
		if(searchKeyword != null) {
			model.addAttribute("searchMode", searchMode);
			model.addAttribute("searchKeyword", searchKeyword);
			model.addAttribute("search", "1");
		} else {
			model.addAttribute("search", "0");
		}
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
		boolean dup = false;
		if(service.isCategory(categoryName) > 0) {
			dup = true;
		} else {
			dup = false;
		}
		for(String i: items) {
			if(!i.equals("")) {
				CategoryVO vo = new CategoryVO();
				vo.setAssetCategory(categoryName);
				vo.setAssetItem(i);
				service.newCategory(vo);
			}
		}
		if(dup) {
			redirectAttributes.addFlashAttribute("msg", "이미 존재하는 분류이므로 해당 분류에 추가되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("msg", "등록되었습니다.");
		}
		return "redirect:/categoryList";
	}
	
	@RequestMapping(value="/categoryDelete")
	public String categoryDelete(RedirectAttributes redirectAttributes, @RequestParam String categoryName, @RequestParam("checkAdminPw") String checkAdminPw) {
		int check = eservice.checkRegistered("admin", checkAdminPw);
//		System.out.println(checkAdminPw);
		if (check == 1) {
			service.deleteCategory(categoryName);
			redirectAttributes.addFlashAttribute("msg", "삭제되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("msg", "비밀번호가 맞지 않아 삭제에 실패했습니다.");
		}
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
	
	@RequestMapping(value="/categoryModifySend")
	public String categoryModifySend(RedirectAttributes redirectAttributes, @RequestParam String categoryOriName, @RequestParam String categoryName, @RequestParam String[] items, @RequestParam String[] deleteItems) {
		List<String> cvolist = service.getCategoryByName(categoryOriName);
		String[] cvo = new String[cvolist.size()];
		cvo = cvolist.toArray(cvo);

		if(!categoryOriName.equals(categoryName)) {
			System.out.println("asd");
			service.updateCategoryName(categoryOriName, categoryName);
		}
		
		ArrayList<Integer> deleteItemsList = new ArrayList<Integer>();
		for(String s: deleteItems) {
			deleteItemsList.add(Integer.parseInt(s));
			service.deleteItem(categoryName, cvo[Integer.parseInt(s)]);
		}
		
		for(int i=0; i<cvo.length; i++) {
			if(!cvo[i].equals(items[i]) && !items[i].equals("")) {
				if(!deleteItemsList.contains(i)) {
					service.updateItemName(cvo[i], items[i], categoryName);
				}
			}
		}
		
			
		for(int j=cvo.length; j<items.length; j++){
			if(!items[j].equals("")) {
				CategoryVO vo = new CategoryVO();
				vo.setAssetCategory(categoryName);
				vo.setAssetItem(items[j]);
				service.newCategory(vo);
			}
		}
		redirectAttributes.addFlashAttribute("msg", "수정되었습니다.");
		return "redirect:/categoryList";
	}
}
