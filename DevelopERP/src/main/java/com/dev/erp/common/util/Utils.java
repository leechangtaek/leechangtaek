package com.dev.erp.common.util;

public class Utils {
	
	/**
	 * 페이징바 html 코드를 문자열로 리턴하는 메소드
	 * 
	 * 
	 */
	public static String getPageBar(int totalContents, int cPage, int numPerPage, String url) {
		
		String pageBar = "";
		
		final int pageBarSize = 5;
		//총페이지
		final int totalPage  = (int)Math.ceil((double)totalContents/numPerPage);
		
		final int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		final int pageEnd = (pageStart+pageBarSize-1);
		//페이지바 순회용 증감 변수
		int pageNo = pageStart;
		
		pageBar += "<ul class=\"pagination justify-content-center\">";
		
		//[이전] previous
		if(pageNo == 1) {
			pageBar += "<li class=\"page-item disabled\">\r\n" + 
					"      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-disabled=\"true\">이전</a>\r\n" + 
					"    </li>";
		}
		else {
			pageBar += "<li class=\"page-item\">"
					+  "<span class=\"page-link\" id=\""+url+"&cPage="+(pageNo-1)+"\">이전</span>"
					+  "</li>";
		}
		
		//[pageNo]
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			if(cPage == pageNo) {
				pageBar += "<li class=\"page-item active\">"
						+  "<span class=\"page-link\">"+pageNo+"</span>"
						+  "</li>";
			}
			else {
				pageBar += "<li class=\"page-item\">"
						+  "<span class=\"page-link\" id=\""+url+"&cPage="+(pageNo)+"\">"+pageNo+"</span>"
						+  "</li>";
			}
			
			pageNo++;
		}
		
		//[다음] next
		if(pageNo > totalPage) {
			pageBar += "<li class=\"page-item disabled\">\r\n" + 
					"      <span class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-disabled=\"true\">다음</span>\r\n" + 
					"    </li>";
		}
		else {
			pageBar += "<li class=\"page-item\">"
					+  "<span class=\"page-link\" id=\""+url+"&cPage="+(pageNo)+"\">다음</span>"
					+  "</li>";
		}
		
		pageBar += "</ul>";
		return pageBar;
	}
}
