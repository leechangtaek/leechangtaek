<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- Custom styles for this page -->
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
</head>
<body>
      <!-- search-container start -->
      <div id="search-container">
          <form class="needs-validation"
           action="${pageContext.request.contextPath}/enrollment/insertProduct.do"
           method="POST">
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="productNo">품목코드 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 					     <input type="number" id="productNo" name="productNo" class="form-control bg-light small" placeholder="품목코드" aria-label="Search" aria-describedby="basic-addon2">
					     <button class="btn btn-primary" type="button" onclick="productNoDuplicatedCheck($('#productNo').val());">중복확인</button>
					     <input type="hidden" id="productNoValid" value="0"/>
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="accountNo">거래처등록번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="accountNo" name="accountNo" class="form-control bg-light small" placeholder="거래처등록번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <button class="btn btn-primary searchBtn" type="button" value="accountNo">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="vendorTypeCode">거래처구분코드</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="vendorType" name="vendorTypeCode" class="form-control bg-light small" placeholder="거래처구분코드" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="productName">품목명</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="text" id="productName" name="productName" class="form-control bg-light small" placeholder="품목명" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="inPrice">입고단가</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="inPrice" name="inPrice" class="form-control bg-light small" placeholder="입고단가" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="outPrice">출고단가</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="outPrice" name="outPrice" class="form-control bg-light small" placeholder="출고단가" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="spec">기준치</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="spec" name="spec" class="form-control bg-light small" placeholder="규격" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="tol">공차</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="tol" name="tol" class="form-control bg-light small" placeholder="공차" aria-label="Search" aria-describedby="basic-addon2" step="0.01">
					</div>
				</div>
				<hr class="hrSize"/>
            	<div class="form-row col-lg-20 col-lg-push-9 btns">
	              <button type="submit" id="FrmBtn" class="btn btn-primary addProduct-submit" onclick="return addProductValidate();">등록</button> 
	              <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                </div>
             </form>
           </div>
      </div>
      
<%--Search modal --%>
<div class="modal" tabindex="-1" role="dialog" id="mySearchModal">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
      <div class="modal-header">
          <h5 class="modal-title search-title" id="searchModalTitle"> </h5>
      </div>
      <div class="modal-body searchModalBody">
          <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-primary searchModal-end">끝</button>
      </div>
      </div>
  </div>
</div>




<style>
.modal-body{
 height: 541px;
}
.searchModalBody{
 height: 500px;
}
#searchModal {
  width: 60%;
  height: 150px;
}
#search-container {
    width: 130%;
    height: 150px;
}
.modal-content{
	width:550px;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display: inline;
    width: 40%;
}
#search-container .btn-primary{
    background-color:#777;
    border-color: #777;

}
#search-container .btn-primary:hover{
    background-color:#777;
    border-color: #777;
}
#search-container #FrmBtn{
    float:right;
    margin-right: 5px;
}
#mySearchModal {
	z-index:1080;
}
.btns{
	padding-left: 389px;
}
.rowResize{
	width: 100%;
}
.hrSize{
    width: 549px;
    padding: 0;
    margin-left: -17px;
}
</style>
<script>    

<%--onload start--%>
$(()=>{
	<%--품목코드 중복검사후 값변경시 valid 0--%>
	$("#productNo").change(function(){
		$("#productNoValid").val(0);
	});
	
	$(".searchBtn").click(function(){
    	var title = $(this).siblings().html();
    	$("#searchModalTitle").html(title);
    	var searchType = $(this).val();
    	//console.log(searchType);
    	 $('.searchModalBody').load("${pageContext.request.contextPath}/enrollment/searchSpecify.do?searchType="+searchType,function(){
 	        $('#mySearchModal').modal({backdrop: 'static', keyboard: false});
 	        $('#mySearchModal').modal({show:true});
 	        $(".modal-backdrop.in").css('opacity', 0.4);
 		});
    });
	
	$(".searchModal-end").click(function(){
    	$('#mySearchModal').modal("hide");
    });
	
	
})
<%--onload end--%>


$(function() {
    //폼닫기
    $(".search-end-button").click(function(){
    	$('#productAddModal').modal("hide");
    });
});
  

  <%-- 품목코드 중복검사 ajax--%>
  function productNoDuplicatedCheck(e){
  	var productNo = e;
  	//console.log(productNo);
  	
  	$.ajax({
  		url: "${pageContext.request.contextPath}/enrollment/productNoDuplicatedCheck.do",
  		data: {productNo : productNo},
  		dataType: "json",
  	 	async: false,
  		contentType:"application/json;charset=UTF-8",
  		success: data => {
  			//console.log(data);
  			if(data.isUsable == true && data.productNo != ""){
  				alert("사용가능한 품목코드 입니다.");
  				$("#productNo").attr("style","border-bottom: 2px solid #00c500");
  				$("#productNoValid").val(1);
  			} 
  			if((data.isUsable == true || data.isUsable == false) && data.productNo == ""){
  				alert("중복확인할 품목코드를 입력해 주세요.");
  				$("#productNo").val("");
  				$("#productNo").attr("style","border-bottom: 2px solid red");
  				$("#productNoValid").val(0);
  			} 
  			else if(data.isUsable == false){
  				alert("중복된 품목코드 입니다.");
  				$("#productNo").val("");
  				$("#productNo").attr("style","border-bottom: 2px solid red");
  				$("#productNoValid").val(0);
  			}
  			
  		},
  		error : (jqxhr, textStatus, errorThrown)=>{
  			/* console.log(jqxhr, textStatus, errorThrown); */
  		}
  	});
  }
  
  
  <%--완제품 등록 유효성검사--%>
function addProductValidate(){
  	var regExpNumber = /[^0-9]/g;
  	var $productNoValid = $("#productNoValid");
  	
      //품목코드
  	var $productNo = $("#productNo");
  	if($productNo.val().trim().length == 0){
          alert("품목코드를 입력하세요.");
          $productNo.focus();
  		return false;
  	}
      //거래처등록번호
	var $accountNo = $("#accountNo");
  	if($accountNo.val().trim().length == 0){
          alert("거래처 등록번호를 입력하세요.");
          $accountNo.focus();
  		return false;
  	}
      //관리번호
  	var $ptNo = $("#ptNo");
  	if($ptNo.val().trim().length == 0){
          alert("관리번호를 입력하세요.");
          $ptNo.focus();
  		return false;
  	}
  	//품목명
  	var $productName = $("#productName");
  	if($productName.val().trim().length == 0){
          alert("품목명을 입력하세요.");
          $productName.focus();
  		return false;
      }
  	//입고단가
  	var $inPrice = $("#inPrice");
  	if($inPrice.val().trim().length == 0){
          alert("입고단가를 입력하세요.");
          $inPrice.focus();
  		return false;
      }  
  	//출고단가
  	var $outPrice = $("#outPrice");
  	if($outPrice.val().trim().length == 0){
          alert("출고단가를 입력하세요.");
          $outPrice.focus();
  		return false;
      }
 	//기준치
  	var $spec = $("#spec");
  	if($spec.val().trim().length == 0){
          alert("기준치를 입력하세요.");
          $spec.focus();
  		return false;
      }
  	//공차
  	var $tol = $("#tol");
  	if($tol.val().trim().length == 0){
          alert("공차를 입력하세요.");
          $tol.focus();
  		return false;
      }
  	
    <%--품목코드 중복검사를 하지않았을경우--%>
  	if($productNoValid.val() == 0){
  		alert("품목코드 중복 검사를 해주세요.");
  		return false;
  	}
  	
  	return true;
  }  
  
  
  
</script>
</body>
</html>