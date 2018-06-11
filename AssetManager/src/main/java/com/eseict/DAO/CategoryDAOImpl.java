package com.eseict.DAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.CategoryCodeVO;
import com.eseict.VO.CategoryVO;

@Repository
public class CategoryDAOImpl implements CategoryDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.eseict.mapper.CategoryMapper.";

	@Override
	public List<CategoryVO> getCategoryList() throws Exception{
		return sqlSession.selectList(namespace+"getCategoryList");
	}

	@Override
	public int getCategoryCount() throws Exception{
		return sqlSession.selectOne(namespace+"getCategoryCount");
	}

	@Override
	public List<String> getCategoryByName(String categoryName) throws Exception{
		return sqlSession.selectList(namespace+"getCategoryByName", categoryName);
	}

	@Override
	public int newCategory(CategoryVO vo) throws Exception{
		return sqlSession.insert(namespace+"newCategory", vo);
	}

	@Override
	public int deleteCategory(String categoryName) throws Exception{
		return sqlSession.delete(namespace+"deleteCategory", categoryName);
	}

	@Override
	public int deleteItem(String categoryName, String itemName) throws Exception{
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("categoryName", categoryName);
		hsm.put("itemName", itemName);
		return sqlSession.delete(namespace+"deleteItem", hsm);
	}

	@Override
	public int checkCategoryItem(CategoryVO vo) throws Exception{
		return sqlSession.selectOne(namespace+"checkCategoryItem", vo);
	}

	@Override
	public int updateCategoryName(String categoryOriName, String categoryName) throws Exception{
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("categoryOriName", categoryOriName);
		hsm.put("categoryName", categoryName);
		return sqlSession.update(namespace+"updateCategoryName", hsm);
	}

	@Override
	public int updateItemName(String itemOriName, String itemName, String categoryName) throws Exception{
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("itemOriName", itemOriName);
		hsm.put("itemName", itemName);
		hsm.put("categoryName", categoryName);
		return sqlSession.update(namespace+"updateItemName", hsm);
	}

	@Override
	public int isCategory(String categoryName) throws Exception{
		return sqlSession.selectOne(namespace+"isCategory", categoryName);
	}

	@Override
	public int existsCode(String code) throws Exception{
		return sqlSession.selectOne(namespace+"existsCode", code);
	}

	@Override
	public int newCode(String categoryName, String codeName) throws Exception{
		HashMap<String, String> hsm = new HashMap<String, String>();
		hsm.put("categoryName", categoryName);
		hsm.put("codeName", codeName);
		return sqlSession.insert(namespace+"newCode", hsm);
	}

	@Override
	public String getCode(String categoryName) throws Exception{
		return sqlSession.selectOne(namespace+"getCode", categoryName);
	}

	@Override
	public List<CategoryCodeVO> getCategoryCodeList() throws Exception{
		return sqlSession.selectList(namespace+"getCategoryCodeList");
	}

	@Override
	public int deleteCode(String categoryName) throws Exception{
		return sqlSession.delete(namespace+"deleteCode", categoryName);
	}	
}
