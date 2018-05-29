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
		return dao.getAssetCountByCategory(assetCategory);
	}

	
}
