package com.eseict.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.AssetVO;
import com.eseict.service.AssetService;

@Controller
public class DisposalController {
	@Autowired
	private AssetService service;

	@RequestMapping(value="/disposalList")
	public String disposalList(Model model, @RequestParam(required = false) String searchMode, @RequestParam(required = false) String searchKeyword) {
		List<AssetVO> volist = service.getDisposalAssetList();

		int assetCountByDispReady =service.getAssetCountByDispReady();
		int assetCountByDisposal =service.getAssetCountByDisposal();
		
		model.addAttribute("assetList", volist);
		model.addAttribute("assetCountByDispReady", assetCountByDispReady);
		model.addAttribute("assetCountByDisposal", assetCountByDisposal);

		if(searchKeyword != null) {
			model.addAttribute("searchMode", searchMode);
			model.addAttribute("searchKeyword", searchKeyword);
			model.addAttribute("search", "1");
		} else {
			model.addAttribute("search", "0");
		}
		return "disposalList.tiles";
	}
	
	@RequestMapping(value="/disposeAsset", method=RequestMethod.POST)
	public String disposeAsset(RedirectAttributes redirectAttributes, @RequestParam String[] disposeArray) {
		for(String assetId: disposeArray) {
			service.disposeAsset(assetId);
		}
		redirectAttributes.addFlashAttribute("msg", disposeArray.length+"개의 자산이 폐기 처리 되었습니다.");
		return "redirect:disposalList";
	}
}
