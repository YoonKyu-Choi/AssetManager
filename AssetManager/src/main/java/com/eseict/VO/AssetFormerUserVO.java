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
	
	
}
