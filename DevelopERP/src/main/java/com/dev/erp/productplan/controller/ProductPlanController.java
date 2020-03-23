package com.dev.erp.productplan.controller;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.productplan.model.service.ProductPlanService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ProductPlanController {

	static final Logger logger = LoggerFactory.getLogger(ProductPlanController.class);
	
	@Autowired
	ProductPlanService productPlanService;
	
	//============================ List<map> to JSON 변환 메소드(2)============================
	// list<map> 을 json 형태로 변형.
	@SuppressWarnings({ "unchecked" })
	public static JSONArray convertListToJson(List<Map<String, String>> firstPL) {
		JSONArray jsonArray = new JSONArray();
		for (Map<String, String> map : firstPL) {
			jsonArray.add(convertMapToJson(map));
		}
		return jsonArray;
	}

	@SuppressWarnings({ "unchecked" })
	public static JSONObject convertMapToJson(Map<String, String> map) {

		JSONObject json = new JSONObject();
		for (Map.Entry<String, String> entry : map.entrySet()) {
			String key = entry.getKey();
			Object value = entry.getValue();
			// json.addProperty(key, value);
			json.put(key, value);
		}
		return json;
	}

	//============================월별생산 계획============================
	@RequestMapping("/productplan/productionPlan.do")
	public ModelAndView productionPlan(ModelAndView mav) {
		
			try {
				//생산계획 메인화면 설정 데이터
				Map<String, String> empty = new HashMap<>();
				Map<String, String> param = new HashMap<>();
				param.put("productNo", "1009");
				param.put("year", "all");
				
				//전체 생산현항 데이터
				int epPlan = productPlanService.selectTotalEpPlan(empty);
				int epResult = productPlanService.selectTotalEpResult(empty);
				double epAttainment = (100.0*epResult)/epPlan;
				
				String epPlanStr = NumberFormat.getInstance().format(epPlan);
				String epResultStr = NumberFormat.getInstance().format(epResult);
				String epAttainmentStr = String.format("%.1f", epAttainment);
				
				Map<String, String> totalStatus = new HashMap<>();
				totalStatus.put("epPlan", epPlanStr);
				totalStatus.put("epResult", epResultStr);
				totalStatus.put("epAttainment", epAttainmentStr);
				
				//선택된 제품 현황 데이터
				int spPlan = productPlanService.selectTotalEpPlan(param);
				int spResult = productPlanService.selectTotalEpResult(param);
				double spAttainment = (100.0*spResult)/spPlan;
				
				String spPlanStr = NumberFormat.getInstance().format(spPlan);
				String spResultStr = NumberFormat.getInstance().format(spResult);
				String spAttainmentStr = String.format("%.1f", spAttainment);
				
				Map<String, String> selectedStatus = new HashMap<>();
				selectedStatus.put("spPlan", spPlanStr);
				selectedStatus.put("spResult", spResultStr);
				selectedStatus.put("spAttainment", spAttainmentStr);
				
				
				List<Map<String, String>> barData = productPlanService.monthlyOutputByProduct(param);
				JSONArray JbarData = convertListToJson(barData);
				
				mav.addObject("totalStatus", totalStatus);
				mav.addObject("selectedStatus", selectedStatus);
				mav.addObject("barData", JbarData);
				mav.addObject("param", param);
				mav.setViewName("productplan/monthlyPlan");
			} catch (Exception e) {
				throw new MyException("월별 생산계획 페이지를 불러올 수 없습니다.");
			}
		
		return mav;
	}
	
	@RequestMapping("/productplan/showBarChart.do")
	@ResponseBody
	public ModelAndView showBarChart(ModelAndView mav,
									 @RequestParam String productNo,
									 @RequestParam String year,
									 HttpServletResponse response) {
		
			try {
				response.setContentType("text/html;charset=utf-8");
				
				Map<String, String> param = new HashMap<>();
				param.put("productNo", productNo);
				param.put("year", year);
				
				//선택된 제품 현황 데이터
				int spPlan = productPlanService.selectTotalEpPlan(param);
				int spResult = productPlanService.selectTotalEpResult(param);
				int spAttainment = (100*spResult)/spPlan;
				
				String spPlanStr = NumberFormat.getInstance().format(spPlan);
				String spResultStr = NumberFormat.getInstance().format(spResult);
				String spAttainmentStr = NumberFormat.getInstance().format(spAttainment);
				
				Map<String, String> selectedStatus = new HashMap<>();
				selectedStatus.put("spPlan", spPlanStr);
				selectedStatus.put("spResult", spResultStr);
				selectedStatus.put("spAttainment", spAttainmentStr);
				
				List<Map<String, String>> barData = productPlanService.monthlyOutputByProduct(param);
				JSONArray JbarData = convertListToJson(barData);
				
				mav.addObject("selectedStatus", selectedStatus);
				mav.addObject("barData", JbarData);
				mav.setViewName("jsonView");
			} catch (Exception e) {
				throw new MyException("차트 데이터를 불러오는 중 오류가 발생했습니다.");
			}
		
		return mav;
	}
	
	@RequestMapping("/productplan/predictNextOutput.do")
	public ModelAndView predictNextOutput(ModelAndView mav,
										  @RequestParam("productName") String productName) {
		
		try {
			String ppDate = productPlanService.productionPlanDate();
			double outputSum = productPlanService.sumLast3Months(productName);
			int avg = (int)Math.round(outputSum/3);
			
			mav.addObject("ppDate", ppDate);
			mav.addObject("avg", avg);
		} catch (Exception e) {
			throw new MyException("생산 계획량 게산 오류!");
		}
		mav.setViewName("productplan/predictNextOutput");
		
		return mav;
	}
	
	
	//============================원재료 구매계획============================
	//헤더 ->
	@RequestMapping("/productplan/purchasePlan.do")
	public ModelAndView purchasePlanView(ModelAndView mav) {
		
		
		try {
			List<Map<String, String>> firstPL = productPlanService.selectFirstByPL();
			JSONArray JfirstPL = convertListToJson(firstPL);
			
			mav.addObject("firstPL", JfirstPL);
			mav.setViewName("productplan/purchasePlan");
		} catch (Exception e) {
			throw new MyException("페이지를 불러올 수 없습니다.");
		}
		
		return mav;
	}
	
	@RequestMapping("/productplan/showRequireCalByProduct.do")
	@ResponseBody
	public ModelAndView showRequireCalByProduct(ModelAndView mav,
												@RequestParam String productNo,
												HttpServletResponse response) {
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			List<Map<String, String>> requireCal = productPlanService.eachAmountByProduct(productNo);
			mav.addObject("requireCal", requireCal);
			
			mav.setViewName("jsonView");
		} catch (Exception e) {
			throw new MyException("소요량계산 테이블 불러오기 실패!");
		}
		return mav;
	}
	
	@RequestMapping("/productplan/endProductList.do")
	public ModelAndView searchSpecify(ModelAndView mav,
	  								  @RequestParam(value="plan") String plan) {
		
		try {
			mav.addObject("plan", plan);
			mav.addObject("year", "all");
			mav.setViewName("productplan/endProductList");
		} catch (Exception e) {
			throw new MyException("제품리스트를 불러오는 중에 오류가 발생했습니다.");
		}
		
		return mav;
	}
	@RequestMapping(value="/productplan/endProductListPage.do")
	@ResponseBody
	public ModelAndView selectEndProduct(ModelAndView mav,
										 @RequestParam(value="plan") String plan,
										 @RequestParam(value="year") String year,
										 @RequestParam(defaultValue="1") int cPage, HttpServletResponse response) {
		
			try {
				response.setContentType("text/html;charset=UTF-8");

				final int numPerPage = 10;
				int totalContents = 0;
				List<Map<String, String>> list  = new ArrayList<>();
				switch(plan) {
				case "product":
					list = productPlanService.selectProduction(cPage, numPerPage, year);
					totalContents= productPlanService.selectTotalContentsByP(year);
					break;
					
				case "purchase":
					list = productPlanService.selectEndProduct(cPage, numPerPage);
					totalContents= productPlanService.selectTotalContentsByEp();
					break;
				}
				
				String url = "endProductListPage.do?plan="+plan+"&year="+year;
				String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
				
				mav.addObject("list", list);
				mav.addObject("totalContents", totalContents);
				mav.addObject("cPage", cPage);
				mav.addObject("numPerPage", numPerPage);
				mav.addObject("pageBar", pageBar);
				
				mav.setViewName("jsonView");
			} catch (Exception e) {
				throw new MyException("제품리스트를 불러오는 중 오류가 발생했습니다.");
			}
		
		return mav;
	}
	
	//제품명에 따른 그래프 ajax
	@RequestMapping("/productplan/showChartByProduct.do")
	@ResponseBody
	public ModelAndView showChartByProduct(ModelAndView mav,
										   @RequestParam("productNo") String productNo,
										   HttpServletResponse response) {
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			List<Map<String, String>> graphData = productPlanService.eachAmountByProduct(productNo);
			
			mav.addObject("graphData", graphData);
			mav.setViewName("jsonView");
		} catch (Exception e) {
			throw new MyException("제품명에 따른 그래프 데이터 불러오기 오류!");
		}
		
		return mav;
	}
	
	//필요수량에 대한 구매계획 등록창
	@RequestMapping("/productplan/orderRequest.do")
	public ModelAndView insertPurchasePlanForm(ModelAndView mav,
											   @RequestParam("rmNo") String rmNo,
											   @RequestParam("rmNameArr") String[] rmNameArr,
											   @RequestParam("requireAm") String requireAm) {
		try {
			String rmName ="";
			
			for(String str :rmNameArr) {
				if(str == rmNameArr[rmNameArr.length-1])
					rmName+=str;
				else
					rmName+=str+" ";
				
			}
			mav.addObject("rmNo", rmNo);
			mav.addObject("rmName", rmName);
			mav.addObject("requireAm", requireAm);
			mav.setViewName("productplan/orderRequest");
		} catch (Exception e) {
			throw new MyException("발주요청 불러오기 오류!");
		}
		
		return mav;
	}
	
	//구매요청
	@RequestMapping("/productplan/orderRequestEnd.do")
	public ModelAndView orderRequestFormEnd(ModelAndView mav,
											@RequestParam String enrollDate,
											@RequestParam String dueDate,
											@RequestParam String rmName,
											@RequestParam String rmNo,
											@RequestParam String requireAmount,
											@RequestParam String orderContent) {
		
		try {
			String vendorNo = productPlanService.selectVendorNo(rmNo);
			
			Map<String, String> map = new HashMap<>();
			map.put("enrollDate",enrollDate);
			map.put("dueDate",dueDate);
			map.put("rmName",rmName);
			map.put("rmNo",rmNo);
			map.put("vendorNo",vendorNo);
			map.put("requireAmount",requireAmount);
			map.put("orderContent",orderContent);
			int result = productPlanService.insertOrderRequest(map);
			
			mav.addObject("msg",result>0?"원재료 구매요청 성공!":"원재료 구매요청 실패!");
			mav.addObject("loc","/purchase/purchaseInsertView.do");
			mav.setViewName("common/msg");
		} catch (Exception e) {
			throw new MyException("원재료 구매요청 오류!");
		}
		return mav;
	}
	
	//============================작업지시서============================
	//작업지시서 조회
	@RequestMapping("/productplan/jobOrder.do")
	public ModelAndView joView(ModelAndView mav) {
		try {
			List<Map<String, String>> joList = productPlanService.selectJobOrder();
			
			mav.addObject("joList", joList);
			mav.setViewName("productplan/jobOrder");
		} catch (Exception e) {
			throw new MyException("작업지시서 페이지를 불러오는 중에 오류가 발생했습니다.");
		}
		
		return mav;
	}
	//작업지시서 등록 전체 폼
	@RequestMapping("/productplan/insertJobOrder.do")
	public ModelAndView insertJobOrderForm(ModelAndView mav) {
		
		try {
			mav.setViewName("productplan/insertJobOrder");
		} catch (Exception e) {
			throw new MyException("작업지시서 등록창 불러오기 오류!");
		}
		
		return mav;
	}
	//작업지시서 등록 입력폼 - 세부사항 검색
	@RequestMapping("/productplan/searchDetails.do")
	public ModelAndView searchDetails(@RequestParam("searchType") String searchType,
									  ModelAndView mav) {
		
		try {
			mav.addObject("searchType", searchType);
			mav.setViewName("productplan/searchDetails");
		} catch (Exception e) {
			throw new MyException("작업지시서 세부사항 검색 오류!");
		}
		
		return mav;
	}
	
	//작업지시서 등록 입력폼 - 세부사항 검색 - modal바디
	@RequestMapping("/productplan/searchDetailsPage.do")
	@ResponseBody
	public ModelAndView searchDetailsPage(ModelAndView mav,
										  @RequestParam(value="searchType") String searchType,
										  @RequestParam(defaultValue="1") int cPage,
										  HttpServletResponse response) {
		try {
			response.setContentType("text/html;charset=UTF-8");
			final int numPerPage = 5;
			int totalContents = 0;
			List<Map<String, String>> list  = new ArrayList<>();
			switch(searchType) {
			case "customer":
				list = productPlanService.selectCustomer(cPage,numPerPage);
				totalContents = productPlanService.selectTotalContentsByCtmr();
				break;
				
			case "productName":
				list = productPlanService.selectProductName(cPage,numPerPage);
				totalContents = productPlanService.selectTotalContentsByPn();
				break;
			}
			
			String url = "searchDetailsPage.do?searchType="+searchType;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			mav.addObject("detailsList", list);
			mav.addObject("cPage", cPage);
			mav.addObject("pageBar", pageBar);
			mav.setViewName("jsonView");
		} catch (Exception e) {
			throw new MyException("작업지시서 세부사항 검색 데이터 불러오기 오류!");
		}
		
		return mav;
	}
	
	//작업지시서 신규등록
	@RequestMapping("/productplan/insertJobOrderEnd.do")
	public ModelAndView insertJobOrder(@RequestParam(value="enrollDate") String enrollDate,
									   @RequestParam String dueDate,
									   @RequestParam String customer,
									   @RequestParam String manager,
									   @RequestParam String productName,
									   @RequestParam String plNo,
									   @RequestParam String quantity,
									   @RequestParam String orderContent,
									   ModelAndView mav) {
		
		try {
			int joTotalContents = 0;
			joTotalContents = productPlanService.selectJoTotalContents();
			//작업지시번호 포맷변경
			String str = String.join("", enrollDate.split("-"));
			Map<String, String> joList = new HashMap<>();
			joList.put("joNo", str+"-"+(joTotalContents+1));
			joList.put("enrollDate", enrollDate);
			joList.put("dueDate", dueDate);
			joList.put("customer", customer);
			joList.put("manager", manager);
			joList.put("productName", productName);
			joList.put("plNo", plNo);
			joList.put("quantity", quantity);
			joList.put("orderContent", orderContent);
			
			
			int result = productPlanService.insertJobOrder(joList);
			mav.addObject("msg",result>0?"작업지시서 신규등록 성공!":"작업지시서 신규등록 실패!");
			mav.addObject("loc","/productplan/jobOrder.do");
			mav.setViewName("common/msg");
		} catch (Exception e) {
			throw new MyException("작업지시서 등록중 오류가 발생했습니다.");
		}
		
		return mav;
		
	}
	//작업지시서 수정 폼
	@RequestMapping("/productplan/updateJobOrder.do")
	public ModelAndView updateJobOrder(ModelAndView mav,
										   @RequestParam(value="joNo") String joNo) {
		
		try {
			Map<String, String> load = productPlanService.selectOneJo(joNo);
			String str = load.get("joNo");
			String year = str.substring(0,4);
			String month = str.substring(4,6);
			String date = str.substring(6,8);
			String str2 = String.format("%s-%s-%s",year,month,date);
			
			mav.addObject("enrollDate", str2);
			mav.addObject("load", load);
			mav.addObject("joNo",joNo);
			mav.setViewName("productplan/updateJobOrder");
		} catch (Exception e) {
			throw new MyException("작업지시서 수정 불러오는 중에 오류가 발생했습니다.");
		}
		return mav;
	}
	//작업 지시서 수정완료
	@RequestMapping("/productplan/updateJobOrderEnd.do")
	public ModelAndView updateJobOrderEnd(ModelAndView mav,
										  @RequestParam (value="joNo") String joNo,
										  @RequestParam String dueDate,
										  @RequestParam String customer,
										  @RequestParam String manager,
										  @RequestParam String productName,
										  @RequestParam String quantity,
										  @RequestParam String orderContent
										  ) {
		try {
			Map<String, String> update = new HashMap<>();
			update.put("joNo", joNo);
			update.put("dueDate", dueDate);
			update.put("customer", customer);
			update.put("manager", manager);
			update.put("productName", productName);
			update.put("quantity", quantity);
			update.put("orderContent", orderContent);
			int result = productPlanService.updateJobOrderEnd(update);
			mav.addObject("msg", result>0?"작업지시서 수정 성공!":"작업지서서 수정 실패!");
			mav.addObject("loc", "/productplan/jobOrder.do");
			mav.setViewName("common/msg");
		} catch (Exception e) {
			throw new MyException("작업지시서 수정완료 중 오류가 발생했습니다.");
		}
		return mav;
	}
	
	//작업지시서 삭제
	@RequestMapping("/productplan/deleteOneJo.do")
	public ModelAndView deleteOneJo(@RequestParam(value="joNo") String joNo,
									ModelAndView mav) {
		try {
			int result = productPlanService.deleteOneJo(joNo);
			mav.addObject("msg", result>0?"삭제 성공!":"삭제 실패!");
			mav.addObject("loc","/productplan/jobOrder.do");
			mav.setViewName("common/msg");
		} catch (Exception e) {
			throw new MyException("작업지시서 삭제 중 오류가 발생했습니다.");
		}
		
		return mav;
	}
	
	
}
