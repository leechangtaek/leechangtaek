<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script>
window.onload = function () {
	
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		title:{
			text: "생산제품",
			horizontalAlign: "left"
		},
		data: [{
			type: "doughnut",
			startAngle: 60,
			//innerRadius: 60,
			indexLabelFontSize: 17,
			indexLabel: "{label} - {y}%",
			toolTipContent: "<b>{label}:</b> {y} ",
			dataPoints: ${pdList}
		}]
	});
	chart.render();
	
	var chart2 = new CanvasJS.Chart("chartContainer2", {
		animationEnabled: true,
		title:{
			text: "원재료",
			horizontalAlign: "left"
		},
		data: [{
			type: "doughnut",
			startAngle: 60,
			//innerRadius: 60,
			indexLabelFontSize: 17,
			indexLabel: "{label} - {y}%",
			toolTipContent: "<b>{label}:</b> {y}%",
			dataPoints: ${rmList}
		}]
	});
	chart2.render();
	
	var chart = new CanvasJS.Chart("chartContainer3", {
		animationEnabled: true,
		title:{
			text: "제품별 검사 수량 & 부적합 발생 수량"
		},	
		axisY: {
			title: "총 검사 수량(ea)",
			titleFontColor: "#4F81BC",
			lineColor: "#4F81BC",
			labelFontColor: "#4F81BC",
			tickColor: "#4F81BC"
		},
		axisY2: {
			title: "부적합 발생 수량(ea)",
			titleFontColor: "#C0504E",
			lineColor: "#C0504E",
			labelFontColor: "#C0504E",
			tickColor: "#C0504E"
		},	
		toolTip: {
			shared: true
		},
		legend: {
			cursor:"pointer",
			itemclick: toggleDataSeries
		},
		data: [{
			type: "column",
			name: "총 검사 수량(ea)",
			legendText: "총 검사 수량(ea)",
			showInLegend: true, 
			dataPoints: ${column1}
		},
		{
			type: "column",	
			name: "부적합 발생 수량(ea)",
			legendText: "부적합 발생 수량(ea)",
			axisYType: "secondary",
			showInLegend: true,
			dataPoints:${column2}
		}]
	});
	chart.render();

	function toggleDataSeries(e) {
		if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
			e.dataSeries.visible = false;
		}
		else {
			e.dataSeries.visible = true;
		}
		chart.render();
	}
	
	$("#searchByPeriod").click(function(){
		$(".search-period").toggleClass("off");
	});
	
	$("#search-period-button").click(function(){
		var startDate = $(".startDate").val();
		var endDate = $(".endDate").val();
		location.href = "${pageContext.request.contextPath}/quality/doughnutHistoGraph.do?startDate="+startDate+"&endDate="+endDate;
	});
	
	
}
</script>
<h1 class="h3 mb-2 text-gray-800">부적합 도넛 & 히스토그램</h1>
<button type="button" class="btn btn-outline-primary" id="searchByPeriod">기간으로 검색하기</button><br /><br />
<div class="search-period off" style="margin-bottom:50px;">
    <div class="row">
       <div class="col">
        <label for="startDate">시작일자</label>&nbsp;&nbsp;&nbsp;
        <input type="date" name="startDate" class="form-control datepicker startDate">
       </div>
       <div class="col">
       <label for="endDate">종료일자</label>&nbsp;&nbsp;&nbsp;
          <input type="date" name="endDate" class="form-control datepicker endDate">	
       </div>
       <div class="col">
       	<button type="button" class="btn btn-outline-secondary" id="search-period-button">조회하기</button>
       </div>
   </div>
</div>
<div class="doughnutCharContainer">
    <div id="chartContainer2" class="doughnut" style="height: 370px; width: 45%;"></div>
    <div id="chartContainer"  class="doughnut" style="height: 370px; width: 45%;"></div>&nbsp;&nbsp;&nbsp;
</div>
<div class="columnChartContainer" style="margin-top:50px;">
	<div id="chartContainer3" style="height: 370px; width: 100%;"></div>
</div>
<style>
.doughnut{
	display: inline-block;
}
.doughnutCharContainer{
	text-align:center;
}
.search-period .form-control {
    display:inline;
    width: 60%;
}
.off {
	display:none;
}
</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
