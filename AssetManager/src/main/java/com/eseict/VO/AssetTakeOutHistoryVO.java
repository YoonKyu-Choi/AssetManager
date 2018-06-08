package com.eseict.VO;

import java.sql.Date;

public class AssetTakeOutHistoryVO {
	
	private String assetId;
	private int employeeSeq;
	private String assetOutStatus;
	private String assetOutObjective;
	private String assetOutPurpose;
	private Date assetOutStartDate;
	private Date assetOutEndDate;
	private String assetOutCost;
	
	public AssetTakeOutHistoryVO() {}
	
	public AssetTakeOutHistoryVO(String assetId, int employeeSeq, String assetOutStatus, String assetOutObjective,
			String assetOutPurpose, Date assetOutStartDate, Date assetOutEndDate, String assetOutCost) {
		super();
		this.assetId = assetId;
		this.employeeSeq = employeeSeq;
		this.assetOutStatus = assetOutStatus;
		this.assetOutObjective = assetOutObjective;
		this.assetOutPurpose = assetOutPurpose;
		this.assetOutStartDate = assetOutStartDate;
		this.assetOutEndDate = assetOutEndDate;
		this.assetOutCost = assetOutCost;
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

	public String getAssetOutStatus() {
		return assetOutStatus;
	}

	public void setAssetOutStatus(String assetOutStatus) {
		this.assetOutStatus = assetOutStatus;
	}

	public String getAssetOutObjective() {
		return assetOutObjective;
	}

	public void setAssetOutObjective(String assetOutObjective) {
		this.assetOutObjective = assetOutObjective;
	}

	public String getAssetOutPurpose() {
		return assetOutPurpose;
	}

	public void setAssetOutPurpose(String assetOutPurpose) {
		this.assetOutPurpose = assetOutPurpose;
	}

	public Date getAssetOutStartDate() {
		return assetOutStartDate;
	}

	public void setAssetOutStartDate(Date assetOutStartDate) {
		this.assetOutStartDate = assetOutStartDate;
	}

	public Date getAssetOutEndDate() {
		return assetOutEndDate;
	}

	public void setAssetOutEndDate(Date assetOutEndDate) {
		this.assetOutEndDate = assetOutEndDate;
	}

	public String getAssetOutCost() {
		return assetOutCost;
	}

	public void setAssetOutCost(String assetOutCost) {
		this.assetOutCost = assetOutCost;
	}
	
	
	
	
	
}
