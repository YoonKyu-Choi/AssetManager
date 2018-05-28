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
	
	private static final String namespace = "com.eseict.mapper.CategoryMapper";

	@Override
	public List<CategoryVO> getCategoryList() {
		return sqlSession.selectList(namespace+".getCategoryList");
	}

}
