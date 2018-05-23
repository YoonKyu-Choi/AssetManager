package com.eseict.service;

import java.util.List;

import com.eseict.VO.EmployeeVO;

public interface EmployeeService {
	// �깉 �엫吏곸썝�쓣 異붽�
	public void newEmployee(EmployeeVO vo);
	
	// �븘�씠�뵒 以묐났�솗�씤, 1�씠硫� 以묐났
	public String checkIdDuplication(String employeeId);
	
	// �벑濡앸맂 �궗�슜�옄�씤吏� �솗�씤, 1�씠硫� ok
	public int checkRegistered(String employeeId, String employeePw);
	
	// �엫吏곸썝 由ъ뒪�듃 媛��졇�삤湲�
	public List<EmployeeVO> getEmployeeList();

	/*
	// �냼�냽 肄붾뱶�뿉 ���븳 臾몄옄�뿴 媛��졇�삤湲�
	public String getDepartment(int employeeDepartment);

	// 吏곴툒 肄붾뱶�뿉 ���븳 臾몄옄�뿴 媛��졇�삤湲�
	public String getRank(int employeeRank);
	*/
	
	// 사용자 상세보기
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq);
}
