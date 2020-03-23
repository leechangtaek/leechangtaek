<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
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
           		$(".static-table tbody").children().remove();
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
		$.ajax({
			url : "${pageContext.request.contextPath }/quality/searchCPkEnd.do",
			data : formData,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success : data=>{
				console.log(data);
				var spec_ = data.spec;
				var cpk_ = data.data;
				
				console.log(cpk_);
				var cpk = [];
				for(let i in cpk_) {
					var items = {
									label: String(cpk_[i].MEASUREMENT),
									y: cpk_[i].COUNT	
								}
					console.log(items);
					cpk.push(items);
				}
				console.log(spec_);
				createGraph(cpk,spec_);
				createTable(spec_,data.statics);
			},
			error: (x,s,e)=>{
				console.log("ajax요청실패",x,s,e);
			}
		});
		
	})

	function createGraph(cpk,spec_){
		var chart = new CanvasJS.Chart("chartContainer", {
			title:{
				text: "Weekly Revenue Analysis for First Quarter"
			},
			axisY:[{
				title : "갯수(ea)",
				lineColor: "#C24642",
				tickColor: "#C24642",
				labelFontColor: "#C24642",
				titleFontColor: "#C24642"
			}],
			axisX:[{
				title: "측정값"
			}],
			toolTip: {
				shared: true
			},
			legend: {
				cursor: "pointer",
				itemclick: toggleDataSeries
			},
			data: [{
				type: "column",
				name: "측정값",
				color: "#369EAD",
				showInLegend: true,
				dataPoints: cpk
			},
			{
				type: "line",
				name: "측정값",
				color: "#C24642",
				showInLegend: true,
				dataPoints: cpk
			},
			]
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
	
	function createTable(spec_,statics) {
// 		<th>Min</th>
// 		<th>Max</th>
// 		<th>Avg</th>
// 		<th>표준편차</th>
// 		<th>cp</th>
// 		<th>절대값</th>
// 		<th>K</th>
// 		<th>공정능력 지수(cpk)</th>
		var diff = Number(statics.AVG)-Number(spec_.SPEC);
		var abs = Math.round(Math.abs(diff)*100)/100;
		var tol = Number(spec_.SPEC)*Number(spec_.TOL)*2;
		var k = Math.round((abs/tol)*100)/100;
		var cp = 0;
		var cpk = 0;
		if(statics.STTDEV!=0) {
			cp = Math.round(((statics.MAX-statics.MIN)/(statics.STTDEV*6))*100)/100;
			cpk = Math.round(((1-k)/cp)*100)/100;
		}

		
		var table = $(".static-table tbody");
		html ="<tr><td>"+statics.MIN+"</td><td>"+statics.MAX+"</td><td>"+statics.AVG
			+"</td><td>"+statics.STTDEV+"</td><td>"+cp +"</td><td>"+ abs +"</td><td>"+ k 
			 +"</td><td>"+ cpk + "</td></tr>";
		table.append(html);
		
	}

	
}
</script>
<h1 class="h3 mb-2 text-gray-800">공정 능력 조회</h1>
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
	<div id="chartContainer" style="height: 370px; width: 100%;"></div>
	
<div class="card shadow mb-4" style="clear:both;">
	<div class="card-header py-3">
	  <h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
	</div>
	<div class="card-body">
	  <div class="table-responsive">
	    <table class="table table-bordered static-table" id="dataTable" width="100%" cellspacing="0">
			<thead>
				<tr>
					<th>Min</th>
					<th>Max</th>
					<th>Avg</th>
					<th>표준편차</th>
					<th>cp</th>
					<th>절대값</th>
					<th>K</th>
					<th>공정능력 지수(cpk)</th>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
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
