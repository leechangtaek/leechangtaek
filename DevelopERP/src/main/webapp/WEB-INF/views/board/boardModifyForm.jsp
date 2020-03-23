<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%Date now = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<title>게시물 수정</title>
</head>
<body>


      <!-- search-container start -->
      <div id="insert-container">
          <form class="needs-validation" action="${pageContext.request.contextPath}/board/boardModifyEnd.do" 
          		name="boardEnrollFrm" method="post">
          		<div>
          		<input type="hidden" value="${boardCategory.categoryWriter}" id="categoryWriter" name="categoryWriter" />
          		<input type="hidden" value="${boardCategory.categoryNo}" id="categoryNo" name="categoryNo" />
          		
          		</div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="datepicker">일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" id="categoryDate" name="categoryDate" value=<%=sdf.format(now)%> readonly  >
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="datepicker">타입</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="boardNo" id="boardNo" style="width:100px">
							<option value="" selected disabled >게시판</option>
								<c:forEach items="${board}" var="d">
									<option value="${d.boardNo}" ${d.boardNo eq boardCategory.boardNo? 'selected':"" }>${d.boardName}</option>
								</c:forEach>
						</select>
                    </div>
                </div>   
                  <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="datepicker">제 목</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" id="categoryTitle" name="categoryTitle" value='${boardCategory.categoryTitle}' required >
                    </div>
                </div>   
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내  용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control quality-comment" required name="categoryComment" cols="80" rows="5" aria-label="With textarea" >${boardCategory.categoryComment}</textarea>	
                    </div>
                </div>
				<div class="modal-footer">
        			<button type="submit" id="FrmBtn" name="submit" class="btn btn-primary">수정</button>
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>       
            </form>
      </div>
         


<style>
.card-body.boardModify{
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
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
.quality-comment {
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

</style>
<script>  

  $(()=>{
	  var date = new Date();
	  var yyyy = date.getFullYear();
	  var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
	  var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
	   
	  $("input[type=date]").val(yyyy+"-"+mm+"-"+dd);

	  
	  
})
  
</script>
</body>
</html>