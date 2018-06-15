package com.eseict.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
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
import com.eseict.VO.AssetTakeOutHistoryVO;
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
		try {
			List<String> elist = eService.getEmployeeNameList();
			List<String> clist = aService.getAssetCategoryList();
			model.addAttribute("employeeNameList", elist);
			model.addAttribute("categoryList", clist);
			return new ModelAndView("assetRegister.tiles", "list", model); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("assetRegister.tiles");
	}
	
	@RequestMapping(value = "/assetRegisterSend")
	public String assetRegister(@ModelAttribute AssetVO avo
							 	,@RequestParam String[] items
							 	,@RequestParam String[] itemsDetail
							 	,@RequestParam String employeeId
							 	,@RequestParam(required=false) MultipartFile uploadImage
							 	,HttpServletRequest request) throws Exception {
		// 관리 번호 생성
		String categoryKeyword = null;
		String month = null;
		String categoryName = avo.getAssetCategory();
		String itemSequence = null;
		
		try {
			categoryKeyword = cService.getCode(categoryName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
		
		avo.setEmployeeSeq(eService.getEmployeeSeqByEmpName(avo.getAssetUser()));
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

		try {
			ahvo.setEmployeeSeq(eService.getEmployeeSeqByEmpName(avo.getAssetUser()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		ahvo.setAssetOccupiedDate(now);
		aService.insertAssetHistory(ahvo);
		
		// 자산 이전 사용자도 등록
		AssetFormerUserVO afuvo = new AssetFormerUserVO();
		afuvo.setAssetId(avo.getAssetId());
		afuvo.setEmployeeSeq(ahvo.getEmployeeSeq());
		afuvo.setAssetUser(avo.getAssetUser());
		afuvo.setAssetStartDate(ahvo.getAssetOccupiedDate());
		aService.insertAssetFormerUser(afuvo);
					
//		// 해당 자산 이력 수정
//		ahvo.setAssetId(avo.getAssetId());
//		ahvo.setEmployeeSeq(avo.getEmployeeSeq());
//		ahvo.setAssetOccupiedDate(now);
//		aService.updateAssetHistory(ahvo);		
		
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
		List<String> elist = null;
		try {
			elist = eService.getEmployeeNameList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		AssetHistoryVO ahvo = aService.getAssetHistoryByAssetId(assetId);
		List<AssetFormerUserVO> afuvo = aService.getAssetFormerUserByAssetId(assetId);
		int detailSize = dlist.size();
		String beforeUser = avo.getAssetUser();
		
		model.addAttribute("beforeUser",beforeUser);
		model.addAttribute("assetVO",avo);
		model.addAttribute("assetDetailList",dlist);
		model.addAttribute("employeeNameList", elist);
		model.addAttribute("AssetHistoryVO",ahvo);
		model.addAttribute("AssetFormerUserList",afuvo);
		model.addAttribute("dSize",detailSize);
		return new ModelAndView("assetModify.tiles","model",model);	
	}
	
	// 자산 수정 Send
	@RequestMapping(value = "/assetModifySend")
	public String userModifySend(@ModelAttribute AssetVO avo
								 ,@ModelAttribute AssetDetailVO dvo
								 ,@ModelAttribute AssetHistoryVO ahvo
								 ,@ModelAttribute AssetFormerUserVO afuvo
								 ,@RequestParam String[] items
								 ,@RequestParam String[] itemsDetail
								 ,@RequestParam String beforeUser
								 ,@RequestParam(required=false) MultipartFile uploadImage
								 ,HttpServletRequest request) throws IllegalStateException, IOException {
		
		// new는 새로운 사용자 사용자번호, empSeq는 이전 사용자 번호 
		// -> 이 부분을 입력 받은 이름으로 해결하고 있는데 동명이인일 경우 문제 해결 필요
		int newEmpSeq = eService.getEmployeeSeqByEmpName(avo.getAssetUser());
		int empSeq = eService.getEmployeeSeqByEmpName(beforeUser);
		
		// 파일 업로드
		ServletContext ctx = request.getServletContext();
		String uploadDir = ctx.getRealPath("/resources/");
		if(uploadImage != null && !uploadImage.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			File dir = new File(uploadDir+fileName+".jpg");
			uploadImage.transferTo(dir);
			avo.setAssetReceiptUrl(fileName+".jpg");
		}
		avo.setEmployeeSeq(newEmpSeq);
		aService.updateAsset(avo);
		
		dvo.setAssetId(avo.getAssetId());
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			aService.updateAssetDetail(dvo);
		}
		
		// 자산 수정 시 자산 이력 자동 입력
		if(!beforeUser.equals(avo.getAssetUser())) {
			// 이전 사용자의 반납 날짜 입력 ( update이긴 한데 반납하기 전까진 null )
			java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
			afuvo.setAssetEndDate(now);
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("assetId", avo.getAssetId());
			map.put("employeeSeq",empSeq);
			map.put("assetEndDate",now);
			aService.updateAssetFormerUserByKey(map);
			
			// 새로운 사용자 정보 입력
			AssetFormerUserVO newAfuvo = new AssetFormerUserVO();
			newAfuvo.setAssetId(avo.getAssetId());
			newAfuvo.setEmployeeSeq(avo.getEmployeeSeq());
			newAfuvo.setAssetUser(avo.getAssetUser());
			newAfuvo.setAssetStartDate(now);
			aService.insertAssetFormerUser(newAfuvo);
			
			// 해당 자산 이력 수정
			ahvo.setAssetId(avo.getAssetId());
			ahvo.setEmployeeSeq(avo.getEmployeeSeq());
			ahvo.setAssetOccupiedDate(now);
			aService.updateAssetHistory(ahvo);
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
		List<AssetTakeOutHistoryVO> atohList = aService.getAssetTakeOutHistoryByAssetId(assetId);
		
		model.addAttribute("assetId",assetId);
		model.addAttribute("AssetHistoryVO", ahvo);
		model.addAttribute("AssetFormerUserList", afulist);
		model.addAttribute("AssetTakeOutHistoryList",atohList);
		return new ModelAndView("assetHistory.tiles", "model", model);
	}
	
	@RequestMapping(value="/assetDelete")
	public String assetDelete(Model model
							  ,@RequestParam String assetId) {
		aService.deleteAssetById(assetId);	
		return "assetList.tiles";
	}
	
	@RequestMapping(value="/assetTakeOutHistory")
	public String assetTakeOutHistory(@ModelAttribute AssetTakeOutHistoryVO atouhvo) {
		AssetVO avo = new AssetVO();
		avo.setAssetId(atouhvo.getAssetId());
		avo.setAssetOutStatus(atouhvo.getAssetOutStatus());
		aService.updateAsset(avo);
		aService.insertAssetTakeOutHistory(atouhvo);
		return "redirect:/assetDetail?assetId="+atouhvo.getAssetId();
	}
	
	@RequestMapping(value="/assetPayment")
	public String assetPayment(@RequestParam String assetId) {

		java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<AssetTakeOutHistoryVO> atouhList = aService.getAssetTakeOutHistoryByAssetId(assetId);
		for(AssetTakeOutHistoryVO vo : atouhList) {
			System.out.println(vo.getAssetId()+" : "+vo.getAssetOutStatus()+" 번호 : "+vo.getTakeOutHistorySeq());
		}
		map.put("assetId", assetId);
		map.put("takeoutHistorySeq",atouhList.get(atouhList.size()-1).getTakeOutHistorySeq());	
		map.put("assetOutEndDate", now);
		
		map.put("assetOutStatus", atouhList.get(atouhList.size()-1).getAssetOutStatus());
		aService.upateAssetTakeOutHistory(map);
		
		AssetVO avo = new AssetVO();
		avo.setAssetId(assetId);
		avo.setAssetOutStatus("반출 X");
		aService.updateAsset(avo);
		
		return "redirect:/assetDetail?assetId="+assetId;
	}
}





















