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
	
	var inprice = [];
	var outprice = [];
	var inprice_ = ${inprice};
	var outprice_ = ${outprice};
	
	for(var i=0; i<inprice_.length;i++){
		
		var temp1 = {"y":Number(inprice_[i].y), "label": inprice_[i].label+"" };
		inprice.push(temp1);
		var temp2 = {"y":Number(outprice_[i].y), "label": outprice_[i].label+"" };
		outprice.push(temp2);
		
	}
	console.log(inprice);
	
	var chart = new CanvasJS.Chart("chartContainer3", {
		title:{
			text: "월별 매출 추이"
		},
		axisY:[{
			lineColor: "#C24642",
			tickColor: "#C24642",
			labelFontColor: "#C24642",
			titleFontColor: "#C24642",
// 			minimum: LCL[0].y-2,
// 			maximum: UCL[0].y+2,
// 			interval : 0.5
		}],
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
		},
		data: [{
			type: "line",
			name: "입고 단가",
			color: "#369EAD",
			showInLegend: true,
			dataPoints: inprice
		},
		{
			type: "line",
			name: "출고 단가",
			color: "#C24642",
			showInLegend: true,
			dataPoints: outprice
		}]
	});
	chart.render();
	
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
	
	$(".removeAll-button").click(function(){
		 $("#searchXBarFrm").each(function() {  
	            this.reset();  
	            $(".startDate").attr("disabled",false);
	            $(".endDate").attr("disabled",false);
	            $(".doughnutCharContainer").children().remove();
           		$(".xbar-table").children().remove();
		 });
	});
	
	$(".searchProduct-button").click(function(){
		var formData = $("#searchXBarFrm").serialize();
		console.log(formData);
		$.ajax({
			url : "${pageContext.request.contextPath }/sales/searchXBarFrmEnd.do",
			data : formData,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success : data=>{
				if(data != null){
					createDoughnutGraph(data.inpricePercentList, data.outpricePercentList);
					createTable(data);
				}
			},
			error: (x,s,e)=>{
				console.log("ajax요청실패",x,s,e);
			}
		});
		
	})

	
	function createDoughnutGraph(outPrice, inPrice){
		var chart = new CanvasJS.Chart("chartContainer1", {
			animationEnabled: true,
			title:{
				text: "매출단가",
				horizontalAlign: "left"
			},
			data: [{
				type: "doughnut",
				startAngle: 60,
				//innerRadius: 60,
				indexLabelFontSize: 17,
				indexLabel: "{label} - {y}%",
				toolTipContent: "<b>{label}:</b> {y} ",
				dataPoints: outPrice
			}]
		});
		chart.render();
		
		var chart2 = new CanvasJS.Chart("chartContainer2", {
			animationEnabled: true,
			title:{
				text: "입고단가",
				horizontalAlign: "left"
			},
			data: [{
				type: "doughnut",
				startAngle: 60,
				//innerRadius: 60,
				indexLabelFontSize: 17,
				indexLabel: "{label} - {y}%",
				toolTipContent: "<b>{label}:</b> {y}%",
				dataPoints: inPrice
			}]
		});
		chart2.render();
	}		
	
	
	function createTable(data){
		var table = $(".xbar-table");
		var html_ = "<tbody>";
		var row = "<thead><tr><th colspan='2'>제목</th><th>내용</th></tr></thead>";
		console.log(data);
		
		html_ += "<tr><td colspan='2'>총 구매 단가</td><td style='color:red;'>"+AddComma(Number(data.totalSalesData.TOTALINPRICE)) +"원</td></tr>";
		html_ += "<tr><td colspan='2'>총 매출액</td><td style='color:blue;'>"+AddComma(Number(data.totalSalesData.TOTALOUTPRICE)) +"원</td></tr>";
		html_ += "<tr><td colspan='3'><b>제품군 별</b></td></tr>";
		for(var i=0; i<data.salesData.length; i++) {
			let p = data.salesData[i];
			html_ += "<tr><td rowspan='2'><b>"+p.PRODUCT_NAME+"</b></td><td >구매 단가</td><td style='color:red;'>"+AddComma(Number(p.SUM_INPRICE))+"원</td></tr>";
			html_ += "</tr><td>매출 단가</td><td style='color:blue;'>"+AddComma(Number(p.SUM_OUTPRICE))+"원</td></tr>";
			
		}
		html_ += "<tr><td colspan='2'>매출 순이익</td><td style='color:green;'><b>"+AddComma(Number(data.totalSalesData.TOTALOUTPRICE)-Number(data.totalSalesData.TOTALINPRICE))+"원</b></td><tr>";
		
		var html = row + html_ + "</tbody>";
		
		console.log(html);
		
		table.append(html);
	}
	
	function AddComma(num){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	$(".print-button").click(function()
	{
	 document.pf.printzone.value = printArea.innerHTML;


	 window.open("${pageContext.request.contextPath}/sales/goPrint.do", "print_open","width=800,height=700,top=0,left=0,noresizable,toolbar=no,status=no,scrollbars=yes,directory=no");
	});

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
<div class="xbar-chart-container" style="margin-bottom:50px;">
	<div id="chartContainer3" style="height: 370px; width: 100%;"></div>
</div>

<h3>제품군 별 매출 비율</h3>
<div class="doughnutCharContainer">
    <div id="chartContainer2" class="doughnut" style="height: 370px; width: 45%;"></div>
    <div id="chartContainer1"  class="doughnut" style="height: 370px; width: 45%;"></div>&nbsp;&nbsp;&nbsp;
</div>

<div class="card shadow mb-4" id="printArea" style="clear:both;">
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
<button id="FrmBtn" class="btn btn-primary print-button">조회 결과 출력하기</button>
<form name="pf">
 <input type=hidden name="printzone">
</form>


<style>
.doughnut{
	display: inline-block;
}
.doughnutCharContainer{
	text-align:center;
}
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
    float:left;
    margin-right: 5px;
}
.xbar-table tr td {
	text-align:center;
	vertical-align:middle;
}
</style>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
