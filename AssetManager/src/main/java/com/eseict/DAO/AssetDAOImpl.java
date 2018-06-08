package com.eseict.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

@Repository
public class AssetDAOImpl implements AssetDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "com.eseict.mapper.AssetMapper.";

	@Override
	public List<AssetVO> getAssetList() {
		return sqlSession.selectList(namespace + "getAssetList");
	}

	@Override
	public int getAssetCount() {
		return sqlSession.selectOne(namespace + "getAssetCount");
	}

	@Override
	public int getAssetCountByUse() {
		return sqlSession.selectOne(namespace + "getAssetCountByUse");
	}

	@Override
	public int getAssetCountCanUse() {
		return sqlSession.selectOne(namespace + "getAssetCountCanUse");
	}

	@Override
	public int getAssetCountbyNotUse() {
		return sqlSession.selectOne(namespace + "getAssetCountByNotUse");
	}

	@Override
	public int getAssetCountByOut() {
		return sqlSession.selectOne(namespace + "getAssetCountByOut");
	}

	@Override
	public int getAssetCountByDispReady() {
		return sqlSession.selectOne(namespace + "getAssetCountByDispReady");
	}

	@Override
	public int getAssetCountByDisposal() {
		return sqlSession.selectOne(namespace + "getAssetCountByDisposal");
	}

	@Override
	public AssetVO getAssetByAssetId(String assetId) {
		return sqlSession.selectOne(namespace + "getAssetByAssetId", assetId);
	}

	@Override
	public void insertAsset(AssetVO avo) {
		sqlSession.selectOne(namespace + "insertAsset", avo);
	}

	@Override
	public int getAssetCountByCategory(String assetCategory) {
		System.out.println("dao 카테고리명 : " + assetCategory);
		return sqlSession.selectOne(namespace + "getAssetCountByCategory", assetCategory);
	}

	@Override
	public List<CategoryVO> getCategoryDetailItem(String assetCategory) {
		return sqlSession.selectList(namespace + "getCategoryDetailItem", assetCategory);
	}

	public List<AssetVO> getDisposalAssetList() {
		return sqlSession.selectList(namespace + "getDisposalAssetList");
	}

	@Override
	public void disposeAsset(String assetId) {
		sqlSession.update(namespace + "disposeAsset", assetId);
	}

	@Override
	public List<String> getAssetCategoryList() {
		return sqlSession.selectList(namespace+"getAssetCategoryList");
	}

	@Override
	public void insertAssetDetail(AssetDetailVO dvo) {
		sqlSession.insert(namespace+"insertAssetDetail",dvo);
	}

	@Override
	public List<AssetDetailVO> getAssetDetailByAssetId(String assetId) {
		return sqlSession.selectList(namespace+"getAssetDetailByAssetId",assetId);
	}

	@Override
	public int updateAsset(AssetVO avo) {
		return sqlSession.update(namespace+"updateAsset",avo);
	}

	@Override
	public int updateAssetDetail(AssetDetailVO dvo) {
		return sqlSession.update(namespace+"updateAssetDetail",dvo);
	}

	@Override
	public int deleteAssetById(String assetId) {
		return sqlSession.delete(namespace+"deleteAssetById", assetId);
	}

	@Override
	public List<String> getAssetIdListByCategory(String assetCategory) {
		return sqlSession.selectList(namespace+"getAssetIdListByCategory", assetCategory);
	}

	@Override
	public int updateAssetDisposal(String assetId) {
		return sqlSession.update(namespace+"updateAssetDisposal",assetId);
	}

	@Override
	public AssetHistoryVO getAssetHistoryByAssetId(String assetId) {
		return sqlSession.selectOne(namespace + "getAssetHistoryByAssetId", assetId);
	}

	@Override
	public List<AssetFormerUserVO> getAssetFormerUserByAssetId(String assetId) {
		return sqlSession.selectList(namespace+"getAssetFormerUserByAssetId", assetId);
	}


}
