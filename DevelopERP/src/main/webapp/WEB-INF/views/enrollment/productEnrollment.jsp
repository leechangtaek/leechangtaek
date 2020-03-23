<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- Custom styles for this page -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


<!-- table start -->
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">품목등록 리스트</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>품목코드</th>
          <th>품목명</th>
          <th>거래처 등록번호</th>
          <th>관리번호</th>
          <th>입고단가</th>
          <th>출고단가</th>
          <th>구매소요일</th>
          <th>규격</th>
          <th>공차</th>
          <th>품목구분</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${productList}" var="p" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${p.PL_NO}</a></td>
	          <td>${p.PRODUCT_NAME}</td>
	          <td>${p.VENDOR_NO}</td>
	          <td>${p.PT_NO}</td>
	          <td>${p.INPRICE}</td>
	          <td>${p.OUTPRICE}</td>
	          <td>${p.DELIVERY}</td>
	          <td>${p.SPEC}</td>
	          <td>${p.TOL}</td>
	          <td>${p.PT_TYPE}</td>
	        </tr>
        </c:forEach>
      </tbody>
</table>
</div>
</div>
</div>

<!-- Trigger the modal with a button -->
<button class="btn btn-primary" type="button" id="addProductBtn">품목 등록</button>

<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="productAddModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <br />
        <div class="form-row" id="ptTypeRadioBtns">
   			<!-- Group of material radios - option 1 -->
   			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   			<label class="form-check-label" for="materialGroupExample2">품목구분</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div class="form-check">
			  <input type="radio" class="form-check-input" id="materialGroupExample1" name="groupOfMaterialRadios" value="3" checked>
			  <label class="form-check-label" for="materialGroupExample1">완제품</label>&nbsp;&nbsp;&nbsp;
			</div>
			
			<!-- Group of material radios - option 2 -->
			<!-- <div class="form-check">
			  <input type="radio" class="form-check-input" id="materialGroupExample2" name="groupOfMaterialRadios" value="2">
			  <label class="form-check-label" for="materialGroupExample2">반제품</label>&nbsp;&nbsp;&nbsp;
			</div> -->
			
			<!-- Group of material radios - option 3 -->
			<div class="form-check">
			  <input type="radio" class="form-check-input" id="materialGroupExample3" name="groupOfMaterialRadios" value="1">
			  <label class="form-check-label" for="materialGroupExample3">원재료</label>
			</div>
		</div>
        <div class="modal-body controll-modal-body2">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        </div>
    </div>
</div>


<script>
<%--onload start--%>
$(()=>{
	
	<%--품목코드 a태그 클릭시 정보수정 Modal 활성화--%>
	$(".getTr td a").click(function(){ 	

		// 현재 클릭된 Row(<tr>)
		var tr = $(this).parent().parent();
		var td = tr.children();
		//console.log(tr)
		//console.log(td)
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var tdProductNo = td.eq(0).text();
		var tdProductName = td.eq(1).text();
		var tdAccountNo = td.eq(2).text();
		var tdPtNo = td.eq(3).text();
		var tdInPrice = td.eq(4).text();
		var tdOutPrice = td.eq(5).text();
		var tdDelivery = td.eq(6).text();
		var tdSpec = td.eq(7).text();
		var tdTol = td.eq(8).text();
		var tdPtType = td.eq(9).text();
		
		if(tdPtType == '원재료'){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/updateRawMeterialForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("원재료 수정");
		        $('#ptTypeRadioBtns').hide();
		        $("#productNo").val(tdProductNo);
		        $("#accountNo").val(tdAccountNo);
		        $("#ptNo").val(tdPtNo);
		        $("#productName").val(tdProductName);
		        $("#delivery").val(tdDelivery);
		        $("#inPrice").val(tdInPrice);
		        $("#outPrice").val(tdOutPrice);
		        $("#spec").val(tdSpec);
		        $("#tol").val(tdTol);
		        $("#productNoCur").val(tdProductNo);
		        
		    });
		}
		/* else if(tdPtType == '반제품'){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/updateSemiProductForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("반제품 수정");
		        $('#ptTypeRadioBtns').hide();
		        $("#productNo").val(tdProductNo);
		        $("#accountNo").val(tdAccountNo);
		        $("#ptNo").val(tdPtNo);
		        $("#productName").val(tdProductName);
		        //$("#delivery").val(tdDelivery);
		        $("#inPrice").val(tdInPrice);
		        $("#outPrice").val(tdOutPrice);
		        $("#spec").val(tdSpec);
		        $("#tol").val(tdTol);
		        $("#productNoCur").val(tdProductNo);
		    });
		} */
		else if(tdPtType == '완제품'){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/updateProductForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("완제품 수정");
		        $('#ptTypeRadioBtns').hide();
		        $("#productNo").val(tdProductNo);
		        $("#accountNo").val(tdAccountNo);
		        $("#ptNo").val(tdPtNo);
		        $("#productName").val(tdProductName);
		        //$("#delivery").val(tdDelivery);
		        $("#inPrice").val(tdInPrice);
		        $("#outPrice").val(tdOutPrice);
		        $("#spec").val(tdSpec);
		        $("#tol").val(tdTol);
		        $("#productNoCur").val(tdProductNo);
		    });
		}
		/* $('#updateVendor #vendorNo2').val(tdVendorNo);
		$('#updateVendor #vendorName2').val(tdVendorName);
		$('#updateVendor #incharge2').val(tdIncharge);
		$('#updateVendor #vendorPhone2').val(tdVendorPhone);
		$('#updateVendorNo #vendorCur').val(tdVendorNo);
		
		$('#updateVendor').modal('show'); */
	});
	
})
<%--onload end--%>

$("#addProductBtn").click(function(){
	var radioVal = $('input[name="groupOfMaterialRadios"]:checked').val();
	
	$("input[name=groupOfMaterialRadios]").change(function() {
		var radioValue = $(this).val();
		//console.log(radioValue);
		
		if(radioValue == 1){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addRawMeterialForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("원재료 등록");
		        $('#ptTypeRadioBtns').show();
		    });
		}
/* 		else if(radioValue == 2){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addSemiProductForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("반제품 등록");
		        $('#ptTypeRadioBtns').show();
		    });
		} */
		else if(radioValue == 3){
			$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addProductForm.do",function(){
		        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
		        $('#productAddModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		        
		        $(".controll-title").html("");
		        $(".controll-title").html("완제품 등록");
		        $('#ptTypeRadioBtns').show();
		    });
		}
		
	})
	
	if(radioVal == 1){
		$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addRawMeterialForm.do",function(){
	        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
	        $('#productAddModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        
	        $(".controll-title").html("");
	        $(".controll-title").html("원재료 등록");
	        $('#ptTypeRadioBtns').show();
	    });
	}
/* 	else if(radioVal == 2){
		$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addSemiProductForm.do",function(){
	        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
	        $('#productAddModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        
	        $(".controll-title").html("");
	        $(".controll-title").html("반제품 등록");
	        $('#ptTypeRadioBtns').show();
	    });
	} */
	else if(radioVal == 3){
		$('.controll-modal-body2').load("${pageContext.request.contextPath}/enrollment/addProductForm.do",function(){
	        $('#productAddModal').modal({backdrop: 'static', keyboard: false});
	        $('#productAddModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        
	        $(".controll-title").html("");
	        $(".controll-title").html("완제품 등록");
	        $('#ptTypeRadioBtns').show();
	    });
	}
	
    
});

</script>


<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>