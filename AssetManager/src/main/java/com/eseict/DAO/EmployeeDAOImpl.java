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
	
	private static final String namespace = "com.eseict.mapper.EmployeeMapper.";
	
	@Override
	public int newEmployee(EmployeeVO vo) throws Exception {
		return sqlSession.insert(namespace+"newEmployee", vo);
	}

	@Override
	public String checkIdDuplication(String employeeId) throws Exception {
		return sqlSession.selectOne(namespace+"checkIdDuplication", employeeId);
	}

	@Override
	public int checkRegistered(String employeeId, String employeePw) throws Exception {
		HashMap<String, String> login = new HashMap<String, String>();
		login.put("id", employeeId);
		login.put("pw", employeePw);
		return sqlSession.selectOne(namespace+"checkRegistered", login);
	}

	@Override
	public List<EmployeeVO> getEmployeeList() throws Exception {
		return sqlSession.selectList(namespace+"getEmployeeList");
	}

	@Override
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) throws Exception {
		return sqlSession.selectOne(namespace+"selectEmployeeByEmployeeSeq",employeeSeq);
	}
	
	@Override
	public int updateEmployee(EmployeeVO evo) throws Exception {
		return sqlSession.update(namespace+"updateEmployee",evo);
	}

	@Override
	public int deleteEmployee(int employeeSeq) throws Exception {
		return sqlSession.delete(namespace+"deleteEmployee", employeeSeq);
		
	}

	@Override
	public String getUserStatusById(String inputId) throws Exception {
		return sqlSession.selectOne(namespace+"selectEmployeeStatusById",inputId);
	}

	@Override
	public int getUserCount() throws Exception {
		return sqlSession.selectOne(namespace+"getUserCount");
	}

	@Override
	public List<EmployeeVO> getEmployeeListByName(String employeeName) throws Exception {
		return sqlSession.selectList(namespace+"getEmployeeListByName",employeeName);
	}

	@Override
	public List<String> getEmployeeNameList() throws Exception {
		return sqlSession.selectList(namespace+"getEmployeeNameList");
	}

	@Override
	public int getEmployeeSeqByEmpId(String employeeId) throws Exception {
		return sqlSession.selectOne(namespace+"getEmployeeSeqByEmpId",employeeId);
	}

	@Override
	public int getEmployeeSeqByEmpName(String beforeUser) {
		return sqlSession.selectOne(namespace+"getEmployeeSeqByEmpName",beforeUser);
	}

}
