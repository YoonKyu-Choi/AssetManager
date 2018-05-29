package com.eseict.DAO;

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

}
