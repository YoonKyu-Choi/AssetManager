package com.eseict.DAO;

import java.util.List;

import com.eseict.VO.EmployeeVO;

public interface EmployeeDAO {
	
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
	public int updateEmployee(EmployeeVO evo);
	
	// 사용자 삭제
	public void deleteEmployee(int employeeSeq);

	// 사용자 상태 확인
	public String getUserStatusById(String inputId);
	
	// 사용자 수 출력
	public int getUserCount();
	
	// 사용자 이름으로 검색
	public List<EmployeeVO> getEmployeeListByName(String employeeName);
	
	// 사용자 이름 조회
	public List<String> getEmployeeNameList();
	
	// 사용자 아이디로 사용자 번호 검색
	public int getEmployeeSeqByEmpId(String employeeId);
	
	// 사용자 이름으로 Seq 찾기 
	public int getEmployeeSeqByEmpName(String beforeUser);
}
