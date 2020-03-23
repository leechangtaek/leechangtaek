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
<!-- Page Heading -->
          <!-- DataTales Example -->
            <h1 class="h3 mb-2 text-gray-800">문서결재</h1>
           <br />
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">조회결과</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered quality-table" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>No</th>
                      <th>기안일자</th>
                      <th>제목</th>
                      <th>구분</th>
                      <th>기안자</th>
                      <th>결재자</th>
                      <th>진행상태</th>
                      <th>결재</th>
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${docList }" var="l" varStatus="vs">
	                    <tr class="getTr">
	                      <td id="${l.docNo}">${vs.count}</td>
	                      <td>${l.regDate }</td>
	                      <td>${l.docTitle }</td>
	                      <td>${l.docType }</td>
	                      <c:if test="${l.docWriter==memberLoggedIn.empName}">
		                      <td style="color:black;">${l.docWriter}</td>
	                      </c:if>
	                      <c:if test="${l.docWriter!=memberLoggedIn.empName}">
		                      <td>${l.docWriter}</td>
	                      </c:if>
	                      <c:if test="${l.docLastapproval==memberLoggedIn.empName}">
		                      <td style="color:black;">${l.docLastapproval}</td>
		                  </c:if>
	                      <c:if test="${l.docLastapproval!=memberLoggedIn.empName}">
		                      <td>${l.docLastapproval}</td>
		                  </c:if>
		                  <c:if test="${l.docStatus=='결재완료'}">
	                     	 <td style="color:red;">${l.docStatus}</td>
	                      </c:if>
		                  <c:if test="${l.docStatus!='결재완료'}">
	                     	 <td>${l.docStatus}</td>
	                      </c:if>
	                      <td><a href="#">보기</a></td>
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
          <button class="btn btn-primary" type="button" id="document-insert-button">신규 </button>
          
  <!-- insertDocument Modal -->
<div class="modal" tabindex="-1" role="dialog" id="documentAddModal">
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

  <!-- detailView Modal -->
<div class="modal modal-center" tabindex="-1" role="dialog" id="documentDetailView">
    <div class="modal-dialog modal-center" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body document">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>
<%--documentLastApproval modal --%>
<div class="modal" tabindex="-1" role="dialog" id="searchDocument">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
      <div class="modal-header">
          <h5 class="modal-title search-title" id="searchModalTitle"> </h5>
      </div>
      <div class="modal-body searchModalBody">
      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-primary searchModal-end">닫기</button>
      </div>
      </div>
  </div>
</div>
  
<script>
$(()=>{
	$(".getTr td a").click(function(){
		var tr = $(this).parent().parent();
		var td = tr.children();
		
		var tdDocNo = td.eq(0).attr("id");
		$('.controll-modal-body').load("${pageContext.request.contextPath}/document/documentDetailView.do?empName=${memberLoggedIn.empName}&docNo="+tdDocNo,function(){
	        $('#documentDetailView').modal({backdrop: 'static', keyboard: false});
	        $('#documentDetailView').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("결재내용보기");
		});
		
	})
})
$("#document-insert-button").click(function(){
 $('.controll-modal-body').load("${pageContext.request.contextPath}/document/insertDocumentForm.do",function(){
        $('#documentAddModal').modal({backdrop: 'static', keyboard: false});
        $('#documentAddModal').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        $(".controll-title").html("");
        $(".controll-title").html("기안서 작성");
	});
});

</script>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>