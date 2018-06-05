package com.eseict.service;

import org.springframework.stereotype.Service;

public interface PrintService {

	public String printFileName(String[] assetIdList);
	
	public byte[] printList(String[] assetIdList);

}
