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
  
 <%--  <!-- Font Awesome 그래프용 mdb 설정-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
  <!-- Google Fonts Roboto -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css_mdb/bootstrap.min.css">
  <!-- Material Design Bootstrap -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css_mdb/mdb.min.css"> --%>
  

<style>
.form-row{
    margin-top: 50px;
}
.form-control {
    display: inline;
}
.rowResize{
	display: block;
    margin: 0 auto;
    text-align: center;
}
input[type=text]{
    text-align: center;
    width: auto;

}
#myModal{
	z-index: 1060;
}
#btn-mark{
	display: inline-block;
    float: right;
    position: relative;
    margin: 30px;
    right: 40px;
    top: 30px;
}
#question{
	color:#858796;
}
.fa-question-circle{
	font-size: x-large;
    vertical-align: middle;
    opacity: 0.9;
}
h4{
	font-weight: 550;
    display: inline-block;
    padding: 10px 0 0 5px;
}
h6{
   display: inline-block;
   float: right;
   padding: 24px 3px 0 0;
}
#pTitle{
	border-bottom: ridge;
}
#statusTable{
	text-align: center;
}
#barGraph{
	width: 90%;
	height:70%;
	margin: 0 auto;
}
#allStatus, #productStatus{
    display: inline-block;
    width: 32%;
    border-style: ridge;
    left: 50px;
    font-size: large;
    top: 69px;
    margin: 0 20px 0 20px;
}
#productionStatus{
	text-align: center;
    margin-top: 35px;
}

/* modal position(center)*/
.modal {
  text-align: center;
}
@@media screen and (min-width: 768px) {
  .modal:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}
.modal-dialog {
  display: inline-block;
  text-align: left;
  vertical-align: middle;
}
#explanation{
    display: inline-block;
    position: relative;
    left: 194px;
    top: 10px;
    font-size: small;
    font-weight: 100;
}
.modal-body{
	text-align: center;
}

</style>

		
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">생산현황 및 생산계획</h1>

<div id="monthlyProduction" >
	<div class="form-row">
		<div class="col-lg-20 mb-3 rowResize">
			 <label for="productName" style="font-size: larger;">제품별 생산량 조회</label>&emsp;<br>
		     <input type="text" id="productName" name="productName" class="form-control bg-light small" value="${barData[0].productName }" aria-label="Search" aria-describedby="basic-addon2" readonly="readonly">
		     <button class="btn btn-primary searchProduct-btn" type="button" value="product">
			 	<i class="fas fa-search fa-sm"></i>
			 </button>
		</div>
	</div>
	<!-- 생산현황 테이블 -->
	<div id="productionStatus">
		<div id="allStatus">
		<div id="pTitle">
			<h4>전체 생산 현황</h4>&nbsp;
			<h6>전체기간 기준</h6>
		</div>
			<table id="statusTable" width="100%" >
			  <thead>
			    <tr>
			      <th>완제품 계획</th>
			      <th>완제품 실적</th>
			      <th>달성율</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<tr class="table-info">
			  		<td>${totalStatus.epPlan }</td>
			  		<td>${totalStatus.epResult }</td>
			  		<td>${totalStatus.epAttainment }%</td>
			  	</tr>
			  </tbody>
			</table>
		</div>
		<div id="productStatus">
		<div id="pTitle"><h4><span>'${barData[0].productName }'</span> 생산현황</h4>&nbsp;<h6><span><c:if test="${param.year eq all}">전체기간</c:if></span> 기준</h6></div>
			<table id="statusTable" width="100%" >
			  <thead>
			    <tr>
			      <th>완제품 계획</th>
			      <th>완제품 실적</th>
			      <th>달성률</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<tr class="table-info spData">
			  		<td>${selectedStatus.spPlan }</td>
			  		<td>${selectedStatus.spResult }</td>
			  		<td>${selectedStatus.spAttainment }%</td>
			  	</tr>
			  </tbody>
			</table>
		</div>
	</div>
	<div id="explanation">
		<p>*완제품 계획: 등록된 작업 지시서 기준</p>
		<p>*완제품 실적: 생산입고된 품질 검수를 통과한 생산제품 기준</p>
		<p>*달성률: 계획에 따른 실적 달성률(%)</p>
		
	</div>
	 <div id="btn-mark">
		<button class="btn btn-primary calNextOutput-btn" type="button" value="">
			생산 계획량 계산
	 	</button>
	 	<span id="question" class="popover-dismiss" title="생산 계획량" data-toggle="popover" 
	 		  data-content="조회된 제품 기준으로 최근 3개월 간<br /> 생산량의 평균값을 계산합니다." 
	 		  data-placement = "bottom"
	 		  data-html = "true" >
	 		<i class="far fa-question-circle"></i>
	 	</span>
	 </div>
	<br />
	<div id="barGraph">
		<canvas id="barChart"></canvas>
	</div>
	
  	<!-- Modal -->
	<div class="modal" tabindex="-1" role="dialog" id="searchProduction">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        <div class="modal-header">
	            <h5 class="modal-title controll-title"></h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	            </button>
	        </div>
	        <div class="modal-body production-body nextOutput-body">
	            <!-- <p>Modal body text goes here.</p> -->
	        </div>
	        
	        </div>
	    </div>
	</div>

