package com.eseict.VO;

import java.sql.Date;

public class AssetVO {
	
	private String assetId;
	private String assetCategory;
	private int employeeSeq;
	private String assetUser;
	private String assetStatus;
	private String assetOutStatus;
	private String assetSerial;
	private Date assetPurchaseDate;
	private String assetPurchasePrice;
	private String assetPurchaseShop;
	private String assetMaker;
	private String assetModel;
	private String assetUsage;
	private String assetManager;
	private String assetLocation;
	private String assetReceiptUrl;
	private String assetComment;
	
	public AssetVO() {}

	public AssetVO(String assetId, String assetCategory, int employeeSeq, String assetUser, String assetStatus,
			String assetOutStatus, String assetSerial, Date assetPurchaseDate, String assetPurchasePrice,
			String assetPurchaseShop, String assetMaker, String assetModel, String assetUsage, String assetManager,
			String assetLocation, String assetReceiptUrl, String assetComment) {
		super();
		this.assetId = assetId;
		this.assetCategory = assetCategory;
		this.employeeSeq = employeeSeq;
		this.assetUser = assetUser;
		this.assetStatus = assetStatus;
		this.assetOutStatus = assetOutStatus;
		this.assetSerial = assetSerial;
		this.assetPurchaseDate = assetPurchaseDate;
		this.assetPurchasePrice = assetPurchasePrice;
		this.assetPurchaseShop = assetPurchaseShop;
		this.assetMaker = assetMaker;
		this.assetModel = assetModel;
		this.assetUsage = assetUsage;
		this.assetManager = assetManager;
		this.assetLocation = assetLocation;
		this.assetReceiptUrl = assetReceiptUrl;
		this.assetComment = assetComment;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getAssetCategory() {
		return assetCategory;
	}

	public void setAssetCategory(String assetCategory) {
		this.assetCategory = assetCategory;
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

	public String getAssetStatus() {
		return assetStatus;
	}

	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}

	public String getAssetOutStatus() {
		return assetOutStatus;
	}

	public void setAssetOutStatus(String assetOutStatus) {
		this.assetOutStatus = assetOutStatus;
	}

	public String getAssetSerial() {
		return assetSerial;
	}

	public void setAssetSerial(String assetSerial) {
		this.assetSerial = assetSerial;
	}

	public Date getAssetPurchaseDate() {
		return assetPurchaseDate;
	}

	public void setAssetPurchaseDate(Date assetPurchaseDate) {
		this.assetPurchaseDate = assetPurchaseDate;
	}
	
	public String getAssetPurchasePrice() {
		return assetPurchasePrice;
	}

	public void setAssetPurchasePrice(String assetPurchasePrice) {
		this.assetPurchasePrice = assetPurchasePrice;
	}

	public String getAssetPurchaseShop() {
		return assetPurchaseShop;
	}

	public void setAssetPurchaseShop(String assetPurchaseShop) {
		this.assetPurchaseShop = assetPurchaseShop;
	}

	public String getAssetMaker() {
		return assetMaker;
	}

	public void setAssetMaker(String assetMaker) {
		this.assetMaker = assetMaker;
	}

	public String getAssetModel() {
		return assetModel;
	}

	public void setAssetModel(String assetModel) {
		this.assetModel = assetModel;
	}

	public String getAssetUsage() {
		return assetUsage;
	}

	public void setAssetUsage(String assetUsage) {
		this.assetUsage = assetUsage;
	}

	public String getAssetManager() {
		return assetManager;
	}

	public void setAssetManager(String assetManager) {
		this.assetManager = assetManager;
	}

	public String getAssetLocation() {
		return assetLocation;
	}

	public void setAssetLocation(String assetLocation) {
		this.assetLocation = assetLocation;
	}

	public String getAssetReceiptUrl() {
		return assetReceiptUrl;
	}

	public void setAssetReceiptUrl(String assetReceiptUrl) {
		this.assetReceiptUrl = assetReceiptUrl;
	}

	public String getAssetComment() {
		return assetComment;
	}

	public void setAssetComment(String assetComment) {
		this.assetComment = assetComment;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((assetCategory == null) ? 0 : assetCategory.hashCode());
		result = prime * result + ((assetComment == null) ? 0 : assetComment.hashCode());
		result = prime * result + ((assetId == null) ? 0 : assetId.hashCode());
		result = prime * result + ((assetLocation == null) ? 0 : assetLocation.hashCode());
		result = prime * result + ((assetMaker == null) ? 0 : assetMaker.hashCode());
		result = prime * result + ((assetManager == null) ? 0 : assetManager.hashCode());
		result = prime * result + ((assetModel == null) ? 0 : assetModel.hashCode());
		result = prime * result + ((assetOutStatus == null) ? 0 : assetOutStatus.hashCode());
		result = prime * result + ((assetPurchaseDate == null) ? 0 : assetPurchaseDate.hashCode());
		result = prime * result + ((assetPurchasePrice == null) ? 0 : assetPurchasePrice.hashCode());
		result = prime * result + ((assetPurchaseShop == null) ? 0 : assetPurchaseShop.hashCode());
		result = prime * result + ((assetReceiptUrl == null) ? 0 : assetReceiptUrl.hashCode());
		result = prime * result + ((assetSerial == null) ? 0 : assetSerial.hashCode());
		result = prime * result + ((assetStatus == null) ? 0 : assetStatus.hashCode());
		result = prime * result + ((assetUsage == null) ? 0 : assetUsage.hashCode());
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
		AssetVO other = (AssetVO) obj;
		if (assetCategory == null) {
			if (other.assetCategory != null)
				return false;
		} else if (!assetCategory.equals(other.assetCategory))
			return false;
		if (assetComment == null) {
			if (other.assetComment != null)
				return false;
		} else if (!assetComment.equals(other.assetComment))
			return false;
		if (assetId == null) {
			if (other.assetId != null)
				return false;
		} else if (!assetId.equals(other.assetId))
			return false;
		if (assetLocation == null) {
			if (other.assetLocation != null)
				return false;
		} else if (!assetLocation.equals(other.assetLocation))
			return false;
		if (assetMaker == null) {
			if (other.assetMaker != null)
				return false;
		} else if (!assetMaker.equals(other.assetMaker))
			return false;
		if (assetManager == null) {
			if (other.assetManager != null)
				return false;
		} else if (!assetManager.equals(other.assetManager))
			return false;
		if (assetModel == null) {
			if (other.assetModel != null)
				return false;
		} else if (!assetModel.equals(other.assetModel))
			return false;
		if (assetOutStatus == null) {
			if (other.assetOutStatus != null)
				return false;
		} else if (!assetOutStatus.equals(other.assetOutStatus))
			return false;
		if (assetPurchaseDate == null) {
			if (other.assetPurchaseDate != null)
				return false;
		} else if (!assetPurchaseDate.equals(other.assetPurchaseDate))
			return false;
		if (assetPurchasePrice == null) {
			if (other.assetPurchasePrice != null)
				return false;
		} else if (!assetPurchasePrice.equals(other.assetPurchasePrice))
			return false;
		if (assetPurchaseShop == null) {
			if (other.assetPurchaseShop != null)
				return false;
		} else if (!assetPurchaseShop.equals(other.assetPurchaseShop))
			return false;
		if (assetReceiptUrl == null) {
			if (other.assetReceiptUrl != null)
				return false;
		} else if (!assetReceiptUrl.equals(other.assetReceiptUrl))
			return false;
		if (assetSerial == null) {
			if (other.assetSerial != null)
				return false;
		} else if (!assetSerial.equals(other.assetSerial))
			return false;
		if (assetStatus == null) {
			if (other.assetStatus != null)
				return false;
		} else if (!assetStatus.equals(other.assetStatus))
			return false;
		if (assetUsage == null) {
			if (other.assetUsage != null)
				return false;
		} else if (!assetUsage.equals(other.assetUsage))
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
