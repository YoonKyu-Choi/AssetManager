package com.eseict.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.DAO.AssetDAO;
import com.eseict.VO.AssetVO;

@Service
public class DisposalServiceImpl implements DisposalService{

	@Autowired
	private AssetDAO dao;
	
	@Override
	public ModelAndView disposalListMnV(String searchMode, String searchKeyword) {
		HashMap<String, Object> disposalListData = new HashMap<String, Object>();

		List<AssetVO> volist = dao.getDisposalAssetList();

		int assetCountByDispReady =dao.getAssetCountByDispReady();
		int assetCountByDisposal =dao.getAssetCountByDisposal();
		
		disposalListData.put("assetList", volist);
		disposalListData.put("assetCountByDispReady", assetCountByDispReady);
		disposalListData.put("assetCountByDisposal", assetCountByDisposal);

		if(searchKeyword != null) {
			disposalListData.put("searchMode", searchMode);
			disposalListData.put("searchKeyword", searchKeyword);
			disposalListData.put("search", "1");
		} else {
			disposalListData.put("search", "0");
		}
		return new ModelAndView("disposalList.tiles", "disposalListData", disposalListData);
	}

	@Override
	public int disposeAsset(String[] disposeArray) {
		int ret = 0;
		for(String assetId: disposeArray) {
			ret += dao.disposeAsset(assetId);
		}
		return ret;
	}

}
