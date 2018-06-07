package com.eseict.service;

import java.io.IOException;

public interface PrintService {

	/**
	 * @param assetIdList
	 * @return filename
	 */
	public String printFileName(String[] assetIdList, int mode);
	
	/**
	 * @param assetIdList
	 * @return byte array of excel file of list
	 * @throws IOException 
	 */
	public byte[] printList(String[] assetIdList) throws IOException;

	/**
	 * @param assetId
	 * @return byte array of excel file of reports
	 */
	public byte[] printReport(String[] assetIdList) throws IOException;
}
