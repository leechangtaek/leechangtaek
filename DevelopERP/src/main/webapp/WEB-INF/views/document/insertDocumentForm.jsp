<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>기안서 작성</title>
</head>
<body>
      <!-- search-container start -->
      <div id="insert-container">
          <form class="needs-validation" action="${pageContext.request.contextPath}/document/enrollDocument.do" 
          		name="documentEnrollFrm" method="post">
          		<div>
          		<input type="hidden" value="${memberLoggedIn.empName}" id="empName" name="empName" />
          		<input type="hidden" value="${memberLoggedIn.email}" id="email" name="email" />
          		</div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="datepicker">일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="date" id="documentDate" name="documentDate" required >
                    </div>
                </div>   
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                	<label for="documentTitle">제  목</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="documentTitle" name="documentTitle" class="form-control bg-light small" required aria-label="Search" aria-describedby="basic-addon2">
	                </div> 
                </div>
                <div class="form-row" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                        <label for="docLastapproval">결재자</label>&nbsp;&nbsp;
                        <input type="text" id="docLastapproval" style="width:195px;" name="docLastapproval" class="form-control bg-light small" required  aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary plusApprovalBtn" type="button">
                            <i class="fas fa-plus fa-sm"></i>
                        </button>
                        <button class="btn btn-primary minusApprovalBtn" type="button">
                            <i class="fas fa-minus fa-sm"></i>
                        </button>
                    </div>
                    <div class="col-md-6 mb-3">
                        <button class="btn btn-primary searchDocument" type="button">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row approval1" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="docLastapproval" style="width:195px;" name="docLastapproval1" class="form-control bg-light small"  aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary plusApprovalBtn1" type="button">
                            <i class="fas fa-plus fa-sm"></i>
                        </button>
                        <button class="btn btn-primary minusApprovalBtn1" type="button">
                            <i class="fas fa-minus fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row approval2" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="docLastapproval" style="width:195px;" name="docLastapproval2" class="form-control bg-light small"  aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary plusApprovalBtn2" type="button">
                            <i class="fas fa-plus fa-sm"></i>
                        </button>
                        <button class="btn btn-primary minusApprovalBtn2" type="button">
                            <i class="fas fa-minus fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row approval3" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="docLastapproval" style="width:195px;" name="docLastapproval3" class="form-control bg-light small"  aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary minusApprovalBtn3" type="button">
                            <i class="fas fa-minus fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">구  분 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <tr>
						<td>
							<select name="documentType" id="documentType" required>
								<option value="" selected disabled >구분</option>
									<c:forEach items="${docTypeList}" var="d">
										<option value="${d.DOC_TYPE}">${d.DOC_TYPE}</option>
									</c:forEach>
							</select>
						</td>
					</tr>
                    </div>
                </div>
                <div class="form-row click documentType">
                    <div class="col-md-6 mb-3 ">
						<label for="startDate">시작일자</label>&nbsp;&nbsp;&nbsp;
					    <input type="date" name="startDate" class="form-control document startDate">
                    </div>
                    <div class="col-md-6 mb-3 ">
					    <label for="endDate">종료일자</label>&nbsp;&nbsp;&nbsp;
					    <input type="date" name="endDate" class="form-control document endDate">	
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내  용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control document-comment" id="summernote" required name="documentContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
				<div class="modal-footer">
        			<button type="submit" id="FrmBtn" name="submit" class="btn btn-primary">전송</button>
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>       
            </form>
      </div>
         


<style>

.col-md-6 .mb-3 .col-md-6 .mb-3 .mb-4{
	width:350px !important;
}
.controll-modal-body.document{
  width: 60%;
}
#insert-container {
    width:660px;
}
.modal-content{
	width:684px;
	height:100% !important; 
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
.document-comment {
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

</style>
<script> 
$(document).ready(function() {
    $('#summernote').summernote({
    		width:630,
            height: 50,                 // set editor height
            minHeight: 200,             // set minimum height of editor
            maxHeight: null,             // set maximum height of editor
            focus: true                  // set focus to editable area after initializing summernote
    });
});



  $(()=>{
	  $('#summernote').summernote();
	  $(".click.documentType").hide();
	  
	  var date = new Date();
	  var yyyy = date.getFullYear();
	  var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
	  var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
	   
	  $("input[type=date]").val(yyyy+"-"+mm+"-"+dd);
	  
	  $(".form-row.approval1").hide();
	  $(".form-row.approval2").hide();
	  $(".form-row.approval3").hide();
	  
	  $(".plusApprovalBtn").click(function(){
		 $(".plusApprovalBtn").hide();
		 $(".form-row.approval1").show();
	  });
	  $(".plusApprovalBtn1").click(function(){
		 $(".plusApprovalBtn1").hide();
		 $(".form-row.approval2").show();
	  });
	  $(".minusApprovalBtn").click(function(){
		  $("[name=docLastapproval]").val("");
	  });
	  $(".minusApprovalBtn1").click(function(){
		 $(".plusApprovalBtn").show();
		 $(".form-row.approval1").hide();
		 $("[name=docLastapproval1]").val("");
	  });
	  $(".plusApprovalBtn2").click(function(){
		 $(".plusApprovalBtn2").hide();
		 $(".form-row.approval3").show();
	  });
	  $(".minusApprovalBtn2").click(function(){
		 $(".plusApprovalBtn1").show();
		 $(".form-row.approval2").hide();
		 $("[name=docLastapproval2]").val("");
	  });
	  $(".minusApprovalBtn3").click(function(){
		 $(".plusApprovalBtn2").show();
		 $(".form-row.approval3").hide();
		 $("[name=docLastapproval3]").val("");
	  });
	  
	  
	  
	  $(".searchDocument").click(function(){
	    	var title = $(this).siblings().html();
	    	 $('.searchModalBody').load("${pageContext.request.contextPath}/document/documentSelectList.do",function(){
	 	        $('#searchDocument').modal({backdrop: 'static', keyboard: false});
	 	        $('#searchDocument').modal({show:true});
	 	        $(".modal-backdrop.in").css('opacity', 0.4);
	 	       	$(".search-title").html("");
	 	        $(".search-title").html("회원리스트");
	 		});
	            
	    });
	  
	  $(".searchModal-end").click(function(){
	    	$('#searchDocument').modal("hide");
	    }); 
	  
	  $("#documentType").change(function(){
		 var documentType= $("#documentType").val();
		 if(documentType=="휴가신청서"){
			 $(".click.documentType").show();
		 }else{
			 $(".click.documentType").hide();
		 }
	  })
})
  
</script>
</body>
</html>