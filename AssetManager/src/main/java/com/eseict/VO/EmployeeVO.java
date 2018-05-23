package com.eseict.VO;

public class EmployeeVO {
	private int employeeSeq;
	private String employeeName;
	private String employeeId;
	private String employeePw;
	private int employeeRank;
	private int employeeDepartment;
	private String employeeLocation;
	private String employeeEmail;
	private String employeePhone;
	private String employeeStatus;
	private String employeeRankString;
	private String employeeDepartmentString;
	
	public EmployeeVO() {}

	public EmployeeVO(int employeeSeq, String employeeName, String employeeId, String employeePw, int employeeRank,
			int employeeDepartment, String employeeLocation, String employeeEmail, String employeePhone,
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

	public EmployeeVO(int employeeSeq, String employeeName, String employeeId, String employeePw,
			String employeeLocation, String employeeEmail, String employeePhone, String employeeStatus,
			String employeeRankString, String employeeDepartmentString) {
		super();
		this.employeeSeq = employeeSeq;
		this.employeeName = employeeName;
		this.employeeId = employeeId;
		this.employeePw = employeePw;
		this.employeeLocation = employeeLocation;
		this.employeeEmail = employeeEmail;
		this.employeePhone = employeePhone;
		this.employeeStatus = employeeStatus;
		this.employeeRankString = employeeRankString;
		this.employeeDepartmentString = employeeDepartmentString;
	}

	public EmployeeVO(int employeeSeq, String employeeName, String employeeId, String employeePw, int employeeRank,
			int employeeDepartment, String employeeLocation, String employeeEmail, String employeePhone,
			String employeeStatus, String employeeRankString, String employeeDepartmentString) {
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
		this.employeeRankString = employeeRankString;
		this.employeeDepartmentString = employeeDepartmentString;
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

	public int getEmployeeRank() {
		return employeeRank;
	}

	public void setEmployeeRank(int employeeRank) {
		this.employeeRank = employeeRank;
	}

	public int getEmployeeDepartment() {
		return employeeDepartment;
	}

	public void setEmployeeDepartment(int employeeDepartment) {
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

	public String getEmployeeRankString() {
		return employeeRankString;
	}

	public void setEmployeeRankString(String employeeRankString) {
		this.employeeRankString = employeeRankString;
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
		result = prime * result + ((employeeEmail == null) ? 0 : employeeEmail.hashCode());
		result = prime * result + ((employeeId == null) ? 0 : employeeId.hashCode());
		result = prime * result + ((employeeLocation == null) ? 0 : employeeLocation.hashCode());
		result = prime * result + ((employeeName == null) ? 0 : employeeName.hashCode());
		result = prime * result + ((employeePhone == null) ? 0 : employeePhone.hashCode());
		result = prime * result + ((employeePw == null) ? 0 : employeePw.hashCode());
		result = prime * result + employeeRank;
		result = prime * result + ((employeeRankString == null) ? 0 : employeeRankString.hashCode());
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
		if (employeeDepartment != other.employeeDepartment)
			return false;
		if (employeeDepartmentString == null) {
			if (other.employeeDepartmentString != null)
				return false;
		} else if (!employeeDepartmentString.equals(other.employeeDepartmentString))
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
		if (employeeRank != other.employeeRank)
			return false;
		if (employeeRankString == null) {
			if (other.employeeRankString != null)
				return false;
		} else if (!employeeRankString.equals(other.employeeRankString))
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
