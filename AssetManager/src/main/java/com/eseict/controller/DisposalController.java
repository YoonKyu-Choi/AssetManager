package com.eseict.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.service.DisposalService;

@Controller
public class DisposalController {
	@Autowired
	private DisposalService dService;

	@RequestMapping(value="/disposalList")
	public ModelAndView disposalList(RedirectAttributes redirectAttributes
								   , @RequestParam(required = false) String searchMode
								   , @RequestParam(required = false) String searchKeyword) {

		try {
			if(searchKeyword != null) {
				return dService.disposalListMnV(searchMode, searchKeyword);
			} else {
				return dService.disposalListMnV(null, null);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/disposalList");
	}
	
	@RequestMapping(value="/disposeAsset", method=RequestMethod.POST)
	public String disposeAsset(RedirectAttributes redirectAttributes
							 , @RequestParam String[] disposeArray) {
		try {
			int dispose = dService.disposeAsset(disposeArray);
			
			redirectAttributes.addFlashAttribute("msg", disposeArray.length+"개의 자산이 폐기 처리 되었습니다.");
			return "redirect:disposalList";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/disposalList";
	}
	
	@RequestMapping(value="/disposeAssetOne", method=RequestMethod.POST)
	public String disposeAssetOne(RedirectAttributes redirectAttributes
							 , @RequestParam String assetId) {
		try {
			dService.disposeAssetOne(assetId);
			redirectAttributes.addFlashAttribute("msg", assetId+" 자산이 폐기 처리 되었습니다.");
			return "redirect:disposalList";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/disposalList";
	}
}
