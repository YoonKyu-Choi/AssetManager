package com.eseict.DAO;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eseict.VO.EmployeeVO;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.eseict.mapper.EmployeeMapper";
	
	@Override
	public void newEmployee(EmployeeVO vo) {
		sqlSession.insert(namespace+".newEmployee", vo);
	}

	@Override
	public String checkIdDuplication(String employeeId) {
		return sqlSession.selectOne(namespace+".checkIdDuplication", employeeId);
	}

	@Override
	public int checkRegistered(String employeeId, String employeePw) {
		HashMap<String, String> login = new HashMap<String, String>();
		login.put("id", employeeId);
		login.put("pw", employeePw);
		return sqlSession.selectOne(namespace+".checkRegistered", login);
	}

	@Override
	public List<EmployeeVO> getEmployeeList() {
		return sqlSession.selectList(namespace+".getEmployeeList");
	}

	@Override
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) {
		return sqlSession.selectOne(namespace+".selectEmployeeByEmployeeSeq",employeeSeq);
	}
	
	@Override
	public int updateEmployee(EmployeeVO evo) {
		return sqlSession.update(namespace+".updateEmployee",evo);
	}

}
