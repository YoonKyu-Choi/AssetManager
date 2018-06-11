package com.eseict.VO;

import java.sql.Date;

public class AssetHistoryVO {
	
	private String assetId;
	private int employeeSeq;
	private Date assetOccupiedDate;
	private String assetHistoryComment;
	
	public AssetHistoryVO(){}

	public AssetHistoryVO(String assetId, int employeeSeq, Date assetOccupiedDate, String assetHistoryComment) {
		super();
		this.assetId = assetId;
		this.employeeSeq = employeeSeq;
		this.assetOccupiedDate = assetOccupiedDate;
		this.assetHistoryComment = assetHistoryComment;
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

	public Date getAssetOccupiedDate() {
		return assetOccupiedDate;
	}

	public void setAssetOccupiedDate(Date assetOccupiedDate) {
		this.assetOccupiedDate = assetOccupiedDate;
	}

	public String getAssetHistoryComment() {
		return assetHistoryComment;
	}

	public void setAssetHistoryComment(String assetHistoryComment) {
		this.assetHistoryComment = assetHistoryComment;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((assetHistoryComment == null) ? 0 : assetHistoryComment.hashCode());
		result = prime * result + ((assetId == null) ? 0 : assetId.hashCode());
		result = prime * result + ((assetOccupiedDate == null) ? 0 : assetOccupiedDate.hashCode());
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
		AssetHistoryVO other = (AssetHistoryVO) obj;
		if (assetHistoryComment == null) {
			if (other.assetHistoryComment != null)
				return false;
		} else if (!assetHistoryComment.equals(other.assetHistoryComment))
			return false;
		if (assetId == null) {
			if (other.assetId != null)
				return false;
		} else if (!assetId.equals(other.assetId))
			return false;
		if (assetOccupiedDate == null) {
			if (other.assetOccupiedDate != null)
				return false;
		} else if (!assetOccupiedDate.equals(other.assetOccupiedDate))
			return false;
		if (employeeSeq != other.employeeSeq)
			return false;
		return true;
	}

	
	
	
}
