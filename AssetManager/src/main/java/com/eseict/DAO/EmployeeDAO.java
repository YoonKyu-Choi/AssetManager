package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.EmployeeVO;

public interface EmployeeDAO {
	// 새 임직원을 추가
	public void newEmployee(EmployeeVO vo);
	
	// 아이디 중복확인, 1이면 중복
	public String checkIdDuplication(String employeeId);
	
	// 등록된 사용자인지 확인, 1이면 ok
	public int checkRegistered(String employeeId, String employeePw);
	
	// 임직원 리스트 가져오기
	public List<EmployeeVO> getEmployeeList();
}
