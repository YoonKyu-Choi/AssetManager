package com.eseict.VO;

import java.sql.Date;

public class AssetHistoryVO {
	
	private String assetId;
	private int employeeSeq;
	private String employeeId;
	private String assetUserHistory;
	private Date assetOccupiedDate;
	private String assetHistoryComment;
	
	public AssetHistoryVO(){}

	public AssetHistoryVO(String assetId, int employeeSeq, String employeeId, String assetUserHistory,
			Date assetOccupiedDate, String assetHistoryComment) {
		super();
		this.assetId = assetId;
		this.employeeSeq = employeeSeq;
		this.employeeId = employeeId;
		this.assetUserHistory = assetUserHistory;
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

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getAssetUserHistory() {
		return assetUserHistory;
	}

	public void setAssetUserHistory(String assetUserHistory) {
		this.assetUserHistory = assetUserHistory;
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
	
	
}
