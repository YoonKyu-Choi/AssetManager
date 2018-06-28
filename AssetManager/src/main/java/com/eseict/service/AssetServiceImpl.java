package com.eseict.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.DAO.AssetDAO;
import com.eseict.DAO.CategoryDAO;
import com.eseict.DAO.EmployeeDAO;
import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetTakeOutHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

@Service
public class AssetServiceImpl implements AssetService {

	@Autowired
	private AssetDAO aDao;

	@Autowired
	private EmployeeDAO eDao;

	@Autowired
	private CategoryDAO cDao;

	@Override
	public void insertAsset(AssetVO avo) throws Exception {
		aDao.insertAsset(avo);
	}

	@Override
	public List<CategoryVO> getCategoryDetailItem(String assetCategory) throws Exception {
		return aDao.getCategoryDetailItem(assetCategory);
	}

	@Override
	public int updateAsset(AssetVO avo) throws Exception {
		return aDao.updateAsset(avo);
	}

	@Override
	public int deleteAssetById(String assetId) throws Exception {
		return aDao.deleteAssetById(assetId);
	}
	@Override
	public int deleteAssetDetailById(String assetId) throws Exception {
		return aDao.deleteAssetDetailById(assetId);
	}


	@Override
	public List<String> getAssetIdListByCategory(String assetCategory) throws Exception {
		return aDao.getAssetIdListByCategory(assetCategory);
	}


	@Override
	public ModelAndView assetListMnV(String searchMode, String searchKeyword) throws Exception {
		HashMap<String, Object> assetListData = new HashMap<String, Object>();

		List<AssetVO> volist = aDao.getAssetList();
		int assetCount = aDao.getAssetCount();

		assetListData.put("assetList", volist);
		assetListData.put("assetCount", assetCount);
		
		HashMap<AssetVO, List<String>> assetItemList = new HashMap<AssetVO, List<String>>();
		for(AssetVO category: volist) {
			assetItemList.put(category, aDao.getAssetCategoryByName(category.getAssetCategory()));
		}
		
		assetListData.put("assetItemList", assetItemList);
		assetListData.put("assetCount", volist.size());
		
		if(searchKeyword != null) {
			assetListData.put("searchMode", searchMode);
			assetListData.put("searchKeyword", searchKeyword);
			assetListData.put("search", "1");
		} else {
			assetListData.put("search", "0");
		}
		return new ModelAndView("assetList.tiles", "assetListData", assetListData);
	}
	
	@Override
	public ModelAndView myAssetListMnV(String searchMode, String searchKeyword,int employeeSeq) throws Exception {
		HashMap<String, Object> assetListData = new HashMap<String, Object>();

		List<AssetVO> volist = aDao.getMyAssetList(employeeSeq);
		int assetCount = aDao.getMyAssetCount(employeeSeq);

		assetListData.put("assetList", volist);
		assetListData.put("assetCount", assetCount);
		
		HashMap<AssetVO, List<String>> assetItemList = new HashMap<AssetVO, List<String>>();
		for(AssetVO category: volist) {
			assetItemList.put(category, aDao.getAssetCategoryByName(category.getAssetCategory()));
		}
		
		assetListData.put("assetItemList", assetItemList);
		assetListData.put("assetCount", volist.size());
		
		if(searchKeyword != null) {
			assetListData.put("searchMode", searchMode);
			assetListData.put("searchKeyword", searchKeyword);
			assetListData.put("search", "1");
		} else {
			assetListData.put("search", "0");
		}
		return new ModelAndView("myAssetList.tiles", "assetListData", assetListData);
	}

	@Override
	public ModelAndView assetDetailMnV(String assetId) throws Exception {
		AssetVO avo = aDao.getAssetByAssetId(assetId);
		List<AssetDetailVO> dlist = aDao.getAssetDetailByAssetId(assetId);
		HashMap<String, Object> assetData = new HashMap<String, Object>();
		Logger.getLogger(assetId);
		assetData.put("assetVO", avo);
		assetData.put("assetDetailList", dlist);
		assetData.put("assetUserId",eDao.getEmployeeIdByEmpSeq(avo.getEmployeeSeq()));
		return new ModelAndView("assetDetail.tiles", "assetData", assetData);
	}
	
	@Override
	public ModelAndView assetRegisterMnV() throws Exception {
		HashMap<String, Object> model = new HashMap<String, Object>();
		List<String> elist = eDao.getEmployeeNameList();
		List<String> clist = aDao.getAssetCategoryList();
		
		model.put("employeeNameList", elist);
		model.put("categoryList", clist);
		return new ModelAndView("assetRegister.tiles", "list", model); 
	}

