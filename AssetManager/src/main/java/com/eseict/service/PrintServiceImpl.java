package com.eseict.service;

import java.io.IOException;
import java.util.List;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eseict.DAO.AssetDAO;
import com.eseict.VO.AssetDetailVO;
import com.eseict.VO.AssetVO;

@Service
public class PrintServiceImpl implements PrintService {
	
	@Autowired
	private AssetDAO dao;

	@Override
	public String printFileName(String[] assetIdList, int mode) {
		String filename = "";
		if(mode == 0) {
			filename = "AssetList_";
		} else if(mode == 1) {
			filename = "AssetReport_";
		}
		
		if(assetIdList.length == 1) {
			filename += assetIdList[0] + ".xlsx";
		}
		else {
			filename += assetIdList[0] + "_&_" + (assetIdList.length-1) + "_others" + ".xlsx";
		}
		return filename;
	}

	@Override
	public byte[] printList(String[] assetIdList) throws IOException {
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
		
		ByteArrayOutputStream fileOut = new ByteArrayOutputStream();
		try{
			wb.write(fileOut);
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			wb.close();
		}
		
		return fileOut.toByteArray();
		
	}

	@Override
	public byte[] printReport(String[] assetIdList) throws IOException {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet();
		for(int i=0; i<4; i++) {
			sheet.setColumnWidth(i, 5120);
		}
		
		Font FontReportTitle = wb.createFont();
		FontReportTitle.setFontHeight((short)(16*20));
		FontReportTitle.setBold(true);
		
		Font FontReportItem = wb.createFont();
		FontReportItem.setBold(true);
		
		// 스타일 지정
		CellStyle BorderTopA = wb.createCellStyle();
		BorderTopA.setBorderTop(BorderStyle.THICK);
		BorderTopA.setBorderLeft(BorderStyle.THICK);
		BorderTopA.setFont(FontReportTitle);

		CellStyle BorderTopBC = wb.createCellStyle();
		BorderTopBC.setBorderTop(BorderStyle.THICK);
		
		CellStyle BorderTopD = wb.createCellStyle();
		BorderTopD.setBorderTop(BorderStyle.THICK);
		BorderTopD.setBorderRight(BorderStyle.THICK);

		CellStyle BorderTopBottomThin = wb.createCellStyle();
		BorderTopBottomThin.setBorderTop(BorderStyle.THIN);
		BorderTopBottomThin.setBorderBottom(BorderStyle.THIN);

		CellStyle BorderThinBold = wb.createCellStyle();
		BorderThinBold.setBorderTop(BorderStyle.THIN);
		BorderThinBold.setBorderLeft(BorderStyle.THIN);
		BorderThinBold.setBorderRight(BorderStyle.THIN);
		BorderThinBold.setBorderBottom(BorderStyle.THIN);
		BorderThinBold.setFont(FontReportItem);
		
		CellStyle BorderThin = wb.createCellStyle();
		BorderThin.setBorderTop(BorderStyle.THIN);
		BorderThin.setBorderLeft(BorderStyle.THIN);
		BorderThin.setBorderRight(BorderStyle.THIN);
		BorderThin.setBorderBottom(BorderStyle.THIN);
		
		CellStyle BorderLeftThick = wb.createCellStyle();
		BorderLeftThick.setBorderLeft(BorderStyle.THICK);
		BorderLeftThick.setFont(FontReportItem);
		
		CellStyle BorderLeftThickTopBottomThin = wb.createCellStyle();
		BorderLeftThickTopBottomThin.setBorderLeft(BorderStyle.THICK);
		BorderLeftThickTopBottomThin.setBorderTop(BorderStyle.THIN);
		BorderLeftThickTopBottomThin.setBorderBottom(BorderStyle.THIN);
		BorderLeftThickTopBottomThin.setFont(FontReportItem);
		
		CellStyle BorderRightThick = wb.createCellStyle();
		BorderRightThick.setBorderRight(BorderStyle.THICK);

		CellStyle BorderRightThickTopBottomThin = wb.createCellStyle();
		BorderRightThickTopBottomThin.setBorderRight(BorderStyle.THICK);
		BorderRightThickTopBottomThin.setBorderTop(BorderStyle.THIN);
		BorderRightThickTopBottomThin.setBorderBottom(BorderStyle.THIN);
		
		CellStyle BorderBottomThin = wb.createCellStyle();
		BorderBottomThin.setBorderBottom(BorderStyle.THIN);

		CellStyle BorderBottomA = wb.createCellStyle();
		BorderBottomA.setBorderTop(BorderStyle.THIN);
		BorderBottomA.setBorderLeft(BorderStyle.THICK);
		BorderBottomA.setBorderBottom(BorderStyle.THICK);

		CellStyle BorderBottomBC = wb.createCellStyle();
		BorderBottomBC.setBorderTop(BorderStyle.THIN);
		BorderBottomBC.setBorderBottom(BorderStyle.THICK);
		
		CellStyle BorderBottomD = wb.createCellStyle();
		BorderBottomD.setBorderTop(BorderStyle.THIN);
		BorderBottomD.setBorderRight(BorderStyle.THICK);
		BorderBottomD.setBorderBottom(BorderStyle.THICK);

		int cur = 0;
		int printIndex = 0;
		for(String assetId: assetIdList) {
			AssetVO vo = dao.getAssetByAssetId(assetId);

			Row rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderTopA);
			rowi.createCell(1).setCellStyle(BorderTopBC);
			rowi.createCell(2).setCellStyle(BorderTopBC);
			rowi.createCell(3).setCellStyle(BorderTopD);
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 3));
			Cell cell = CellUtil.createCell(rowi, 0, vo.getAssetId()+"의 자산 정보");
			CellUtil.setAlignment(cell, HorizontalAlignment.CENTER);
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 1));
			cell = CellUtil.createCell(rowi, 0, "자산 공통사항");
			CellUtil.setAlignment(cell, HorizontalAlignment.CENTER);
			cur += 1;

			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "분류");
			CellUtil.createCell(rowi, 1, vo.getAssetCategory());
			CellUtil.createCell(rowi, 2, "사용자");
			CellUtil.createCell(rowi, 3, vo.getAssetUser());
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "관리 번호");
			CellUtil.createCell(rowi, 1, vo.getAssetId());
			CellUtil.createCell(rowi, 2, "자산 상태");
			CellUtil.createCell(rowi, 3, vo.getAssetStatus());
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "시리얼 번호");
			CellUtil.createCell(rowi, 1, vo.getAssetSerial());
			CellUtil.createCell(rowi, 2, "반출 상태");
			CellUtil.createCell(rowi, 3, "");
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			CellStyle dateCellStyle = wb.createCellStyle();
			dateCellStyle.setDataFormat(wb.createDataFormat().getFormat("yyyy-mm-dd"));
			dateCellStyle.setAlignment(HorizontalAlignment.LEFT);
			dateCellStyle.setBorderTop(BorderStyle.THIN);
			dateCellStyle.setBorderRight(BorderStyle.THICK);
			dateCellStyle.setBorderBottom(BorderStyle.THIN);
			rowi.createCell(3).setCellStyle(dateCellStyle);
			CellUtil.createCell(rowi, 0, "제조사");
			CellUtil.createCell(rowi, 1, vo.getAssetMaker());
			CellUtil.createCell(rowi, 2, "구입일");
			CellUtil.createCell(rowi, 3, vo.getAssetPurchaseDate().toString());
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "모델명");
			CellUtil.createCell(rowi, 1, vo.getAssetModel());
			CellUtil.createCell(rowi, 2, "구입가");
			CellUtil.createCell(rowi, 3, vo.getAssetPurchasePrice());
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "용도");
			CellUtil.createCell(rowi, 1, vo.getAssetUsage());
			CellUtil.createCell(rowi, 2, "구입처");
			CellUtil.createCell(rowi, 3, vo.getAssetPurchaseShop());
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderThin);
			rowi.createCell(2).setCellStyle(BorderThinBold);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, "사용 위치");
			CellUtil.createCell(rowi, 1, vo.getAssetLocation());
			CellUtil.createCell(rowi, 2, "책임자");
			CellUtil.createCell(rowi, 3, vo.getAssetManager());
			cur += 1;
			
			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			cur += 1;

			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 1));
			cell = CellUtil.createCell(rowi, 0, "자산 세부사항");
			CellUtil.setAlignment(cell, HorizontalAlignment.CENTER);
			cur += 1;

			List<AssetDetailVO> advo = dao.getAssetDetailByAssetId(assetId);
			int i = 0;
			for(i=0; i<advo.size()-1; i=i+2) {
				rowi = sheet.createRow(cur);
				rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
				rowi.createCell(1).setCellStyle(BorderThin);
				rowi.createCell(2).setCellStyle(BorderThinBold);
				rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
				CellUtil.createCell(rowi, 0, advo.get(i).getAssetItem());
				CellUtil.createCell(rowi, 1, advo.get(i).getAssetItemDetail());
				CellUtil.createCell(rowi, 2, advo.get(i+1).getAssetItem());
				CellUtil.createCell(rowi, 3, advo.get(i+1).getAssetItemDetail());
				cur += 1;
			}
			if(advo.size() % 2 == 1) {
				rowi = sheet.createRow(cur);
				rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
				rowi.createCell(1).setCellStyle(BorderThin);
				rowi.createCell(2).setCellStyle(BorderThinBold);
				rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
				CellUtil.createCell(rowi, 0, advo.get(i).getAssetItem());
				CellUtil.createCell(rowi, 1, advo.get(i).getAssetItemDetail());
				cur += 1;
			}
			
			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			cur += 1;

			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 1));
			cell = CellUtil.createCell(rowi, 0, "영수증 주소");
			CellUtil.setAlignment(cell, HorizontalAlignment.CENTER);
			cur += 1;

			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderLeftThickTopBottomThin);
			rowi.createCell(1).setCellStyle(BorderTopBottomThin);
			rowi.createCell(2).setCellStyle(BorderTopBottomThin);
			rowi.createCell(3).setCellStyle(BorderRightThickTopBottomThin);
			CellUtil.createCell(rowi, 0, vo.getAssetReceiptUrl());
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 3));
			cur += 1;

			rowi = sheet.createRow(cur);
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			cur += 1;
			
			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderLeftThick);
			rowi.createCell(3).setCellStyle(BorderRightThick);
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 1));
			cell = CellUtil.createCell(rowi, 0, "자산 코멘트");
			CellUtil.setAlignment(cell, HorizontalAlignment.CENTER);
			cur += 1;

			rowi = sheet.createRow(cur); 
			rowi.createCell(0).setCellStyle(BorderBottomA);
			rowi.createCell(1).setCellStyle(BorderBottomBC);
			rowi.createCell(2).setCellStyle(BorderBottomBC);
			rowi.createCell(3).setCellStyle(BorderBottomD);
			CellUtil.createCell(rowi, 0, vo.getAssetComment());
			sheet.addMergedRegion(new CellRangeAddress(cur, cur, 0, 3));
			
			if(printIndex % 2 == 1) {
				sheet.setRowBreak(cur);
			} else {
				cur += 1;
			}
			
			cur += 1;
			printIndex += 1;
		}
		
		ByteArrayOutputStream fileOut = new ByteArrayOutputStream();
		try{
			wb.write(fileOut);
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			wb.close();
		}
		
		return fileOut.toByteArray();
	}


}
