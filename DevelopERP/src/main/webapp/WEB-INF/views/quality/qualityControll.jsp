<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<script src="${pageContext.request.contextPath }/resources/js/jquery.table2excel.js"></script>
 	<script type="text/javascript" src="libs/js-xlsx/xlsx.core.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">부적합 관리</h1>
           <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="float:right;">
            <div class="input-group" style="margin:30px;" >
              <div class="input-group-append">
                <button class="btn btn-primary" type="button" id="quality-search-button">
                	  부적합 상세 검색하기&nbsp;&nbsp;&nbsp; <i class="fas fa-search fa-sm"></i>
                </button> &nbsp;&nbsp;&nbsp;&nbsp;
                <button class="btn" type="button" id="export-excel-button">
                	  <img src="${pageContext.request.contextPath }/resources/images/excel.png" alt="" style="width:40px;height:40px;"/>
                </button> 
              </div>
            </div>
          </form>
          <br />

          <!-- DataTales Example -->
          <div class="card shadow mb-4" style="clear:both;">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered quality-table" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>부적합 관리 번호</th>
                      <th>Lot번호</th>
                      <th>창고번호</th>
                      <th>제품군</th>
                      <th>작성일자</th>
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${list }" var="l">
	                    <tr>
	                      <td>${l.qualityNo }</td>
	                      <td>${l.lotNo }</td>
	                      <td>${l.storeNo }</td>
	                      <td>${l.type }</td>
	                      <td>${l.regDate }</td>
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
  <!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="qualityControllModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title quality-controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body quality-controll-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

  <!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="myUpdateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title Update-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body update-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

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

  
<script>
$(".quality-table tbody tr").click(function(){
	var quality_no = $(this).children().eq(0).html();
	$('.update-modal-body').children().remove();
	 $('.update-modal-body').load("${pageContext.request.contextPath}/quality/updateQualityForm.do?quality_no="+quality_no,function(){
	        $('#myUpdateModal').modal({backdrop: 'static', keyboard: false});
	        $('#myUpdateModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".Update-title").html("");
	        $(".Update-title").html("부적합 정보 수정");
		});
});
$("#quality-search-button").click(function(){
    $('.quality-controll-modal-body').load("${pageContext.request.contextPath}/quality/qualitySearch.do",function(){
        $('#qualityControllModal').modal({backdrop: 'static', keyboard: false});
        $('#qualityControllModal').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        
        $(".quality-controll-title").html("");
        $(".quality-controll-title").html("부적합 상세조회");
        
    });
});

$("#export-excel-button").click(function(){
	  $("#dataTable").table2excel({
		      // exclude CSS class
		      exclude:".noExl",
		      name:"Worksheet Name",
		      filename:"SomeFile",//do not include extension
		      fileext:".xls" // file extension
    	});
});

	
	
</script>
<style>
.quality-table tbody tr td:hover{
	cursor:pointer;
}
</style>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>