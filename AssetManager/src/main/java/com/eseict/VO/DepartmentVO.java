package com.eseict.VO;

public class DepartmentVO {
	private int employeeDepartment;
	private String employeeDepartmentString;

	public DepartmentVO() {}

	public DepartmentVO(int employeeDepartment, String employeeDepartmentString) {
		super();
		this.employeeDepartment = employeeDepartment;
		this.employeeDepartmentString = employeeDepartmentString;
	}

	public int getEmployeeDepartment() {
		return employeeDepartment;
	}

	public void setEmployeeDepartment(int employeeDepartment) {
		this.employeeDepartment = employeeDepartment;
	}

	public String getEmployeeDepartmentString() {
		return employeeDepartmentString;
	}

	public void setEmployeeDepartmentString(String employeeDepartmentString) {
		this.employeeDepartmentString = employeeDepartmentString;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + employeeDepartment;
		result = prime * result + ((employeeDepartmentString == null) ? 0 : employeeDepartmentString.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DepartmentVO other = (DepartmentVO) obj;
		if (employeeDepartment != other.employeeDepartment)
			return false;
		if (employeeDepartmentString == null) {
			if (other.employeeDepartmentString != null)
				return false;
		} else if (!employeeDepartmentString.equals(other.employeeDepartmentString))
			return false;
		return true;
	}
	
	
}
