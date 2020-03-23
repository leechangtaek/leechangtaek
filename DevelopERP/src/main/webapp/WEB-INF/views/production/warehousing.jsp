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
  <h6 class="m-0 font-weight-bold text-primary">생산입고</h6>
</div>
<div class="card-body">
  <div class="table-responsive">
    <table class="table table-bordered" id="dataTablep" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>로트번호</th>
          <th>제품명</th>
          <th>품목코드</th>
          <th>생산량</th>
          <th>생산일</th>
        </tr>
      </thead>
	  <tbody>
      	<c:forEach items="${productList}" var="p" varStatus="vs">
	        <tr class="getTr">
	          <td><a href="#" >${p.LOT_NO}</a></td>
	          <td>${p.PRODUCT_NAME}</td>
	          <td>${p.PL_NO}</td>
	          <td>${p.QUANTITY}</td>
	          <td>${p.PRODUCTION}</td>
	        </tr>
        </c:forEach>
      </tbody>
</table>
</div>
</div>
</div>


<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-success openBtn" data-toggle="modal" data-target="#addReleasing-Modal">생산불출 등록</button>

<!-- 생산불출 등록 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="addReleasing-Modal">
    <div class="modal-dialog modal-lg" id="resizeModal" role="document">
        <div class="modal-content">
        <form class="needs-validation"
         action="${pageContext.request.contextPath}/production/addReleasing"
         method="POST">
        <div class="modal-header">
            <h5 class="modal-title">생산불출 등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <!-- search-container start -->
      <div id="search-container">
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="showJobOrder">작업지시서 번호 조회</label>&nbsp;&nbsp;
					     <input type="text" id="showJobOrder" name="showJobOrder" class="form-control bg-light small" placeholder="" aria-label="Search" aria-describedby="basic-addon2">
					     <button class="btn btn-primary searchBtn" type="button" value="showJobOrder">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="rProduct">생산불출 품목</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="text" id="rProduct" name="rProduct" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					</div>
				</div>
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="rQuantity">불출수량</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="rQuantity" name="rQuantity" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					</div>
				</div>
                <div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="rCode">품목코드</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     <input type="number" id="rCode" name="rCode" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					</div>
				</div>
				<div class="col-lg-20 mb-3 rowResize">
					     <label for="searchBOM">BOM 검색</label>&nbsp;&nbsp;
					     <button class="btn btn-primary" id="BOMSrcBtn" type="button" value="showJobOrder">
						 <i class="fas fa-search fa-sm"></i>
						 </button>
					</div>
				</div>
				<!-- Editable table -->
				<div class="card">
				  <div class="card-body">
				    <div id="table" class="table-editable releasingAdd">
				      <span class="table-add float-right mb-3 mr-2"><a href="#!" class="text-success"><i
				            class="fas fa-plus fa-2x" aria-hidden="true"></i></a></span>
				      <table class="table table-bordered table-responsive-md table-striped text-center" id="edTable">
				        <thead>
				          <tr>
				            <th class="text-center">No</th>
				            <th class="text-center">품목코드</th>
				            <th class="text-center">품목명</th>
				            <th class="text-center">필요수량</th>
				            <th class="text-center">로트넘버</th>
				            <th class="text-center">보유수량</th>
				            <th class="text-center">불출수량</th>
				            <!-- <th class="text-center">Sort</th> -->
				            <th class="text-center">Remove</th>
				          </tr>
				        </thead>
				        <tbody class="releasingTbody">
				          <!-- <tr>
				            <td class="pt-3-half pNo" contenteditable="false"></td>
				            <td class="pt-3-half pCode tdPtCode" contenteditable="true"></td>
				            <td class="pt-3-half pName" contenteditable="false"></td>
				            <td class="pt-3-half pNeed" contenteditable="true"></td>
				            <td class="pt-3-half pLotNo" contenteditable="true"></td>
				            <td class="pt-3-half pReleasing" contenteditable="true"></td>
				            <td>
				              <span class="table-remove"><button type="button"
				                  class="btn btn-danger btn-rounded btn-sm my-0">Remove</button></span>
				            </td>
				          </tr> -->
				        </tbody>
				      </table>
				    </div>
				  </div>
				</div>
				<br />
				<!-- Editable table -->
      </div>
        <div class="modal-footer">
        	<button type="button" id="FrmBtn" class="btn btn-primary">저장</button>
            <button type="button" class="btn btn-secondary cloMdl" data-dismiss="modal">닫기</button>
        </div>
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


 <!-- 작업지시서 Modal -->
