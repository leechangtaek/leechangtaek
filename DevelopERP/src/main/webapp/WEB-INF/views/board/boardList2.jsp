<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%Date now = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  
<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="float:right;">
		<div class="input-group" style="margin:30px;">
			<div class="input-group-append">
				<button class="btn btn-primary" type="button" id="board-insert-button">
					  게시판 등록
				</button> &nbsp;&nbsp;&nbsp;&nbsp;
				<button class="btn btn-primary" type="button" id="board-update-button">
					  게시판 수정/삭제
				</button> &nbsp;&nbsp;&nbsp;&nbsp;
			
			</div>
		</div>
	</form>
<!-- Page Heading -->

			     <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">게시판 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <tr>
						<td>
							<select name="boardType" id="boardType" required>
								<option value="" selected disabled >타입</option>
									<c:forEach items="${board}" var="b">
										<option value="${b.boardNo}">${b.boardName}</option>
									</c:forEach>
							</select>
						</td>
					</tr>
                    </div>
                </div>

          <!-- DataTales Example -->
          <div class="card shadow mb-4" style="clear:both;">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">조회 결과</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered quality-table board" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>                    
                      <th>No</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>작성일자</th>
                      <th>타입</th>
                      <th>보기</th>
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${boardlist }" var="l" varStatus="vs">
	                    <tr class="getTr">
	                      <td id="${l.CATEGORY_NO}" class="categoryNo">${vs.count}</td>
	                      <td>${l.CATEGORY_TITLE }</td>
	                      <td>${l.CATEGORY_WRITER }</td>
	                      <td>${l.CATEGORY_DAY}</td>
	                      <td>${l.BOARD_NAME}</td>
	                      <td><a href="#" id="${l.CATEGORY_NO}" class="boardDetailView">보기</a></td>
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
       
          
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

  <!--UpdateBoard Modal -->
<div class="modal" tabindex="-1" role="dialog" id="boardUpdateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content boardUpdateModal">
        <div class="modal-header boardUpdateModal">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body boardUpdateModal">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

 <!-- detailView Modal -->
<div class="modal" tabindex="-1" role="dialog" id="boardDetailView">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body boardDetailView">
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
$(()=>{
	$('.controll-modal-body.boardDetailView').load("${pageContext.request.contextPath}/board/boardDetailView.do?categoryNo=${categoryNo}",function(){
	    $('#boardDetailView').modal({backdrop: 'static', keyboard: false});
	    $('#boardDetailView').modal({show:true});
	    $(".modal-backdrop.in").css('opacity', 0.4);
	    $(".controll-title").html("");
	    $(".controll-title").html("상세보기");
	});
})


/* $(".btn-primary").click(function(){
var boardNo= $(this).closest("tr").children().eq(0).html(); */
	function detailBoard(){
		var tr = $(this).parent().parent();
		var td = tr.children();
		console.log(tr);
		
		var tdCategoryNo = td.eq(0).attr("id");
		console.log(tdCategoryNo);
		console.log(tdCategoryNo);
		$('.controll-modal-body.boardDetailView').load("${pageContext.request.contextPath}/board/boardDetailView.do?categoryNo="+tdCategoryNo,function(){
	        $('#boardDetailView').modal({backdrop: 'static', keyboard: false});
	        $('#boardDetailView').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("상세보기");
		});
		
	};
$("#board-insert-button").click(function(){
 $('.controll-modal-body').load("${pageContext.request.contextPath}/board/insertBoardForm.do",function(){
        $('#boardAddModal').modal({backdrop: 'static', keyboard: false});
        $('#boardAddModal').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        $(".controll-title").html("");
        $(".controll-title").html("게시판 작성");
	});
});

$("#board-update-button").click(function(){
 $('.controll-modal-body').load("${pageContext.request.contextPath}/board/UpdateBoardForm.do?categoryWriter=${memberLoggedIn.empName}",function(){
        $('#boardUpdateModal').modal({backdrop: 'static', keyboard: false});
        $('#boardUpdateModal').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        $(".controll-title").html("");
        $(".controll-title").html("게시판 수정/삭제");
	});
});

$("#boardType").change(function(){
	var boardNo = $("#boardType").val();
	console.log(boardNo);
	if(boardNo==0) {
		location.href = "${pageContext.request.contextPath}/board/boardList.do";
	}
	else {
		location.href ="${pageContext.request.contextPath}/board/boardClubList.do?boardNo="+boardNo;
	}
});


$(".boardDetailView").click(function(){
	var boardNo = $(this).attr("id");
	$('.controll-modal-body.boardDetailView').load("${pageContext.request.contextPath}/board/boardDetailView.do?categoryNo="+boardNo,function(){
        $('#boardDetailView').modal({backdrop: 'static', keyboard: false});
        $('#boardDetailView').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
        $(".controll-title").html("");
        $(".controll-title").html("상세보기");
	});
	});
	

</script>

<style>
#myModal{
	z-index: 1060;
}

</style>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>