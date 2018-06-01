package com.eseict.VO;

public class AssetDetailVO {
	
	private String assetId;
	private String assetItem;
	private String assetItemDetail;
	
	public AssetDetailVO() {}

	public AssetDetailVO(String assetId, String assetItem, String assetItemDetail) {
		super();
		this.assetId = assetId;
		this.assetItem = assetItem;
		this.assetItemDetail = assetItemDetail;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getAssetItem() {
		return assetItem;
	}

	public void setAssetItem(String assetItem) {
		this.assetItem = assetItem;
	}

	public String getAssetItemDetail() {
		return assetItemDetail;
	}

	public void setAssetItemDetail(String assetItemDetail) {
		this.assetItemDetail = assetItemDetail;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((assetId == null) ? 0 : assetId.hashCode());
		result = prime * result + ((assetItem == null) ? 0 : assetItem.hashCode());
		result = prime * result + ((assetItemDetail == null) ? 0 : assetItemDetail.hashCode());
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
		AssetDetailVO other = (AssetDetailVO) obj;
		if (assetId == null) {
			if (other.assetId != null)
				return false;
		} else if (!assetId.equals(other.assetId))
			return false;
		if (assetItem == null) {
			if (other.assetItem != null)
				return false;
		} else if (!assetItem.equals(other.assetItem))
			return false;
		if (assetItemDetail == null) {
			if (other.assetItemDetail != null)
				return false;
		} else if (!assetItemDetail.equals(other.assetItemDetail))
			return false;
		return true;
	}
	
	

}