<div class="modal" tabindex="-1" role="dialog" id="joModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body jo-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
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
#mySearchModal .modal-content{
	width: 1040px;
}
#resizeModal .modal-content{
	width: 740px;
}
#edTable {
    counter-reset: rowNumber;
}
#edTable tr td:first-child::before {
	counter-increment: rowNumber;
    content: counter(rowNumber);
    min-width: 1em;
    margin-right: 0.5em;
}
#insert-container {
    width: 100%;
    height: 100%;
}
#enrollBtn{
	display: none;
}
.modal-body {
    height: 100%;
}
[name=orderContent]{
	width: 73%;
}
.jResize{
	max-width: 100%;
}
.searchSpec{
	float: inherit!important;
	display: none;
}
.ui-datepicker-trigger{
	display: none;
}
.modal{
	overflow: auto!important;
}
</style>
<script>
	var rArr = [];
<%--onload start--%>
$(()=>{
	
	$("#dataTablep").DataTable({
		// 3번째 항목을 오름 차순 
		// order : [ [ 열 번호, 정렬 순서 ], ... ]
		order: [ [ 4, "desc" ] ]
	});
	
	<%--입력 모달 창 close시 값 초기화--%>
	$('#addReleasing-Modal').on('hidden.bs.modal', function (e) {
	    //console.log('modal close');
	  $(this).find('form')[0].reset();
	  $(".releasingTbody tr").detach();
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
 	        $("#mySearchModal #valForSearch").val("update");
 		});
            
    });
	
	//search modal close
	$(".searchModal-end").click(function(){
    	$('#mySearchModal').modal("hide");
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
	
	$("#BOMSrcBtn").on("click", function(){
		var chkBOM = $("#rProduct").val().trim()
		var rQuantity = $("#rQuantity").val().trim()
		//console.log("chkBOM값은?",chkBOM);
		
		 $.ajax({
			url:"${pageContext.request.contextPath}/production/checkBOMExist",
			contentType:"application/json;charset=UTF-8",	
			dataType:"json",
			data:{chkBOM:chkBOM,
				  rQuantity:rQuantity},
			async: false,
			success: data => {
				//console.log(data.isUsable);
				if(data.isUsable == false){
					alert("BOM이 존재하지 않습니다. BOM을 등록해 주세요.");
					return false;
				}
				//console.log(data.list);
				Object.assign(rArr, data.list);
	            //console.log("rArr="+rArr[0].RM_NO);
	            //console.log(JSON.stringify(rArr));
				var context;
				$.each(data.list, (idx, elem)=>{
					var tr = "<tr>";
					tr += "<td class='pt-3-half pNo' contenteditable='false'></td>";
					tr += "<td class='pt-3-half pCode tdPtCode' contenteditable='true'>"+elem.RM_NO+"</td>";
					tr += "<td class='pt-3-half pName' contenteditable='false'>"+elem.RM_NAME+"</td>";
					tr += "<td class='pt-3-half pNeed' contenteditable='false'>"+elem.REQUIRED+"</td>";
					tr += "<td class='pt-3-half pLotNo' contenteditable='true'></td>";
					tr += "<td class='pt-3-half pQuantity' contenteditable='false'></td>";
					tr += "<td class='pt-3-half pReleasing' contenteditable='true'></td>";
					tr += "<td><span class='table-remove'><button type='button' class='btn btn-danger btn-rounded btn-sm my-0'>Remove</button></span></td></tr>";
					$(".releasingAdd .releasingTbody").prepend(tr);
					
				});
				
			},
			error : (x,s,e) =>{
				//console.log("ajax요청 실패!!", x, s, e);
			}
		})
	}); //end of ajax
	
	<%--editable table script--%>
	 const $tableID = $('#table');
	 const $BTN = $('#export-btn');
	 const $EXPORT = $('#export');
	
	 
	 const newTr = `
	<tr class="hide">
		 <td class='pt-3-half pNo' contenteditable='false'></td>
		 <td class='pt-3-half pCode tdPtCode' contenteditable='true'></td>
		 <td class='pt-3-half pName' contenteditable='false'></td>
		 <td class='pt-3-half pNeed' contenteditable='false'></td>
		 <td class='pt-3-half pLotNo' contenteditable='true'></td>
		 <td class='pt-3-half pQuantity' contenteditable='false'></td>
		 <td class='pt-3-half pReleasing' contenteditable='true'></td>
	  <td>
	    <span class="table-remove"><button type="button" class="btn btn-danger btn-rounded btn-sm my-0 waves-effect waves-light">Remove</button></span>
	  </td>
	</tr>`;

	 $('.table-add').on('click', 'i', () => {
		 
	   const $clone = $tableID.find('tbody tr').last().clone(true).removeClass('hide table-line');

	   $tableID.find('table tbody').append(newTr);
		
	 });

	 $tableID.on('click', '.table-remove', function () {
	   $(this).parents('tr').detach();
	   
	   var tds = $("#addReleasing-Modal .releasingTbody tr");
	   
	 	//console.log("tds length?",tds.length);
	 	
	 	if(tds.length == 0){
	 		 const $clone = $tableID.find('tbody tr').last().clone(true).removeClass('hide table-line');
		     $tableID.find('table tbody').append(newTr);
	 	}
	 });

	 $tableID.on('click', '.table-up', function () {

	   const $row = $(this).parents('tr');

	   if ($row.index() === 1) {
	     return;
	   }

	   $row.prev().before($row.get(0));
	 });

	 $tableID.on('click', '.table-down', function () {

	   const $row = $(this).parents('tr');
	   $row.next().after($row.get(0));
	 });

	 // A few jQuery helpers for exporting only
	 jQuery.fn.pop = [].pop;
	 jQuery.fn.shift = [].shift;

	 $BTN.on('click', () => {

	   const $rows = $tableID.find('tr:not(:hidden)');
	   const headers = [];
	   const data = [];

	   // Get the headers (add special header logic here)
	   $($rows.shift()).find('th:not(:empty)').each(function () {

	     headers.push($(this).text().toLowerCase());
	   });

	   // Turn all existing rows into a loopable array
	   $rows.each(function () {
	     const $td = $(this).find('td');
	     const h = {};

	     // Use the headers from earlier to name our hash keys
	     headers.forEach((header, i) => {

	       h[header] = $td.eq(i).text();
	     });

	     data.push(h);
	   });

	   // Output the result
	   $EXPORT.text(JSON.stringify(data));
	 });
	 <%--editable table script end--%>
	 
	  $("#FrmBtn").off("click").on('click', function() {
		   var tds = $("#edTable .pNo").nextAll();
			////console.log(tds);
			var exit= false;
			$(tds).each(function(){
				if($(this).text()==""){
					 exit = true;
					alert("값을 입력해 주세요.");
					$(this).focus();
					return false;
				}
				else{
					exit= false;
				}
			}) 
			if(exit){ return false;}
			
			var pLotNo = $(".pLotNo");
			var pLotNos = [];

			var pReleasing = $(".pReleasing");
			var pReleasings = [];
			
			var rProduct = $("#rProduct").val();
			var rQuantity = $("#rQuantity").val();
			var rCode = $("#rCode").val();
			
			for(var i=0;i<pLotNo.length;i++) {
				pLotNos.push(pLotNo.eq(i).text());
				pReleasings.push(pReleasing.eq(i).text());
			}
			var data_ = {"pLotNos":pLotNos,
						 "pReleasings":pReleasings,
						 "rProduct":rProduct,
						 "rQuantity":rQuantity,
						 "rCode":rCode
						 };
			//console.log(data_);
 		 	$.ajax({
		 		url: "${pageContext.request.contextPath}/production/addWarehousing.do",
		 		data: data_,
		 		async: false,
		 		type : 'POST', 
		 		//contentType : "application; charset=utf-8",
		 		dataType: "json",
		 		success: data => {
		 			//console.log(data);
		 			$('#addReleasing-Modal').modal("hide"); //닫기 
		 			location.reload();
		 		},
		 		error : (jqxhr, textStatus, errorThrown)=>{
		 			//console.log(jqxhr, textStatus, errorThrown);
		 		}
		 	}); // end of ajax */
		}) 
	
})
<%--onload end--%>

