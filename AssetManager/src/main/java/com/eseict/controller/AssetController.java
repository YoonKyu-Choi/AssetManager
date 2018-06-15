package com.eseict.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetTakeOutHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;
import com.eseict.service.AssetService;
import com.eseict.service.EmployeeService;

@Controller
public class AssetController {
	
	@Autowired
	private AssetService aService;
	@Autowired
	private EmployeeService eService;
	
	
	@RequestMapping(value="/assetList")
	public ModelAndView assetList(RedirectAttributes redirectAttributes
								, @RequestParam(required = false) String searchMode
								, @RequestParam(required = false) String searchKeyword) {

		try {
			if(searchKeyword != null) {
				return aService.assetListMnV(searchMode, searchKeyword);
			} else {
				return aService.assetListMnV(null, null);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/assetList");
	}
	
	@RequestMapping(value = "/assetDetail")
	public ModelAndView assetDetail(RedirectAttributes redirectAttributes
								  , @RequestParam String assetId) {
		try {
			return aService.assetDetailMnV(assetId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/assetList");

	}

	@RequestMapping(value = "/assetRegister")
	public ModelAndView nameList2(RedirectAttributes redirectAttributes) {
		try {
			return aService.assetRegisterMnV();
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/assetList");
	}
	
	@RequestMapping(value = "/assetRegisterSend")

	public String assetRegister(RedirectAttributes redirectAttributes
							  , @ModelAttribute AssetVO avo
							  , @RequestParam String[] items
							  , @RequestParam String[] itemsDetail
							  , @RequestParam(required=false) MultipartFile uploadImage
							  , HttpServletRequest request){

		try {
			// 관리 번호 생성
			String assetId = aService.generateAssetId(avo);
			avo.setAssetId(assetId);
			
			// 이미지 업로드
			avo.setAssetReceiptUrl(aService.uploadImageFile(request.getServletContext(), uploadImage));
			
			// 동명이인 방지용 사원번호
			String assetUser = avo.getAssetUser();
			avo.setEmployeeSeq(eService.getEmployeeSeqByEmpName(assetUser));
			
			aService.insertAsset(avo);
			
			// 자산 세부사항 등록 
			aService.insertAssetDetail(assetId, items, itemsDetail);
					
			// 자산 이력 등록
			aService.insertAssetHistory(assetId, assetUser);
			
			return "redirect:/assetList.tiles";
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/assetList.tiles";
	}
	
	@RequestMapping(value = "/getCategoryDetailItem")
	@ResponseBody
	public List<CategoryVO> getCategoryDetailItem(RedirectAttributes redirectAttributes
												, @RequestParam String assetCategory) {
		try {
			List<CategoryVO> list = aService.getCategoryDetailItem(assetCategory);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return null;
	}
	
	@RequestMapping(value="assetModify")
	public ModelAndView assetModify(RedirectAttributes redirectAttributes
								  , @RequestParam String assetId) {
		try {
			return aService.assetModifyMnV(assetId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/assetList");
	}
	
	// 자산 수정 Send
	@RequestMapping(value = "/assetModifySend")
	public String userModifySend(RedirectAttributes redirectAttributes
							   , @ModelAttribute AssetVO avo
							   , @ModelAttribute AssetDetailVO dvo
							   , @ModelAttribute AssetHistoryVO ahvo
							   , @ModelAttribute AssetFormerUserVO afuvo
							   , @RequestParam String[] items
							   , @RequestParam String[] itemsDetail
							   , @RequestParam String beforeUser
							   , @RequestParam(required=false) MultipartFile uploadImage
							   , HttpServletRequest request) {
		try {
			String assetId = avo.getAssetId();
			String assetUser = avo.getAssetUser();
			
			// new는 새로운 사용자 사용자번호, empSeq는 이전 사용자 번호 
			// -> 이 부분을 입력 받은 이름으로 해결하고 있는데 동명이인일 경우 문제 해결 필요
			int newEmpSeq = eService.getEmployeeSeqByEmpName(assetUser);
			int empSeq = eService.getEmployeeSeqByEmpName(beforeUser);
			
			// 이미지 업로드
			avo.setAssetReceiptUrl(aService.uploadImageFile(request.getServletContext(), uploadImage));
			
			avo.setEmployeeSeq(newEmpSeq);
			aService.updateAsset(avo);
			
			aService.updateAssetDetail(assetId, items, itemsDetail);
			
			// 자산 수정 시 자산 이력 자동 입력
			if(newEmpSeq != empSeq) {
				aService.updateAssetHistory(assetId, assetUser, empSeq, newEmpSeq);
			}
			return "redirect:/assetDetail?assetId="+assetId;
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/assetList";
	}
		
	@RequestMapping(value="/assetDisposal")	
	public String assetDisposal(RedirectAttributes redirectAttributes
							  , @RequestParam String[] assetIdList) {
		try {
			aService.updateAssetDisposal(assetIdList);
			return "redirect:/assetList.tiles";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/assetList";
	}
	
	@RequestMapping(value="/assetHistory")
	public ModelAndView assetHistory(RedirectAttributes redirectAttributes
								   , @RequestParam String assetId) {
		try {
			return aService.assetHistoryMnV(assetId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return new ModelAndView("redirect:/assetList");

	}
	
	@RequestMapping(value="/assetDelete")
	public String assetDelete(RedirectAttributes redirectAttributes
							, @RequestParam String assetId) {
		try {
			aService.deleteAssetById(assetId);	
			return "assetList.tiles";
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/assetList";
	}
	
	@RequestMapping(value="/assetTakeOutHistory")
	public String assetTakeOutHistory(RedirectAttributes redirectAttributes
									, @ModelAttribute AssetTakeOutHistoryVO atouhvo) {
		try {
			aService.insertAssetTakeOutHistory(atouhvo);
			return "redirect:/assetDetail?assetId="+atouhvo.getAssetId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/assetList";
	}
	
	@RequestMapping(value="/assetPayment")
	public String assetPayment(RedirectAttributes redirectAttributes
							 , @RequestParam String assetId) {
		try {
			aService.upateAssetTakeOutHistory(assetId);
			return "redirect:/assetDetail?assetId="+assetId;
		} catch (Exception e) {
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("msg", "에러 발생!");
		return "redirect:/assetList";
	}
}