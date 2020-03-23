<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품조회(modal-body)</title>

<style>
.endProduct-table tbody tr:hover td{
	cursor : auto;
	background-color:#ccc;
}
/* .modal-body{
	text-align: center;
} */

</style>
</head>
<body>
	<c:if test="${plan eq 'product'}">
		<div id="yearOption">
			<div class="input-group mb-3">
			  <div class="input-group-prepend">
			    <label class="input-group-text" for="inputGroupSelect01">년도별 조회</label>
			  </div>
			  <select class="custom-select yearList" id="inputGroupSelect01" name="yearList">
			    <option ${year eq "all" ? "selected":"" } value=${year }> 전체</option>
			    <option value="2019">2019년</option>
			    <option value="2020">2020년</option>
			  </select>
			</div>
		</div>
	</c:if>
     <table class="table table-bordered endProduct-table" id="" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th>No.</th>
           <th>제품관리번호</th>
           <th>제품명</th>
         </tr>
       </thead>
       <tbody>
       </tbody>
     </table>
     <div class="pageBar">
<%--      ${pageBar} --%>
     </div>
</body>

<script>
$(()=>{
	var a = "${plan}";
	var b = "${year}";
	morePage(a,b);
	
	$(".yearList").on('change',function(){
		b = $(".yearList option:selected").val();
		console.log("조건변경!");
		morePage(a,b);
	});
	
	
});

function morePage(a,b){
	var plan = a;
	var year = b;
	console.log("a="+a);
	console.log("b="+b);
	
	if(a=="product") {
		url_ = "${pageContext.request.contextPath}/productplan/endProductListPage.do?plan="+plan+"&year="+year+"&cPage=1";
	}
	else if(a=="purchase"){
		url_ = "${pageContext.request.contextPath}/productplan/endProductListPage.do?plan="+plan+"&year='all'&cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/productplan/"+a;
	}
	console.log("url="+url_);
	
	$.ajax({
		url : url_,
		dataType : "json",
		contentType: "application/json; charset=utf-8",
		success : data => {
			var list = data.list;
			$(".endProduct-table tbody").children().remove();
			for(var i in list) {
				let l = list[i];
				console.log(l);	
				$(".endProduct-table tbody").append("<tr><td>"+(Number(i)+(data.cPage-1)*10+1)+"</td><td>"+l.plNo+"</td><td>"+l.productName+"</td><tr>");
			}
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"morePage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
		
	});
	
}



$(".endProduct-table tbody").on('dblclick','tr',function(){
	
	var productNo = $(this).children().eq(1).html(); //선택 행 값 담기
	var name = $(this).children().eq(2).html(); //선택 행 값 담기
	
	$("#productName").val(name); //input창에 뿌려주기
	
	
	if("${plan}" == "purchase"){
		$("#lineChart").remove();
		$("#graph").append("<canvas id='lineChart'></canvas>");
		
		$("#purchasePlan-modal").modal('hide');
		$.ajax({
			url : "${pageContext.request.contextPath}/productplan/showChartByProduct.do?productNo="+productNo,
			contentType :"application/json; charset=utf-8",
			dataType : "json",
			success : data=>{
				var graphData_ = data.graphData;
				console.log(data);
				
				var rmName = [];
				var required = [];
				var rmStock = [];
				
				for(let i in graphData_ ) {
					
					var p = graphData_[i];
					
					rmName.push(p.rmName);
					required.push(p.requiredQ);
					rmStock.push(p.rmStock);
					
				}
				console.log(data.graphData);
				createGraph(rmName, required, rmStock);
			},
			error : (x,s,e)=>{
				console.log("ajax요청실패",x,s,e);
			}
		});
		//소요량계산 테이블 ajax
		$.ajax({
			url : "${pageContext.request.contextPath}/productplan/showRequireCalByProduct.do?productNo="+productNo,
			contentType :"application/json; charset=utf-8",
			success : data =>{
				$("#calResult").empty();
				var requireCal = data.requireCal;
				var table = "";
// 				<table class="table table-bordered jo-table" id="dataTable" width="100%" cellspacing="0">
				
				
				$.each(requireCal, function(i,each){
					table += "<tr><td>"+each.rmNo+"</td><td>"+each.rmName+"</td><td>"+each.requiredQ+"</td><td>"+each.rmStock+"</td><td class='requireAm'>"+(each.requiredQ-each.rmStock)+"</td></tr>";
				});
				
				
				$(".jo-table").append(table);
				
				var result = $(".requireAm");
				$.each(result, function(index, td){
					if(td.innerHTML > 0){
						$(this).css("color", "red");
					}
				});
				
			},
			error : (x, s, e)=>{
				console.log("showRequireCal ajax요청실패!",x,s,e);
			}
		});
	}
	
	if("${plan}" == "product"){

		$("#barChart").remove();
		$("#barGraph").append("<canvas id='barChart'></canvas>");
		
		$("#searchProduction").modal('hide');
		
		var year = $(".yearList option:selected").val()
		if(year == '2019') {
			$(".calNextOutput-btn").hide();
			$("#question").hide();
		}
		else {
			$(".calNextOutput-btn").show();
			$("#question").show();
		}
		$.ajax({
			url : "${pageContext.request.contextPath}/productplan/showBarChart.do?productNo="+productNo+"&year="+year,
			contentType :"application/json; charset=utf-8",
			dataType : "json",
			success : data=>{
				var barData_ = data.barData;
				var ss_ = data.selectedStatus;
				console.log(barData_);
				$("#pTitle h4 span").html("'"+barData_[0].productName+"'");
				if(year =='all'){
					$("#pTitle h6 span").html("전체기간");
				}
				else{
					$("#pTitle h6 span").html(barData_[0].date+"년");
				}
				$(".spData").children().eq(0).html(ss_.spPlan);
				$(".spData").children().eq(1).html(ss_.spResult);
				$(".spData").children().eq(2).html(ss_.spAttainment+"%");
				
				var month = [];
				var output1 = [];
				var output2 = [];
				var date = $(".yearList option:selected").val();
				
				for(let i in barData_){
					
					var bar = barData_[i]; 
					
					if(bar.date == '2019'){
						output1.push(bar.output);
					}
					
					if(bar.date == '2020'){
						output2.push(bar.output);
					}
				}
				for(var n=1; n<=12; n++)
					month.push(n+"월");
				console.log(output1);
				createBarChart(month, output1, output2, date);
			},
			error : (x,s,e)=>{
				console.log("ajax요청실패",x,s,e);
			}
		});
	}
	
		
});


function createGraph(rmName, required, rmStock){
	
	//line
	var ctxL = document.getElementById("lineChart").getContext('2d');
	var myLineChart = new Chart(ctxL, {
	type: 'line',
	data: {
	labels: rmName,
	// ${labels}
	datasets: [{
	label: "소요량",
	data: required,
	//${data}
	backgroundColor: [
	'rgba(105, 0, 132, .2)',
	],
	borderColor: [
	'rgba(200, 99, 132, .7)',
	],
	borderWidth: 2
	},
	{
	label: "재고량",
	data: rmStock,
	backgroundColor: [
	'rgba(0, 137, 132, .2)',
	],
	borderColor: [
	'rgba(0, 10, 130, .7)',
	],
	borderWidth: 2
	}
	]
	},
	options: {
	responsive: true
	}
	});
}

</script>


</html>