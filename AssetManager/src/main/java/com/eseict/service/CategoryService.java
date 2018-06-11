package com.eseict.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.eseict.VO.CategoryCodeVO;
import com.eseict.VO.CategoryVO;

public interface CategoryService {

	public String getCode(String categoryName);
	
	public void deleteCategory(String categoryName);
	
	public int existsCode(String code);

	public void newCode(String categoryName, String codeName);
	
	public int deleteCode(String categoryName);
	
	public ModelAndView categoryDetailMnV(String categoryName);

	public ModelAndView categoryListMnV(String searchMode, String searchKeyword);

	public ModelAndView categoryModifyMnV(String categoryName);
	
	public boolean categoryRegisterSend(String categoryName, String[] items);
	
	public int categoryModifyCheckName(String categoryOriName, String categoryName);
	
	public ArrayList<Integer> categoryModifyItemDelete(String categoryName, String[] deleteItems);
	
	public int categoryModifyItemUpdate(String categoryName, String[] items, ArrayList<Integer> deleteItemsList);
}
