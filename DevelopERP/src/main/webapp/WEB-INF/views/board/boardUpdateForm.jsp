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
 <!-- Custom styles for this page -->

<!-- Page Heading -->

			

          <!-- DataTales Example -->
          <div class="card shadow mb-4 updateBoard" style="clear:both;">
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered board-list-table "  width="100%" cellspacing="0">
                  <thead>
                    <tr>                    
                      <th>No</th>
                      <th style="width:180px;">제목</th>
                      <th style="width:75px;">작성자</th>
                      <th>작성일자</th>
                      <th>수정</th>
                      <th>삭제</th>
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${list}" var="l" varStatus="vs">
	                    <tr class="getTr">
	                      <td id="${l.categoryNo}">${vs.count}</td>
	                      <td>${l.categoryTitle }</td>
	                      <td>${l.categoryWriter}</td>
	                      <td>${l.categoryDate}</td>
	                     <td><button class="btn btn-primary" type="button" id="board-Modify-button">수정 </button></td>
	                     <td><button class="btn btn-primary" type="button" id="board-Delete-button">삭제 </button></td>
	                      <td hidden>${l.categoryNo}</td>
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="modal-footer">
          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          </div>
          
          
 <!-- board-Modify- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="boardModify">
    <div class="modal-dialog" role="document">
        <div class="modal-content boardModify">
        <div class="modal-header">
            <h5 class="modal-title controll-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body controll-modal-body boardModify">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        <div class="modal-footer">
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>  
        </div>
    </div>
</div>
<style>
.modal-content.boardUpdateModal{	
	width:140%;
}
.card.shadow.mb-4.updateBoard{
	height:500px;
	overflow-y:auto;
}
</style>
 <script>
 $(()=>{
 $("#board-Delete-button ").click(function(){
	 var categoryNo= $(this).closest("tr").children().eq(6).text();
	location.href = "${pageContext.request.contextPath}/board/boardDelete.do?categoryNo="+categoryNo;
	});
 $("#board-Modify-button ").click(function(){
	 var categoryNo= $(this).closest("tr").children().eq(6).text();
	 $('.controll-modal-body').load("${pageContext.request.contextPath}/board/boardModify.do?categoryNo="+categoryNo,function(){
	        $('#boardModify').modal({backdrop: 'static', keyboard: false});
	        $('#boardModify').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".controll-title").html("");
	        $(".controll-title").html("게시판 수정");
		});
	});
 });
 </script>
 
 
 