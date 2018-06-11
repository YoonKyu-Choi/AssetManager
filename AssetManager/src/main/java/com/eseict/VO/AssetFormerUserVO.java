package com.eseict.VO;

import java.sql.Date;

public class AssetFormerUserVO {
	
	private String assetId;
	private int employeeSeq;
	private String assetUser;
	private Date assetStartDate;
	private Date assetEndDate;
	
	public AssetFormerUserVO() {}

	public AssetFormerUserVO(String assetId, int employeeSeq, String assetUser, Date assetStartDate,
			Date assetEndDate) {
		super();
		this.assetId = assetId;
		this.employeeSeq = employeeSeq;
		this.assetUser = assetUser;
		this.assetStartDate = assetStartDate;
		this.assetEndDate = assetEndDate;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public int getEmployeeSeq() {
		return employeeSeq;
	}

	public void setEmployeeSeq(int employeeSeq) {
		this.employeeSeq = employeeSeq;
	}

	public String getAssetUser() {
		return assetUser;
	}

	public void setAssetUser(String assetUser) {
		this.assetUser = assetUser;
	}

	public Date getAssetStartDate() {
		return assetStartDate;
	}

	public void setAssetStartDate(Date assetStartDate) {
		this.assetStartDate = assetStartDate;
	}

	public Date getAssetEndDate() {
		return assetEndDate;
	}

	public void setAssetEndDate(Date assetEndDate) {
		this.assetEndDate = assetEndDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((assetEndDate == null) ? 0 : assetEndDate.hashCode());
		result = prime * result + ((assetId == null) ? 0 : assetId.hashCode());
		result = prime * result + ((assetStartDate == null) ? 0 : assetStartDate.hashCode());
		result = prime * result + ((assetUser == null) ? 0 : assetUser.hashCode());
		result = prime * result + employeeSeq;
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
		AssetFormerUserVO other = (AssetFormerUserVO) obj;
		if (assetEndDate == null) {
			if (other.assetEndDate != null)
				return false;
		} else if (!assetEndDate.equals(other.assetEndDate))
			return false;
		if (assetId == null) {
			if (other.assetId != null)
				return false;
		} else if (!assetId.equals(other.assetId))
			return false;
		if (assetStartDate == null) {
			if (other.assetStartDate != null)
				return false;
		} else if (!assetStartDate.equals(other.assetStartDate))
			return false;
		if (assetUser == null) {
			if (other.assetUser != null)
				return false;
		} else if (!assetUser.equals(other.assetUser))
			return false;
		if (employeeSeq != other.employeeSeq)
			return false;
		return true;
	}
	
	
	
}
