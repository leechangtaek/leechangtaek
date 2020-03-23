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

<style>
#search-container {
    width: 200%;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
.btn-primary{
    background-color:#777;
    border-color: #777;

}.btn-primary:hover{
    background-color:#777;
    border-color: #777;
}
#FrmBtn{
    float:right;
}

@media (min-width: 576px){
	.modal-dialog {
	    max-width: 1000px!important;
	    margin: 1.75rem auto;
	}
}
.modal-content{
    width: 610px;
    margin: 0 auto;
}
.table-responsive{
	overflow: hidden;
}
#vendorCur{
	width: 270px;
}
#vendorNoCha{
	width: 270px;
}
</style>
<script>

<%--onload function--%>
$(()=>{
	
	<%--거래처등록 중복검사후 값변경시 valid 0--%>
	$("#vendorNo").change(function(){
		$("#vendorNoValid").val(0);
	});
	
	<%--거래처번호 업데이트 중복검사후 값변경시 valid 0--%>
	$("#vendorNoCha").change(function(){
		$("#vendorNoUpdateValid").val(0);
	});
	
	<%--입력 모달 창 close시 값 초기화--%>
	$('#addVendor-Modal').on('hidden.bs.modal', function (e) {
	    //console.log('modal close');
	  $(this).find('form')[0].reset();
	  $("#vendorNoValid").val(0);
	  $("#vendorNo").removeAttr('style');
	});
	
	<%--수정 모달 창 close시 값 초기화--%>
	$('#updateVendor').on('hidden.bs.modal', function (e) {
	    //console.log('modal close');
	  $(this).find('form')[0].reset();
	});
	
	<%--거래처번호 수정 모달 창 close시 값 초기화--%>
	$('#updateVendorNo').on('hidden.bs.modal', function (e) {
	    //console.log('modal close');
	  $("#vendorNoUpdateValid").val(0);
	  $(this).find('form')[0].reset();
 	  $("#vendorNoCha").removeAttr('style');
	});
	
	<%--거래처번호 a태그 클릭시 정보수정 Modal 활성화--%>
	$(".getTr td a").click(function(){ 	

		// 현재 클릭된 Row(<tr>)
		var tr = $(this).parent().parent();
		var td = tr.children();
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var tdVendorNo = td.eq(0).text();
		var tdVendorName = td.eq(1).text();
		var tdIncharge = td.eq(2).text();
		var tdVendorPhone = td.eq(3).text();
		var tdVendorTypes = td.eq(4).text();
		$('#updateVendor #vendorNo2').val(tdVendorNo);
		$('#updateVendor #vendorName2').val(tdVendorName);
		$('#updateVendor #incharge2').val(tdIncharge);
		$('#updateVendor #vendorPhone2').val(tdVendorPhone);
		$('#updateVendor #vendorCur').val(tdVendorNo);
		$('#updateVendorNo #vendorCur').val(tdVendorNo);
		$('#updateVendor #vendorTypess').val(tdVendorTypes);
		
		$('#updateVendor').modal('show');
	});
	
	//search button
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
	
	//search form close
	$(".searchModal-end").click(function(){
    	$('#mySearchModal').modal("hide");
    });
	
	$("#delBtn").on("click",function(){
		if(!confirm("정말 삭제하시겠습니까?"))
			return;
	
		var vendorNo = $("#vendorNo2").val();
		//console.log(vendorNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/enrollment/deleteVendorByVendorNo.do",
			data: {vendorNo : vendorNo},
		 	async: false,
			contentType:"application/json;charset=UTF-8",
			success: data => {
				$('#updateVendor').modal("hide");
				location.reload();
			},
			error : (x,s,e) =>{
				//console.log("ajax요청 실패!!", x, s, e);
			}
		})
	});
	
	$("#addVendor-Modal #vendorTypes").change(function() {
		var ckData = $(this).val();
		//console.log("data=???",ckData);
		$.ajax({
			url: "${pageContext.request.contextPath}/enrollment/checkDataAvailable",
			data: {ckData : ckData},
			async: false,
			contentType: "application/json;charset=UTF-8",
			success: data => {
				//console.log(data.isUsable);
				if(data.isUsable == false){
					$(this).val("");
					alert("존재하지 않는 거래처코드입니다. 다시 확인해주세요.");
				}
				else{
				}
				
			},
			error: (x,s,e) => {
				//console.log("ajax요청 실패!!", x, s, e);
			}
		})
	});
	
	
}); //end of onload
	

