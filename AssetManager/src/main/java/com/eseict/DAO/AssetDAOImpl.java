package com.eseict.DAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetFormerUserVO;
import com.eseict.VO.AssetHistoryVO;
import com.eseict.VO.AssetTakeOutHistoryVO;
import com.eseict.VO.AssetVO;
import com.eseict.VO.CategoryVO;

@Repository
public class AssetDAOImpl implements AssetDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "com.eseict.mapper.AssetMapper.";

	@Override
	public List<AssetVO> getAssetList() throws Exception {
		return sqlSession.selectList(namespace + "getAssetList");
	}

	@Override
	public int getAssetCount() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCount");
	}

	@Override
	public int getAssetCountByUse() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByUse");
	}

	@Override
	public int getAssetCountCanUse() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountCanUse");
	}

	@Override
	public int getAssetCountByNotUse() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByNotUse");
	}

	@Override
	public int getAssetCountByOut() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByOut");
	}

	@Override
	public int getAssetCountByDispReady() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByDispReady");
	}

	@Override
	public int getAssetCountByDisposal() throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByDisposal");
	}

	@Override
	public AssetVO getAssetByAssetId(String assetId) throws Exception {
		return sqlSession.selectOne(namespace + "getAssetByAssetId", assetId);
	}

	@Override
	public void insertAsset(AssetVO avo) throws Exception {
		sqlSession.selectOne(namespace + "insertAsset", avo);
	}

	@Override
	public int getAssetCountByCategory(String assetCategory) throws Exception {
		return sqlSession.selectOne(namespace + "getAssetCountByCategory", assetCategory);
	}

	@Override
	public List<CategoryVO> getCategoryDetailItem(String assetCategory) throws Exception {
		return sqlSession.selectList(namespace + "getCategoryDetailItem", assetCategory);
	}

	public List<AssetVO> getDisposalAssetList() throws Exception {
		return sqlSession.selectList(namespace + "getDisposalAssetList");
	}

	@Override
	public int disposeAsset(String assetId) throws Exception {
		return sqlSession.update(namespace + "disposeAsset", assetId);
	}

	@Override
	public List<String> getAssetCategoryList() throws Exception {
		return sqlSession.selectList(namespace+"getAssetCategoryList");
	}

	@Override
	public int insertAssetDetail(AssetDetailVO dvo) throws Exception {
		return sqlSession.insert(namespace+"insertAssetDetail",dvo);
	}

	@Override
	public List<AssetDetailVO> getAssetDetailByAssetId(String assetId) throws Exception {
		return sqlSession.selectList(namespace+"getAssetDetailByAssetId",assetId);
	}

	@Override
	public int updateAsset(AssetVO avo) throws Exception {
		return sqlSession.update(namespace+"updateAsset",avo);
	}

	@Override
	public int updateAssetDetail(AssetDetailVO dvo) throws Exception {
		return sqlSession.update(namespace+"updateAssetDetail",dvo);
	}

	@Override
	public int deleteAssetById(String assetId) throws Exception {
		return sqlSession.delete(namespace+"deleteAssetById", assetId);
	}
	@Override
	public int deleteAssetDetailById(String assetId) throws Exception {
		return sqlSession.delete(namespace+"deleteAssetDetailById", assetId);
	}

	@Override
	public List<String> getAssetIdListByCategory(String assetCategory) throws Exception {
		return sqlSession.selectList(namespace+"getAssetIdListByCategory", assetCategory);
	}

	@Override
	public int updateAssetDisposal(String assetId) throws Exception {
		return sqlSession.update(namespace+"updateAssetDisposal",assetId);
	}

	@Override
	public AssetHistoryVO getAssetHistoryByAssetId(String assetId) throws Exception {
		return sqlSession.selectOne(namespace + "getAssetHistoryByAssetId", assetId);
	}

	@Override
	public List<AssetFormerUserVO> getAssetFormerUserByAssetId(String assetId) throws Exception {
		return sqlSession.selectList(namespace+"getAssetFormerUserByAssetId", assetId);
	}

	@Override
	public int insertAssetHistory(AssetHistoryVO ahvo) throws Exception {
		return sqlSession.insert(namespace+"insertAssetHistory",ahvo);
	}

	@Override
	public int insertAssetFormerUser(AssetFormerUserVO afuvo) throws Exception {
		return sqlSession.insert(namespace+"insertAssetFormerUser",afuvo);
	}

	@Override
	public int updateAssetFormerUserByKey(HashMap<String, Object> map) throws Exception {
		return sqlSession.update(namespace+"updateAssetFormerUserByKey",map);
	}

	@Override
	public int updateAssetHistory(AssetHistoryVO ahvo) throws Exception {
		return sqlSession.update(namespace+"updateAssetHistory",ahvo);
	}

	@Override
	public List<AssetTakeOutHistoryVO> getAssetTakeOutHistoryByAssetId(String assetId) throws Exception {
		return sqlSession.selectList(namespace+"getAssetTakeOutHistoryByAssetId",assetId);
	}

	@Override
	public int insertAssetTakeOutHistory(AssetTakeOutHistoryVO atouhvo) throws Exception {
		return sqlSession.insert(namespace+"insertAssetTakeOutHistory",atouhvo);
	}

	@Override
	public int upateAssetTakeOutHistory(HashMap<String, Object> map) throws Exception {
		return sqlSession.update(namespace+"upateAssetTakeOutHistory",map);
	}

	@Override
	public List<Integer> getTakeOutHistorySeqByAssetId(String assetId) throws Exception {
		return sqlSession.selectList(namespace+"getTakeOutHistorySeqByAssetId",assetId);
	}

	@Override
	public List<String> getAssetCategoryByName(String assetCategory) throws Exception {
		return sqlSession.selectList(namespace+"getAssetCategoryByName",assetCategory);
	}


}
