package com.eseict.service;

import org.springframework.web.servlet.ModelAndView;

public interface DisposalService {

	public ModelAndView disposalListMnV(String searchMode, String searchKeyword);

	public int disposeAsset(String[] disposeArray);
}
