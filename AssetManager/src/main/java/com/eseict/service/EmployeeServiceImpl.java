package com.eseict.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

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
	public EmployeeVO selectEmployeeByEmployeeSeq(int employeeSeq) {
		return dao.selectEmployeeByEmployeeSeq(employeeSeq);
	}

	@Override
	public void updateEmployee(EmployeeVO evo) {
		dao.updateEmployee(evo);
	}
	
	public void deleteEmployee(int employeeSeq) {
		dao.deleteEmployee(employeeSeq);
		
	}

	@Override
	public List<String> getEmployeeNameList() {
		return dao.getEmployeeNameList();
	}

	@Override
	public int loginReact(String inputId, String inputPw) {
		int check = dao.checkRegistered(inputId, inputPw);
		String userStatus = dao.getUserStatusById(inputId);
		if (check == 1 && userStatus.equals("퇴사")) {
			check = 2;
		}
		return check;
	}

	@Override
	public ModelAndView userListMnV(String employeeName) {
		HashMap<String, Object> userListData = new HashMap<String, Object>();
		
		int userCount = dao.getUserCount();
		if (employeeName == null) {
			List<EmployeeVO> list = dao.getEmployeeList();
			userListData.put("employeeList", list);
		} else {
			List<EmployeeVO> list = dao.getEmployeeListByName(employeeName);
			userListData.put("employeeList", list);
		}
		userListData.put("userCount", userCount);
		return new ModelAndView("userList.tiles", "userListData", userListData);
	}

}