	@Override
	public String generateAssetId(AssetVO avo) throws Exception {

		// 관리 번호 생성
		String categoryKeyword = null;
		String year = null;
		String month = null;
		String categoryName = avo.getAssetCategory();
		String itemSequence = null;
		
		categoryKeyword = cDao.getCode(categoryName);
		
		// getYear는 폐기함수 -> getFullYear 함수로 대체 ,
		// Year,Month 한자리수일 때 형식에 맞게 수정
		if(avo.getAssetPurchaseDate().getYear() % 100 <10) {
			year = "0" + Integer.toString(avo.getAssetPurchaseDate().getYear() % 100); 
		} else {
			year = Integer.toString(avo.getAssetPurchaseDate().getYear() % 100);
		}
		if(avo.getAssetPurchaseDate().getMonth() + 1 <10) {
			month = "0" + Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1); 
		} else {
			month = Integer.toString(avo.getAssetPurchaseDate().getMonth() + 1);
		}
		
		int i = aDao.getAssetCountByCategory(avo.getAssetCategory()) + 1;
		
		if (i < 10) {
			itemSequence = "0" + "0" + i;
		} else if(i>=10 && i<100) {
			itemSequence = "0" + i;
		} else {
			itemSequence = Integer.toString(i);	
		}
		
		if(avo.getAssetPurchaseDate().getYear() == 8099) { // 9999 를 넘기면 8099 로 받아짐
			return "0000"+ "-" + categoryKeyword + "-" + (itemSequence);
		}else {
			return year + month + "-" + categoryKeyword + "-" + (itemSequence);
		}
	}

	@Override
	public String uploadImageFile(ServletContext ctx, MultipartFile uploadImage) throws Exception {

		String uploadDir = ctx.getRealPath("/resources/");
		if(uploadImage != null && !uploadImage.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			File dir = new File(uploadDir+fileName+".jpg");
			uploadImage.transferTo(dir);
			return fileName+".jpg";
		}
		
		return null;
	}

	@Override
	public int insertAssetDetail(String assetId, String[] items, String[] itemsDetail) throws Exception{
		AssetDetailVO dvo = new AssetDetailVO();
		dvo.setAssetId(assetId);
		int ret = 0;
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			ret += aDao.insertAssetDetail(dvo);
		}
		return ret;
	}

	@Override
	public int updateAssetDetail(String assetId, String[] items, String[] itemsDetail) throws Exception{
		AssetDetailVO dvo = new AssetDetailVO();
		dvo.setAssetId(assetId);
		int ret = 0;
		for(int a = 0; a < items.length; a++) {
			dvo.setAssetItem(items[a]);
			dvo.setAssetItemDetail(itemsDetail[a]);
			ret += aDao.updateAssetDetail(dvo);
		}
		return ret;
	}

	@Override
	public int insertAssetHistory(String assetId, String assetUser) throws Exception {
		int ret = 0;
		int employeeSeq = 0;
		AssetHistoryVO ahvo = new AssetHistoryVO();
		java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
		ahvo.setAssetId(assetId);
		
		
		if(assetUser == "사용자 없음") {
			employeeSeq = 0;
		}else {
			employeeSeq = eDao.getEmployeeSeqByEmpId(assetUser);
		}
		ahvo.setEmployeeSeq(employeeSeq);
		ahvo.setAssetOccupiedDate(now);
		ret += aDao.insertAssetHistory(ahvo);
		
		AssetFormerUserVO afuvo = new AssetFormerUserVO();
		afuvo.setAssetId(assetId);
		afuvo.setEmployeeSeq(employeeSeq);
		if(afuvo.getAssetUser() == null) {
			afuvo.setAssetUser("사용자 없음");
		} else {
			afuvo.setAssetUser(eDao.getEmployeeNameByEmpId(assetUser));
		}
		afuvo.setAssetStartDate(now);
		ret += aDao.insertAssetFormerUser(afuvo);

		return ret;		// 정상 작동 시 ret = 2
	}

	@Override
	public int updateAssetHistory(String assetId, String assetUser, int empSeq, int newEmpSeq) throws Exception {

		int ret = 0;
		
		// 이전 사용자의 반납 날짜 입력 ( update이긴 한데 반납하기 전까진 null )
		AssetFormerUserVO afuvo = new AssetFormerUserVO();
		java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
		afuvo.setAssetEndDate(now);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("assetId", assetId);
		map.put("employeeSeq",empSeq);
		map.put("assetEndDate",now);
		ret += aDao.updateAssetFormerUserByKey(map);
		
		// 새로운 사용자 정보 입력
		AssetFormerUserVO newAfuvo = new AssetFormerUserVO();
		newAfuvo.setAssetId(assetId);
		newAfuvo.setEmployeeSeq(newEmpSeq);
		newAfuvo.setAssetUser(assetUser);
		newAfuvo.setAssetStartDate(now);
		ret += aDao.insertAssetFormerUser(newAfuvo);
		
		// 해당 자산 이력 수정
		AssetHistoryVO ahvo = new AssetHistoryVO();
		ahvo.setAssetId(assetId);
		ahvo.setEmployeeSeq(newEmpSeq);
		ahvo.setAssetOccupiedDate(now);
		ret += aDao.updateAssetHistory(ahvo);

		return ret;
	}
	
	@Override
	public ModelAndView assetModifyMnV(String assetId) throws Exception {
		HashMap<String, Object> model = new HashMap<String, Object>();

		AssetVO avo = aDao.getAssetByAssetId(assetId);
		List<AssetDetailVO> dlist = aDao.getAssetDetailByAssetId(assetId);
		List<String> elist = eDao.getEmployeeNameList();
		AssetHistoryVO ahvo = aDao.getAssetHistoryByAssetId(assetId);
		List<AssetFormerUserVO> afuvo = aDao.getAssetFormerUserByAssetId(assetId);
		int detailSize = dlist.size();
		String beforeUser = eDao.getEmployeeIdByEmpSeq(avo.getEmployeeSeq());
		
		// Detail 때문에 DB에 저장을 이름으로 저장하고 다시 뽑아갈 때는 ID로 뽑아간다.
		if(avo.getAssetUser() == "사용자 없음") {
			avo.setAssetUser("NoUser");
		} else {
			avo.setAssetUser(eDao.getEmployeeIdByEmpSeq(avo.getEmployeeSeq()));
		}
		avo.setAssetManager(eDao.getEmployeeIdByEmpSeq(avo.getAssetManagerSeq()));
		model.put("beforeUser",beforeUser);
		model.put("assetVO",avo);
		model.put("assetDetailList",dlist);
		model.put("employeeNameList", elist);
		model.put("AssetHistoryVO",ahvo);
		model.put("AssetFormerUserList",afuvo);
		model.put("dSize",detailSize);
		return new ModelAndView("assetModify.tiles","model",model);	
	}

	@Override
	public int updateAssetDisposal(String[] assetIdList) throws Exception {
		int ret = 0;
		for(int i=0;i<assetIdList.length;i++) {
			ret += aDao.updateAssetDisposal(assetIdList[i]);
		}
		return ret;
	}

	@Override
	public ModelAndView assetHistoryMnV(String assetId) throws Exception {
		HashMap<String, Object> model = new HashMap<String, Object>();

		AssetHistoryVO ahvo = aDao.getAssetHistoryByAssetId(assetId);
		List<AssetFormerUserVO> afulist = aDao.getAssetFormerUserByAssetId(assetId);
		List<AssetTakeOutHistoryVO> atohList = aDao.getAssetTakeOutHistoryByAssetId(assetId);
		
		model.put("assetId",assetId);
		model.put("AssetHistoryVO", ahvo);
		model.put("AssetFormerUserList", afulist);
		model.put("AssetTakeOutHistoryList",atohList);
		return new ModelAndView("assetHistory.tiles", "model", model);
	}

	@Override
	public int insertAssetTakeOutHistory(AssetTakeOutHistoryVO atouhvo) throws Exception {
		int ret = 0;
		AssetVO avo = new AssetVO();
		avo.setAssetId(atouhvo.getAssetId());
		avo.setAssetOutStatus(atouhvo.getAssetOutStatus());
		ret += aDao.updateAsset(avo);
		ret += aDao.insertAssetTakeOutHistory(atouhvo);
		return ret;
	}
	
	@Override
	public int insertAssetTakeOutHistoryWhenRegister(AssetTakeOutHistoryVO atouhvo) throws Exception {
		return aDao.insertAssetTakeOutHistory(atouhvo);
	}

	@Override
	public int upateAssetTakeOutHistory(String assetId) throws Exception {
		int ret = 0;
		
		java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<AssetTakeOutHistoryVO> atouhList = aDao.getAssetTakeOutHistoryByAssetId(assetId);

		map.put("assetId", assetId);
		map.put("takeoutHistorySeq",atouhList.get(atouhList.size()-1).getTakeOutHistorySeq());	
		map.put("assetOutEndDate", now);
		
		map.put("assetOutStatus", atouhList.get(atouhList.size()-1).getAssetOutStatus());
		ret += aDao.upateAssetTakeOutHistory(map);
		
		AssetVO avo = new AssetVO();
		avo.setAssetId(assetId);
		avo.setAssetOutStatus("반출 X");
		ret += aDao.updateAsset(avo);
		
		return ret;
	}


}
