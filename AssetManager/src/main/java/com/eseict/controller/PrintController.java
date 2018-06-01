package com.eseict.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eseict.service.PrintService;

@Controller
public class PrintController {

	@Autowired
	private PrintService service;
	
	@RequestMapping(value="printList")
	public void printList(@RequestParam String[] assetIdList) {
		service.printList(assetIdList);
	}
}
