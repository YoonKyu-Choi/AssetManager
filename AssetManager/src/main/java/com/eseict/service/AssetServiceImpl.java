package com.eseict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.DAO.AssetDAO;
import com.eseict.VO.AssetVO;

@Service
public class AssetServiceImpl implements AssetService{

	@Autowired
	private AssetDAO dao;
	
	@Override
	public List<AssetVO> getAssetList() {
		return dao.getAssetList();
	}
	
	@Override
	public int getAssetCount() {
		return dao.getAssetCount();
	}

	@Override
	public int getAssetCountByUse() {
		return dao.getAssetCountByUse();
	}

	@Override
	public int getAssetCountByNotUse() {
		return dao.getAssetCountbyNotUse();
	}

	@Override
	public int getAssetCountByOut() {
		return dao.getAssetCountByOut();
	}

	@Override
	public int getAssetCountByDispReady() {
		return dao.getAssetCountByDispReady();
	}

	@Override
	public int getAssetCountByDisposal() {
		return dao.getAssetCountByDisposal();
	}

	@Override
	public AssetVO getAssetByAssetId(String assetId) {
		return dao.getAssetByAssetId(assetId);
	}

	@Override
	public void insertAsset(AssetVO avo) {
		dao.insertAsset(avo);
	}

	@Override
	public int getAssetCountByCategory(String assetCategory) {
		System.out.println("서비스 카테고리명 : "+assetCategory);
		return dao.getAssetCountByCategory(assetCategory);
	}

	@Override
	public List<AssetVO> getDisposalAssetList() {
		return dao.getDisposalAssetList();
	}

	@Override
	public void disposeAsset(String assetId) {
		dao.disposeAsset(assetId);
	}

	
}
