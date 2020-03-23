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

<%-- table start --%>
<div class="card shadow mb-4">
<div class="card-header py-3">
  <h6 class="m-0 font-weight-bold text-primary">생산입고</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTableBOMList" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>로트번호</th>
          <th>입고창고명</th>
          <th>품목구분</th>
          <th>품목명</th>
          <th>수량</th>
          <th>입고날짜</th>
          <th>작업지시서</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${receivingList}" var="r" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${r.LOT_NO}</a></td>
	          <td>${r.STORE_NAME}</td>
	          <td>${r.TYPE}</td>
	          <td>${r.RM_NAME}</td>
	          <td>${r.QUANTITY}</td>
	          <td>${r.REC_DATE}</td>
	          <td><button class="btn btn-primary BOMAddBtn" type="button">작업지시서 보기</button></td>
	        </tr>
        </c:forEach>
    </tbody>
</table>
</div>
</div>
</div>

<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-success openBtn" data-toggle="modal" data-target="#addWarehosing-Modal">입고 등록</button>

<!-- 입고 등록 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="addWarehosing-Modal">
    <div class="modal-dialog modal-lg" id="resizeModal" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/production/addWarehousing.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">입고 등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="rawMaterial">원재료번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="rawMaterialDetail" name="rawMaterialDetail" class="form-control bg-light small" placeholder="원재료번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <button class="btn btn-primary searchBtn" type="button" value="rawMaterialDetail">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="ptNo">관리번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="ptNo" name="ptNo" class="form-control bg-light small" placeholder="관리번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
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
					     <label for="storeNo">창고번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="storeNo" name="storeNo" class="form-control bg-light small" placeholder="창고번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <button class="btn btn-primary searchBtn" type="button" value="storeNo">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="quantity">입고수량</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="quantity" name="quantity" class="form-control bg-light small" placeholder="입고수량" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
						<label for="regDate">입고일</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="date" id="regDate" name="regDate"
							class="form-control bg-light small" placeholder="입고일"
							aria-label="Search" aria-describedby="basic-addon2" step="0.01"
							style="width: 175px">
					</div>
				</div>
				<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
			      	추가정보 입력
			    </button>
			    <br />
			    <br />
				<div class="collapse" id="collapseExample">
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for=quailityYN>부적합여부</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							 <select class="custom-select" name='quailityYN'>
								  <option selected value="N">N</option>
								  <option value="Y">Y</option>
							 </select>
						</div>
					</div>
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for="insectionYN">검사여부</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							 <select class="custom-select" name='insectionYN'>
								  <option selected value="N">N</option>
								  <option value="Y">Y</option>
							 </select>
						</div>
					</div>
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for="measurement">측정값</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						     <input type="number" id="measurement" name="measurement" class="form-control bg-light small" placeholder="측정값" aria-label="Search" aria-describedby="basic-addon2" value="0" step="0.1" >
						     <input type="hidden" id="rmName" name="rmName" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
						</div>
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

