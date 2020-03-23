<%@page import="com.dev.erp.board.model.vo.BoardCategory"%>
<%@page import="com.dev.erp.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="com.dev.erp.board.model.vo.BoardComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% List<BoardComment> commentList 
= (List<BoardComment>)request.getAttribute("boardComment"); 
BoardCategory boardCategory=(BoardCategory)request.getAttribute("categorylist");
String name=(String)request.getAttribute("name");
%>
      <!-- search-container start -->
      <div id="insert-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="categoryDate">일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                <input type="text" id="categoryDate" value="${categorylist.categoryDate}" readonly name="categoryDate" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div> 
                  
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                	<label for="categoryTitle">제  목</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="text" id=categoryTitle value="${categorylist.categoryTitle}" readonly name="categoryTitle" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
	                </div> 
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="categoryWriter">작성자</label>&nbsp;&nbsp;
                        <input type="text" id="categoryWriter" value="${categorylist.categoryWriter}" readonly name="categoryWriter" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="categoryComment">내 용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
						<textarea class="form-control category-comment" placeholder="${categorylist.categoryComment}" readonly name="documentContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
           

<div class="comment-container">
	<div class="comment-editor">
		<form action="${pageContext.request.contextPath}/board/boardCommentInsert.do"
			  method="post"
			  name="boardCommentFrm">
			  <input type="hidden" name="BoardRef" 
			  		 value="${categorylist.categoryNo}" />
			  <input type="hidden" name="email"
			  		 value='${memberLoggedIn.email}'/>
			  <input type="hidden" name="name"
			  		 value='${memberLoggedIn.empName}'/>
			  <input type="hidden" name="BoardCommentLevel" value="1" />
			  <input type="hidden" name="BoardCommentRef" value="0" />
			  
			  <textarea name="BoardCommentContent" cols="63" rows="3" required></textarea>
			  <input type="submit" id="btn-insert" value="등록" />
		
		</form>
	</div>	
     
	<!-- 댓글목록테이블 -->
	<table id="tbl-comment">
	<%
		if(commentList != null && !commentList.isEmpty()){
			for(BoardComment bc : commentList){
				//1.댓글인 경우
				if(bc.getBoardCommentLevel() == 1){
	%>
		<tr class="level1">
			<td>
				<sub class="comment-writer"><%=bc.getName()%></sub>
				<sub class="comment-date"><%=bc.getBoardCommentDate() %></sub>
				<br />
				<%=bc.getBoardCommentContent() %>
			</td>
			<td>
				<button class="btn-reply"
						value="<%=bc.getBoardCommentNo()%>">답글</button>
				<%if(bc.getName().equals(name)||name.equals("관리자")){ %>				
				<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>">삭제</button>
				<%} %>
			</td>
		
		
		</tr>
	<%
				}
				//2.대댓글(답글)인 경우
				else{
	%>
		<tr class="level2">
			<td>
				<sub class="comment-writer"><%=bc.getName() %></sub>
				<sub class="comment-date"><%=bc.getBoardCommentDate() %></sub>
				<br />
				<%=bc.getBoardCommentContent() %>
			</td>
			<td>
				  <%if(bc.getName().equals(name)||name.equals("관리자")){ %>
				<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>">삭제</button>
				<%} %>
			</td>
		</tr>
	<%
				}
			}
		}
	%>
	</table> 
	</div>
	</div>

<style>

#boardDetailView{
	z-index: 1060;
	width:100%;	
}
.modal-body{
}
#searchModal {
  width: 60%;
}
#insert-container {
    width:660px;
}
.modal-content{
	width:700px;
	height:100% !important;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
.category-comment {
	width:200%;
	height:300%;
}
#insert-container .btn-primary{
    background-color:#777;
    border-color: #777;
}
#insert-container .btn-primary:hover{
    background-color:#777;
    border-color: #777;
}
#insert-container #FrmBtn{
    float:right;
    margin-right: 5px;
}
#searchDocument {
	z-index:1080;
}
#accordionSidebar{
	background-image : linear-gradient(180deg,#00475d 10%,#0a0f29 100%) !important;
}
.boardDetailView{
	height:484.5px;
	overflow-y:auto;
}




div.comment-container #btn-insert{width:60px; height:50px; color:white; background:#3300ff; position:relative; top:-20px;}

table#tbl-comment{width:644px;  border-collapse:collapse; clear:both; } 
table#tbl-comment tr td{border-bottom:1px solid; border-top:1px solid; padding:5px; text-align:left; line-height:120%;}
table#tbl-comment tr td:first-of-type {padding: 5px 5px 5px 50px;}
table#tbl-comment tr td:last-of-type {text-align:right; width: 100px;}
table#tbl-comment button.btn-reply{display:none;}
table#tbl-comment tr:hover {background:lightgray;}
table#tbl-comment tr:hover button.btn-reply{display:inline;}
table#tbl-comment sub.comment-writer {color:navy; font-size:14px}
table#tbl-comment sub.comment-date {color:tomato; font-size:10px}
table#tbl-comment tr.level2 {color:gray; font-size: 14px;}
table#tbl-comment tr.level2 td:first-of-type{padding-left:100px;}
table#tbl-comment tr.level2 sub.comment-writer {color:#8e8eff; font-size:14px}
table#tbl-comment tr.level2 sub.comment-date {color:#ff9c8a; font-size:10px}

table#tbl-comment textarea{margin: 4px 0 0 0;}
table#tbl-comment .btn-insert2{width:60px; height:23px; color:white; background:#3300ff; position:relative; top:-5px; left:10px;}

table#tbl-comment button.btn-delete{background:red; color:white; display:none;}
table#tbl-comment tr:hover button.btn-delete{display:inline;}



</style>
<script>
$(function(){
	
    //삭제버튼 클릭시
    $(".btn-delete").click(function(){
        if(!confirm("정말 삭제하시겠습니까?")) return;
        //삭제처리후 돌아올 현재게시판번호도 함께 전송함.
        location.href="<%=request.getContextPath()%>/board/boardCommentDelete.do?BoardCommentNo="+$(this).val()+"&BoardRef=${categorylist.categoryNo}";
    });
    
    
	//대댓글(답글)버튼 .btn-reply
	$(".btn-reply").on("click", function(e){
	
			var tr = $("<tr></tr>");
			var html = '<td style="display:none; text-align:left;" colspan=2>';
			html += '<form action="<%=request.getContextPath()%>/board/boardCommentInsert.do" method="POST">';
			html += '<input type="hidden" name="boardRef" value=${categorylist.categoryNo} />';
			html += '<input type="hidden" name="name" value=${memberLoggedIn.empName} />';
			html += '<input type="hidden" name="email" value=${memberLoggedIn.email} />';
			html += '<input type="hidden" name="boardCommentLevel" value="2" />';
			html += '<input type="hidden" name="boardCommentRef" value="'+$(this).val()+'" />';
			html += '<textarea name="boardCommentContent" cols="60" rows="1"></textarea>';
			html += '<input type="submit" class="btn-insert2" value="등록" />';
			html += '</form></td>';
			tr.html(html);
			
			console.log($(this).parent().parent());//tr.level1
			console.log(tr.children('td'));//방금 생성한 td
			
			tr.insertAfter($(this).parent().parent())
			  .children('td')
			  .slideDown(800)
			  .children('form')
			  .submit(function(e){
				 var $textarea = $(this).children("textarea");
				 
				 if($textarea.val().trim().length == 0)
					 e.preventDefault();
				 	
			  });
			  
			  
		
		
	
	});
	
})
</script>

