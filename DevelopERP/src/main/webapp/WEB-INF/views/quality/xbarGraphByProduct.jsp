<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<script>
window.onload = function () {
	
	$("#dateAll").change(function(){
		if($("#dateAll").is(":checked")) {
			console.log("!!!!!!!!!!!!!");
			$(".startDate").attr("disabled",true);
			$(".endDate").attr("disabled",true);
		}else{
			$(".startDate").attr("disabled",false);
			$(".endDate").attr("disabled",false);
		}
		
	});
	$("#ptType").change("option:selected",function(){
		var optionVal = $(this).val();
		if(optionVal>0) {
			$("#product-ptNo").attr("disabled",false);
			var html="<option value='0' selected>제품 선택하기</option>";
			$.ajax({
				url : "${pageContext.request.contextPath}/quality/searchProuctNamePtNo.do?ptNo="+optionVal,
				dataType: "json",
				contentType: "application/json; charset=utf-8",
				success: data => {
					console.log(data);
					$("#product-ptNo").children().remove();
					for(let i in data) {
						var p = data[i];
						html += "<option value='"+p.PL_NO+"'>"+p.PL_NO +" | "+p.PRODUCT_NAME+ "</option>";
					}
					$("#product-ptNo").append(html);
				},
				error : (x,s,e)=>{
					console.log("ajax요청실패",x,s,e);
				}
			});
		}
		else {
			$("#product-ptNo").attr("disabled",true);
		}
		
	});
	
	$(".removeAll-button").click(function(){
		 $("#searchXBarFrm").each(function() {  
	            this.reset();  
	            $("#product-ptNo").attr("disabled",true);
	            $(".startDate").attr("disabled",false);
	            $(".endDate").attr("disabled",false);
	            $("#chartContainer").children().remove();
           		$(".xbar-table").children().remove();
		 });
	});
	
	$(".searchProduct-button").click(function(){
		if(!confirm("해당 조건으로 조회하시겠습니까?")) return;
		if($("#ptType option:selected").val()==0){
			alert("타입을 선택해주세요."); 
			return;
		}
		if($("#product-ptNo option:selected").val()==0){
			alert("제품을 선택해주세요."); 
			return;
		}
		var formData = $("#searchXBarFrm").serialize();
		console.log(formData);
		$.ajax({
			url : "${pageContext.request.contextPath }/quality/searchXBarFrmEnd.do",
			data : formData,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success : data=>{
				var UCL_ = data.UCL;
				var LCL_ = data.LCL;
				var DATA = data.DATA;
				var UCL = []; 
				
				for(let i in UCL_) {
						var p = UCL_[i];
						var label_ = p.label;
// 						var year = date_.substr(0,4);
// 						var month = date_.substr(5,2)-1;
// 						var day = date_.substr(8,2);
						var items = {
								label: label_,
								y: Number(p.y)
						}
						UCL.push(items);
				}
				var LCL = []; 
				
				for(let i in LCL_) {
						var p = LCL_[i];
						var label_ = p.label;
// 						var year = date_.substr(0,4);
// 						var month = date_.substr(5,2)-1;
// 						var day = date_.substr(8,2);
						var items = {
								label: label_,
								y: Number(p.y)
						}
						LCL.push(items);
				}
				createGraph(UCL, DATA, LCL);
				createTable(DATA);
			},
			error: (x,s,e)=>{
				console.log("ajax요청실패",x,s,e);
			}
		});
		
	})

	
	function createGraph(UCL, DATA, LCL){
		var chart = new CanvasJS.Chart("chartContainer", {
			title:{
				text: "Weekly Revenue Analysis for First Quarter"
			},
			axisY:[{
				lineColor: "#C24642",
				tickColor: "#C24642",
				labelFontColor: "#C24642",
				titleFontColor: "#C24642",
				minimum: LCL[0].y-2,
				maximum: UCL[0].y+2,
				interval : 0.5
			}],
			toolTip: {
				shared: true
			},
			legend: {
				cursor: "pointer",
				itemclick: toggleDataSeries
			},
			data: [{
				type: "line",
				name: "UCL",
				color: "#369EAD",
				showInLegend: true,
				dataPoints: UCL
			},
			{
				type: "line",
				name: "측정치",
				color: "#C24642",
				showInLegend: true,
				dataPoints: DATA
			},
			{
				type: "line",
				name: "LCL",
				color: "#7F6084",
				showInLegend: true,
				dataPoints: LCL
			}]
		});
		chart.render();

		function toggleDataSeries(e) {
			if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
				e.dataSeries.visible = false;
			} else {
				e.dataSeries.visible = true;
			}
			e.chart.render();
		}		
	}
	
	function createTable(DATA){
		var table = $(".xbar-table");
		var html = "<tbody>";
		var row1 = "<tr><th>입고일</th>";
		var row2 = "<tr><th>검사수치</th>";
		console.log(DATA);
		for(var i=0;i<DATA.length;i++) {
			
			if(i!=0&&i%5==0) {
				html += row1 + "</tr>" + row2 + "</tr>";
				html += "<tr>";
				row1 = "<tr><th>입고일</th>";
				row2 = "<tr><th>검사수치</th>";
				row1 += "<td>"+DATA[i].label+"</td>";
				row2 += "<td>"+DATA[i].y+"</td>";
			}else {
				row1 += "<td>"+DATA[i].label+"</td>";
				row2 += "<td>"+DATA[i].y+"</td>";	
			}
		}
		html += row1 + "</tr>" + row2 + "</tr>" + "</tbody>";
		console.log(html);
		
		table.append(html);
	}

}
</script>
<h1 class="h3 mb-2 text-gray-800" >제품별 x-bar Chart</h1>
<div id="search-container">
	<form class="needs-validation" id="searchXBarFrm" name="searchXBarFrm">
          <div class="form">
               <div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">시작일</label>
				  </div>
				  <input type="date" class="startDate" id="startDate" name="startDate" value="${monthAgo }">
				</div>
				<div class="input-group mb-3">
				  <div class="input-group-prepend">
			    <label class="input-group-text" for="inputGroupSelect01">종료일</label>
				  </div>
				  <input type="date" class="endDate" id="endDate" name="endDate" value="${today }">
				      <div class="col-auto">
				      <div class="form-check mb-2">
					    <input class="form-check-input" type="checkbox" id="dateAll" class="dateAll">
					    <label class="form-check-label" for="autoSizingCheck">
					      	전체 조회하기
					    </label>
					  </div>
					</div>
				</div>
          </div>              
          <div class="form">
              <div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">제품타입</label>
				  </div>
				  <select class="custom-select" id="ptType" name="ptType">
				    <option value="0" >제품타입 선택하기</option>
				    <c:forEach items="${ptType }" var="t" varStatus="vs">
				    	<option value="${vs.count }">${t.content }</option>
				    </c:forEach>
				  </select>
			  </div>
			  <div class="input-group mb-3">
				  <div class="input-group-prepend">
				    <label class="input-group-text" for="product-ptNo">제품번호 | 제품명</label>
				  </div>
				  <select class="custom-select" id="product-ptNo" name="ptNo" disabled>
				    <option value="0" >제품 선택하기</option>
				  </select>
			  </div>
          </div>
      </form>
      <div class="form">
      	<div class="col">
      	</div>
          <div class="col">
         <button id="FrmBtn" class="btn btn-primary removeAll-button">초기화</button> &nbsp;&nbsp;&nbsp;
         <button id="FrmBtn" class="btn btn-primary searchProduct-button">조회</button> 
          </div>
      </div>
</div>
<div class="xbar-chart-container">
	<div id="chartContainer" style="height: 370px; width: 100%;"></div>
</div>

<div class="card shadow mb-4" style="clear:both;">
	<div class="card-header py-3">
	  <h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
	</div>
	<div class="card-body">
	  <div class="table-responsive">
	    <table class="table table-bordered xbar-table" id="dataTable" width="100%" cellspacing="0">
	
	    </table>
	  </div>
	</div>
</div>
<style>

#search-container{
	width: 80%;
	margin-bottom : 50px;
	margin-top:50px;
	margin-bottom:50px;
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
</style>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
