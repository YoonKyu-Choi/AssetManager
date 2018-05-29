package com.eseict.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.AssetVO;

@Repository
public class AssetDAOImpl implements AssetDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.eseict.mapper.AssetMapper.";

	@Override
	public List<AssetVO> getAssetList() {
		return sqlSession.selectList(namespace+"getAssetList");
	}

	@Override
	public int getAssetCount() {
		return sqlSession.selectOne(namespace+"getAssetCount");
	}

	@Override
	public int getAssetCountByUse() {
		return sqlSession.selectOne(namespace+"getAssetCountByUse");
	}

	@Override
	public int getAssetCountbyNotUse() {
		return sqlSession.selectOne(namespace+"getAssetCountByNotUse");
	}

	@Override
	public int getAssetCountByOut() {
		return sqlSession.selectOne(namespace+"getAssetCountByOut");
	}

	@Override
	public int getAssetCountByDispReady() {
		return sqlSession.selectOne(namespace+"getAssetCountByDispReady");
	}

	@Override
	public int getAssetCountByDisposal() {
		return sqlSession.selectOne(namespace+"getAssetCountByDisposal");
	}

	@Override
	public AssetVO getAssetByAssetId(String assetId) {
		return sqlSession.selectOne(namespace+"getAssetByAssetId",assetId);
	}

	@Override
	public void insertAsset(AssetVO avo) {
		sqlSession.selectOne(namespace+"insertAsset",avo);
	}

	@Override
	public int getAssetCountByCategory(String assetCategory) {
		return sqlSession.selectOne(namespace+"getAssetByCategory",assetCategory);
	}

}
