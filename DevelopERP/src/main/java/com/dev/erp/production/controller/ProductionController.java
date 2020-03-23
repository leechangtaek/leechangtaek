package com.dev.erp.production.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.enrollment.model.service.EnrollmentService;
import com.dev.erp.production.model.service.ProductionService;
import com.google.gson.JsonIOException;


@Controller
public class ProductionController {
	
	static final Logger logger = LoggerFactory.getLogger(ProductionController.class);

	@Autowired
	ProductionService productionService;
	
	@Autowired
	EnrollmentService enrollmentService;
	
	@RequestMapping("/production/BOMListManagement.do")
	public ModelAndView BOMListManagement(ModelAndView mav) {
		try {
			List<Map<String, String>> productList = productionService.selectproductList();
			
			//loger.info("vendorList@Controller={}", productList);
			
			mav.addObject("productList", productList);
			mav.setViewName("production/BOMListManagement");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 등록 페이지를 불러올 수 없습니다. 관리자에게 문의하세요.");
		}
		return mav;
	}
	
	@RequestMapping("/production/warehousing.do")
	public ModelAndView warehousing(ModelAndView mav) {
		try {
			List<Map<String, String>> productList  = productionService.selectProductionList();
			
			//loger.info("productList@Controller={}",productList);
			
			mav.addObject("productList",productList);
			mav.setViewName("production/warehousing");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("생산입고 페이지를 불러올 수 없습니다. 관리자에게 문의하세요.");
		}
		return mav;
	}
	
	//add
	@RequestMapping("/production/addBOMForm.do")
	public ModelAndView addBOMForm(ModelAndView mav) {
		try {
			mav.setViewName("production/addBOMForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 등록 페이지를 불러올 수 없습니다. 관리자에게 문의하세요.");
		}
		return mav;
	}

