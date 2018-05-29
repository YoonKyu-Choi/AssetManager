package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.CategoryVO;

public interface CategoryDAO {
	public List<CategoryVO> getCategoryList();
	
	public int getCategoryCount();
	
	public List<String> getCategoryByName(String categoryName);
	
	public void newCategory(CategoryVO vo);
	
	public void deleteCategory(String categoryName);
}
