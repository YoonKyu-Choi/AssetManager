package com.eseict.service;

import java.util.List;

import com.eseict.VO.EmployeeVO;

public interface EmployeeService {

	// 사용자 등록하기
	public void newEmployee(EmployeeVO vo);
	
	// 아이디 중복 확인
	public String checkIdDuplication(String employeeId);
	
	// 등록 확인
	public int checkRegistered(String employeeId, String employeePw);
	
	// 사용자 목록 조회
	public List<EmployeeVO> getEmployeeList();
	
	// 사용자 상세보기
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq);
	
	// 사용자 수정
	public void updateEmployee(EmployeeVO evo);
	
}
