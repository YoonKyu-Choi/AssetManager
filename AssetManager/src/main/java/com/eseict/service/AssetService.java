package com.eseict.service;

import java.util.List;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

public interface AssetService {

	// 자산 목록 조회
	public List<AssetVO> getAssetList();
	// 총 자산 수
	public int getAssetCount();
	// 사용 자산 수
	public int getAssetCountByUse();
	// 사용 가능 자산 수
	public int getAssetCountCanUse();
	// 사용 불가 자산 수
	public int getAssetCountByNotUse();
	// 반출 자산 수
	public int getAssetCountByOut();
	// 폐기 대기 자산 수
	public int getAssetCountByDispReady();
	// 폐기 자산 수 
	public int getAssetCountByDisposal();
	// 관리번호로 상세보기
	public AssetVO getAssetByAssetId(String assetId);
	// 자산 등록
	public void insertAsset(AssetVO avo);
	// 카테고리 별 자산 수 
	public int getAssetCountByCategory(String assetCategory);
	// 카테고리 이름으로 항목 조회
	public List<CategoryVO> getCategoryDetailItem(String assetCategory);
	// 폐기 자산 목록 조회
	public List<AssetVO> getDisposalAssetList();
	// 폐기 처리
	public void disposeAsset(String assetId);
	// 카테고리 리스트 조회
	public List<String> getAssetCategoryList();
	// 자산 세부사항 등록
	public void insertAssetDetail(AssetDetailVO dvo);
	// 자산 세부사항 상세보기
	public List<AssetDetailVO> getAssetDetailByAssetId(String assetId);
	// 자산 정보 수정
	public int updateAsset(AssetVO avo);
	public int updateAssetDetail(AssetDetailVO dvo);
}
