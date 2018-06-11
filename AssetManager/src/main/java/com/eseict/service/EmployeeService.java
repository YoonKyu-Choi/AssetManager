package com.eseict.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.EmployeeVO;

public interface EmployeeService {

	// 사용자 등록하기
	public void newEmployee(EmployeeVO vo);
	
	// 아이디 중복 확인
	public String checkIdDuplication(String employeeId);
	
	// 등록 확인
	public int checkRegistered(String employeeId, String employeePw);
	
	// 사용자 상세보기
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq);
	
	// 사용자 수정
	public void updateEmployee(EmployeeVO evo);
	
	// 사용자 삭제
	public void deleteEmployee(int employeeSeq);

	// 사용자 이름 조회
	public List<String> getEmployeeNameList();
	
	public int loginReact(String inputId, String inputPw);
	
	public ModelAndView userListMnV(String employeeName);

	// 사용자 아이디로 사용자 번호 검색
	public int getEmployeeSeqByEmpId(String employeeId);
	
}
