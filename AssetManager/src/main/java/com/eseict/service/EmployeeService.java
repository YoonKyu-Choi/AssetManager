package com.eseict.service;

import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.EmployeeVO;

public interface EmployeeService {

	// 사용자 등록하기
	public int newEmployee(EmployeeVO vo) throws Exception;
	
	// 아이디 중복 확인
	public String checkIdDuplication(String employeeId) throws Exception;
	
	// 등록 확인
	public int checkRegistered(String employeeId, String employeePw) throws Exception;
	
	// 사용자 상세보기
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) throws Exception;
	
	// 사용자 수정
	public int updateEmployee(EmployeeVO evo) throws Exception;
	
	// 사용자 삭제
	public int deleteEmployee(int employeeSeq) throws Exception;

	// 사용자 이름 조회
	public List<String> getEmployeeNameList() throws Exception;
	
	public int loginReact(String inputId, String inputPw) throws Exception;
	
	public ModelAndView userListMnV(String employeeName) throws Exception;

	// 사용자 아이디로 사용자 번호 검색
	public int getEmployeeSeqByEmpId(String employeeId) throws Exception;
	
}
