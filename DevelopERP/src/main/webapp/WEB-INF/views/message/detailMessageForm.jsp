<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>쪽지 보기</title>
</head>
<body>
      <!-- search-container start -->
      <div id="detail-message-container">
          		<div>
          		</div>
                <div class="form-row" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                        <label for="insertSender">보낸 사람</label>&nbsp;&nbsp;
                        <input type="text" id="insertSender" style="width:290px;"  value="${message.sender}" readonly name="insertSender" class="form-control bg-light small"  aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div>
                <div class="form-row">
                &nbsp;
	                	<label for="meTitle" style="padding-top:5px;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</label>&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="meTitle" name="meTitle" value="${message.meTitle}" readonly class="form-control bg-light small" required aria-label="Search" aria-describedby="basic-addon2">
                </div>
                <br />
                <div class="form-row message">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</label><br />
                        <textarea class="form-control detail-message-comment" placeholder="${message.message }" readonly name="messageContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
                <div class="modal-footer">
                	<c:if test="${message.sender != memberLoggedIn.empName}">
			          <button type="button" class="btn btn-primary detailMessage-answer" style="color: #fff;
    background-color: #4e73df;
    border-color: #4e73df;">답장</button>
			          </c:if>
			          <button type="button" class="btn btn-secondary insert detailMessage-close">닫기</button>
			      </div>
      </div>
         


<style>
.col-md-6 .mb-3 .col-md-6 .mb-3 .mb-4{
	width:350px !important;
}
.controll-modal-body.document{
  width: 60%;
}
#detail-message-container {
    height:460px;
}
.modal-content.messeage{
	width:550px;
	height:665px; 
}
#formGroupExampleInput {
    width: 70%;
}
.detail-message-comment {
	width:205%;
	height:90% !important;
}

#detail-message-container .btn-primary{
    background-color:#777;
    border-color: #777;
}
#detail-message-containerr .btn-primary:hover{
    background-color:#777;
    border-color: #777;
}
#detail-message-containerr #FrmBtn{
    float:right;
    margin-right: 5px;
}
#searchDocument {
	z-index:1080;
}
#accordionSidebar{
	background-image : linear-gradient(180deg,#00475d 10%,#0a0f29 100%) !important;
}
.form-row.message{
	height:327px;
}

</style>
<script>  


  $(()=>{
	  var sender = $("#insertSender").val();
	  console.log(sender);
	  $(".btn.detailMessage-answer").on('click',function(){
			$('.controll-modal-body-answerMessage').load("${pageContext.request.contextPath}/message/answerMessageForm.do?sender="+sender,function(){
		        $('#answerMessage').modal({backdrop: 'static', keyboard: false});
		        $('#answerMessage').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		    $('#detailMessage').modal("hide");
			});
		});
	  
	  
	  $(".btn-primary.detail").click(function(){
		  $('.controll-modal-body-messageList').load("${pageContext.request.contextPath}/message/messageList.do?empName=${memberLoggedIn.empName}",function(){
		        $('#messageList').modal({backdrop: 'static', keyboard: false});
		        $('#messageList').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
	    		$('#detailMessage').modal("hide");
		        
		    });
	    }); 
		$(".btn.detailMessage-close").click(function(){
			$("#detailMessage").modal('hide');
			$('.controll-modal-body-messageList').load("${pageContext.request.contextPath}/message/messageList.do?empName=${memberLoggedIn.empName}",function(){
		        $('#messageList').modal({backdrop: 'static', keyboard: false});
		        $('#messageList').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		    });
		})
	  
})
  
</script>
</body>
</html>