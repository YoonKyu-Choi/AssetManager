package com.eseict.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;
import com.eseict.service.AssetService;
import com.eseict.service.CategoryService;
import com.eseict.service.EmployeeService;

@Controller
public class AssetController {
	
	@Autowired
	private AssetService aService;
	@Autowired
	private EmployeeService eService;
	@Autowired
	private CategoryService cService;
	
	
	@RequestMapping(value="/assetList")
	public ModelAndView assetList(Model model
								/* ,@RequestParam(required = false) int searchMode
								 ,@RequestParam(required = false) String searchKeyword*/) {
		List<AssetVO> list = aService.getAssetList();
		model.addAttribute("assetList",list);
		
		// 자산 상태 조회
		// 이 부분은 축소 할 수 있음 -> select로 다 뽑고 뽑은거에서 나눠
		int assetCount = aService.getAssetCount();
		int assetCountByUse = aService.getAssetCountByUse();
		int assetCountCanUse = aService.getAssetCountCanUse();
		int assetCountByNotUse = aService.getAssetCountByNotUse();
		int assetCountByOut = aService.getAssetCountByOut();
		int assetCountByDispReady = aService.getAssetCountByDispReady();
		int assetCountByDisposal = aService.getAssetCountByDisposal();

		model.addAttribute("assetCount", assetCount);
		model.addAttribute("assetCountByUse", assetCountByUse);
		model.addAttribute("assetCountCanUse", assetCountCanUse);
		model.addAttribute("assetCountByNotUse", assetCountByNotUse);
		model.addAttribute("assetCountByOut", assetCountByOut);
		model.addAttribute("assetCountByDispReady", assetCountByDispReady);
		model.addAttribute("assetCountByDisposal", assetCountByDisposal);
		
		/*
		if(searchKeyword != null) {
			model.addAttribute("searchMode", searchMode);
			model.addAttribute("searchKeyword", searchKeyword);
				model.addAttribute("search", "1");
		} else {
			model.addAttribute("search", "0");
		}
		*/

		return new ModelAndView("assetList.tiles");
	}
	
	@RequestMapping(value = "/assetDetail")
	public ModelAndView assetDetail(Model model, @RequestParam String assetId) {
		AssetVO avo = aService.getAssetByAssetId(assetId);
		List<AssetDetailVO> dlist = aService.getAssetDetailByAssetId(assetId);
		model.addAttribute("assetVO", avo);
		model.addAttribute("assetDetailList", dlist);

		return new ModelAndView("assetDetail.tiles", "model", model);
	}

	@RequestMapping(value = "/assetRegister")
	public ModelAndView nameList2(Model model) {
		List<String> elist = eService.getEmployeeNameList();
		List<String> clist = aService.getAssetCategoryList();
		model.addAttribute("employeeNameList", elist);
		model.addAttribute("categoryList", clist);
		return new ModelAndView("assetRegister.tiles", "list", model); 
	}
	
