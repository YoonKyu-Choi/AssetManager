package com.eseict.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.AssetVO;
import com.eseict.service.AssetService;

@Controller
public class AssetController {
	
	@Autowired
	private AssetService service;
	
	@RequestMapping(value="/assetList")
	public ModelAndView assetList(Model model) {
		
		List<AssetVO> list = service.getAssetList();
		model.addAttribute("assetList",list);
		
		// 자산 상태 조회
		int assetCount = service.getAssetCount();
		int assetCountByUse =service.getAssetCountByUse();
		int assetCountByNotUse =service.getAssetCountByNotUse();
		int assetCountByOut =service.getAssetCountByOut();
		int assetCountByDispReady =service.getAssetCountByDispReady();
		int assetCountByDisposal =service.getAssetCountByDisposal();
		
		model.addAttribute("assetCount",assetCount);
		model.addAttribute("assetCountByUse",assetCountByUse);
		model.addAttribute("assetCountByNotUse",assetCountByNotUse);
		model.addAttribute("assetCountByOut",assetCountByOut);
		model.addAttribute("assetCountByDispReady",assetCountByDispReady);
		model.addAttribute("assetCountByDisposal",assetCountByDisposal);
		
		return new ModelAndView("assetList.tiles");
	}
	
	@RequestMapping(value = "/assetDetail")
	public ModelAndView assetDetail(@RequestParam String assetId) {
		System.out.println(assetId);
		AssetVO avo = service.getAssetByAssetId(assetId);
		System.out.println(avo);
		return new ModelAndView("assetDetail.tiles", "assetVO", avo);
	}
	
	@RequestMapping(value="/assetRegister")
	public String assetRegister(@ModelAttribute AssetVO avo) {
		
		// 관리 번호 생성
		String categoryKeyword = null;
		if(avo.getAssetCategory()=="노트북") {
			categoryKeyword = "NT";
		}else if(avo.getAssetCategory()=="데스크탑") {
			categoryKeyword = "DT";
		}else if(avo.getAssetCategory()=="모니터") {
			categoryKeyword = "MT";
		}else if(avo.getAssetCategory()=="서버") {
			categoryKeyword = "SV";
		}else if(avo.getAssetCategory()=="SW") {
			categoryKeyword = "SW";
		}else if(avo.getAssetCategory()=="IP WALL") {
			categoryKeyword = "IW";
		}else if(avo.getAssetCategory()=="프린터") {
			categoryKeyword = "PR";
		}else if(avo.getAssetCategory()=="책상") {
			categoryKeyword = "TA";
		}else if(avo.getAssetCategory()=="의자") {
			categoryKeyword = "CH";
		}else if(avo.getAssetCategory()=="책") {
			categoryKeyword = "BO";
		}else if(avo.getAssetCategory()=="기타") {
			categoryKeyword = "ET";
		}
		
		int month = avo.getAssetPurchaseDate().getMonth();
		int day = avo.getAssetPurchaseDate().getDay();
		System.out.println("구입 날짜 : "+month+day);
		int itemCount = service.getAssetCountByCategory(avo.getAssetCategory());
		
		avo.setAssetId(month+day+"-"+categoryKeyword+"-"+(itemCount+=1));
		service.insertAsset(avo);
		return "assetList.tiles";
	}

}




















