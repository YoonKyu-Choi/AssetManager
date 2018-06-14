package com.eseict.VO;

import java.sql.Date;

public class AssetTakeOutHistoryVO {
	
	private String assetId;
	private int takeOutHistorySeq;
	private String assetOutStatus;
	private String assetOutObjective;
	private String assetOutPurpose;
	private Date assetOutStartDate;
	private Date assetOutEndDate;
	private String assetOutCost;
	
	public AssetTakeOutHistoryVO() {}

	public AssetTakeOutHistoryVO(String assetId, int takeOutHistorySeq, String assetOutStatus, String assetOutObjective,
			String assetOutPurpose, Date assetOutStartDate, Date assetOutEndDate, String assetOutCost) {
		super();
		this.assetId = assetId;
		this.takeOutHistorySeq = takeOutHistorySeq;
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

	public int getTakeOutHistorySeq() {
		return takeOutHistorySeq;
	}

	public void setTakeOutHistorySeq(int takeOutHistorySeq) {
		this.takeOutHistorySeq = takeOutHistorySeq;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((assetId == null) ? 0 : assetId.hashCode());
		result = prime * result + ((assetOutCost == null) ? 0 : assetOutCost.hashCode());
		result = prime * result + ((assetOutEndDate == null) ? 0 : assetOutEndDate.hashCode());
		result = prime * result + ((assetOutObjective == null) ? 0 : assetOutObjective.hashCode());
		result = prime * result + ((assetOutPurpose == null) ? 0 : assetOutPurpose.hashCode());
		result = prime * result + ((assetOutStartDate == null) ? 0 : assetOutStartDate.hashCode());
		result = prime * result + ((assetOutStatus == null) ? 0 : assetOutStatus.hashCode());
		result = prime * result + takeOutHistorySeq;
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
		AssetTakeOutHistoryVO other = (AssetTakeOutHistoryVO) obj;
		if (assetId == null) {
			if (other.assetId != null)
				return false;
		} else if (!assetId.equals(other.assetId))
			return false;
		if (assetOutCost == null) {
			if (other.assetOutCost != null)
				return false;
		} else if (!assetOutCost.equals(other.assetOutCost))
			return false;
		if (assetOutEndDate == null) {
			if (other.assetOutEndDate != null)
				return false;
		} else if (!assetOutEndDate.equals(other.assetOutEndDate))
			return false;
		if (assetOutObjective == null) {
			if (other.assetOutObjective != null)
				return false;
		} else if (!assetOutObjective.equals(other.assetOutObjective))
			return false;
		if (assetOutPurpose == null) {
			if (other.assetOutPurpose != null)
				return false;
		} else if (!assetOutPurpose.equals(other.assetOutPurpose))
			return false;
		if (assetOutStartDate == null) {
			if (other.assetOutStartDate != null)
				return false;
		} else if (!assetOutStartDate.equals(other.assetOutStartDate))
			return false;
		if (assetOutStatus == null) {
			if (other.assetOutStatus != null)
				return false;
		} else if (!assetOutStatus.equals(other.assetOutStatus))
			return false;
		if (takeOutHistorySeq != other.takeOutHistorySeq)
			return false;
		return true;
	}
	
	
	
	
}
