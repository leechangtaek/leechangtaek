<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>신규 입고 등록하기</title>
</head>

<body>
	<!-- search-container start -->
	<div id="search-container">
		<form class="needs-validation"
			action="${pageContext.request.contextPath}/stock/rm/InsertRm.do"
			method="POST">

			<div class="form-row">
				<div class="col-lg-20 mb-3 rowResize">
					<label for="rmNo">원재료번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="number" id="rmNo" name="rmNo"
						class="form-control bg-light small" placeholder="원재료번호"
						aria-label="Search" aria-describedby="basic-addon2"
						readonly="readonly">
						
					<button class="btn btn-primary searchBtn" type="button"
						value="rmNo">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>

			<div class="form-row">
				<div class="col-lg-20 mb-3 rowResize">
					<label for="quantity">입고수량</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="number" id="quantity" name="quantity"
						class="form-control bg-light small" placeholder="입고수량"
						aria-label="Search" aria-describedby="basic-addon2">
				</div>
			</div>

			<div class="form-row">
				<div class="col-md-6 mb-3">
					<label for="recDate">입고일</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="date" id="recDate" name="recDate"
						class="form-control bg-light small" placeholder="입고일"
						aria-label="Search" aria-describedby="basic-addon2" step="0.01"
						style="width: 175px">
				</div>
			</div>

			<hr class="hrSize" />
			<div class="form-row col-lg-20 col-lg-push-9 btns">
				<button type="submit" id="FrmBtn"
					class="btn btn-primary addProduct-submit"
					onclick="return addProductValidate();">등록</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</form>
	</div>

	<%--Search modal --%>
	<div class="modal" tabindex="-1" role="dialog" id="mySearchModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title search-title" id="searchModalTitle"></h5>
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
	.modal-body {
		height: 300px;
	}
	
	.searchModalBody {
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
	
	.modal-content {
		width: 550px;
	}
	
	#formGroupExampleInput {
		width: 70%;
	}
	
	.form-control {
		display: inline;
		width: 40%;
	}
	
	#search-container .btn-primary {
		background-color: #777;
		border-color: #777;
	}
	
	#search-container .btn-primary:hover {
		background-color: #777;
		border-color: #777;
	}
	
	#search-container #FrmBtn {
		float: right;
		margin-right: 5px;
	}
	
	#mySearchModal {
		z-index: 1080;
	}
	
	.btns {
		padding-left: 389px;
	}
	
	.rowResize {
		width: 100%;
	}
	
	.hrSize {
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
	    	console.log(searchType);
	    	 $('.searchModalBody').load("${pageContext.request.contextPath}/stock/common/searchSpecify.do?searchType="+searchType,function(){
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
	  
	  
	//rmNo storeNo ptNo quantity recDate
	
	<%-- 신규 입고 등록 유효성검사--%>
	function addProductValidate(){
	  	var regExpNumber = /[^0-9]/g;
	  	var $productNoValid = $("#productNoValid");
	  	
	    // 원재료번호를 입력하세요
	  	var $rmNo = $("#rmNo");
	  	if($rmNo.val().trim().length == 0){
	          alert("원재료번호를 입력하세요.");
	          $rmNo.focus();
	  		return false;
	  	}
	  	// 입고수량을 입력하세요
	  	var $quantity = $("#quantity");
	  	if($quantity.val().trim().length == 0){
	          alert("입고수량을 입력하세요.");
	          $quantity.focus();
	  		return false;
	    }
	  	// 입고일을 입력하세요
	  	var $recDate = $("#recDate");
	  	if($recDate.val().trim().length == 0){
	          alert("입고일을 입력하세요.");
	          $recDate.focus();
	  		return false;
	    }
	  	
	  	return true;
	}  
</script>

</body>
</html>