</div>

<!-- jQuery -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/js_mdb/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/js_mdb/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/js_mdb/bootstrap.min.js"></script> --%>
<!-- MDB core JavaScript (그래프 점)-->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/js_mdb/mdb.min.js"></script>
<script>
$(()=> {
	$('.popover-dismiss').popover({
  		trigger: 'hover'
	});  
});
//제품조회 모달
$(".searchProduct-btn").click(function(){
	var product = $(this).val();
	 $('.production-body').load("${pageContext.request.contextPath}/productplan/endProductList.do?plan="+product,function(){
	        $('#searchProduction').modal({backdrop: 'static', keyboard: false});
	        $('#searchProduction').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("생산품 조회");
		});
});
$(".calNextOutput-btn").click(function(){
	var productName = $("#productName").val();
	 $('.nextOutput-body').load("${pageContext.request.contextPath}/productplan/predictNextOutput.do?productName="+productName,function(){
	        $('#searchProduction').modal({backdrop: 'static', keyboard: false});
	        $('#searchProduction').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("생산 계획량");
		});
});
	
var barData = ${barData};
console.log(barData);

var month = [];
var output1 = [];
var output2 = [];
var date = "all";
for(let i in barData){
	
	var bar = barData[i];
	
	if(bar.date == '2019'){
		output1.push(bar.output);
	}
	if(bar.date == '2020'){
		output2.push(bar.output);
	}
		
}
for(var n=1; n<=12; n++)
	month.push(n+"월");
	
createBarChart(month, output1, output2, date);