<!-- 입고 등록 수정 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="updateWarehousing">
    <div class="modal-dialog modal-lg" id="resizeModal" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/production/updateWarehousing.do"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">입고 등록 수정</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="rawMaterial">원재료번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="rawMaterialDetail" name="rawMaterialDetail" class="form-control bg-light small" placeholder="원재료번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <button class="btn btn-primary searchBtn" type="button" value="rawMaterialDetail">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="ptNo">관리번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="ptNo" name="ptNo" class="form-control bg-light small" placeholder="관리번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
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
					     <label for="storeNo">창고번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="storeNo" name="storeNo" class="form-control bg-light small" placeholder="창고번호" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <button class="btn btn-primary searchBtn" type="button" value="storeNo">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="quantity">입고수량</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="quantity" name="quantity" class="form-control bg-light small" placeholder="입고수량" aria-label="Search" aria-describedby="basic-addon2">
					</div>
				</div>
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
						<label for="regDate">입고일</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="date" id="regDate" name="regDate"
							class="form-control bg-light small" placeholder="입고일"
							aria-label="Search" aria-describedby="basic-addon2" step="0.01"
							style="width: 175px">
					</div>
				</div>
				<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
			      	추가정보 입력
			    </button>
			    <br />
			    <br />
				<div class="collapse" id="collapseExample">
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for=quailityYN>부적합여부</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							 <select class="custom-select" name='quailityYN' id="quailityYN">
								  <option selected value="N">N</option>
								  <option value="Y">Y</option>
							 </select>
						</div>
					</div>
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for="insectionYN">검사여부</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							 <select class="custom-select" name='insectionYN' id="insectionYN">
								  <option selected value="N">N</option>
								  <option value="Y">Y</option>
							 </select>
						</div>
					</div>
					<div class="form-row">
						<div class="col-lg-20 mb-3 rowResize">
						     <label for="measurement">측정값</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						     <input type="number" id="measurement" name="measurement" class="form-control bg-light small" placeholder="측정값" aria-label="Search" aria-describedby="basic-addon2" value="0" step="0.1" >
						     <input type="hidden" id="lotNo" name="lotNo" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
						</div>
					</div>
				</div>
      </div>
        </div>
        <div class="modal-footer">
        	<button type="submit" id="FrmBtn" class="btn btn-primary" onclick="return storageAddValidate();">저장</button>
        	<button type="button" class="btn btn-secondary" id="delBtn">삭제</button>
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
    width: 100%;
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
.form-row{
    display: inline-block;
    width: 100%;
}
.rowResize{
	width: 100%;
}
.custom-select{
	width: 60%;
}
</style>
<script>
<%--onload start--%>
$(()=>{
	
	$(".searchBtn").click(function(){
    	var title = $(this).siblings().html();
    	$("#searchModalTitle").html(title);
    	var searchType = $(this).val();
    	//console.log(searchType);
    	 $('.searchModalBody').load("${pageContext.request.contextPath}/enrollment/searchSpecify.do?searchType="+searchType,function(){
 	        $('#mySearchModal').modal({backdrop: 'static', keyboard: false});
 	        $('#mySearchModal').modal({show:true});
 	        $(".modal-backdrop.in").css('opacity', 0.4);
 	        $("#mySearchModal #valForSearch").val("update");
 		});
            
    });
	
	//search modal close
	$(".searchModal-end").click(function(){
    	$('#mySearchModal').modal("hide");
    });
	
	<%--a태그 클릭시 정보수정 Modal 활성화--%>
	$(".getTr td a").click(function(){ 	
	
		// 현재 클릭된 Row(<tr>)
		var tr = $(this).parent().parent();
		var td = tr.children();
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var tdLotNo = td.eq(0).text();
		//console.log(tdLotNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/production/selectWarehousingByLotNo.do",
			data: {tdLotNo : tdLotNo},
			dataType: "json",
		 	async: false,
			contentType:"application/json;charset=UTF-8",
			success: data => {
				//console.log(data);
				$('#updateWarehousing #rawMaterialDetail').val(data.RM_NO);
				$('#updateWarehousing #ptNo').val(data.PT_NO);
				$('#updateWarehousing #vendorType').val(data.VENDOR_TYPE);
				$('#updateWarehousing #storeNo').val(data.STORE_NO);
				$('#updateWarehousing #quantity').val(data.QUANTITY);
				if(data.QUALITY_YN == "N"){
					$("#quailityYN").val("N").prop("selected", true);
				}
				if(data.QUALITY_YN == "Y"){
					$("#quailityYN").val("Y").prop("selected", true);
				}
				if(data.INSECTION_YN == "N"){
					$("#insectionYN").val("N").prop("selected", true);
				}
				if(data.INSECTION_YN == "Y"){
					$("#insectionYN").val("Y").prop("selected", true);
				}
				$('#updateWarehousing #measurement').val(data.MEASUREMENT);
				$('#updateWarehousing #lotNo').val(data.LOT_NO);
				$('#updateWarehousing #regDate').val(data.nDate);
				
				
			},
			error : (jqxhr, textStatus, errorThrown)=>{
				//console.log(jqxhr, textStatus, errorThrown);
			}
		});
		
		
		$('#updateWarehousing').modal('show');
	});
	
	//삭제버튼클릭
	$("#delBtn").on("click",function(){
		if(!confirm("정말 삭제하시겠습니까?"))
			return;
	
		var rmNo = $("#updateWarehousing #rawMaterialDetail").val();
		//console.log(rmNo);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/production/deleteWarehousingByRmNo.do",
			data: {rmNo : rmNo},
		 	async: false,
			contentType:"application/json;charset=UTF-8",
			success: data => {
				$('#productAddModal').modal("hide");
				location.reload();
			},
			error : (x,s,e) =>{
				//console.log("ajax요청 실패!!", x, s, e);
			}
		})
	});
})
<%--onload end--%>

</script>








<!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>