package com.eseict.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eseict.service.PrintService;

@Controller
public class PrintController {

	@Autowired
	private PrintService service;
	
	@RequestMapping(value="printList")
	@ResponseBody
	public byte[] printList(HttpServletResponse response, @RequestParam String[] assetIdList) throws IOException {
		String filename = service.printFileName(assetIdList, 0);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename +"\""); 

		return service.printList(assetIdList);
	}

	@RequestMapping(value="printReport")
	@ResponseBody
	public byte[] printReport(HttpServletResponse response, @RequestParam String[] assetIdList) throws IOException {
		String filename = service.printFileName(assetIdList, 1);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename +"\""); 

		return service.printReport(assetIdList);
	}
	
	@RequestMapping(value="printLabel")
	@ResponseBody
	public byte[] printLabel(HttpServletResponse response, @RequestParam String[] assetIdList) throws IOException {
		String filename = service.printFileName(assetIdList, 2);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename +"\""); 

		return service.printLabel(assetIdList);
	}
}
