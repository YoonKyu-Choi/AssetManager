package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.CategoryCodeVO;
import com.eseict.VO.CategoryVO;

public interface CategoryDAO {
	public List<CategoryVO> getCategoryList() throws Exception;
	
	public int getCategoryCount() throws Exception;
	
	public List<String> getCategoryByName(String categoryName) throws Exception;
	
	public int newCategory(CategoryVO vo) throws Exception;
	
	public int deleteCategory(String categoryName) throws Exception;
	
	public int deleteItem(String categoryName, String itemName) throws Exception;
	
	public int checkCategoryItem(CategoryVO vo) throws Exception;
	
	public int updateCategoryName(String categoryOriName, String categoryName) throws Exception;
	
	public int updateItemName(String itemOriName, String itemName, String categoryName) throws Exception;
	
	public int isCategory(String categoryName) throws Exception;

	public int existsCode(String code) throws Exception;
	
	public int newCode(String categoryName, String codeName) throws Exception;
	
	public String getCode(String categoryName) throws Exception;
	
	public List<CategoryCodeVO> getCategoryCodeList() throws Exception;
	
	public int deleteCode(String categoryName) throws Exception;
}
