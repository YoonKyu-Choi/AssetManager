package com.eseict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.DAO.EmployeeDAO;
import com.eseict.VO.EmployeeVO;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private EmployeeDAO dao;
	
	@Override
	public void newEmployee(EmployeeVO vo) {
		dao.newEmployee(vo);	
	}

	@Override
	public String checkIdDuplication(String employeeId) {
		return dao.checkIdDuplication(employeeId);
	}

	@Override
	public int checkRegistered(String employeeId, String employeePw) {
		return dao.checkRegistered(employeeId, employeePw);
	}

	@Override
	public List<EmployeeVO> getEmployeeList() {
		System.out.println("service부분"+dao.getEmployeeList());
		return dao.getEmployeeList();
	}

	/*
	@Override
	public String getDepartment(int employeeDepartment) {
		return dao.getDepartment(employeeDepartment);
	}

	@Override
	public String getRank(int employeeRank) {
		return dao.getRank(employeeRank);
	}
	*/
	
	@Override
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) {
		return dao.selectEmployeeByEmployeeSeq(employeeSeq);
	}
}
