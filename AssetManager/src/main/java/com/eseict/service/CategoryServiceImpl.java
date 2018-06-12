package com.eseict.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.eseict.DAO.CategoryDAO;
import com.eseict.VO.CategoryCodeVO;
import com.eseict.VO.CategoryVO;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO dao;
	
	@Override
	public String getCode(String categoryName) throws Exception {
		return dao.getCode(categoryName);
	}

	@Override
	public int deleteCategory(String categoryName) throws Exception{
		return dao.deleteCategory(categoryName);
	}

	@Override
	public int existsCode(String code) throws Exception{
		return dao.existsCode(code);
	}

	@Override
	public int newCode(String categoryName, String codeName) throws Exception{
		return dao.newCode(categoryName, codeName);
	}

	@Override
	public int deleteCode(String categoryName) throws Exception{
		return dao.deleteCode(categoryName);
	}

	@Override
	public ModelAndView categoryDetailMnV(String categoryName) throws Exception{
		List<String> cvo = dao.getCategoryByName(categoryName);
		HashMap<String, Object> categoryData = new HashMap<String, Object>();
		categoryData.put("name", categoryName);
		categoryData.put("items", cvo);
		categoryData.put("code", dao.getCode(categoryName));
		return new ModelAndView("categoryDetail.tiles", "categoryData", categoryData);
	}

	@Override
	public ModelAndView categoryListMnV(String searchMode, String searchKeyword) throws Exception{
		HashMap<String, Object> categoryListData = new HashMap<String, Object>();

		List<CategoryCodeVO> codelist = dao.getCategoryCodeList();
		HashMap<CategoryCodeVO, List<String>> categoryItemList = new HashMap<CategoryCodeVO, List<String>>();
		int columnSize = 0;
		
		for(CategoryCodeVO code: codelist) {
			categoryItemList.put(code, dao.getCategoryByName(code.getAssetCategory()));
		}

		for(CategoryCodeVO key: categoryItemList.keySet()) {
			int items = categoryItemList.get(key).size();
			if(columnSize < items) {
				columnSize = items;
			}
		}
		categoryListData.put("categoryItemList", categoryItemList);
		categoryListData.put("columnSize", columnSize);
		categoryListData.put("categoryCount", codelist.size());
		
		if(searchKeyword != null) {
			categoryListData.put("searchMode", searchMode);
			categoryListData.put("searchKeyword", searchKeyword);
			categoryListData.put("search", "1");
		} else {
			categoryListData.put("search", "0");
		}

		return new ModelAndView("categoryList.tiles", "categoryListData", categoryListData);
	}

	@Override
	public ModelAndView categoryModifyMnV(String categoryName) throws Exception{
		List<String> cvo = dao.getCategoryByName(categoryName);
		HashMap<String, Object> categoryData = new HashMap<String, Object>();
		categoryData.put("name", categoryName);
		categoryData.put("items", cvo);
		categoryData.put("itemSize", cvo.size());
		categoryData.put("code", dao.getCode(categoryName));
		return new ModelAndView("categoryModify.tiles", "categoryData", categoryData);
	}
	
	@Transactional
	@Override
	public boolean categoryRegisterSend(String categoryName, String[] items) throws Exception{
		for(String i: items) {
			if(!i.equals("")) {
				CategoryVO vo = new CategoryVO();
				vo.setAssetCategory(categoryName);
				vo.setAssetItem(i);
				dao.newCategory(vo);
			}
		}
		if(dao.isCategory(categoryName) > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int categoryModifyCheckName(String categoryOriName, String categoryName) throws Exception{
		List<String> cvolist = dao.getCategoryByName(categoryOriName);
		String[] cvo = new String[cvolist.size()];
		cvo = cvolist.toArray(cvo);

		if(!categoryOriName.equals(categoryName)) {
			return dao.updateCategoryName(categoryOriName, categoryName);
		} else {
			return 0;
		}
	}

	@Transactional
	@Override
	public ArrayList<Integer> categoryModifyItemDelete(String categoryName, String[] deleteItems) throws Exception{
		List<String> cvolist = dao.getCategoryByName(categoryName);
		String[] cvo = new String[cvolist.size()];
		cvo = cvolist.toArray(cvo);

		ArrayList<Integer> deleteItemsList = new ArrayList<Integer>();
		for(String s: deleteItems) {
			deleteItemsList.add(Integer.parseInt(s));
			dao.deleteItem(categoryName, cvo[Integer.parseInt(s)]);
		}
		return deleteItemsList;
	}

	@Transactional
	@Override
	public int categoryModifyItemUpdate(String categoryName, String[] items, ArrayList<Integer> deleteItemsList) throws Exception{
		List<String> cvolist = dao.getCategoryByName(categoryName);
		String[] cvo = new String[cvolist.size()];
		cvo = cvolist.toArray(cvo);
		List<String> itemsList = new ArrayList<String>(Arrays.asList(items));
		for(int i=deleteItemsList.size()-1; i>=0; i--) {
			itemsList.remove((int)deleteItemsList.get(i));
		}
		
		for(int i=0; i<cvo.length; i++) {
			if(!cvo[i].equals(itemsList.get(i)) && !itemsList.get(i).equals("")) {
				dao.updateItemName(cvo[i], itemsList.get(i), categoryName);
			}
		}
		
			
		for(int j=cvo.length; j<itemsList.size(); j++){
			if(!items[j].equals("")) {
				CategoryVO vo = new CategoryVO();
				vo.setAssetCategory(categoryName);
				vo.setAssetItem(itemsList.get(j));
				dao.newCategory(vo);
			}
		}
		return 0;
	}

	
}