<%--거래처번호 등록용 유효성검사--%>
function vendorValidate(){
	var regExpNumber = /[^0-9]/g;
	var $vendorNoValid = $("#vendorNoValid");
	
    //거래처 번호
	var $vendorNo = $("#vendorNo");
	if($vendorNo.val().trim().length == 0){
        alert("거래처 번호를 입력하세요.");
        $vendorNo.focus();
		return false;
	}
    //거래처명
	var $vendorName = $("#vendorName");
	if($vendorName.val().trim().length == 0){
        alert("거래처명을 입력하세요.");
        $vendorName.focus();
		return false;
	}
    //incharge
	var $incharge = $("#incharge");
	if($incharge.val().trim().length == 0){
        alert("담당자명을 입력하세요.");
        $incharge.focus();
		return false;
	}
	//거래처 전화번호
	var $vendorPhone = $("#vendorPhone");
	if($vendorPhone.val().trim().length == 0){
        alert("거래처 전화번호를 입력하세요.");
        $vendorPhone.focus();
		return false;
    }
    <%--거래처번호 중복검사를 하지않았을경우--%>
	if($vendorNoValid.val() == 0){
		alert("거래처번호 중복 검사를 해주세요.");
		return false;
	}
	
	return true;
}
	
<%-- 거래처등록 중복검사 ajax--%>
function vendorNoDuplicatedCheck(e){
	var vendorNo = e;
	//console.log(vendorNo);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/enrollment/vendorNoDuplicatedCheck.do",
		data: {vendorNo : vendorNo},
		dataType: "json",
	 	async: false,
		contentType:"application/json;charset=UTF-8",
		success: data => {
			//console.log(data);
			if(data.isUsable == true && data.vendorNo != ""){
				alert("사용가능한 거래처번호 입니다.");
				$("#vendorNo").attr("style","border-bottom: 2px solid #00c500");
				$("#vendorNoCha").attr("style","border-bottom: 2px solid #00c500");
				$("#vendorNoValid").val(1);
				$("#vendorNoUpdateValid").val(1);
			}
			if((data.isUsable == true || data.isUsable == false) && data.vendorNo == ""){
				alert("중복확인할 거래처번호를 입력해 주세요.");
				$("#vendorNo").val("");
				$("#vendorNoCha").val("");
				$("#vendorNo").attr("style","border-bottom: 2px solid red");
				$("#vendorNoCha").attr("style","border-bottom: 2px solid red");
				$("#vendorNoValid").val(0);
				$("#vendorNoUpdateValid").val(0);
			}
			else if(data.isUsable == false){
				alert("중복된 거래처번호 입니다.");
				$("#vendorNo").val("");
				$("#vendorNoCha").val("");
				$("#vendorNo").attr("style","border-bottom: 2px solid red");
				$("#vendorNoCha").attr("style","border-bottom: 2px solid red");
				$("#vendorNoValid").val(0);
				$("#vendorNoUpdateValid").val(0);
				
			}
			
		},
		error : (jqxhr, textStatus, errorThrown)=>{
			//console.log(jqxhr, textStatus, errorThrown);
		}
	});
}

<%--거래처번호 수정용 유효성검사--%>
function vendorValidate2(){
	var regExpNumber = /[^0-9]/g;
	//var $vendorNoValid = $("#vendorNoValid");
	
    //거래처 번호
	var $vendorNo = $("#vendorNo2");
	if($vendorNo.val().trim().length == 0){
        alert("거래처 번호를 입력하세요.");
        $vendorNo.focus();
		return false;
	}
    //거래처명
	var $vendorName = $("#vendorName2");
	if($vendorName.val().trim().length == 0){
        alert("거래처명을 입력하세요.");
        $vendorName.focus();
		return false;
	}
    //incharge
	var $incharge = $("#incharge2");
	if($incharge.val().trim().length == 0){
        alert("담당자명을 입력하세요.");
        $incharge.focus();
		return false;
	}
	//거래처 전화번호
	var $vendorPhone = $("#vendorPhone2");
	if($vendorPhone.val().trim().length == 0){
        alert("거래처 전화번호를 입력하세요.");
        $vendorPhone.focus();
		return false;
    }
	return true;
}

function vendorNoUpdateValidate(){
	var result = confirm('거래처번호를 변경하시겠습니까?');
	
	if(result){
		if($("#vendorNoUpdateValid").val() == 0){
			alert("거래처번호 중복확인을 해주세요.");
			return false;
		}
		else{
			return true;
		}
	}
	else{
		return false;
	}
	
	return false;
}

function vendorNoUpdateValidate2(){
	var formData = $('#vendorNoUpdateFrm').serialize();
	//console.log(formData);
	//console.log($('#vendorNoCha').val());
	
	$.ajax({
        cache : false,
        url : "${pageContext.request.contextPath}/enrollment/updateVendorNo2.do",
        processData: false,
        type : 'POST', 
        data : formData,
        success : function(data) {
        	$('#updateVendor #vendorNo2').val($('#vendorNoCha').val());
        	
        	$('#updateVendorNo').modal('hide');
        },
        error : function(x,h,r, status) {
            alert(x,h,r + " : " + status);
        }
    }); // $.ajax */
}



</script>

