package com.eseict.service;

import java.util.ArrayList;

import org.springframework.web.servlet.ModelAndView;

public interface CategoryService {

	public String getCode(String categoryName) throws Exception;
	
	public int deleteCategory(String categoryName) throws Exception;
	
	public int existsCategory(String categoryName) throws Exception;
	
	public int existsCode(String code) throws Exception;

	public int newCode(String categoryName, String codeName) throws Exception;
	
	public int deleteCode(String categoryName) throws Exception;
	
	public ModelAndView categoryDetailMnV(String categoryName) throws Exception;

	public ModelAndView categoryListMnV(String searchMode, String searchKeyword) throws Exception;

	public ModelAndView categoryModifyMnV(String categoryName) throws Exception;
	
	public boolean categoryRegisterSend(String categoryName, String[] items) throws Exception;
	
	public int categoryModifyCheckName(String categoryOriName, String categoryName) throws Exception;
	
	public int categoryModifyItemDelete(String categoryName, String[] deleteItems) throws Exception;
	
	public int categoryModifyItemUpdate(String categoryName, String[] items, ArrayList<Integer> deleteItemsList) throws Exception;
}
