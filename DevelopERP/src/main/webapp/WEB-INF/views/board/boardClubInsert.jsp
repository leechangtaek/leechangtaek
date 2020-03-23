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
          
          <ul class="navbar-nav mr-auto">	  
		      	  <!-- 데모메뉴 DropDown변경 -->
				  <!--https://getbootstrap.com/docs/4.1/components/navbar/#supported-content-->
				  <li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						게시판
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do">사내게시판</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardClubInsert.do">공지사항게시판</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardNoticeInsert.do">동아리게시판</a>
					</div>
				  </li>
			      
			    </ul>

          <!-- DataTales Example -->
          <div class="card shadow mb-4" style="clear:both;">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
              	<ul class="nav nav-tabs">
              	
  <li class="nav-item">
    <a class="nav-link active" href="#">전체</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">진행중</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">완료</a>
  </li>
</ul>
            
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered quality-table" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>                    
                      <th>No</th>
                      <th>일자</th>
                      <th>작성자</th>
                      <th>동아리명</th>
                      <th>제목</th>
                      <th>장소</th>
                      <th>내용</th>
                    </tr>
                  </thead>
                  <tbody>
               	<c:forEach items="${boardclub }" var="l" varStatus = "vs">
                	<tr class = "getBo">
                	<td id ="${l.clubNo}">${vs.count}</td> 
	                      <td>${l.clubDate}</td>
	                      <td>${l.clubWriter }</td>
	                      <td>${l.clubName }</td> 
	                      <td>${l.clubTitle}</td>
						  <td>${l.categoryWhere}</td>			      
	                      <td><a href="#">보기</a></td>
	        
	                    
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
           <button class="btn btn-primary" type="button" id="board-insert-button">신규 </button>
          
  <!--insertBoard Modal -->
<div class="modal" tabindex="-1" role="dialog" id="boardAddModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header boardAddModal">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body boardAddModal">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

 <!-- detailView Modal -->
<div class="modal" tabindex="-1" role="dialog" id="boardClubDetailView">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body boardClubDetailView">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        <div class="modal-footer">
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>  
        </div>
    </div>
</div>

<%--boardLastApproval modal --%>
<div class="modal" tabindex="-1" role="dialog" id="searchBoard">
  <div class="modal-dialog" role="document">
      <div class="modal-content">
      <div class="modal-header">
          <h5 class="modal-title search-title" id="searchModalTitle"> </h5>
      </div>
      <div class="modal-body searchModalBody">
          <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-primary searchModal-end">닫기</button>
      </div>
      </div>
  </div>
</div>
  
<script>

/* $(".btn-primary").click(function(){
var boardNo= $(this).closest("tr").children().eq(0).html(); */
$(()=>{
	$(".getBo td a").click(function(){
		var tr = $(this).parent().parent();
		var td = tr.children();
		
		var tdClubNo = td.eq(0).attr("id");
		console.log(tdClubNo);
		$('.controll-modal-body.boardClubDetailView').load("${pageContext.request.contextPath}/board/boardClubDetailView.do?clubNo="+tdClubNo,function(){
	        $('#boardClubDetailView').modal({backdrop: 'static', keyboard: false});
	        $('#boardClubDetailView').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("상세보기");
		});
		
	})
})
$("#board-insert-button").click(function(){
 $('.controll-modal-body').load("${pageContext.request.contextPath}/board/insertBoardForm.do",function(){
        $('#boardAddModal').modal({backdrop: 'static', keyboard: false});
        $('#boardAddModal').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        $(".controll-title").html("");
        $(".controll-title").html("게시판 작성");
	});
});
	

</script>
<style>
#myModal{a
	z-index: 1060;
}

</style>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>