	//add
	@RequestMapping("/production/updateBOMForm.do")
	public ModelAndView updateBOMForm(@RequestParam("tdPtNo") String tdPtNo, ModelAndView mav) {
		try {
			//loger.info("tdPtNo@Controller={}",tdPtNo);
			int bomNo = productionService.selectBOMNobyProductCode(tdPtNo);
			//loger.info("bomNo@Controller={}",bomNo);
			
			List<Map<String, String>> BOMrmList = productionService.selectBOMRmListByBOMNo(bomNo);
			
			//loger.info("BOMrmList@Controller={}", BOMrmList);
			
			mav.addObject("BOMrmList", BOMrmList);
			mav.setViewName("production/updateBOMForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/production/selectRawMaterialList.do")
	public ModelAndView selectRawMaterialList(ModelAndView mav) {
		try {
			List<Map<String, String>> rawmaterialList = productionService.selectRawMaterialList();
			mav.addObject("rawmaterialList",rawmaterialList);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("원재료 목록을 불러올 수 없습니다. 관리자에게 문의하세요");
		}
		return mav;
	}
	
	
	@RequestMapping(value="/production/addBOM.do", method=RequestMethod.POST)
	@ResponseBody
	public Object addBOM(@RequestParam(value="pNos[]", required=false) List<String> pNoList,
						 @RequestParam(value="pCodes[]", required=false) List<String> pCodeList,
						 @RequestParam(value="pNames[]", required=false) List<String> pNameList,
					 	 @RequestParam(value="pCounts[]", required=false) List<String> pCountList,
					 	@RequestParam(value="productCode", required=false) String productCode,
										 ModelAndView mav) {
		try {
			if(!(pCodeList.size()==0 || pCountList.size()==0)) {
				Map<String, String> map = new HashMap<>();
				map.put("productCode", productCode);
				//loger.info("map@controller={}",map);
				int result = productionService.insertBOM(productCode); 
				
				int bomNo = productionService.selectBOMNobyProductCode(productCode);
				
				//loger.info("bomNo@Conteroller={}",bomNo);
				
				
				//loger.info("productCode@Controller={}",productCode);
				//loger.info("pCodeList@Controller={}",pCodeList);
				//loger.info("pNameList@Controller={}",pNameList);
				//loger.info("pCountList@Controller={}",pCountList);
				
				List<Map<String, Object>> BOMList = new ArrayList<Map<String, Object>>();
		
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("productCode", productCode);
				paramMap.put("bomNo", bomNo);
				
				for(int i=0; i<pCodeList.size();i++) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("pCodeList", pCodeList.get(i));
					temp.put("pCountList", pCountList.get(i));
					
					BOMList.add(temp);
				}
				paramMap.put("BOMList", BOMList);
				//loger.info("1232134BOM={}",paramMap);
				int result2 = productionService.insertBOMlist(paramMap);
			}
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 등록 오류!");
		}
		List<String> list = new ArrayList<>();
		list.add("성공");
		return list;
	}
	
	@RequestMapping("/production/deleteBOMByBOMNo.do")
	public ModelAndView deleteBOMByBOMNo(@RequestParam("plNo") String plNo,
										 ModelAndView mav) {
		try {
			//loger.info("plNo@Controller={}",plNo);
			
			int bomNo = productionService.selectBOMNobyProductCode(plNo);
			int result = productionService.deleteBOMByBOMNo(bomNo); 
			
			//loger.info("result@controller={}",result);
			
			mav.addObject("result",result);
			mav.setViewName("redirect:/production/BOMListManagement.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 삭제 오류");
		}
		return mav;
	}
	
	@RequestMapping("/production/selectBOMForm.do")
	@ResponseBody
	public Map<String, Object> selectBOMForm(@RequestParam("tdPtNo") String tdPtNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			//loger.info("productNo@Controller={}",tdPtNo);
			map.put("tdPtNo", tdPtNo);
			
			boolean isUsable = productionService.selectBOMForm(tdPtNo)==null?true:false;
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 페이지 로드 오류");
		}
		return map;
	}
	
	
	@RequestMapping(value="/production/updateBOM.do", method=RequestMethod.POST)
	@ResponseBody
	public Object updateBOM(@RequestParam(value="pNos[]", required=false) List<String> pNoList,
						 @RequestParam(value="pCodes[]", required=false) List<String> pCodeList,
						 @RequestParam(value="pNames[]", required=false) List<String> pNameList,
					 	 @RequestParam(value="pCounts[]", required=false) List<String> pCountList,
					 	 @RequestParam(value="productCode", required=false) String productCode,
					 	 @RequestParam(value="beforeArr[]", required=false) List<String> beforeArrList,
					 	 @RequestParam(value="removeCode[]", required=false) List<String> removeCodeList,
										 ModelAndView mav) {
		try {
			//loger.info("productCode@Controller={}",productCode);
			//loger.info("pCodeList@Controller={}",pCodeList);
			//loger.info("pNameList@Controller={}",pNameList);
			//loger.info("pCountList@Controller={}",pCountList);
			//loger.info("beforeArrList@Controller={}",beforeArrList);
			//loger.info("removeCodeList@Controller={}",removeCodeList);
			
			if(beforeArrList == null) {
				beforeArrList = new ArrayList<>();
			}
			
			//제품코드로 BOM NO 가져오기
			Map<String, String> map = new HashMap<>();
			map.put("productCode", productCode);
			//loger.info("map@controller={}",map);
			int bomNo = productionService.selectBOMNobyProductCode(productCode);
			//loger.info("bomNo@Conteroller={}",bomNo);
			
			//delete
			if(removeCodeList != null) {
				//loger.info("delete started");
				List<Map<String, Object>> deleteList = new ArrayList<Map<String, Object>>();
				Map<String, Object> deleteMap = new HashMap<String, Object>();
				deleteMap.put("bomNo", bomNo);
				for(int i=0; i<removeCodeList.size();i++) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("removeCode", removeCodeList.get(i));
					deleteList.add(temp);
				}
				deleteMap.put("deleteList", deleteList);
				int delete = productionService.deleteBOMRm(deleteMap);
			}
			
			
			//merge into
			if(pCodeList != null) {
			
				List<Map<String, Object>> BOMList = new ArrayList<Map<String, Object>>();
		
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("productCode", productCode);
				paramMap.put("bomNo", bomNo);
				//loger.info("beforeArrList.size()@Controller={}",beforeArrList.size());
				if((beforeArrList.size() < pCodeList.size())) {
					int repeat = pCodeList.size() - beforeArrList.size();
					//loger.info("repeat@controller={}",repeat);
					for(int i=0;i<repeat;i++) {
						beforeArrList.add("0");
					}
				}
				
				for(int i=0; i<pCodeList.size();i++) {
					Map<String,Object> temp = new HashMap<>();
					temp.put("pCodeList", pCodeList.get(i));
					temp.put("pCountList", pCountList.get(i));
					temp.put("beforeArrList", beforeArrList.get(i));
					
					BOMList.add(temp);
				}
				
				paramMap.put("BOMList", BOMList);
				//loger.info("paramMap@Controller={}",paramMap);
				int result2 = productionService.updateBOMRm(paramMap);
			}
			
			//not cotains = delete
			if(pCodeList != null) {
				for(String before : beforeArrList) {
				    if(pCodeList.contains(before)) {
				        //system.out.println("pCodeList 에는 "+ before + " 가 있다.");
				    }else {
				        //system.out.println("pCodeList 에는 "+ before + " 가 없다. 따라서 지울것이다.");
				        List<String> removeThis = new ArrayList<>();
				        removeThis.add(before);
				        
				        List<Map<String, Object>> deleteList = new ArrayList<Map<String, Object>>();
						Map<String, Object> deleteMap = new HashMap<String, Object>();
						deleteMap.put("bomNo", bomNo);
						for(int i=0; i<removeThis.size();i++) {
							Map<String,Object> temp = new HashMap<>();
							temp.put("removeCode", removeThis.get(i));
							deleteList.add(temp);
						}
						deleteMap.put("deleteList", deleteList);
						int delete = productionService.deleteBOMRm(deleteMap);
				    }
				}
			}
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 수정 오류");
		}
		List<String> list = new ArrayList<>();
		list.add("성공");
		
