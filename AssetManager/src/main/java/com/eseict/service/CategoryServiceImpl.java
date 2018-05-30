package com.eseict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.DAO.CategoryDAO;
import com.eseict.VO.CategoryVO;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO dao;
	
	@Override
	public List<CategoryVO> getCategoryList() {
		return dao.getCategoryList();
	}

	@Override
	public int getCategoryCount() {
		return dao.getCategoryCount();
	}

	@Override
	public List<String> getCategoryByName(String categoryName) {
		return dao.getCategoryByName(categoryName);
	}

	@Override
	public void newCategory(CategoryVO vo) {
		dao.newCategory(vo);		
	}

	@Override
	public void deleteCategory(String categoryName) {
		dao.deleteCategory(categoryName);
	}

	@Override
	public void deleteItem(String categoryName, String itemName) {
		dao.deleteItem(categoryName, itemName);
	}

	@Override
	public int checkCategoryItem(CategoryVO vo) {
		return dao.checkCategoryItem(vo);
	}

	@Override
	public void updateCategoryName(String categoryOriName, String categoryName) {
		dao.updateCategoryName(categoryOriName, categoryName);
	}

	@Override
	public void updateItemName(String itemOriName, String itemName, String categoryName) {
		dao.updateItemName(itemOriName, itemName, categoryName);
	}

}
