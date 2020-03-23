<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- Custom styles for this page -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">창고별 재고 조회</h1>

<br />

<!-- DataTales Example -->
<div class="card shadow mb-4" style="clear:both;">
	<div class="card-header py-3">
	<h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
</div>

  <%-- nav bar tap start --%>
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link" href="${pageContext.request.contextPath }/stock/storage/storageView.do?storeNo=0">전체창고</a>
	  </li>
	  
	  <c:forEach items="${storageList}" var="storageList" varStatus="vs">
		  <li class="nav-item">
		    <a class="nav-link" href="${pageContext.request.contextPath }/stock/storage/storageView.do?storeNo=${storageList.STORE_NO}">${storageList.STORE_NO}: ${storageList.STORE_NAME}</a>
		  </li>
	  </c:forEach>
	  
	</ul>
	
<%-- 막대그래프 추가 --%>
 <div id="chart"></div>
	
	
	<%-- nav bar tap end --%>
	
  <div class="card-body">
    <div class="table-responsive">
		<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		  <thead>
		    <tr>
		     <th>창고번호</th>
		     <th>창고이름</th>
		     <th>로트번호</th>
		     <th>품목분류</th>
		     <th>품목이름</th>
		     <th>수량</th>
		    </tr>
		  </thead>
		  
		  
		  <tbody>
	      	<c:forEach items="${storageStockList}" var="storageStockList" varStatus="vs">
		        <tr>
		          <td>${storageStockList.STORE_NO}</td>
		          <td>${storageStockList.STORE_NAME}</td>
		          <td>${storageStockList.LOT_NO}</td>
		          <td>${storageStockList.TYPE}</td>
		          <td>${storageStockList.STORED_ITEM_NAME}</td>
		          <td>${storageStockList.QUANTITY}</td>      
		        </tr>
	        </c:forEach>
		  </tbody>
		  
		</table>
    </div>
  </div>
</div>
         
<!-- ================================================================== 그래프 Start -->


<style>

#chart {
  padding: 20px;
}

table {
  width: 100%;
  height: 400px;
}

.charttitle {
  text-align: center;
}

.bars td {
  vertical-align: bottom;
}

.bars div:hover {
  opacity: 0.6;
}

.legend {
  vertical-align: bottom;
  padding-left: 30px;
  text-align: left;
  width: 7px;
}

.legbox {
  display: block;
  clear: both;
}

.xaxisname {
  margin: 5px;
  color: #fff;
  font-size: 77%;
  padding: 5px;
  float: left;
}


/*Flat UI colors*/

.one {
  background: #16A085;
}

.two {
  background: #2ECC71;
}

.three {
  background: #27AE60;
}

.four {
  background: #3498DB;
}

.five {
  background: #2980B9;
}

.six {
  background: #9B59B6;
}

.seven {
  background: #8E44AD;
}

.eight {
  background: #34495E;
}

.nine {
  background: #2C3E50;
}

.ten {
  background: #22313f;
}

.eleven {
  background: #F1C40F;
}

.twelve {
  background: #F39C12;
}

.thirteen {
  background: #E67E22;
}

.fourteen {
  background: #D35400;
}

.fifteen {
  background: #E74C3C;
}

.sixteen {
  background: #C0392B;
}

.seventeen {
  background: #ECF0F1;
}

.seventeen.clouds {
  color: #BDC3C7;
}

.eighteen {
  background: #BDC3C7;
}

.nineteen {
  background: #95A5A6;
}

.twenty {
  background: #7F8C8D;
}
</style>

<script>
var chartjson = {
		
  "title": "창고번호별 수량 차트",
  "data": ${storageTotalList},
  
  "xtitle": "Secured Marks",
  "ytitle": "Marks",
  "ymax": 100,
  "ykey": 'STORE_SUM',
  "xkey": "STORE_NO",
  "prefix": "개"
}

//chart colors
var colors = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen',
	'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen'
	,'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen'];

//constants
var TROW = 'tr',
  TDATA = 'td';

var chart = document.createElement('div');
//create the chart canvas
var barchart = document.createElement('table');
//create the title row
var titlerow = document.createElement(TROW);
//create the title data
var titledata = document.createElement(TDATA);
//make the colspan to number of records
titledata.setAttribute('colspan', chartjson.data.length + 1);
titledata.setAttribute('class', 'charttitle');
titledata.innerText = chartjson.title;
titlerow.appendChild(titledata);
barchart.appendChild(titlerow);
chart.appendChild(barchart);

//create the bar row
var barrow = document.createElement(TROW);

//lets add data to the chart
for (var i = 0; i < chartjson.data.length; i++) {
  barrow.setAttribute('class', 'bars');
  var prefix = chartjson.prefix || '';
  //create the bar data
  var bardata = document.createElement(TDATA);
  var bar = document.createElement('div');
  bar.setAttribute('class', colors[i]);
  bar.style.height = chartjson.data[i][chartjson.ykey]/30 + "px";
  bardata.innerText = chartjson.data[i][chartjson.ykey];
  bardata.appendChild(bar);
  barrow.appendChild(bardata);
}

//create legends
var legendrow = document.createElement(TROW);
var legend = document.createElement(TDATA);
legend.setAttribute('class', 'legend');
legend.setAttribute('colspan', chartjson.data.length);

//add legend data
for (var i = 0; i < chartjson.data.length; i++) {
  var legbox = document.createElement('span');
  legbox.setAttribute('class', 'legbox');
  var barname = document.createElement('span');
  barname.setAttribute('class', colors[i] + ' xaxisname');
  var bartext = document.createElement('span');
  bartext.innerText = chartjson.data[i][chartjson.xkey] + "번 창고";
  legbox.appendChild(barname);
  legbox.appendChild(bartext);
  legend.appendChild(legbox);
}
barrow.appendChild(legend);
barchart.appendChild(barrow);
barchart.appendChild(legendrow);
chart.appendChild(barchart);
document.getElementById('chart').innerHTML = chart.outerHTML;
</script>
<!-- ==================================================================  그래프 End -->           
          
          
<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="storageModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
	        <div class="modal-header">
	            <h5 class="modal-title controll-title"></h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	            </button>
	        </div>
	        <div class="modal-body controll-modal-body">
	            <!-- <p>Modal body text goes here.</p> -->
	        </div>
        </div>
    </div>
</div>




  
<script>
	$("#storageUpdate_button").click(function(){
	 $('.controll-modal-body').load("${pageContext.request.contextPath}/stock/rm/modalRmInsert.do",function(){
	        $('#storageModal').modal({backdrop: 'static', keyboard: false});
	        $('#storageModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("재고 수정하기");
		});
	});
	
	$("#storageSearch_button").click(function(){
	    $('.controll-modal-body').load("${pageContext.request.contextPath}/stock/rm/modalRmSearch.do",function(){
	        $('#storageModal').modal({backdrop: 'static', keyboard: false});
	        $('#storageModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("재고 상세 검색하기");
	    });
	});
</script>

<style>
#storageModal{
	z-index: 1060;
}
</style>

<!-- Page level plugins -->
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>






