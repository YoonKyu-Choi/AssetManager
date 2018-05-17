package com.eseict.service;

import com.eseict.domain.EmployeeVO;

public interface EmployeeService {
	// �� ����ڸ� �߰�
	public void newEmployee(EmployeeVO vo);
	
	// �����ϴ� ���̵��� ��� 1�� ��ȯ, �ƴϸ� 0�� ��ȯ
	public int checkIdDuplication(String employeeId);
	
	// ��ϵ� ������� ��� 1�� ��ȯ, �ƴϸ� 0�� ��ȯ
	public int checkRegistered(String employeeId, String employeePw);

}
