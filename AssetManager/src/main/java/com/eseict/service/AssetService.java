package com.eseict.service;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.AssetTakeOutHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

public interface AssetService {

	// 자산 등록
	public void insertAsset(AssetVO avo) throws Exception;
	// 카테고리 이름으로 항목 조회
	public List<CategoryVO> getCategoryDetailItem(String assetCategory) throws Exception;
	// 자산 정보 수정
	public int updateAsset(AssetVO avo) throws Exception;
	// 해당 id의 자산 삭제
	public int deleteAssetById(String assetId) throws Exception;
	public int deleteAssetDetailById(String assetId) throws Exception;
	// 해당 분류의 자산 ID 리스트 조회
	public List<String> getAssetIdListByCategory(String assetCategory) throws Exception;

	public ModelAndView assetListMnV(String searchMode, String searchKeyword) throws Exception;
	// assetId로 상세보기
	public ModelAndView assetDetailMnV(String assetId) throws Exception;
	
	public ModelAndView assetRegisterMnV() throws Exception;

	public String generateAssetId(AssetVO avo) throws Exception;
	
	public String uploadImageFile(ServletContext ctx, MultipartFile uploadImage) throws Exception;
	// 자산 세부사항 등록
	public int insertAssetDetail(String assetId, String[] items, String[] itemsDetail) throws Exception;

	public int updateAssetDetail(String assetId, String[] items, String[] itemsDetail) throws Exception;
	// 자산 이력 등록
	public int insertAssetHistory(String assetId, String assetUser) throws Exception;

	public int updateAssetHistory(String assetId, String assetUser, int empSeq, int newEmpSeq) throws Exception;

	public ModelAndView assetModifyMnV(String assetId) throws Exception;
	// 자산 폐기 신청
	public int updateAssetDisposal(String[] assetIdList) throws Exception;

	public ModelAndView assetHistoryMnV(String assetId) throws Exception;
	// 자산 반출/수리 입력
	public int insertAssetTakeOutHistory(AssetTakeOutHistoryVO atouhvo) throws Exception;
	// 자산 납입
	public int upateAssetTakeOutHistory(String assetId) throws Exception;
	// 자산 등록 할 때 반출 중/수리 중 선택 시 자산 반출/수리 등록
	public int insertAssetTakeOutHistoryWhenRegister(AssetTakeOutHistoryVO atouhvo) throws Exception;
	// My 자산 목록 조회
	public ModelAndView myAssetListMnV(String searchMode, String searchKeyword,int employeeSeq) throws Exception;
	
}