	@RequestMapping(value = "/assetRegisterSend")
	public String assetRegister(@ModelAttribute AssetVO avo
							 	,@RequestParam String[] items
							 	,@RequestParam String[] itemsDetail
							 	,@RequestParam String employeeId
							 	,@RequestParam(required=false) MultipartFile uploadImage
							 	,HttpServletRequest request) throws IllegalStateException, IOException {
		// 관리 번호 생성
		String categoryKeyword = null;
		String month = null;
		String categoryName = avo.getAssetCategory();
		String itemSequence = null;
		
		categoryKeyword = cService.getCode(categoryName);
		
		// getYear는 폐기함수 -> getFullYear 함수로 대체 , 
		int yearCut = avo.getAssetPurchaseDate().getYear() % 100;
		
		if(avo.getAssetPurchaseDate().getMonth() + 1 <10) {
			month = "0" + Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1); 
		} else {
			month = Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1);
		}
		int i = aService.getAssetCountByCategory(avo.getAssetCategory()) + 1;
		if (i < 10) {
			itemSequence = "0" + "0" + i;
		} else if(i>=10 && i<100) {
			itemSequence = "0" + i;
		} else {
			itemSequence = Integer.toString(i);	
		}
		if(avo.getAssetPurchaseDate().getYear() == 8099) { // 9999 를 넘기면 8099 로 받아짐
			avo.setAssetId("0000"+ "-" + categoryKeyword + "-" + (itemSequence));
		}else {
			avo.setAssetId(yearCut + month + "-" + categoryKeyword + "-" + (itemSequence));
		}
		
		// 파일 업로드
		ServletContext ctx = request.getServletContext();
		String uploadDir = ctx.getRealPath("/resources/");
		if(uploadImage != null && !uploadImage.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			File dir = new File(uploadDir+fileName+".jpg");
			uploadImage.transferTo(dir);
			avo.setAssetReceiptUrl(fileName+".jpg");
		}
		aService.insertAsset(avo);
		
		// 자산 세부사항도 같이 등록 
		AssetDetailVO dvo = new AssetDetailVO();
		dvo.setAssetId(avo.getAssetId());
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			aService.insertAssetDetail(dvo);
		}
		
		// 등록 시 자산 이력 자동 등록
		AssetHistoryVO ahvo = new AssetHistoryVO();
		java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
		ahvo.setAssetId(avo.getAssetId());
		ahvo.setEmployeeSeq(eService.getEmployeeSeqByEmpId(employeeId));
		ahvo.setAssetOccupiedDate(now);
		aService.insertAssetHistory(ahvo);
		AssetFormerUserVO afuvo = new AssetFormerUserVO();
		afuvo.setAssetId(avo.getAssetId());
		afuvo.setEmployeeSeq(ahvo.getEmployeeSeq());
		afuvo.setAssetUser(avo.getAssetUser());
		afuvo.setAssetStartDate(ahvo.getAssetOccupiedDate());
		aService.insertAssetFormerUser(afuvo);
		return "redirect:/assetList.tiles";
	}
	
	@RequestMapping(value = "/getCategoryDetailItem")
	@ResponseBody
	public List<CategoryVO> getCategoryDetailItem(@RequestParam String assetCategory) {
		List<CategoryVO> list = aService.getCategoryDetailItem(assetCategory);
		return list;
	}
	
	
	@RequestMapping(value="assetModify")
	public ModelAndView assetModify(@RequestParam String assetId, Model model) {
		AssetVO avo = aService.getAssetByAssetId(assetId);
		List<AssetDetailVO> dlist = aService.getAssetDetailByAssetId(assetId);
		List<String> elist = eService.getEmployeeNameList();
		model.addAttribute("assetVO",avo);
		model.addAttribute("assetDetailList",dlist);
		model.addAttribute("employeeNameList", elist);
		int detailSize = dlist.size();
		model.addAttribute("dSize",detailSize);
		return new ModelAndView("assetModify.tiles","model",model);	
	}
	
	// 자산 수정 Send
	@RequestMapping(value = "/assetModifySend")
	public String userModifySend(@ModelAttribute AssetVO avo
								 ,@ModelAttribute AssetDetailVO dvo
								 ,@RequestParam String[] items
								 ,@RequestParam String[] itemsDetail
								 ,@RequestParam(required=false) MultipartFile uploadImage
								 ,HttpServletRequest request) throws IllegalStateException, IOException {
		String beforeUser = avo.getAssetUser();
		// 파일 업로드
		ServletContext ctx = request.getServletContext();
		String uploadDir = ctx.getRealPath("/resources/");
		if(uploadImage != null && !uploadImage.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			File dir = new File(uploadDir+fileName+".jpg");
			uploadImage.transferTo(dir);
			avo.setAssetReceiptUrl(fileName+".jpg");
		}
		aService.updateAsset(avo);
		
		dvo.setAssetId(avo.getAssetId());
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			aService.updateAssetDetail(dvo);
		}
		
		// 자산 수정 시 자산 이력 자동 입력
		if(!beforeUser.equals(avo.getAssetUser())) {
			AssetFormerUserVO afuvo = new AssetFormerUserVO();
			java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
			afuvo.setAssetEndDate(now);
			System.out.println(afuvo.getAssetEndDate());
//			aService.insertAssetFormerUser(afuvo);
		}
		return "redirect:/assetDetail?assetId="+avo.getAssetId();
	}
		
	@RequestMapping(value="/assetDisposal")	
	public String assetDisposal(@RequestParam(required=false) String assetId,
								@RequestParam(required=false) String[] assetIdList) {
		if(assetId != null) {
			aService.updateAssetDisposal(assetId);
		}else {
			for(int i=0;i<assetIdList.length;i++) {
				aService.updateAssetDisposal(assetIdList[i]);
			}
		}
		return "redirect:/assetList.tiles";
	}
	
	@RequestMapping(value="/assetHistory")
	public ModelAndView assetHistory(Model model
									,@RequestParam String assetId) {
		AssetHistoryVO ahvo = aService.getAssetHistoryByAssetId(assetId);
		
		List<AssetFormerUserVO> afulist = aService.getAssetFormerUserByAssetId(assetId);
		model.addAttribute("assetId",assetId);
		model.addAttribute("AssetHistoryVO", ahvo);
		model.addAttribute("AssetFormerUserList", afulist);
		
		return new ModelAndView("assetHistory.tiles", "model", model);
	}
	
	
}





















