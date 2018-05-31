package com.eseict.service;

import java.util.List;

import com.eseict.VO.AssetVO;

public interface AssetService {

	// 자산 목록 조회
	public List<AssetVO> getAssetList();
	// 총 자산 수
	public int getAssetCount();
	// 사용 자산 수
	public int getAssetCountByUse();
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
	// 폐기 자산 목록 조회
	public List<AssetVO> getDisposalAssetList();
	// 폐기 처리
	public void disposeAsset(String assetId);
}
