package com.eseict.service;

import java.util.List;

import com.eseict.VO.CategoryVO;

public interface CategoryService {

	public List<CategoryVO> getCategoryList();
	
	public int getCategoryCount();
	
	public List<String> getCategoryByName(String categoryName);
	
	public void newCategory(CategoryVO vo);
}
