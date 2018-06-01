package com.eseict.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.DAO.AssetDAO;
import com.eseict.VO.AssetVO;

@Service
public class PrintServiceImpl implements PrintService {
	
	@Autowired
	private AssetDAO dao;

	@Override
	public void printList(String[] assetIdList) {
		File directory = new File("C:\\ESE ASSETMANAGER\\");
		if(!directory.exists()) {
			directory.mkdir();
		}
		String filename = "C:\\ESE ASSETMANAGER\\";
		if(assetIdList.length == 1) {
			filename += "자산 " + assetIdList[0] + ".xlsx";
		}
		else {
			filename += "자산 " + assetIdList[0] + " 외 " + assetIdList.length + "개" + ".xlsx";
		}
		System.out.println(filename);

		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet();
		for(int i=0; i<13; i++) {
			sheet.setColumnWidth(i, 3000);
		}
		sheet.setColumnWidth(9, 4000);
		sheet.setColumnWidth(13, 8000);

		
		Row row = sheet.createRow(0);
		row.createCell(0).setCellValue("관리번호");
		row.createCell(1).setCellValue("자산 분류");
		row.createCell(2).setCellValue("사용자");
		row.createCell(3).setCellValue("상태");
		row.createCell(4).setCellValue("SID");
		row.createCell(5).setCellValue("구입일");
		row.createCell(6).setCellValue("구입가");
		row.createCell(7).setCellValue("구입처");
		row.createCell(8).setCellValue("제조사");
		row.createCell(9).setCellValue("모델명");
		row.createCell(10).setCellValue("용도");
		row.createCell(11).setCellValue("책임자");
		row.createCell(12).setCellValue("위치");
		row.createCell(13).setCellValue("추가사항");
		
		int index = 0;
		for(String assetId: assetIdList) {
			CreationHelper createHelper = wb.getCreationHelper();
			
			index += 1;
			AssetVO vo = dao.getAssetByAssetId(assetId);
			Row rowi = sheet.createRow(index);
			rowi.createCell(0).setCellValue(vo.getAssetId());
			rowi.createCell(1).setCellValue(vo.getAssetCategory());
			rowi.createCell(2).setCellValue(vo.getAssetUser());
			rowi.createCell(3).setCellValue(vo.getAssetStatus());
			rowi.createCell(4).setCellValue(vo.getAssetSerial());
			
			CellStyle cellStyle5 = wb.createCellStyle();
			cellStyle5.setDataFormat(wb.createDataFormat().getFormat("yyyy-mm-dd"));
			Cell c5 = rowi.createCell(5);
			c5.setCellStyle(cellStyle5);
			c5.setCellValue(vo.getAssetPurchaseDate());

			CellStyle cellStyle6 = wb.createCellStyle();
			cellStyle6.setDataFormat(wb.createDataFormat().getFormat("₩#,##0;-₩#,##0"));
			Cell c6 = rowi.createCell(6);
			c6.setCellStyle(cellStyle6);
			c6.setCellValue(vo.getAssetPurchasePrice());
			
			rowi.createCell(6).setCellValue(vo.getAssetPurchasePrice());
			rowi.createCell(7).setCellValue(vo.getAssetPurchaseShop());
			rowi.createCell(8).setCellValue(vo.getAssetMaker());
			rowi.createCell(9).setCellValue(vo.getAssetModel());
			rowi.createCell(10).setCellValue(vo.getAssetUsage());
			rowi.createCell(11).setCellValue(vo.getAssetManager());
			rowi.createCell(12).setCellValue(vo.getAssetLocation());
			rowi.createCell(13).setCellValue(vo.getAssetComment());
		}
		
		try{
			OutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
		} catch(Exception e) {
			System.out.println(e);
		}
	}

}
