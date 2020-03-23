<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
      <!-- search-container start -->
      <div id="insert-container">
          <form class="needs-validation" action="${pageContext.request.contextPath}/document/updateDocument.do" 
          		name="documentEnrollFrm" method="post">
          		<div>
          		<input type="hidden" value="${memberLoggedIn.empName}" id="empName" name="empName" />
          		<input type="hidden" value="${list.docNo}" id="docNo" name="docNo" />
          		</div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="documentDate">일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                <input type="text" id="documentDate" value="${list.regDate}" readonly name="documentDate" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div>   
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                	<label for="documentTitle">제  목</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="documentTitle" value="${list.docTitle}" readonly name="documentTitle" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
	                </div> 
                </div>
                <div class="form-row nextApproval">
                        <label for="docLastapproval">결재자</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <c:forEach items="${docLine}" var="d" varStatus="vs">
                        	<c:if test="${d.returnYn=='Y' && d.nextWriter!=null}">
                        	<input type="text" id="docLastapproval" value="${d.nextWriter}" style="border:1px solid red" readonly name="docLastapproval" class="form-control bg-light small nextWriter" aria-label="Search" aria-describedby="basic-addon2">
                    		&nbsp;&nbsp;&nbsp;&nbsp;
                        	</c:if>
                        	<c:if test="${d.returnYn=='N' && d.nextWriter!=null}">
                        	<input type="text" id="docLastapproval" value="${d.nextWriter}" style="border:2px solid #00c500" readonly name="docLastapproval" class="form-control bg-light small nextWriter" aria-label="Search" aria-describedby="basic-addon2">
                    		&nbsp;&nbsp;&nbsp;&nbsp;
                        	</c:if>
                    	</c:forEach>
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">구  분 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="docType" value="${list.docType}" readonly name="docType" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
					
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내  용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control quality-comment" placeholder="${list.docContent}" readonly name="documentContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
				<div class="modal-footer">
                    <c:forEach items="${docLine}" var="d" varStatus="vs">
						<c:if test="${(memberLoggedIn.empName == d.nextWriter) and (d.returnYn == 'Y') and (prevWriter.returnYn=='N')}">
		        			<button type="submit" id="FrmBtn" name="submitApprove" value="1" class="btn btn-primary">결재</button>
		        			<button type="submit" id="FrmBtn" name="submitApprove" value="0" class="btn btn-primary">반려</button>
	        			</c:if>
						<c:if test="${(memberLoggedIn.empName == d.nextWriter) and (d.returnYn == 'N')}">
		        			<button id="FrmBtn" type="button" name="submitApprove" value="1" class="btn btn-primary">결재완료됨</button>
	        			</c:if>
        			</c:forEach>
						<c:if test="${(memberLoggedIn.empName == nextWriter.nextWriter) and (prevWriter.returnYn == 'Y')}">
		        			<button id="FrmBtn" type="button" name="submitApprove" value="1" class="btn btn-primary">결재진행중</button>
	        			</c:if>
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>       
            </form>
      </div>
         


<style>
.modal-body{
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
.quality-comment {
	width:200%;
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
.nextWriter{width:100px !important;}
.nextApproval{padding-bottom:15px;}

</style>
<script>
	$(()=>{
		var docLastapproval = $("#docLastapproval").val();
		console.log(docLastapproval[0]);
	});

</script>