function createBarChart(month, output1, output2, date){
	if(date == "2019"){
		//그래프 자바스크립트
		//bar
		var ctxB = document.getElementById("barChart").getContext('2d');
		var myBarChart = new Chart(ctxB, {
		type: 'bar',
		data: {
		labels: month,
		datasets: [{
		//first bar
		label: '2019년 생산량',
		data: output1,
		backgroundColor: [
		'rgba(255, 99, 132, 0.2)', //1월
		'rgba(54, 162, 235, 0.2)', //2월
		'rgba(255, 206, 86, 0.2)', //3월
		'rgba(75, 192, 192, 0.2)', //4월
		'rgba(153, 102, 255, 0.2)',//5월
		'rgba(255, 159, 64, 0.2)', //6월
		'rgba(40, 191, 123, 0.2)', //7월
		'rgba(5, 94, 237, 0.2)',   //8월
		'rgba(240, 73, 7, 0.2)',   //9월
		'rgba(163, 181, 43, 0.2)',   //10월
		'rgba(7, 240, 228, 0.2)',   //11월
		'rgba(227, 11, 141, 0.2)'    //12월
		],
		borderColor: [
		'rgba(255,99,132,1)',
		'rgba(54, 162, 235, 1)',
		'rgba(255, 206, 86, 1)',
		'rgba(75, 192, 192, 1)',
		'rgba(153, 102, 255, 1)',
		'rgba(255, 159, 64, 1)',
		'rgba(40, 191, 123, 1)',
		'rgba(5, 94, 237, 1)',
		'rgba(240, 73, 7, 1)',
		'rgba(163, 181, 43, 1)',   //10월
		'rgba(7, 240, 228, 1)',   //11월
		'rgba(227, 11, 141, 1)'   //12월
		
		],
		borderWidth: 1
		}]
		},
		options: {
		scales: {
		yAxes: [{
		ticks: {
		beginAtZero: true
		}
		}]
		}
		}
		});
	}
	else if(date == "2020"){
		//그래프 자바스크립트
		//bar
		var ctxB = document.getElementById("barChart").getContext('2d');
		var myBarChart = new Chart(ctxB, {
		type: 'bar',
		data: {
		labels: month,
		datasets: [{
		//first bar
		label: '2020년 생산량',
		data: output2,
		backgroundColor: [
		'rgba(255, 99, 132, 0.2)', //1월
		'rgba(54, 162, 235, 0.2)', //2월
		'rgba(255, 206, 86, 0.2)', //3월
		'rgba(75, 192, 192, 0.2)', //4월
		'rgba(153, 102, 255, 0.2)',//5월
		'rgba(255, 159, 64, 0.2)', //6월
		'rgba(40, 191, 123, 0.2)', //7월
		'rgba(5, 94, 237, 0.2)',   //8월
		'rgba(240, 73, 7, 0.2)',   //9월
		'rgba(163, 181, 43, 0.2)',   //10월
		'rgba(7, 240, 228, 0.2)',   //11월
		'rgba(227, 11, 141, 0.2)'    //12월
		],
		borderColor: [
		'rgba(255,99,132,1)',
		'rgba(54, 162, 235, 1)',
		'rgba(255, 206, 86, 1)',
		'rgba(75, 192, 192, 1)',
		'rgba(153, 102, 255, 1)',
		'rgba(255, 159, 64, 1)',
		'rgba(40, 191, 123, 1)',
		'rgba(5, 94, 237, 1)',
		'rgba(240, 73, 7, 1)',
		'rgba(163, 181, 43, 1)',   //10월
		'rgba(7, 240, 228, 1)',   //11월
		'rgba(227, 11, 141, 1)'   //12월
		
		],
		borderWidth: 1
		}]
		},
		options: {
		scales: {
		yAxes: [{
		ticks: {
		beginAtZero: true
		}
		}]
		}
		}
		});
	}
	else{
		//그래프 자바스크립트
		//bar
		var ctxB = document.getElementById("barChart").getContext('2d');
		var myBarChart = new Chart(ctxB, {
		type: 'bar',
		data: {
		labels: month,
		datasets: [{
		//first bar
		label: '2019년 생산량',
		data: output1,
		backgroundColor: [
		'rgba(255, 99, 132, 0.2)', //1월
		'rgba(54, 162, 235, 0.2)', //2월
		'rgba(255, 206, 86, 0.2)', //3월
		'rgba(75, 192, 192, 0.2)', //4월
		'rgba(153, 102, 255, 0.2)',//5월
		'rgba(255, 159, 64, 0.2)', //6월
		'rgba(40, 191, 123, 0.2)', //7월
		'rgba(5, 94, 237, 0.2)',   //8월
		'rgba(240, 73, 7, 0.2)',   //9월
		'rgba(163, 181, 43, 0.2)',   //10월
		'rgba(7, 240, 228, 0.2)',   //11월
		'rgba(227, 11, 141, 0.2)'    //12월
		],
		borderColor: [
		'rgba(255,99,132,1)',
		'rgba(54, 162, 235, 1)',
		'rgba(255, 206, 86, 1)',
		'rgba(75, 192, 192, 1)',
		'rgba(153, 102, 255, 1)',
		'rgba(255, 159, 64, 1)',
		'rgba(40, 191, 123, 1)',
		'rgba(5, 94, 237, 1)',
		'rgba(240, 73, 7, 1)',
		'rgba(163, 181, 43, 1)',   //10월
		'rgba(7, 240, 228, 1)',   //11월
		'rgba(227, 11, 141, 1)'   //12월
		
		],
		borderWidth: 1
		},
		{
		//second bar
		label: '2020 생산량',
		data: output2,
		backgroundColor: [
			'rgba(255, 99, 132, 0.2)', //1월
			'rgba(54, 162, 235, 0.2)', //2월
			'rgba(255, 206, 86, 0.2)', //3월
			'rgba(75, 192, 192, 0.2)', //4월
			'rgba(153, 102, 255, 0.2)',//5월
			'rgba(255, 159, 64, 0.2)', //6월
			'rgba(40, 191, 123, 0.2)', //7월
			'rgba(5, 94, 237, 0.2)',   //8월
			'rgba(240, 73, 7, 0.2)',   //9월
			'rgba(163, 181, 43, 0.2)',   //10월
			'rgba(7, 240, 228, 0.2)',   //11월
			'rgba(227, 11, 141, 0.2)'    //12월
		],
		borderColor: [
			'rgba(255,99,132,1)',
			'rgba(54, 162, 235, 1)',
			'rgba(255, 206, 86, 1)',
			'rgba(75, 192, 192, 1)',
			'rgba(153, 102, 255, 1)',
			'rgba(255, 159, 64, 1)',
			'rgba(40, 191, 123, 1)',
			'rgba(5, 94, 237, 1)',
			'rgba(240, 73, 7, 1)',
			'rgba(163, 181, 43, 1)',   //10월
			'rgba(7, 240, 228, 1)',   //11월
			'rgba(227, 11, 141, 1)'   //12월
		],
		borderWidth: 1
		}
		]
		},
		options: {
		scales: {
		yAxes: [{
		ticks: {
		beginAtZero: true
		}
		}]
		}
		}
		});
	}
	
}

</script>	

<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>