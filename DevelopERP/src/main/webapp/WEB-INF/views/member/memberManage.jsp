<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%int i=0; %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">사원 관리</h1>

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
                      <th>이름</th>
                      <th>주민번호</th>
                      <th>이메일</th>
                      <th>핸드폰</th>
                      <th>부서명</th>
                      <th>직급</th>
                      <th>입사일</th>
                     
                      <th>수정</th>
                      <th>삭제</th>
                   
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${list}" var="l">
	                    <tr value="${l.email }">
	                      <td>${l.empName }</td>
	                      <td>${l.empNo }</td>
	                      <td>${l.email }</td>
	                      <td>${l.phone }</td>
	                      <td>${l.deptCode }</td>
	                      <td>${l.jobCode }</td>
	                      <td>${l.hireDate }</td>                  	                    
	                      <td><button class="btn btn-primary" type="button" id="Modify">수정하기</button> </td>
	                      <td><button class="btn btn-primary" type="button"  id="Delete" >삭제</button></td>              	                    
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
  <!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="empModify">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title empModify-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body">
            <p>Modal body text goes here.</p>
        </div>
        
        </div>
    </div>
</div>
  
<script>
// $(".btn-primary").click(function(){
//  	var facilityNo= $(this).closest("tr").children().eq(0).html();
// 	 $('.controll-modal-body').load("${pageContext.request.contextPath}/facility/facilityBook.do?facilityNo="+facilityNo,function(){
// 	        $('#myModal').modal({backdrop: 'static', keyboard: false});
// 	        $('#myModal').modal({show:true});
// 	        $(".modal-backdrop.in").css('opacity', 0.4);
// 	        $(".controll-title").html("");
// 	        $(".controll-title").html("시설물예약");
// 		});
// });
// function bookList(facilityNo,facilityName){

//  $('.controll-modal-body').load("${pageContext.request.contextPath}/facility/facilityBookList.do?facilityNo="+facilityNo,function(){
//         $('#myModal').modal({backdrop: 'static', keyboard: false});
//         $('#myModal').modal({show:true});
//         $(".modal-backdrop.in").css('opacity', 0.4);
//         $(".controll-title").html("");
//         $(".controll-title").html("시설물예약 현황("+facilityName+")");
// 	});}

$("#Modify ").click(function(){
	var email=$(this).parent().siblings().eq(2).text();
	console.log(email);
 $('.controll-modal-body').load("${pageContext.request.contextPath}/member/memberManageModify.do?email="+email,function(){
 $('#empModify').modal({backdrop: 'static', keyboard: false});
 $('#empModify').modal({show:true});
 $(".modal-backdrop.in").css('opacity', 0.4);
 $(".empModify-title").html("");
 $(".empModify-title").html("사원 정보 수정");
});
});
$("#Delete ").click(function(){
	var email=$(this).parent().siblings().eq(2).text();
	console.log(email);
	location.href = "${pageContext.request.contextPath}/member/memberDelete.do?email="+email;
});
</script>
<!-- <!-- <style> --> 
<!-- /* #myModal{ */ -->
<!-- /* 	z-index: 1060; */ -->
<!-- /* 	width:100%;	 */ -->
<!-- /* 	height:100%; */ -->
	
<!-- /* } */ -->

<!-- <!-- </style> --> 


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>