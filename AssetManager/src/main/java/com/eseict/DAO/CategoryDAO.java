package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.CategoryVO;

public interface CategoryDAO {
	public List<CategoryVO> getCategoryList();
	
	public int getCategoryCount();
	
	public List<String> getCategoryByName(String categoryName);
	
	public void newCategory(CategoryVO vo);
	
	public void deleteCategory(String categoryName);
	
	public void deleteItem(String categoryName, String itemName);
	
	public int checkCategoryItem(CategoryVO vo);
	
	public void updateCategoryName(String categoryOriName, String categoryName);
	
	public void updateItemName(String itemOriName, String itemName, String categoryName);
	
	public int isCategory(String categoryName);
}
