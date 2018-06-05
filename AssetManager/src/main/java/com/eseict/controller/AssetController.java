package com.eseict.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;
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
		AssetVO avo = service.getAssetByAssetId(assetId);
		return new ModelAndView("assetDetail.tiles", "assetVO", avo);
	}
	
	@RequestMapping(value = "/assetRegister", method = RequestMethod.GET)
	public String register(HttpSession session) {
		return "assetRegister.tiles";
	}
	
	@RequestMapping(value="/assetRegister2")
	public String assetRegister(@ModelAttribute AssetVO avo) {
		// 관리 번호 생성
		String categoryKeyword = null;
		int year = 0;
		String month = null;
		String ac = avo.getAssetCategory();
		
		if(ac.equals("노트북")) {
			categoryKeyword = "NT";
		} else if(ac.equals("데스크탑")) {
			categoryKeyword = "DT";
		} else if(ac.equals("모니터")) {
			categoryKeyword = "MT";
		} else if(ac.equals("서버")) {
			categoryKeyword = "SV";
		} else if(ac.equals("SoftWare")) {
			categoryKeyword = "SW";
		} else if(ac.equals("IP WALL")) {
			categoryKeyword = "IW";
		} else if(ac.equals("프린터")) {
			categoryKeyword = "PR";
		} else if(ac.equals("책상")) {
			categoryKeyword = "TA";
		} else if(ac.equals("의자")) {
			categoryKeyword = "CH";
		} else if(ac.equals("책")) {
			categoryKeyword = "BO";
		} else if(ac.equals("기타")) {
			categoryKeyword = "ET";
		}
		
		year = avo.getAssetPurchaseDate().getYear()%100;
		if(avo.getAssetPurchaseDate().getMonth()+1 <10) {
			month = "0"+Integer.toString(avo.getAssetPurchaseDate().getMonth()+1); 
		} else {
			month = Integer.toString(avo.getAssetPurchaseDate().getMonth()+1);
		}
		
		String itemSequence = "0"+"0"+(service.getAssetCountByCategory(avo.getAssetCategory())+1);
		avo.setAssetId(year+month+"-"+categoryKeyword+"-"+(itemSequence));
		System.out.println("관리번호 생성 : "+year+month+"-"+categoryKeyword+"-"+(itemSequence));
		service.insertAsset(avo);
		
		return "redirect:/assetList.tiles";
	}
	
//	@RequestMapping(value="/getCategoryDetailItem")
//	public List<CategoryVO> getCategoryDetailItem(@RequestParam String assetCategory) {
//		System.out.println(assetCategory);
//		List<CategoryVO> list = service.getCategoryDetailItem(assetCategory);
//		System.out.println(list);
//		return list;
//	}
	
	@RequestMapping(value="/getCategoryDetailItem")
	@ResponseBody
	public List<CategoryVO> getCategoryDetailItem(@RequestParam String assetCategory) {
		System.out.println(assetCategory);
		List<CategoryVO> list = service.getCategoryDetailItem(assetCategory);
		
		System.out.println(list);
//		model.addAttribute("list",list);
		return list;
	}
	
}




