<!-- table start -->
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">거래처 목록</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>거래처 번호</th>
          <th>거래처명</th>
          <th>담당자명</th>
          <th>거래처 전화번호</th>
          <th>거래처 분류</th>
        </tr>
      </thead>
      <tbody>
      	<c:forEach items="${vendorList}" var="v" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${v.VENDOR_NO}</a></td>
	          <td>${v.VENDOR_NAME}</td>
	          <td>${v.INCHARGE}</td>
	          <td>${v.VENDOR_PHONE}</td>
	          <td>${v.VENDOR_TYPE}</td>
	        </tr>
        </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>





<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-success openBtn" data-toggle="modal" data-target="#addVendor-Modal">거래처 등록</button>

<!-- 거래처등록 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="addVendor-Modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/enrollment/addVendor.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">거래처 등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="userId">거래처번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="vendorNo" name="vendorNo" class="form-control bg-light small" placeholder="거래처번호" aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary" type="button" onclick="vendorNoDuplicatedCheck($('#vendorNo').val());">중복확인</button>
                        <input type="hidden" id="vendorNoValid" value="0"/>
                    </div>
                </div>
                <div class="form-row">
	               <div class="col-md-6 mb-3">
	                   <label for="vendor">거래처명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <input type="text" id="vendorName" name="vendorName" class="form-control bg-light small" placeholder="거래처명" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="productName">담당자명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="incharge" name="incharge" class="form-control bg-light small" placeholder="담당자명" aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div>
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                    <label for="rmName">거래처 전화번호</label>&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="vendorPhone" name="vendorPhone" class="form-control bg-lightsmall" placeholder="거래처 전화번호" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                    <label for="vendorType">거래처 분류</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="number" id="vendorTypes" name="vendorTypes" class="form-control bg-lightsmall" placeholder="거래처 분류" aria-label="Search" aria-describedby="basic-addon2">
	                	<button class="btn btn-primary searchBtn" type="button" value="vendorTypes">
						<i class="fas fa-search fa-sm"></i>
						</button>
	                </div>
                </div>
                
      </div>
        </div>
        <div class="modal-footer">
        	<button type="submit" id="FrmBtn" class="btn btn-primary" onclick="return vendorValidate();">저장</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
        </div>
    </div>
</div>


<!-- 거래처수정 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="updateVendor">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/enrollment/updateVendor.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">거래처 수정</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="userId">거래처번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="vendorNo2" name="vendorNo" class="form-control bg-light small" placeholder="거래처번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
                        <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#updateVendorNo">변경</button>
                    </div>
                </div>
                <div class="form-row">
	               <div class="col-md-6 mb-3">
	                   <label for="vendorName">거래처명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <input type="text" id="vendorName2" name="vendorName" class="form-control bg-light small" placeholder="거래처명" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="incharge">담당자명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="incharge2" name="incharge" class="form-control bg-light small" placeholder="담당자명" aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div>
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                    <label for="vendorPhone">거래처 전화번호</label>&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="vendorPhone2" name="vendorPhone" class="form-control bg-lightsmall" placeholder="거래처 전화번호" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                    <label for="vendorTypess">거래처 분류</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="number" id="vendorTypess" name="vendorTypess" class="form-control bg-lightsmall" placeholder="거래처 분류" aria-label="Search" aria-describedby="basic-addon2">
	                	<button class="btn btn-primary searchBtn" type="button" value="vendorTypes">
						<i class="fas fa-search fa-sm"></i>
						</button>
	                </div>
                </div>
                
      </div>
        </div>
        <div class="modal-footer">
        	<button type="submit" id="FrmBtn2" class="btn btn-primary" onclick="return vendorValidate2();">수정</button>
        	<button type="button" class="btn btn-secondary" id="delBtn">삭제</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
        </div>
    </div>
</div>


<!-- 거래처번호(vendorNo) 수정(update) Modal -->
<div class="modal" tabindex="-1" role="dialog" id="updateVendorNo">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <form id="vendorNoUpdateFrm" class="needs-validation"
         <%-- action="${pageContext.request.contextPath}/enrollment/updateVendorNo.do" --%>
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">거래처번호 수정</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="vendorNoCur">현재 거래처번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="vendorCur" name="vendorNoCur" value="" class="form-control bg-light small" placeholder="거래처번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="vendorNoCha">변경할 거래처번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="vendorNoCha" name="vendorNoCha" class="form-control bg-light small" placeholder="거래처번호" aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary" type="button" onclick="vendorNoDuplicatedCheck($('#vendorNoCha').val());">중복확인</button>
                        <input type="hidden" id="vendorNoUpdateValid" value="0"/>
                    </div>
                </div>
      </div>
        </div>
        <div class="modal-footer">
        	<!-- <button type="submit" id="FrmBtn3" class="btn btn-primary" onclick="return vendorNoUpdateValidate();">변경</button> -->
        	<button type="button" id="FrmBtn3" class="btn btn-primary" onclick="vendorNoUpdateValidate2(); return false;">변경</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
        </div>
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

  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>