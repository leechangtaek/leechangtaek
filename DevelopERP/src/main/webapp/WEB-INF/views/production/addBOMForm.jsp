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
				<div class="form-row">
					<div class="col-lg-20 mb-3 rowResize">
					     <label for="productInfo">생산품목 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 					     <input type="text" id="productInfo" name="productInfo" class="form-control bg-light small" placeholder="생산품목" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					     <br />
					     <label for="productCode">생산품목코드 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 					     <input type="text" id="productCode" name="productCode" class="form-control bg-light small" placeholder="생산품목코드" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
					</div>
				</div>
				<!-- Editable table -->
				<div class="card">
				  <div class="card-body">
				    <div id="table" class="table-editable">
				      <span class="table-add float-right mb-3 mr-2"><a href="#!" class="text-success"><i
				            class="fas fa-plus fa-2x" aria-hidden="true"></i></a></span>
				      <table class="table table-bordered table-responsive-md table-striped text-center" id="edTable">
				        <thead>
				          <tr>
				            <th class="text-center">No</th>
				            <th class="text-center">품목코드</th>
				            <th class="text-center">품목명</th>
				            <th class="text-center">수량</th>
				            <!-- <th class="text-center">Sort</th> -->
				            <th class="text-center">Remove</th>
				          </tr>
				        </thead>
				        <tbody class="BOMTbody">
				          <tr>
				            <td class="pt-3-half pNo" contenteditable="false"></td>
				            <td class="pt-3-half pCode tdPtCode" contenteditable="true"></td>
				            <td class="pt-3-half pName" contenteditable="false"></td>
				            <td class="pt-3-half pCount" contenteditable="true"></td>
				            <td>
				              <span class="table-remove"><button type="button"
				                  class="btn btn-danger btn-rounded btn-sm my-0">Remove</button></span>
				            </td>
				          </tr>
				        </tbody>
				      </table>
				    </div>
				  </div>
				</div>
				<br />
				<!-- Editable table -->
            	<div class="form-row col-lg-20 col-lg-push-9 btns">
	              <button type="button" id="FrmBtn" class="btn btn-primary addBOM-submit" >저장</button>
	              <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
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
#searchModal {
  width: 60%;
  height: 150px;
}
#search-container {
    width: 100%;
}
.modal-content{
	width:800px;
	height: 100%;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display: inline;
    width: 20%;
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
    padding-left: 84.8%;
}
.rowResize{
	width: 100%;
}
.updateModalBody{
    height: 130px;
}
.scResize{
	height: 110px;
}
#edTable {
    counter-reset: rowNumber;
}
#delBtn{
	margin-right: 5px;
}
#edTable tr td:first-child::before {
	counter-increment: rowNumber;
    content: counter(rowNumber);
    min-width: 1em;
    margin-right: 0.5em;
}
</style>
<script>    

<%--onload start--%>
$(()=>{	
	$(".searchModal-end").click(function(){
    	$('#mySearchModal').modal("hide");
    });
	
	$(".mdlCloseBtn").click(function(){
    	$('#updateProductNo').modal("hide");
    });
	
	 <%--editable table script--%>
	 const $tableID = $('#table');
	 const $BTN = $('#export-btn');
	 const $EXPORT = $('#export');
	
	 const newTr = `
	<tr class="hide">
	  <td class="pt-3-half pNo" contenteditable="false"></td>
      <td class="pt-3-half pCode tdPtCode" contenteditable="true"></td>
      <td class="pt-3-half pName" contenteditable="false"></td>
      <td class="pt-3-half pCount" contenteditable="true"></td>
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
	   
	   var tds = $("#BOMAddModal .BOMTbody tr");
	   
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
			//console.log(tds);
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
			
			var pNo = $(".pNo");
			var pNos = [];

			var pCode = $(".pCode");
			var pCodes = [];
			
			var pName = $(".pName");
			var pNames = [];
			
			var pCount = $(".pCount");
			var pCounts = [];
			
			var productCode = $("#productCode").val();
			
			for(var i=0;i<pName.length;i++) {
				pNames.push(pName.eq(i).text());
				pNos.push(pNo.eq(i).text());
				pCounts.push(pCount.eq(i).text());
				pCodes.push(pCode.eq(i).text());
			}
			var data_ = {"pNos":pNos,
						 "pCodes":pCodes,
						 "pNames":pNames,
						 "pCounts":pCounts,
						 "productCode":productCode
						 };
			//console.log(data_);
		 	$.ajax({
		 		url: "${pageContext.request.contextPath}/production/addBOM.do",
		 		data: data_,
		 		async: false,
		 		type : 'POST', 
//		 		contentType : "application; charset=utf-8",
		 		dataType: "json",
		 		success: data => {
		 			//console.log(data);
		 			$('#BOMAddModal').modal("hide"); //닫기 
		 			location.reload();
		 		},
		 		error : (jqxhr, textStatus, errorThrown)=>{
		 			//console.log(jqxhr, textStatus, errorThrown);
		 		}
		 	});
		}) 
})
<%--onload end--%>



$(function() {
    //폼닫기
    $(".search-end-button").click(function(){
    	$('#productAddModal').modal("hide");
    });
});
  
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
  
</script>
</body>
</html>