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
				<!-- Editable table -->
				<div class="card">
				  <div class="card-body">
				    <div id="table" class="table-editable">
				      <span class="table-add float-right mb-3 mr-2"><a href="#!" class="text-success"><i
				            class="fas fa-plus fa-2x" aria-hidden="true"></i></a></span>
				      <table class="table table-bordered table-responsive-md table-striped text-center" id="edTable">
				        <thead>
				          <tr>
				            <th class="text-center">번호</th>
				            <th class="text-center">Lot번호</th>
				            <th class="text-center">제품 번호</th>
				            <th class="text-center">거래처 번호</th>
				            <th class="text-center">재고량</th>
				            <th class="text-center">입고가</th>
				            <th class="text-center">출고가</th>
				            <th class="text-center">출고수량</th>
				            <!-- <th class="text-center">Sort</th> -->
				            <th class="text-center">Remove</th>
				          </tr>
				        </thead>
				        <tbody class="salesTbody">
				          <tr class="hide">
				          		<td class="pt-3-half pNo" contenteditable="false"></td>
							  <td class="pt-3-half lotNo lotNoSearch" contenteditable="false"></td>
						      <td class="pt-3-half plNo" contenteditable="false"></td>
						      <td class="pt-3-half vendorNo" contenteditable="false"></td>
						      <td class="pt-3-half quantity" contenteditable="false"></td>
						      <td class="pt-3-half inprice" contenteditable="false"></td>
						      <td class="pt-3-half outprice" contenteditable="false"></td>
						      <td class="pt-3-half salesQuantity" contenteditable="true"></td>
							  <td>
							    <span class="table-remove"><button type="button" class="btn btn-danger btn-rounded btn-sm my-0 waves-effect waves-light">Remove</button></span>
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
	              <button type="button" id="FrmBtn" class="btn btn-primary addBOM-submit" >출고</button>
	              <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                </div>
           </div>
      </div>
      
<%--Search modal --%>
<div class="modal" tabindex="-1" role="dialog" id="searchLotModal">
  <div class="modal-dialog" role="document">
      <div class="modal-content searchLotModal-content">
      <div class="modal-header">
          <h5 class="modal-title search-title" id="searchLotModalTitle"> </h5>
      </div>
      <div class="searchLotModalBody">
      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-primary searchModal-end">끝</button>
      </div>
      </div>
  </div>
</div>



<style>
#searchModal {
  height: 150px;
}
#search-container {
    width: 100%;
}

.add-modal-content{
	width:1000px !important;
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
#searchLotModal {
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
    	$('#searchLotModal').modal("hide");
    });
	
	
	 <%--editable table script--%>
	 const $tableID = $('#table');
	 const $BTN = $('#export-btn');
	 const $EXPORT = $('#export');
	
	 const newTr = `
	<tr class="hide">
		 <td class="pt-3-half pNo" contenteditable="false"></td>
	  <td class="pt-3-half lotNo lotNoSearch" contenteditable="false"></td>
      <td class="pt-3-half plNo" contenteditable="false"></td>
      <td class="pt-3-half vendorNo" contenteditable="false"></td>
      <td class="pt-3-half quantity" contenteditable="false"></td>
      <td class="pt-3-half inprice" contenteditable="false"></td>
      <td class="pt-3-half outprice" contenteditable="false"></td>
      <td class="pt-3-half salesQuantity" contenteditable="true"></td>
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
	   
	   var tds = $("#salesAddModal .salesTbody tr");
	   
	 	
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

// 	   Get the headers (add special header logic here)
	   $($rows.shift()).find('th:not(:empty)').each(function () {

	     headers.push($(this).text().toLowerCase());
	   });

// 	   Turn all existing rows into a loopable array
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
		   var tds = $("#edTable .lotNo").nextAll();
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
			
			var lotNo = $(".lotNo");
			var lotNos = [];

			var plNo = $(".plNo");
			var plNos = [];
			
			var vendorNo = $(".vendorNo");
			var vendorNos = [];
			
			var quantity = $(".quantity");
			var quantitys = [];
			
			var inprice = $(".inprice");
			var inprices = [];
			
			var outprice = $(".outprice");
			var outprices = [];
			
			var salesQuantity = $(".salesQuantity");
			var salesQuantitys = [];
			
			
			for(var i=0;i<plNo.length;i++) {
				lotNos.push(lotNo.eq(i).text());
				plNos.push(plNo.eq(i).text());
				vendorNos.push(vendorNo.eq(i).text());
				quantitys.push(quantity.eq(i).text());
				inprices.push(inprice.eq(i).text());
				outprices.push(outprice.eq(i).text());
				salesQuantitys.push(salesQuantity.eq(i).text());
			}
			var data_ = {"lotNos":lotNos,
						 "plNos":plNos,
						 "vendorNos":vendorNos,
						 "quantitys":quantitys,
						 "inprices":inprices,
						 "outprices":outprices,
						 "salesQuantitys":salesQuantitys
						 };
			console.log(data_);
		 	$.ajax({
		 		url: "${pageContext.request.contextPath}/sales/addSales.do",
		 		data: data_,
		 		async: false,
		 		type : 'POST', 
//		 		contentType : "application; charset=utf-8",
		 		dataType: "json",
		 		success: data => {
		 			$('#salesAddModal').modal("hide"); //닫기 
		 			location.reload();
		 		},
		 		error : (jqxhr, textStatus, errorThrown)=>{
		 			console.log(jqxhr, textStatus, errorThrown);
		 		}
		 	});
		}) 
})
<%--onload end--%>



$(function() {
    //폼닫기
    $(".search-end-button").click(function(){
    	$('#salesAddModal').modal("hide");
    });
});
  
$(document).on('dblclick','.lotNoSearch',function(){
	$("#searchLotModalTitle").html('로트번호 검색');
	var clickedTd = $(this).parent().index();
	var trNum = $(this).closest('tr').prevAll().length;
	
	trNum += 1;
	
	
	 $('.searchLotModalBody').load("${pageContext.request.contextPath}/sales/searchLotNo.do",function(){
	        $('#searchLotModal').modal({backdrop: 'static', keyboard: false});
	        $('#searchLotModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $("#searchLotModal #trNum").val(trNum);
	 })
			
});

$(".salesQuantity").blur(function(){
	var val = Number($(this).text());
	var rquantity = Number($(this).siblings('.quantity').text());
// 	alert(val);
	if(isNaN(val)) {
		alert("숫자를 입력해 주세요");
		$(this).text('');
		$(this).focus();
	}
	else if(val>rquantity) {
		alert("재고량보다 많은 수량입니다.");
		$(this).text('');
		$(this).focus();
	}
})

  
</script>
</body>
</html>