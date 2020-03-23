package com.dev.erp.enrollment.controller;

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
import com.dev.erp.enrollment.model.service.EnrollmentService;

@Controller
public class EnrollmentController {

	static final Logger logger = LoggerFactory.getLogger(EnrollmentController.class);
	
	@Autowired
	EnrollmentService enrollmentservice;
	
	//===============================거래처등록 start===============================
	@RequestMapping("/enrollment/vendorEnrollment.do")
	public ModelAndView selectVendorList(ModelAndView mav) {
		try {
			List<Map<String, String>> vendorList = enrollmentservice.selectVendorList();
			
			//loger.info("vendorList@Controller={}", vendorList);
			
			mav.addObject("vendorList", vendorList);
			mav.setViewName("enrollment/vendorEnrollment");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 페이지를 불러올수 없습니다.");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/addVendor.do")
	public ModelAndView insertVendor(@RequestParam String vendorNo,
										 @RequestParam String vendorName,
										 @RequestParam String incharge,
										 @RequestParam String vendorPhone,
										 @RequestParam String vendorTypes,
										 ModelAndView mav) {
		
		try {
			//loger.info("vendorName@Controller={}",vendorName);
			
			Map<String, String> vendor = new HashMap<>();
			vendor.put("vendorNo", vendorNo);
			vendor.put("vendorName", vendorName);
			vendor.put("incharge", incharge);
			vendor.put("vendorPhone", vendorPhone);
			vendor.put("vendorTypes", vendorTypes);
			vendor.put("regDate", null);
			
			//loger.info("vendor@controller={}",vendor);
			
			int result = enrollmentservice.insertVendor(vendor); 
			
			mav.addObject("vendor", vendor);
			mav.setViewName("redirect:/enrollment/vendorEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 등록 오류. 관리자에게 문의하세요");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/deleteVendorByVendorNo.do")
	public ModelAndView deleteVendorByVendorNo(@RequestParam("vendorNo") String vendorNo,
										 ModelAndView mav) {
		try {
			//loger.info("vendorNo@Controller={}",vendorNo);
			
			int result = enrollmentservice.deleteVendorByVendorNo(vendorNo); 
			//loger.info("result@controller={}",result);
			
			mav.addObject("vendorNo",vendorNo);
			mav.setViewName("redirect:/enrollment/vendorEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 삭제 오류");
		}
		return mav;
	}
	
	
	@RequestMapping("/enrollment/vendorNoDuplicatedCheck.do")
	@ResponseBody
	public Map<String, Object> vendorNoDuplicatedCheck(@RequestParam("vendorNo") String vendorNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			//loger.info("vendorNo@Controller={}",vendorNo);
			
			map.put("vendorNo", vendorNo);
			
			boolean isUsable = enrollmentservice.selectOneVendorNo(vendorNo)==null?true:false;
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처번호 중복확인 오류");
		}
		return map;
	}
	
	@RequestMapping("/enrollment/updateVendor.do")
	public ModelAndView updateVendor(@RequestParam("vendorNo") String vendorNo,
									 @RequestParam("vendorName") String vendorName,
							 		 @RequestParam("incharge") String incharge,
						 		 	 @RequestParam("vendorPhone") String vendorPhone,
						 		 	 @RequestParam("vendorTypess") String vendorTypes,
										 ModelAndView mav) {
		
		try {
			//loger.info("vendorName@Controller={}",vendorName);
			
			Map<String, String> vendor = new HashMap<>();
			vendor.put("vendorNo", vendorNo);
			vendor.put("vendorName", vendorName);
			vendor.put("incharge", incharge);
			vendor.put("vendorPhone", vendorPhone);
			vendor.put("vendorTypes", vendorTypes);
			vendor.put("regDate", null);
			
			//loger.info("vendor@controller={}",vendor);
			
			int result = enrollmentservice.updateVendor(vendor); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/vendorEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 수정오류");
		}
		return mav;
	}
	
	
	@RequestMapping("/enrollment/updateVendorNo.do")
	public ModelAndView updateVendorNo(@RequestParam String vendorNoCur,
										 @RequestParam String vendorNoCha,
										 ModelAndView mav) {
		try {
			//loger.info("vendorNoCur@Controller={}",vendorNoCur);
			//loger.info("vendorNoCha@Controller={}",vendorNoCha);
			
			Map<String, String> vendorNo = new HashMap<>();
			vendorNo.put("vendorNoCur", vendorNoCur);
			vendorNo.put("vendorNoCha", vendorNoCha);
			
			//loger.info("vendor@controller={}",vendorNo);
			
			int result = enrollmentservice.updateVendorNo(vendorNo); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/vendorEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 수정 오류");
		}
			
		return mav;
	}
	
	@RequestMapping("/enrollment/updateVendorNo2.do")
	public ModelAndView updateVendorNo2(@RequestParam String vendorNoCur,
										 @RequestParam String vendorNoCha,
										 ModelAndView mav) {
		try {
			//loger.info("vendorNoCur@Controller={}",vendorNoCur);
			//loger.info("vendorNoCha@Controller={}",vendorNoCha);
			
			Map<String, String> vendorNo = new HashMap<>();
			vendorNo.put("vendorNoCur", vendorNoCur);
			vendorNo.put("vendorNoCha", vendorNoCha);
			
			//loger.info("vendor@controller={}",vendorNo);
			
			int result = enrollmentservice.updateVendorNo(vendorNo); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/vendorEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 수정오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/checkDataAvailable")
	@ResponseBody
	public Map<String, Object> checkDataAvailable(@RequestParam("ckData") String ckData,
										   ModelAndView mav) {
		Map<String, Object> map = new HashMap<>();
		try {
			//loger.info("ckData!!!!!!!!!!!!!!!!!!!={}",ckData);
			boolean isUsable = enrollmentservice.checkDataAvailable(ckData)==null?false:true;
			
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("페이지 오류. 관리자에게 문의하세요");
		}
		return map;
	}
	
	
	//===============================거래처등록 end===============================
	
	
	
	//===============================창고등록 start===============================
	@RequestMapping("/enrollment/warehouseEnrollment.do")
	public ModelAndView storageEnrollment(ModelAndView mav) {
		try {
			List<Map<String, String>> storageList = enrollmentservice.selectStorageList();
			
			//loger.info("warehouseList@Controller={}", storageList);
			
			mav.addObject("storageList", storageList);
			mav.setViewName("enrollment/warehouseEnrollment");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("창고등록 페이지를 불러올수 없습니다. 관리자에게 문의하세요.");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/addStorage.do")
	public ModelAndView insertStorage(@RequestParam String storageNo,
										 @RequestParam String storageName,
										 ModelAndView mav) {
		try {
			Map<String, String> storage = new HashMap<>();
			storage.put("storageNo", storageNo);
			storage.put("storageName", storageName);
			storage.put("regDate", null);
			
			//loger.info("storage@controller={}",storage);
			
			int result = enrollmentservice.insertStorage(storage); 
			
			mav.addObject("storage", storage);
			mav.setViewName("redirect:/enrollment/warehouseEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("창고등록 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/storageNoDuplicatedCheck.do")
	@ResponseBody
	public Map<String, Object> storageNoDuplicatedCheck(@RequestParam("storageNo") String storageNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			//loger.info("storageNo@Controller={}",storageNo);
			map.put("storageNo", storageNo);
			
			boolean isUsable = enrollmentservice.selectOneStorageNo(storageNo)==null?true:false;
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("창고 중복검사 오류");
		}
		return map;
	}
	
	@RequestMapping("/enrollment/updateStorage.do")
	public ModelAndView updateStorage(@RequestParam("storageNo") String storageNo,
									 @RequestParam("storageName") String storageName,
										 ModelAndView mav) {
		try {
			Map<String, String> storage = new HashMap<>();
			storage.put("storageNo", storageNo);
			storage.put("storageName", storageName);
			
			//loger.info("storage@controller={}",storage);
			
			int result = enrollmentservice.updateStorage(storage); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/warehouseEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("창고 수정오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/deleteStorageByStNo.do")
	public ModelAndView deleteStorageByStNo(@RequestParam("stNo") String stNo,
										 ModelAndView mav) {
		try {
			////loger.info("stNo@Controller={}",stNo);
			int result = enrollmentservice.deleteStorageByStNo(stNo); 
			////loger.info("result@controller={}",result);
			
			mav.addObject("stNo",stNo);
			mav.setViewName("redirect:/enrollment/warehouseEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("창고 삭제 오류");
		}
		return mav;
	}
	//===============================창고등록 end===============================
	
	
	
	//===============================품목등록 start===============================
	
	@RequestMapping("/enrollment/productEnrollment.do")
	public ModelAndView productEnrollment(ModelAndView mav) {
		
		try {
			List<Map<String, String>> productList = enrollmentservice.selectproductList();
			
			//loger.info("vendorList@Controller={}", productList);
			
			mav.addObject("productList", productList);
			mav.setViewName("enrollment/productEnrollment");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목등록 페이지를 불러올수 없습니다. 관리자에게 문의하세요.");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/insertProduct.do")
	public ModelAndView insertProduct(@RequestParam String productNo,
										 @RequestParam String accountNo,
										 @RequestParam String productName,
										 @RequestParam String inPrice,
										 @RequestParam String outPrice,
										 @RequestParam String spec,
										 @RequestParam String tol,
										 @RequestParam String vendorTypeCode,
										 ModelAndView mav) {
		
		try {
			Map<String, String> product = new HashMap<>();
			product.put("productNo", productNo);
			product.put("accountNo", accountNo);
			product.put("productName", productName);
			product.put("inPrice", inPrice);
			product.put("outPrice", outPrice);
			product.put("spec", spec);
			product.put("tol", tol);
			product.put("vendorTypeCode", vendorTypeCode);
			product.put("regDate", null);
			
			//loger.info("product@controller={}",product);
			
			int result = enrollmentservice.insertProduct(product); 
			
			mav.addObject("product", product);
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목등록 오류");
		}	
		return mav;
	}
	
	@RequestMapping("/enrollment/deleteProductByProductNo.do")
	public ModelAndView deleteProductByProductNo(@RequestParam("productNo") String productNo,
										 ModelAndView mav) {
		try {
			//loger.info("productNo@Controller={}",productNo);
			
			int result = enrollmentservice.deleteProductByProductNo(productNo); 
			
			//loger.info("result@controller={}",result);
			
			mav.addObject("productNo",productNo);
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목 삭제 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/deleteRawmaterialByRmNo.do")
	public ModelAndView deleteRawmaterialByRmNo(@RequestParam("rmNo") String rmNo,
										 ModelAndView mav) {
		try {
			//loger.info("rmNo@Controller={}",rmNo);
			
			int result = enrollmentservice.deleteRawmaterialByRmNo(rmNo); 
			
			//loger.info("result@controller={}",result);
			
			mav.addObject("result",result);
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목 삭제 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/productNoDuplicatedCheck.do")
	@ResponseBody
	public Map<String, Object> productNoDuplicatedCheck(@RequestParam("productNo") String productNo) {
		
		Map<String, Object> map = new HashMap<>();
		try {
			////loger.info("productNo@Controller={}",productNo);
			map.put("productNo", productNo);
			
			boolean isUsable = enrollmentservice.selectOneProductNo(productNo)==null?true:false;
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("중복 확인 오류");
		}
		return map;
	}
	
	@RequestMapping("/enrollment/searchSpecify.do")
	public ModelAndView searchSpecify(ModelAndView mav, @RequestParam("searchType") String searchType, @RequestParam(value="thisCode", defaultValue="0") String thisCode) {
		try {
			//loger.info("thisCode@controller={}",String.valueOf(thisCode));
			mav.addObject("searchType",searchType);
			mav.addObject("thisCode",thisCode);
			mav.setViewName("enrollment/searchSpecify");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("해당 페이지가 존재하지 않습니다.");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/searchSpecifyPage.do")
	@ResponseBody
	public Map<String,Object> searchSpecify(@RequestParam("searchType") String searchType,
											@RequestParam(defaultValue="1") int cPage,
											@RequestParam(value="thisCode", defaultValue="0") String thisCode,
											HttpServletResponse rexsponse) {
		////loger.info("searchType@controller={}",searchType);
		////loger.info("thisCode@controller={}",String.valueOf(thisCode));
		List<Map<String,String>> list = new ArrayList<>();
		final int numPerPage = 5;
		int totalContents = 0;
		switch(searchType) {
		case "accountNo" : 
			list = enrollmentservice.selectAccountAll(cPage,numPerPage);  
			totalContents = enrollmentservice.selectAllCountByAccountNo(); 
			break;
		case "ptNo" :  
			list =  enrollmentservice.selectProductTypeAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllCountByProductNo();
			break;
		case "rawMaterial" :  
			list =  enrollmentservice.selectRawmaterialAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllRawmaterial();
			break;
		case "vendorTypes" :  
			list =  enrollmentservice.selectVendorTypeAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllVendorType();
			break;
		case "rawMaterialDetail" :  
			list =  enrollmentservice.selectrawMaterialDetailAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllrawMaterialDetail();
			break;
		case "storeNo" :  
			list =  enrollmentservice.selectStoreNoAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllStoreNo();
			break;
		case "showJobOrder" :  
			list =  enrollmentservice.selectJobOrderAll(cPage,numPerPage); 
			totalContents = enrollmentservice.selectAllJobOrder();
			break;
		case "receivingLotNo" :  
			list =  enrollmentservice.selectReceivingLotNoAll(cPage,numPerPage,thisCode);
			//loger.info("list@Controller={}",list);
			totalContents = enrollmentservice.selectAllReceivingLotNo(thisCode);
			break;
		}
		String url = "searchSpecifyPage.do?searchType="+searchType;
		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
		
		Map<String,Object> map = new HashMap<>();
		map.put("numPerPage",numPerPage);
		map.put("cPage",cPage);
		map.put("totalContents",totalContents);
		map.put("searchType",searchType);
		map.put("speclist",list);
		map.put("pageBar", pageBar);
		return map;
	}
	
	//Form 연결
	@RequestMapping("/enrollment/addProductForm.do")
	public ModelAndView addProductForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/addProductForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목 등록 페이지 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/addSemiProductForm.do")
	public ModelAndView addSemiProductForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/addSemiProductForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("반제품 등록 페이지 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/addRawMeterialForm.do")
	public ModelAndView addRawMeterialForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/addRawMeterialForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("원재료 등록 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateRawMeterialForm.do")
	public ModelAndView updateRawMeterialForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/updateRawMeterialForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("원재료 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateSemiProductForm.do")
	public ModelAndView updateSemiProductForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/updateSemiProductForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("반제품 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateProductForm.do")
	public ModelAndView updateProductForm(ModelAndView mav) {
		try {
			mav.setViewName("enrollment/updateProductForm");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("제품 수정 오류");
		}
		return mav;
	}
	
	//Form연결 끝
	
	@RequestMapping("/enrollment/productNoDuplicatedCheckForRawMaterial.do")
	@ResponseBody
	public Map<String, Object> productNoDuplicatedCheckForRawMaterial(@RequestParam("productNo") String productNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			//loger.info("productNo@Controller={}",productNo);
			map.put("productNo", productNo);
			
			boolean isUsable = enrollmentservice.selectOneProductNoForRawMaterial(productNo)==null?true:false;
			map.put("isUsable", isUsable);
			
			//loger.info("isUsable@Controller={}",isUsable);
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("품목 번호 중복 체크 오류");
		}
		return map;
	}
	
	@RequestMapping("/enrollment/insertRawMaterial.do")
	public ModelAndView insertRawMaterial(@RequestParam String productNo,
										 @RequestParam String accountNo,
										 @RequestParam String delivery,
										 @RequestParam String productName,
										 @RequestParam String inPrice,
										 @RequestParam String outPrice,
										 @RequestParam String spec,
										 @RequestParam String tol,
										 @RequestParam String vendorTypeCode,
										 ModelAndView mav) {
		try {
			Map<String, String> rawMaterial = new HashMap<>();
			rawMaterial.put("productNo", productNo);
			rawMaterial.put("accountNo", accountNo);
			rawMaterial.put("delivery", delivery);
			rawMaterial.put("productName", productName);
			rawMaterial.put("inPrice", inPrice);
			rawMaterial.put("outPrice", outPrice);
			rawMaterial.put("spec", spec);
			rawMaterial.put("tol", tol);
			rawMaterial.put("vendorTypeCode", vendorTypeCode);
			rawMaterial.put("regDate", null);
			
			//loger.info("rawMaterial@controller={}",rawMaterial);
			
			int result = enrollmentservice.insertRawMaterial(rawMaterial); 
			
			mav.addObject("rawMaterial", rawMaterial);
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("원재료 등록 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateProductNo.do")
	public ModelAndView updateProductNo(@RequestParam String productNoCur,
										 @RequestParam String productNoCha,
										 ModelAndView mav) {
		try {
			//loger.info("productNoCur@Controller={}",productNoCur);
			//loger.info("productNoCha@Controller={}",productNoCha);
			
			Map<String, String> productNo = new HashMap<>();
			productNo.put("productNoCur", productNoCur);
			productNo.put("productNoCha", productNoCha);
			
			//loger.info("productNo@controller={}",productNo);
			
			int result = enrollmentservice.updateProductNo(productNo); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("제품 수정 오류");
		}
		return mav;
	}

	@RequestMapping("/enrollment/updateRawMaterial.do")
	public ModelAndView updateRawMaterial(@RequestParam("productNo") String productNo,
									 @RequestParam("accountNo") String accountNo,
							 		 @RequestParam("ptNo") String ptNo,
						 		 	 @RequestParam("delivery") String delivery,
						 		 	 @RequestParam("productName") String productName,
						 		 	 @RequestParam("inPrice") String inPrice,
						 		 	 @RequestParam("outPrice") String outPrice,
						 		 	 @RequestParam("spec") String spec,
						 		 	 @RequestParam("tol") String tol,
										 ModelAndView mav) {
		try {
			Map<String, String> rawMaterial = new HashMap<>();
			rawMaterial.put("productNo", productNo);
			rawMaterial.put("accountNo", accountNo);
			rawMaterial.put("ptNo", ptNo);
			rawMaterial.put("delivery", delivery);
			rawMaterial.put("productName", productName);
			rawMaterial.put("inPrice", inPrice);
			rawMaterial.put("outPrice", outPrice);
			rawMaterial.put("spec", spec);
			rawMaterial.put("tol", tol);
			
			//loger.info("rawMaterial@controller={}",rawMaterial);
			
			int result = enrollmentservice.updateRawMaterial(rawMaterial); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("원재료 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateProduct.do")
	public ModelAndView updateProduct(@RequestParam("productNo") String productNo,
									 @RequestParam("accountNo") String accountNo,
						 		 	 @RequestParam("productName") String productName,
						 		 	 @RequestParam("inPrice") String inPrice,
						 		 	 @RequestParam("outPrice") String outPrice,
						 		 	 @RequestParam("spec") String spec,
						 		 	 @RequestParam("tol") String tol,
										 ModelAndView mav) {
		try {
			Map<String, String> product = new HashMap<>();
			product.put("productNo", productNo);
			product.put("accountNo", accountNo);
			product.put("productName", productName);
			product.put("inPrice", inPrice);
			product.put("outPrice", outPrice);
			product.put("spec", spec);
			product.put("tol", tol);
			
			//loger.info("product@controller={}",product);
			
			int result = enrollmentservice.updateProduct(product); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("제품 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateRawMeterial.do")
	public ModelAndView updateRawMeterial(@RequestParam("productNo") String productNo,
									 @RequestParam("accountNo") String accountNo,
						 		 	 @RequestParam("productName") String productName,
						 		 	 @RequestParam("inPrice") String inPrice,
						 		 	 @RequestParam("outPrice") String outPrice,
						 		 	 @RequestParam("spec") String spec,
						 		 	 @RequestParam("tol") String tol,
						 		 	 @RequestParam("delivery") String delivery,
										 ModelAndView mav) {
		try {
			Map<String, String> product = new HashMap<>();
			product.put("productNo", productNo);
			product.put("accountNo", accountNo);
			product.put("productName", productName);
			product.put("inPrice", inPrice);
			product.put("outPrice", outPrice);
			product.put("spec", spec);
			product.put("tol", tol);
			product.put("delivery", delivery);
			
			//loger.info("product@controller={}",product);
			
			int result = enrollmentservice.updateRawMeterial(product); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("제품 수정 오류");
		}
		return mav;
	}
	
	@RequestMapping("/enrollment/updateProductNoForProductList.do")
	public ModelAndView updateProductNoForProductList(@RequestParam String productNoCur,
										 @RequestParam String productNoCha,
										 ModelAndView mav) {
		try {
			//loger.info("productNoCur@Controller={}",productNoCur);
			//loger.info("productNoCha@Controller={}",productNoCha);
			
			Map<String, String> productNo = new HashMap<>();
			productNo.put("productNoCur", productNoCur);
			productNo.put("productNoCha", productNoCha);
			
			//loger.info("productNo@controller={}",productNo);
			
			int result = enrollmentservice.updateProductNoForProductList(productNo); 
			
			//loger.info("result@Controller={}",result);
			
			mav.setViewName("redirect:/enrollment/productEnrollment.do");
		} catch(Exception e) {
			//loger.error(e.getMessage(), e);
			throw new MyException("거래처 번호 수정 오류");
		}
		return mav;
	}
	
	
	//===============================품목등록 end===============================	
	
}
