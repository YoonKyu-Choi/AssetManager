package com.eseict.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;
import com.eseict.VO.EmployeeVO;
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
	public String assetRegister(@ModelAttribute AssetVO avo, @RequestParam String[] items,
			@RequestParam String[] itemsDetail, @RequestParam(required=false) MultipartFile uploadImage, HttpServletRequest request)
			throws IllegalStateException, IOException {
		System.out.println("0000");
		// 관리 번호 생성
		String categoryKeyword = null;
		int year = 0;
		String month = null;
		String categoryName = avo.getAssetCategory();
		String itemSequence = null;
		
		categoryKeyword = cService.getCode(categoryName);
		System.out.println("1111");
		year = avo.getAssetPurchaseDate().getYear() % 100;
		if(avo.getAssetPurchaseDate().getMonth() + 1 <10) {
			month = "0" + Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1); 
		} else {
			month = Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1);
		}
		int i = aService.getAssetCountByCategory(avo.getAssetCategory()) + 1;
		System.out.println("2222");
		if (i < 10) {
			itemSequence = "0" + "0" + i;
		} else if(i>=10 && i<100) {
			itemSequence = "0" + i;
		} else {
			itemSequence = Integer.toString(i);	
		}
		avo.setAssetId(year + month + "-" + categoryKeyword + "-" + (itemSequence));
		
		System.out.println("3333");
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
		AssetDetailVO dvo = new AssetDetailVO();
		dvo.setAssetId(year + month + "-" + categoryKeyword + "-" + (itemSequence));
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			aService.insertAssetDetail(dvo);
		}
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
	
}





















