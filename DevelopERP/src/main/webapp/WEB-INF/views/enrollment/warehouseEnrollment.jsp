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
.form-control {
    display:inline;
    width: 60%;
}
#resizeModal{
	width: 610px;
}
.modal-content{
    margin: 0 auto;
}
#search-container {
    width: 200%;
}
#resizeModalContent{
	margin: 0 auto;
    width: 350px;
}
#resizeModal2{
	width: 310px;
}
#resizeModalBody{
	width: 360px;
    height: 130px;
}
</style>
<script>

<%--onload start--%>
$(()=>{
	
	<%--입력 모달 창 close시 값 초기화--%>
	$('#addStorage-Modal').on('hidden.bs.modal', function (e) {
	    //console.log('modal close');
	  $(this).find('form')[0].reset()
	  $("#storageNoValid").val(0);
	  $("#storageNo").removeAttr('style');
	});
	
	<%--창고 번호 a태그 클릭시 정보수정 Modal 활성화--%>
	$(".getTr td a").click(function(){ 	

		// 현재 클릭된 Row(<tr>)
		var tr = $(this).parent().parent();
		var td = tr.children();
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var tdStorageNo = td.eq(0).text();
		var tdStorageName = td.eq(1).text();
		$('#updateStorage-Modal #storageNo2').val(tdStorageNo);
		$('#updateStorage-Modal #storageName2').val(tdStorageName);
		
		$('#updateStorage-Modal').modal('show');
	});
	
	$("#delBtn").on("click",function(){
		if(!confirm("정말 삭제하시겠습니까?"))
			return;
	
		var stNo = $("#storageNo2").val();
		//console.log(stNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/enrollment/deleteStorageByStNo.do",
			data: {stNo : stNo},
		 	async: false,
			contentType:"application/json;charset=UTF-8",
			success: data => {
				$('#updateStorage-Modal').modal("hide");
				location.reload();
			},
			error : (x,s,e) =>{
				//console.log("ajax요청 실패!!", x, s, e);
			}
		})
	});
	
});


<%--창고 등록 유효성검사--%>
function storageAddValidate(){
	var regExpNumber = /[^0-9]/g;
	var $storageNoValid = $("#storageNoValid");
	
    //창고번호
	var $storageNo = $("#storageNo");
	if($storageNo.val().trim().length == 0){
        alert("창고번호를 입력하세요.");
        $storageNo.focus();
		return false;
	}
    //창고명
	var $storageName = $("#storageName");
	if($storageName.val().trim().length == 0){
        alert("창고명을 입력하세요.");
        $storageName.focus();
		return false;
	}
    if(regExpNumber.test($storageNo.val())){
        alert("창고번호는 숫자만 입력가능합니다.");
        $storageNo.val('');
        $storageNo.focus();
		return false;
    }
    
    <%--거래처번호 중복검사를 하지않았을경우--%>
	if($storageNoValid.val() == 0){
		alert("창고번호 중복 검사를 해주세요.");
		return false;
	}
	
	return true;
}

<%-- 창고등록 중복검사 ajax--%>
function storageNoDuplicatedCheck(e){
	var storageNo = e;
	//console.log(storageNo);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/enrollment/storageNoDuplicatedCheck.do",
		data: {storageNo : storageNo},
		dataType: "json",
	 	async: false,
		contentType:"application/json;charset=UTF-8",
		success: data => {
			//console.log(data);
			if(data.isUsable == true && data.storageNo != ""){
				alert("사용가능한 창고번호 입니다.");
				$("#storageNo").attr("style","border-bottom: 2px solid #00c500");
				$("#storageNoValid").val(1);
			} 
			if((data.isUsable == true || data.isUsable == false) && data.storageNo == ""){
				alert("중복확인할 창고번호를 입력해 주세요.");
				$("#storageNo").val("");
				$("#storageNo").attr("style","border-bottom: 2px solid red");
				$("#storageNoValid").val(0);
			} 
			else if(data.isUsable == false){
				alert("중복된 창고번호 입니다.");
				$("#storageNo").val("");
				$("#storageNo").attr("style","border-bottom: 2px solid red");
				$("#storageNoValid").val(0);
			}
			
		},
		error : (jqxhr, textStatus, errorThrown)=>{
			//console.log(jqxhr, textStatus, errorThrown);
		}
	});
}


<%--창고 수정 유효성검사--%>
function storageUpdateValidate(){
	var regExpNumber = /[^0-9]/g;
	
    //창고번호
	var $storageNo2 = $("#storageNo2");
	if($storageNo2.val().trim().length == 0){
        alert("창고번호를 입력하세요.");
        $storageNo2.focus();
		return false;
	}
    //창고명
	var $storageName2 = $("#storageName2");
	if($storageName2.val().trim().length == 0){
        alert("창고명을 입력하세요.");
        $storageName2.focus();
		return false;
	}
    if(regExpNumber.test($storageNo2.val())){
        alert("창고번호는 숫자만 입력가능합니다.");
        $storageNo2.val('');
        $storageNo2.focus();
		return false;
    }
    
	return true;
}

</script>
<!-- table start -->
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">창고 목록</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>창고 번호</th>
          <th>창고명</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${storageList}" var="s" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${s.STORE_NO}</a></td>
	          <td>${s.STORE_NAME}</td>
	        </tr>
        </c:forEach>
      </tbody>
</table>
</div>
</div>
</div>

<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-success openBtn" data-toggle="modal" data-target="#addStorage-Modal">창고 등록</button>

<!-- 창고등록 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="addStorage-Modal">
    <div class="modal-dialog modal-lg" id="resizeModal" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/enrollment/addStorage.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">창고 등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storageNo">창고번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="storageNo" name="storageNo" class="form-control bg-light small" placeholder="창고번호" aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary" type="button" onclick="storageNoDuplicatedCheck($('#storageNo').val());">중복확인</button>
                        <input type="hidden" id="storageNoValid" value="0"/>
                    </div>
                </div>
                <div class="form-row">
	               <div class="col-md-6 mb-3">
	                   <label for="storageName">창고명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <input type="text" id="storageName" name="storageName" class="form-control bg-light small" placeholder="창고명" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
      </div>
        </div>
        <div class="modal-footer">
        	<button type="submit" id="FrmBtn" class="btn btn-primary" onclick="return storageAddValidate();">저장</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
        </div>
    </div>
</div>


<!-- 창고수정 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="updateStorage-Modal">
    <div class="modal-dialog modal-sm" id="resizeModal2" role="document">
        <div class="modal-content" id="resizeModalContent">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/enrollment/updateStorage.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">창고 수정</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" id="resizeModalBody">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storageNo">창고번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="storageNo2" name="storageNo" class="form-control bg-light small" placeholder="창고번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
                    </div>
                </div>
                <div class="form-row">
	               <div class="col-md-6 mb-3">
	                   <label for="storageName">창고명 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <input type="text" id="storageName2" name="storageName" class="form-control bg-light small" placeholder="창고명" aria-label="Search" aria-describedby="basic-addon2">
	                </div>
                </div>
      </div>
        </div>
        <div class="modal-footer">
        	<button type="submit" id="FrmBtn2" class="btn btn-primary" onclick="return storageUpdateValidate();">수정</button>
        	<button type="button" class="btn btn-secondary" id="delBtn">삭제</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
        </div>
    </div>
</div>





<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>