		return list;
	}
	
	
	//==============================releasing start======================================
	@RequestMapping("/production/checkBOMExist")
	@ResponseBody
	public ModelAndView checkBOMExist(@RequestParam("chkBOM") String chkBOM,
											 @RequestParam("rQuantity") String rQuantity,HttpServletResponse response,
											 ModelAndView mav) throws JsonIOException, IOException {
		try {
			response.setContentType("text/html;charset=utf-8");
			//loger.info("chkBOM@Controller={}",chkBOM);
			
			Map<String, Object> map = new HashMap<>();
			map.put("chkBOM", chkBOM);
			map.put("rQuantity", rQuantity);
			
			//bom존재하는지 확인
			List<Map<String, String>> lMap = productionService.checkBOMExist(chkBOM);
			//loger.info("lMap@Controller={}",lMap);
			
			
			//값존재시 true 사용가능, 값없을시 false 사용불가
			boolean isUsable = lMap.size()==0?false:true;
			map.put("isUsable", isUsable);
			
			List<Map<String, String>> list = productionService.quantityCheck(map);
			//loger.info("list@Controller={}",list);
			
			//Map<String, String> isUsableMap = new HashMap<>();
			//isUsableMap.put("isUsable", String.valueOf(isUsable));
			
			//loger.info("isUsable@Controller={}",isUsable);
			//lMap.add(isUsableMap);
			
			//loger.info("lMap@Controller={}",lMap);
			
			mav.addObject("isUsable",isUsable);
			mav.addObject("list",list);
			mav.setViewName("jsonView");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("BOM 존재 유무 확인 오류");
		}
		return mav;
		
	}
	
	@RequestMapping(value="/production/addWarehousing.do", method=RequestMethod.POST)
	@ResponseBody
	public Object addWarehousing(@RequestParam(value="pLotNos[]", required=false) List<String> pLotNoList,
								 @RequestParam(value="pReleasings[]", required=false) List<String> pReleasingList,
								 @RequestParam(value="rProduct", required=false) String rProduct,
								 @RequestParam(value="rQuantity", required=false) String rQuantity,
								 @RequestParam(value="rCode", required=false) String rCode,
							 	 ModelAndView mav) {
		try {
			//loger.info("pLotNoList@Controller={}",pLotNoList);
			//loger.info("pReleasingList@Controller={}",pReleasingList);
			//loger.info("rProduct@Controller={}",rProduct);
			//loger.info("rQuantity@Controller={}",rQuantity);
			//loger.info("rQuantity@Controller={}",rCode);
			
			
			//receiving, release update/insert
			for(int i = 0 ; i < pLotNoList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				String pLotNo = pLotNoList.get(i);
				String pReleasing = pReleasingList.get(i);
				map.put("pLotNo", pLotNo);
				map.put("pReleasing", pReleasing);
				
				int result = productionService.addWarehousing(map);
				int result2 = productionService.updateReceivingForWarehousing(map);
			}
			
			Map<String, String> product = productionService.selectOneProductByPlNo(rCode);
			//loger.info("product@Conteroller={}",product);
			
			int bomNo = productionService.selectOneBOMNoByPlNo(rCode);
			//loger.info("bomNo@Conteroller={}",bomNo);
			
			String vendorNo = String.valueOf(product.get("VENDOR_NO"));
			String ptNo = String.valueOf(product.get("PT_NO"));
			String vendorType = String.valueOf(product.get("VENDOR_TYPE"));
			String productName = product.get("PRODUCT_NAME");
			
			Map<String, String> pMap = new HashMap<>();
			pMap.put("rCode", rCode);
			pMap.put("bomNo", Integer.toString(bomNo));
			pMap.put("vendorNo", vendorNo);
			pMap.put("ptNo", ptNo);
			pMap.put("vendorType", vendorType);
			pMap.put("productName", productName);
			pMap.put("rQuantity", rQuantity);
			
			int pResult = productionService.insertProduction(pMap);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("생산입고 등록 오류");
		}

		List<String> list = new ArrayList<>();
		list.add("성공");
		return list;
	}
	
	
	
}
