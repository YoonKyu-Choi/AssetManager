package com.eseict.DAO;

import com.eseict.VO.EmployeeVO;

public interface EmployeeDAO {
	// 새 사용자를 추가
	public void newEmployee(EmployeeVO vo);
	
	// 존재하는 아이디일 경우 1을 반환, 아니면 0을 반환
	public String checkIdDuplication(String employeeId);
	
	// 등록된 사용자일 경우 1을 반환, 아니면 0을 반환
	public int checkRegistered(String employeeId, String employeePw);
}
