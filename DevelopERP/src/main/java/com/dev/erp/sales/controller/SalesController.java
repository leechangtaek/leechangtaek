package com.dev.erp.sales.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.sales.model.service.SalesService;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

@Controller
public class SalesController {
	
	private final static Logger logger = LoggerFactory.getLogger(SalesController.class);
	
	@Autowired
	private SalesService salesService;
	
	@RequestMapping("/sales/salesListManagement.do")
	public ModelAndView salesListManagemnet(ModelAndView mav, @RequestParam(value="startDate", required=false) String startDate,
											@RequestParam(value="endDate", required=false) String endDate) {
		try {
			Map<String,String> param = new HashMap<>();
			param.put("startDate", startDate);
			param.put("endDate", endDate);
			List<Map<String,String>> salesList = new ArrayList<>();
			salesList = salesService.selectAllSalesList(param);
			
			mav.addObject("salesList",salesList);
			mav.setViewName("sales/salesListManagement");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	@RequestMapping("/sales/cancleSalesForm.do")
	public ModelAndView cancleSalesForm(ModelAndView mav, @RequestParam("sales_no") String sales_no) {
		try {
			
			Map<String,String> map = salesService.selectSalesOneBySalesNo(sales_no);
			mav.addObject("map",map);
			mav.setViewName("sales/cancleSalesForm");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	
	@RequestMapping(value="/sales/cancleSalesFormEnd.do", method=RequestMethod.POST)
	public ModelAndView cancleSalesFormEnd(ModelAndView mav, @RequestParam("salesNo") String salesNo,
											@RequestParam("lotNo") String lotNo, @RequestParam("quantity") String quantity) {
		try {
			Map<String,String> param = new HashMap<>();
			param.put("lotNo", lotNo);
			param.put("quantity", quantity);
			int result = 0;
			result = salesService.deleteSalesOneBySalesNo(salesNo);
			
			result = salesService.reInsertProductBySalesNo(param);
			
			mav.addObject("msg",result>0?"등록성공":"등록실패");
			mav.addObject("loc","/sales/salesListManagement.do");
			mav.setViewName("common/msg");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	
	@RequestMapping("/sales/salesAddModal.do")
	public ModelAndView salesAddModal(ModelAndView mav) {
		try {
			mav.setViewName("sales/addSalesForm");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	
	@RequestMapping("/sales/searchLotNo.do")
	public ModelAndView searchSpecify(ModelAndView mav) {
		try {
			mav.setViewName("sales/searchLotNo");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	
	@RequestMapping("/sales/searchSpecifyPage.do")
	@ResponseBody
	public ModelAndView searchSpecify(ModelAndView mav, @RequestParam(value="searchType", required=false) String searchType, @RequestParam(defaultValue="1") int cPage, HttpServletResponse rexsponse) {
		try {
			rexsponse.setContentType("text/html;charset=utf-8");
			List<Map<String,String>> list = new ArrayList<>();
			final int numPerPage = 5;
			int totalContents = 0;
			
			list = salesService.selectLotAllInProduction(cPage,numPerPage);  
			totalContents = salesService.selectAllCountByLotNo(); 
			
			String url = "searchSpecifyPage.do?searchType="+searchType;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("speclist",list);
			map.put("pageBar", pageBar);
			
			mav.setViewName("jsonView");
			mav.addObject("map",map);
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		return mav;
	}
	
	@RequestMapping(value="/sales/addSales.do", method=RequestMethod.POST)
	@ResponseBody
	public Object addBOM(@RequestParam(value="lotNos[]", required=false) List<String> lotNoList,
						 @RequestParam(value="plNos[]", required=false) List<String> plNoList,
						 @RequestParam(value="vendorNos[]", required=false) List<String> vendorNoList,
						 @RequestParam(value="quantitys[]", required=false) List<String> quantityList,
					 	 @RequestParam(value="inprices[]", required=false) List<String> inpriceList,
					 	@RequestParam(value="outprices[]", required=false) List<String> outpricesList,
					 	@RequestParam(value="salesQuantitys[]", required=false) List<String> salesQuantityList,
										 ModelAndView mav) {
		try {
			int result = 0;
			if(!(lotNoList.size()==0)) {
				Map<String, String> map = new HashMap<>();
	//			int result = productionService.insertBOM(productCode); 
				
	//			int bomNo = productionService.selectBOMNobyProductCode(productCode);
	//			
	//			logger.info("bomNo@Conteroller={}",bomNo);
	//			
	//			
	//			logger.info("productCode@Controller={}",productCode);
	//			logger.info("pCodeList@Controller={}",pCodeList);
	//			logger.info("pNameList@Controller={}",pNameList);
	//			logger.info("pCountList@Controller={}",pCountList);
				
				List<Map<String, Object>> salesList = new ArrayList<Map<String, Object>>();
				Map<String, Object> paramMap = new HashMap<String, Object>();
				
				for(int i=0; i<lotNoList.size();i++) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("lotNoList", lotNoList.get(i));
					temp.put("plNoList", plNoList.get(i));
					temp.put("vendorNoList", vendorNoList.get(i));
					temp.put("inpriceList", inpriceList.get(i));
					temp.put("outpricesList", outpricesList.get(i));
					temp.put("quantityList", quantityList.get(i));
					temp.put("salesQuantityList", salesQuantityList.get(i));
					
					salesList.add(temp);
				}
				paramMap.put("salesList", salesList);
				
				result = salesService.updateSalesList(paramMap);
				result = salesService.insertSalesListInProduction(paramMap);
			}
			List<String> list = new ArrayList<>();
			list.add(result>0?"성공":"실패");
			return list;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/sales/xbarGraphByProduct.do")
	public ModelAndView salesGraph(ModelAndView mav) {
		try {
			Calendar date = new GregorianCalendar().getInstance();
			Calendar beforeMonth  = new GregorianCalendar().getInstance();
			beforeMonth.add(Calendar.MONTH, -1);
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			String today = fmt.format(date.getTime());
			String monthAgo = fmt.format(beforeMonth.getTime());
			mav.addObject("today",today);
			mav.addObject("monthAgo",monthAgo);
			
			List<Map<String,String>> salesList = salesService.selectSalesProduct();
			List<Map<String,String>> totalSalesDataPerMonth = new ArrayList<>();
			List<Map<String,String>> inprice = new ArrayList<>();
			List<Map<String,String>> outprice = new ArrayList<>();
			totalSalesDataPerMonth = salesService.selectTotalSalesDataPerMonth();
			
			for(int i=0;i<totalSalesDataPerMonth.size();i++) {
				Map<String,String> inprice_ = new HashMap<>();
				Map<String,String> outprice_ = new HashMap<>();
				Map<String,String> temp = totalSalesDataPerMonth.get(i);
				inprice_.put("label", temp.get("SALES_DATE"));
				inprice_.put("y", String.valueOf(temp.get("TOTALINPRICE")));
				inprice.add(inprice_);
				outprice_.put("label", temp.get("SALES_DATE"));
				outprice_.put("y", String.valueOf(temp.get("TOTALOUTPRICE")));
				outprice.add(outprice_);
			}
			
			mav.addObject("inprice", new Gson().toJson(inprice));
			mav.addObject("outprice", new Gson().toJson(outprice));
			mav.addObject("salesList",salesList);
			mav.setViewName("sales/xbarGraphByProduct");
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}	
		return mav;
	}
	
	@RequestMapping("/sales/searchXBarFrmEnd.do")
	@ResponseBody
	public void searchXBarFrmEnd(@RequestParam(value="startDate", required=false) String startDate,
									@RequestParam(value="endDate", required=false) String endDate,
									HttpServletResponse response) throws JsonIOException, IOException {
		try {
			response.setContentType("text/html;charset=UTF-8");
			Map<String,String> param = new HashMap<>();
			param.put("startDate", startDate);
			param.put("endDate", endDate);
			Map<String,String> totalSalesData = new HashMap<>();
			List<Map<String,String>> salesData = new ArrayList<>();
			
			salesData = salesService.selectSalesMoney(param);
			totalSalesData = salesService.selectTotalSalesData(param);
			
			
			double totalInprice_ = Double.parseDouble(String.valueOf(totalSalesData.get("TOTALINPRICE")));
			double totalOutprice_ = Double.parseDouble(String.valueOf(totalSalesData.get("TOTALOUTPRICE")));
			
			
			
			List<Map<String,String>> inpricePercentList = new ArrayList<>();
			List<Map<String,String>> outpricePercentList = new ArrayList<>();
			for(int i=0;i<salesData.size();i++) {
				Map<String,String> temp = new HashMap<>();
				double outprice = 0.0;
				double inprice = 0.0;
				double percent = 0.0;
				
				String productName = ((Map<String,String>)salesData.get(i)).get("PRODUCT_NAME");
				temp.put("label", productName);
				inprice = Double.parseDouble(String.valueOf(((Map<String,String>)salesData.get(i)).get("SUM_INPRICE")));
				
				percent = Math.round((inprice/totalInprice_)*100.0)/100.0;
				temp.put("y", String.valueOf(percent));
				inpricePercentList.add(temp);
				
				
				temp = new HashMap<>();
				temp.put("label", productName);
				outprice = Double.parseDouble(String.valueOf(((Map<String,String>)salesData.get(i)).get("SUM_OUTPRICE")));
				percent = Math.round((outprice/totalOutprice_)*100.0)/100.0;
				temp.put("y", String.valueOf(percent));
				outpricePercentList.add(temp);
			}
			
			
			Map <String,Object> xbarMap = new HashMap<>();
			xbarMap.put("outpricePercentList", outpricePercentList);
			xbarMap.put("inpricePercentList", inpricePercentList);
			xbarMap.put("salesData", salesData);
			xbarMap.put("totalSalesData", totalSalesData);
			
	//		data = qualityService
			
			new Gson().toJson(xbarMap,response.getWriter());
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/sales/goPrint.do")
	public void goPrint() {
		
	}
}
