package com.eseict.DAO;

import java.util.HashMap;
import java.util.List;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetTakeOutHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

public interface AssetDAO {

	// 자산 목록 조회
	public List<AssetVO> getAssetList() throws Exception;
	// 총 자산 수
	public int getAssetCount() throws Exception;
	// 폐기 대기 자산 수
	public int getAssetCountByDispReady() throws Exception;
	// 폐기 자산 수 
	public int getAssetCountByDisposal() throws Exception;
	// 관리번호로 상세보기
	public AssetVO getAssetByAssetId(String assetId) throws Exception;
	// 자산 등록
	public void insertAsset(AssetVO avo) throws Exception;
	// 카테고리별 자산 수 
	public int getAssetCountByCategory(String assetCategory);
	// 카테고리 이름으로 항목 조회
	public List<CategoryVO> getCategoryDetailItem(String assetCategory) throws Exception;
	// 폐기 자산 목록 조회
	public List<AssetVO> getDisposalAssetList() throws Exception;
	// 폐기 처리
	public int disposeAsset(String assetId) throws Exception;
	// 카테고리 리스트 조회
	public List<String> getAssetCategoryList() throws Exception;
	// 자산 세부사항 등록
	public int insertAssetDetail(AssetDetailVO dvo) throws Exception;
	// 자산 세부사항 상세보기
	public List<AssetDetailVO> getAssetDetailByAssetId(String assetId) throws Exception;
	// 자산 정보 수정
	public int updateAsset(AssetVO avo) throws Exception;
	public int updateAssetDetail(AssetDetailVO dvo) throws Exception;
	// 해당 id의 자산 삭제
	public int deleteAssetById(String assetId) throws Exception;
	public int deleteAssetDetailById(String assetId) throws Exception;
	// 해당 분류의 자산 ID 리스트 조회
	public List<String> getAssetIdListByCategory(String assetCategory) throws Exception;
	// 자산 폐기 신청
	public int updateAssetDisposal(String assetId) throws Exception;
	// 자산 이력 조회
	public AssetHistoryVO getAssetHistoryByAssetId(String assetId) throws Exception;
	// 자산 이전 사용자 리스트 조회
	public List<AssetFormerUserVO> getAssetFormerUserByAssetId(String assetId) throws Exception;
	// 자산 이력 등록
	public int insertAssetHistory(AssetHistoryVO ahvo) throws Exception;
	// 자산 이전 사용자 등록
	public int insertAssetFormerUser(AssetFormerUserVO afuvo) throws Exception;
	// 자산 이전 사용자 수정 
	public int updateAssetFormerUserByKey(HashMap<String, Object> map) throws Exception;
	// 자산 이력 수정
	public int updateAssetHistory(AssetHistoryVO ahvo) throws Exception;
	// 자산 반출/수리 이력 조회 
	public List<AssetTakeOutHistoryVO> getAssetTakeOutHistoryByAssetId(String assetId) throws Exception;
	// 자산 반출/수리 입력
	public int insertAssetTakeOutHistory(AssetTakeOutHistoryVO atouhvo) throws Exception;
	// 자산 납입
	public int upateAssetTakeOutHistory(HashMap<String, Object> map) throws Exception;
	// 자산 반출 seq 조회
	public List<Integer> getTakeOutHistorySeqByAssetId(String assetId) throws Exception;
	// 자산 카테고리 검색
	public List<String> getAssetCategoryByName(String assetCategory) throws Exception;

	// My자산 목록 조회
	public List<AssetVO> getMyAssetList(int employeeSeq) throws Exception;
	// My 자산 목록 수 
	public int getMyAssetCount(int employeeSeq) throws Exception;
}
