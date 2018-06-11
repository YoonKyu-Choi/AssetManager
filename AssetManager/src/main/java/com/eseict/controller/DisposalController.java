package com.eseict.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public ModelAndView disposalList(Model model, @RequestParam(required = false) String searchMode, @RequestParam(required = false) String searchKeyword) {

		if(searchKeyword != null) {
			return dService.disposalListMnV(searchMode, searchKeyword);
		} else {
			return dService.disposalListMnV(null, null);
		}
	}
	
	@RequestMapping(value="/disposeAsset", method=RequestMethod.POST)
	public String disposeAsset(RedirectAttributes redirectAttributes, @RequestParam String[] disposeArray) {
		int dispose = dService.disposeAsset(disposeArray);
		
		redirectAttributes.addFlashAttribute("msg", disposeArray.length+"개의 자산이 폐기 처리 되었습니다.");
		return "redirect:disposalList";
	}
}
