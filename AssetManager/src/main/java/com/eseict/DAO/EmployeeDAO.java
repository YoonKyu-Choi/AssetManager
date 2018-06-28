package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.EmployeeVO;

public interface EmployeeDAO {
	
	// 사용자 등록하기
	public int newEmployee(EmployeeVO vo) throws Exception;
	
	// 아이디 중복 확인
	public String checkIdDuplication(String employeeId) throws Exception;
	
	// 등록 확인
	public int checkRegistered(String employeeId, String employeePw) throws Exception;
	
	// 사용자 목록 조회
	public List<EmployeeVO> getEmployeeList() throws Exception;

	// 사용자 상세보기
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) throws Exception;

	// 사용자 수정
	public int updateEmployee(EmployeeVO evo) throws Exception;
	
	// 사용자 삭제
	public int deleteEmployee(int employeeSeq) throws Exception;

	// 사용자 상태 확인
	public String getUserStatusById(String inputId) throws Exception;
	
	// 사용자 수 출력
	public int getUserCount() throws Exception;
	
	// 사용자 이름으로 검색
	public List<EmployeeVO> getEmployeeListByName(String employeeName) throws Exception;
	
	// 사용자 이름 조회
	public List<String> getEmployeeNameList() throws Exception;
	
	// 사용자 아이디로 사용자 번호 검색
	public int getEmployeeSeqByEmpId(String employeeId) throws Exception;
	
	// 사용자 아이디로 사용자 이름 찾기 
	public String getEmployeeNameByEmpId(String assetUser);
	
	// 사용자 이름으로 사용자 번호 찾기 
	public String getEmployeeIdByEmpSeq(int employeeSeq);	
	
	// 사용자 이름으로 사용자 아이디 찾기
	public String getEmployeeIdByEmpName(String assetManager);
}
