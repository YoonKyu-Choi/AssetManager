package com.eseict.DAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.CategoryVO;

@Repository
public class CategoryDAOImpl implements CategoryDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.eseict.mapper.CategoryMapper.";

	@Override
	public List<CategoryVO> getCategoryList() {
		return sqlSession.selectList(namespace+"getCategoryList");
	}

	@Override
	public int getCategoryCount() {
		return sqlSession.selectOne(namespace+"getCategoryCount");
	}

	@Override
	public List<String> getCategoryByName(String categoryName) {
		return sqlSession.selectList(namespace+"getCategoryByName", categoryName);
	}

	@Override
	public void newCategory(CategoryVO vo) {
		sqlSession.insert(namespace+"newCategory", vo);
	}

	@Override
	public void deleteCategory(String categoryName) {
		sqlSession.delete(namespace+"deleteCategory", categoryName);
	}

	@Override
	public void deleteItem(String categoryName, String itemName) {
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("categoryName", categoryName);
		hsm.put("itemName", itemName);
		sqlSession.delete(namespace+"deleteItem", hsm);
	}

	@Override
	public int checkCategoryItem(CategoryVO vo) {
		return sqlSession.selectOne(namespace+"checkCategoryItem", vo);
	}

	@Override
	public void updateCategoryName(String categoryOriName, String categoryName) {
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("categoryOriName", categoryOriName);
		hsm.put("categoryName", categoryName);
		sqlSession.update(namespace+"updateCategoryName", hsm);
	}

	@Override
	public void updateItemName(String itemOriName, String itemName, String categoryName) {
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("itemOriName", itemOriName);
		hsm.put("itemName", itemName);
		hsm.put("categoryName", categoryName);
		sqlSession.update(namespace+"updateItemName", hsm);
	}

}
