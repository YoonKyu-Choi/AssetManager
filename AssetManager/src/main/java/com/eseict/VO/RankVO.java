package com.eseict.VO;

public class RankVO {
	private int employeeRank;
	private String employeeRankString;

	public RankVO() {
	}

	public RankVO(int employeeRank, String employeeRankString) {
		super();
		this.employeeRank = employeeRank;
		this.employeeRankString = employeeRankString;
	}

	public int getEmployeeRank() {
		return employeeRank;
	}

	public void setEmployeeRank(int employeeRank) {
		this.employeeRank = employeeRank;
	}

	public String getEmployeeRankString() {
		return employeeRankString;
	}

	public void setEmployeeRankString(String employeeRankString) {
		this.employeeRankString = employeeRankString;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + employeeRank;
		result = prime * result + ((employeeRankString == null) ? 0 : employeeRankString.hashCode());
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
		RankVO other = (RankVO) obj;
		if (employeeRank != other.employeeRank)
			return false;
		if (employeeRankString == null) {
			if (other.employeeRankString != null)
				return false;
		} else if (!employeeRankString.equals(other.employeeRankString))
			return false;
		return true;
	}
	
	

}
