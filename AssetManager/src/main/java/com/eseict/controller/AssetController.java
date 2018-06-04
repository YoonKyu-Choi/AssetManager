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

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;
import com.eseict.service.AssetService;
import com.eseict.service.EmployeeService;

@Controller
public class AssetController {
	
	@Autowired
	private AssetService service;
	@Autowired
	private EmployeeService service2;
	
	/*
	@Resource(name="imageView") ImageView imageView;
	
	@Autowired
	private ImageService service3;
	*/
	
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
	public ModelAndView assetDetail(Model model, @RequestParam String assetId) {
		System.out.println(assetId);
		AssetVO avo = service.getAssetByAssetId(assetId);
		List<AssetDetailVO> dlist = service.getAssetDetailByAssetId(assetId);
		System.out.println(avo);
		model.addAttribute("assetVO",avo);
		model.addAttribute("assetDetailList",dlist);
		return new ModelAndView("assetDetail.tiles", "model", model);
	}
	
	@RequestMapping(value = "/assetRegister", method = RequestMethod.GET)
	public String register(HttpSession session) {
		return "assetRegister.tiles";
	}
	
	@RequestMapping(value="/assetRegister2")
	public String assetRegister(@ModelAttribute AssetVO avo, @RequestParam String[] items
								, @RequestParam String[] itemsDetail
								, @RequestParam MultipartFile uploadImage
								, HttpServletRequest request) throws IllegalStateException, IOException {
		// 관리 번호 생성
		String categoryKeyword = null;
		int year = 0;
		String month = null;
		String ac = avo.getAssetCategory();
		String itemSequence = null;
		
		if(ac.equals("노트북")) { categoryKeyword = "NT";
		}else if(ac.equals("데스크탑")) {	categoryKeyword = "DT";
		}else if(ac.equals("모니터")) { categoryKeyword = "MT";
		}else if(ac.equals("서버")) { categoryKeyword = "SV";
		}else if(ac.equals("SoftWare")) { categoryKeyword = "SW";
		}else if(ac.equals("IP WALL")) { categoryKeyword = "IW";
		}else if(ac.equals("프린터")) { categoryKeyword = "PR";
		}else if(ac.equals("책상")) { categoryKeyword = "TA";
		}else if(ac.equals("의자")) { categoryKeyword = "CH";
		}else if(ac.equals("책")) { categoryKeyword = "BO";
		}else if(ac.equals("기타")) { categoryKeyword = "ET";
		}else{ categoryKeyword="NW";
		}
		
		year = avo.getAssetPurchaseDate().getYear()%100;
		if(avo.getAssetPurchaseDate().getMonth()+1 <10) {
			month = "0"+Integer.toString(avo.getAssetPurchaseDate().getMonth()+1); 
		} else {
			month = Integer.toString(avo.getAssetPurchaseDate().getMonth()+1);
		}
		
		int i = service.getAssetCountByCategory(avo.getAssetCategory())+1;
		if(i<10) {	itemSequence = "0"+"0"+i;
		} else if(i>=10 && i<100) {	itemSequence = "0"+i;
		} else { itemSequence = Integer.toString(i);	
		}
		avo.setAssetId(year+month+"-"+categoryKeyword+"-"+(itemSequence));
		System.out.println("관리번호 생성 : "+year+month+"-"+categoryKeyword+"-"+(itemSequence));
		
		// 파일 업로드
		// MultipartFile assetReceiptUrl = avo.getMultiImage();
		if(uploadImage != null && !uploadImage.isEmpty()) {
			String uploadDir = request.getServletContext().getRealPath("/uploadImages");
			String fileName = UUID.randomUUID().toString();
			uploadImage.transferTo(new File(uploadDir,fileName+".jpg"));
			avo.setAssetReceiptUrl(fileName+".jpg");
			System.out.println("업로드 출력 되나"+fileName);
		}
		
		service.insertAsset(avo);
		
		AssetDetailVO dvo = new AssetDetailVO();
		dvo.setAssetId(year+month+"-"+categoryKeyword+"-"+(itemSequence));
		for(int a=0; a<items.length; a++) {
			String s = items[a];
			String s2 = itemsDetail[a];
			dvo.setAssetItem(s);
			dvo.setAssetItemDetail(s2);
			service.insertAssetDetail(dvo);
			System.out.println(dvo.getAssetId()+ " "+dvo.getAssetItem()+" "+dvo.getAssetItemDetail());
		}
		
		return "redirect:/assetList.tiles";
	}
	
	
	@RequestMapping(value="/getCategoryDetailItem")
	@ResponseBody
	public List<CategoryVO> getCategoryDetailItem(@RequestParam String assetCategory) {
		System.out.println(assetCategory);
		List<CategoryVO> list = service.getCategoryDetailItem(assetCategory);
		System.out.println(list);	
		return list;
	}
	
	@RequestMapping(value="/nameList2")
	public ModelAndView nameList2(Model model) {
		List<String> list =service2.getEmployeeNameList();
		List<String> list2 = service.getAssetCategoryList();
		model.addAttribute("employeeNameList",list);
		model.addAttribute("categoryList",list2);
		return new ModelAndView("assetRegister.tiles","list",model); 
	}
	
	@RequestMapping(value="uploadImage")
	@ResponseBody
	public String upliadImage(@RequestParam MultipartFile assetReceiptUrl, HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		// 이미지 업로드
				
		return "assetRegister.tiles";
	}
	
}




















