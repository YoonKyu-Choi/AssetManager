package com.eseict.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.domain.EmployeeVO;
import com.eseict.persistence.EmployeeDAO;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private EmployeeDAO dao;
	
	@Override
	public void newEmployee(EmployeeVO vo) {
		dao.newEmployee(vo);	
	}

	@Override
	public int checkIdDuplication(String employeeId) {
		return dao.checkIdDuplication(employeeId);
	}

	@Override
	public int checkRegistered(String employeeId, String employeePw) {
		return dao.checkRegistered(employeeId, employeePw);
	}

}
