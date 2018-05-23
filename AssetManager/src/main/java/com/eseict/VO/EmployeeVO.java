package com.eseict.VO;

public class EmployeeVO {
	private int employeeSeq;
	private String employeeName;
	private String employeeId;
	private String employeePw;
	private String employeeRank;
	private String employeeDepartment;
	private String employeeLocation;
	private String employeeEmail;
	private String employeePhone;
	private String employeeStatus;
	
	public EmployeeVO() {}
	
	public EmployeeVO(int employeeSeq, String employeeName, String employeeId, String employeePw, String employeeRank,
			String employeeDepartment, String employeeLocation, String employeeEmail, String employeePhone,
			String employeeStatus) {
		super();
		this.employeeSeq = employeeSeq;
		this.employeeName = employeeName;
		this.employeeId = employeeId;
		this.employeePw = employeePw;
		this.employeeRank = employeeRank;
		this.employeeDepartment = employeeDepartment;
		this.employeeLocation = employeeLocation;
		this.employeeEmail = employeeEmail;
		this.employeePhone = employeePhone;
		this.employeeStatus = employeeStatus;
	}
	public int getEmployeeSeq() {
		return employeeSeq;
	}
	public void setEmployeeSeq(int employeeSeq) {
		this.employeeSeq = employeeSeq;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeePw() {
		return employeePw;
	}
	public void setEmployeePw(String employeePw) {
		this.employeePw = employeePw;
	}
	public String getEmployeeRank() {
		return employeeRank;
	}
	public void setEmployeeRank(String employeeRank) {
		this.employeeRank = employeeRank;
	}
	public String getEmployeeDepartment() {
		return employeeDepartment;
	}
	public void setEmployeeDepartment(String employeeDepartment) {
		this.employeeDepartment = employeeDepartment;
	}
	public String getEmployeeLocation() {
		return employeeLocation;
	}
	public void setEmployeeLocation(String employeeLocation) {
		this.employeeLocation = employeeLocation;
	}
	public String getEmployeeEmail() {
		return employeeEmail;
	}
	public void setEmployeeEmail(String employeeEmail) {
		this.employeeEmail = employeeEmail;
	}
	public String getEmployeePhone() {
		return employeePhone;
	}
	public void setEmployeePhone(String employeePhone) {
		this.employeePhone = employeePhone;
	}
	public String getEmployeeStatus() {
		return employeeStatus;
	}
	public void setEmployeeStatus(String employeeStatus) {
		this.employeeStatus = employeeStatus;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((employeeDepartment == null) ? 0 : employeeDepartment.hashCode());
		result = prime * result + ((employeeEmail == null) ? 0 : employeeEmail.hashCode());
		result = prime * result + ((employeeId == null) ? 0 : employeeId.hashCode());
		result = prime * result + ((employeeLocation == null) ? 0 : employeeLocation.hashCode());
		result = prime * result + ((employeeName == null) ? 0 : employeeName.hashCode());
		result = prime * result + ((employeePhone == null) ? 0 : employeePhone.hashCode());
		result = prime * result + ((employeePw == null) ? 0 : employeePw.hashCode());
		result = prime * result + ((employeeRank == null) ? 0 : employeeRank.hashCode());
		result = prime * result + employeeSeq;
		result = prime * result + ((employeeStatus == null) ? 0 : employeeStatus.hashCode());
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
		EmployeeVO other = (EmployeeVO) obj;
		if (employeeDepartment == null) {
			if (other.employeeDepartment != null)
				return false;
		} else if (!employeeDepartment.equals(other.employeeDepartment))
			return false;
		if (employeeEmail == null) {
			if (other.employeeEmail != null)
				return false;
		} else if (!employeeEmail.equals(other.employeeEmail))
			return false;
		if (employeeId == null) {
			if (other.employeeId != null)
				return false;
		} else if (!employeeId.equals(other.employeeId))
			return false;
		if (employeeLocation == null) {
			if (other.employeeLocation != null)
				return false;
		} else if (!employeeLocation.equals(other.employeeLocation))
			return false;
		if (employeeName == null) {
			if (other.employeeName != null)
				return false;
		} else if (!employeeName.equals(other.employeeName))
			return false;
		if (employeePhone == null) {
			if (other.employeePhone != null)
				return false;
		} else if (!employeePhone.equals(other.employeePhone))
			return false;
		if (employeePw == null) {
			if (other.employeePw != null)
				return false;
		} else if (!employeePw.equals(other.employeePw))
			return false;
		if (employeeRank == null) {
			if (other.employeeRank != null)
				return false;
		} else if (!employeeRank.equals(other.employeeRank))
			return false;
		if (employeeSeq != other.employeeSeq)
			return false;
		if (employeeStatus == null) {
			if (other.employeeStatus != null)
				return false;
		} else if (!employeeStatus.equals(other.employeeStatus))
			return false;
		return true;
	}
	
}