//품목코드 더블클릭시 searchType 모달 활성화
$(document).on('dblclick','.tdPtCode',function(){
	$("#searchModalTitle").html('품목코드 검색');
	var searchType = "rawMaterial";
	var clickedTd = $(this).parent().index();
	var trNum = $(this).closest('tr').prevAll().length;
	
	trNum += 1;
	
	//console.log("this", clickedTd);
	//console.log("trNum", trNum);
	//console.log("prevAll", $(this).closest('tr').prevAll());
	
	 $('.searchModalBody').load("${pageContext.request.contextPath}/enrollment/searchSpecify.do?searchType="+searchType,function(){
	        $('#mySearchModal').modal({backdrop: 'static', keyboard: false});
	        $('#mySearchModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $("#mySearchModal #trNum").val(trNum);
	 })
})

//품목코드 더블클릭시 searchType 모달 활성화
$(document).on('dblclick','.pLotNo',function(){
	$("#searchModalTitle").html('원재료 검색');
	var searchType = "receivingLotNo";
	var clickedTd = $(this).parent().index();
	var trNum = $(this).closest('tr').prevAll().length;
	var thisCode = $(this).parent().children().eq(1).text()+"";
	//console.log("thisCode="+thisCode);
	trNum += 1;
	
	//console.log("this", clickedTd);
	//console.log("trNum", trNum);
	//console.log("prevAll", $(this).closest('tr').prevAll());
	var url = "${pageContext.request.contextPath}/enrollment/searchSpecify.do?searchType="+searchType+"&thisCode="+thisCode;
	//console.log(url);
	 $('.searchModalBody').load(url,function(){
	        $('#mySearchModal').modal({backdrop: 'static', keyboard: false});
	        $('#mySearchModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $("#mySearchModal #trNum").val(trNum);
	        $("#mySearchModal #valForSearch").val("receivingLotNo");
	 })
})

//불출수량 입력시 keyup 이벤트, 조건 지정
$(document).on( 'keyup', '.pReleasing', function() {
	var thisObj = $(this);
	var thisHavingQuantity = $(this).parent().children().eq(5).text();
	var thisNeedQuantity = $(this).parent().children().eq(3);
	var thisTrPname = $(this).parent().children().eq(2).text();
	var thisTrReleasingQuantity = $(this).text();
	var thisTrReleasingQuantity2 = $(".releasingTbody tr .pName:contains('삼성 LED패널')").next().next().next().next().text();
	//console.log("thisNeedQuantity", thisNeedQuantity.text());
	//var sum = 0;
	/* for(var i=0;i<thisTrReleasingQuantity2.length;i++){
		sum += parseInt(thisTrReleasingQuantity2[i]);
		console.log("sum",sum);
	} */
	var trs = $(".releasingTbody tr .pName:contains('삼성 케이블')");
	/* console.log(thisTrPname);
	console.log("thisHavingQuantity="+thisHavingQuantity);
    console.log($(this).text());
    console.log(rArr);
    console.log(trs);
    console.log("thisTrReleasingQuantity2",thisTrReleasingQuantity2); */
    if(parseInt(thisTrReleasingQuantity) > parseInt(thisHavingQuantity)){
    	alert("불출수량이 보유수량보다 클 수 없습니다.");
		thisObj.text("");
    }
    
    for(var i=0; i<rArr.length; i++){
    	//console.log("Z");
	    $.each(rArr[i], function(key, value){
	    	if(key == "RM_NAME" && value == thisTrPname ){
	        	//console.log('key:' + key + ' / ' + 'value:' + parseInt(value-thisTrReleasingQuantity));
	        	//console.log('key2:' + key + ' / ' + 'value2:' + value);
	        	//console.log(rArr[i].REQUIRED-thisTrReleasingQuantity);
	        	var rmName = rArr[i].RM_NAME;
	        	//var cal = rArr[i].REQUIRED-thisTrReleasingQuantity;
	        	//console.log(rmName);
	        	//console.log("zz",$('.releasingTbody tr .pName:contains('+rmName+')').next().text(cal));
	        	//rArr[i].REQUIRED = parseInt(rArr[i].REQUIRED-thisTrReleasingQuantity);
	        	var sum = 0;
	        	var minus = $('.releasingTbody tr .pName:contains('+rmName+')').next().next().next().next();
	        	//console.log("minus",minus)
	        	for(var q=0;q<minus.length;q++){
	        		sum += parseInt(minus[q].innerText);
	        		//console.log("sum",sum);
	        		if(isNaN(sum)){
		        		sum = 0;
		        	}
	        	}
	        	if(isNaN(sum)){
	        		sum = 0;
	        	}
	        	var cal = rArr[i].REQUIRED-sum;
	        	thisNeedQuantity.text(cal);
	        	$('.releasingTbody tr .pName:contains('+rmName+')').next().text(cal);
	        	
	        	if(cal < 0){
	        		alert("불출수량이 필요수량보다 클 수 없습니다.");
	        		if(isNaN(sum)){
		        		sum = 0;
		        	}
	        		thisObj.text("");
	        		thisNeedQuantity.text(rArr[i].REQUIRED);
	        		$('.releasingTbody tr .pName:contains('+rmName+')').next().text(rArr[i].REQUIRED);
	        	}
	    	}
	        	//console.log('key:' + key + ' / ' + 'value:' + value);
	    });
    }
    //console.log(rArr);
});


//작업지시서 보기
$(".openJobOrder").click(function(){
	var joNo = $(this).val();
	/* console.log("joNo="+joNo); */
	if(joNo != ""){
	 	$('.jo-modal-body').load("${pageContext.request.contextPath}/productplan/updateJobOrder.do?joNo="+joNo,function(){
	        $('#jodal').modal({backdrop: 'static', keyboard: false});
	        $('#joModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("작업지시서 보기");
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