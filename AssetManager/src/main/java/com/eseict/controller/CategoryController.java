package com.eseict.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.service.AssetService;
import com.eseict.service.CategoryService;
import com.eseict.service.EmployeeService;

@Controller
public class CategoryController {
	
	@Autowired
	private AssetService aService;
	
	@Autowired
	private CategoryService cService;
	
	@Autowired
	private EmployeeService eService;

	@RequestMapping(value="/categoryList")
	public ModelAndView categoryList(RedirectAttributes redirectAttributes
								   , @RequestParam(required = false) String searchMode
								   , @RequestParam(required = false) String searchKeyword) {
		try {
			if(searchKeyword != null) {
				return cService.categoryListMnV(searchMode, searchKeyword);
			} else {
				return cService.categoryListMnV(null, null);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/categoryList");
	}

	
	@RequestMapping(value="/categoryDetail")
	public ModelAndView categoryDetail(RedirectAttributes redirectAttributes
									 , @RequestParam String categoryName) {
		try {
			return cService.categoryDetailMnV(categoryName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/categoryList");
	}
	
	
	@RequestMapping(value="/categoryRegister")
	public String categoryRegister() {
		return "categoryRegister.tiles";
	}
	
	@RequestMapping(value="/categoryRegisterSend")
	public String categoryRegisterSend(RedirectAttributes redirectAttributes
									 , @RequestParam String categoryName
									 , @RequestParam String[] items
									 , @RequestParam String code) {
		boolean  dup;
		try {
			dup = cService.categoryRegisterSend(categoryName, items);
			if(dup) {
				redirectAttributes.addFlashAttribute("msg", "이미 존재하는 분류이므로 해당 분류에 추가되었습니다.");
			} else {
				cService.newCode(categoryName, code);
				redirectAttributes.addFlashAttribute("msg", "등록되었습니다.");
			}
			return "redirect:/categoryList";

		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/categoryList";
	}
	
	@RequestMapping(value="/categoryDelete")
	public String categoryDelete(RedirectAttributes redirectAttributes
							   , @RequestParam String categoryName
							   , @RequestParam("checkAdminPw") String checkAdminPw) {
		try {
			int check = eService.checkRegistered("admin", checkAdminPw);
			if (check == 1) {
				int categoryDel = cService.deleteCategory(categoryName);
				int assetDel = 0;
				for(String assetId: aService.getAssetIdListByCategory(categoryName)) {
					assetDel += aService.deleteAssetById(assetId);
				}
				int codeDel = cService.deleteCode(categoryName);
				redirectAttributes.addFlashAttribute("msg", assetDel + " 개 자산이 삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("msg", "비밀번호가 맞지 않아 삭제에 실패했습니다.");
			}
			return "redirect:/categoryList";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/categoryList";
	}
	
	@RequestMapping(value="/categoryModify")
	public ModelAndView categoryModify(RedirectAttributes redirectAttributes
									 , @RequestParam String categoryName) {
		try {
			return cService.categoryModifyMnV(categoryName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/categoryList");
	}
	
	@RequestMapping(value="/categoryModifySend")
	public String categoryModifySend(RedirectAttributes redirectAttributes
								   , @RequestParam String categoryOriName
								   , @RequestParam String categoryName
								   , @RequestParam String[] items
								   , @RequestParam String[] deleteItems) {
		try {
			String msg = "";
			int checkName = cService.categoryModifyCheckName(categoryOriName, categoryName);
			if(checkName > 0) {
				msg += "분류의 이름이 변경되었습니다. ";
			}
			int categoryDel = cService.categoryModifyItemDelete(categoryName, deleteItems);	
			msg += (categoryDel + " 개의 세부사항이 삭제되었습니다. ");

			ArrayList<Integer> deleteItemsList = new ArrayList<Integer>();
			for(String s: deleteItems) {
				deleteItemsList.add(Integer.parseInt(s));
			}

			int categoryChange = cService.categoryModifyItemUpdate(categoryName, items, deleteItemsList);
			msg += (categoryChange + " 개의 세부사항이 변경/추가되었습니다.");
			
			redirectAttributes.addFlashAttribute("msg", msg);
			return "redirect:/categoryList";
		} catch(Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/categoryList";
	}

	@RequestMapping(value = "/checkCode")
	@ResponseBody
	public String checkId(@RequestParam(value = "code", required = false) String inputCode
						, HttpServletResponse response) {
		try {
			if (!inputCode.isEmpty()) {
				return String.valueOf(cService.existsCode(inputCode));
			} else {
				return "empty";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
	}
}
