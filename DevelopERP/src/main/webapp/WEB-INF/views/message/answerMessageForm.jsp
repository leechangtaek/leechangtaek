<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>답장작성</title>
      <!-- search-container start -->
      <div id="answer-message-container">
          <form class="needs-validation" action="${pageContext.request.contextPath}/message/insertMessage.do" 
          		name="documentEnrollFrm" method="post">
          		<div>
          		<input type="hidden" value="${memberLoggedIn.empName}" id="empName" name="empName" />
          		</div>
                <div class="form-row" style="width:750px">
                    <div class="col-md-6 mb-3 col-md-6 mb-3">
                        <label for="insertSender">받는 사람</label>&nbsp;&nbsp;
                        <input type="text" id="insertSender" style="width:290px;" value="${sender}" name="insertSender" class="form-control bg-light small" required  aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                    <div class="col-md-6 mb-3">
                        <button class="btn btn-primary searchDocument message" type="button">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row">
                &nbsp;
	                	<label for="meTitle" style="padding-top:5px;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</label>&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="meTitle2" name="meTitle" class="form-control bg-light small" style="background-color:white !important; width:97%; margin-left:5px;"required aria-label="Search" aria-describedby="basic-addon2">
                </div>
                <br />
                <div class="form-row message">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</label><br />
                        <textarea class="form-control message-comment" required name="messageContent" id="messageContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
                <div class="modal-footer ">
        			<button type="button" id="FrmBtn" name="button" class="btn btn-primary submit">보내기</button>
            		<button type="button" class="btn btn-secondary insert" data-dismiss="modal">닫기</button>
        		</div>  
            </form>
      </div>
         


<style>
.searchDocument.message{
	position:absolute;
	top:42%;
	left:-17%;
}
.col-md-6 .mb-3 .col-md-6 .mb-3 .mb-4{
	width:350px !important;
}
#insert-message-container {
    height:500px;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control.message-comment {
	width:200%;
	height:90% !important;
	display:inline;
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
.form-row.message{
	height:334px;
}

</style>
<script>  


  $(()=>{
	  
	  
	  
	  $(".searchDocument.message").click(function(){
	    	 $('.controll-modal-body-searhMessageList').load("${pageContext.request.contextPath}/message/messageSelectList.do",function(){
	 	        $('#searhMessageList').modal({backdrop: 'static', keyboard: false});
	 	        $('#searhMessageList').modal({show:true});
	 	        $(".modal-backdrop.in").css('opacity', 0.4);
	 	       	$(".control-title-searhMessageList").html("");
	 	        $(".control-title-searhMessageList").html("회원리스트");
	 		});
	            
	    });
	  
	  $(".searchModal-end").click(function(){
	    		$('#searhMessageList').modal("hide");	
	    }); 
	  $(".btn-secondary.insert").click(function(){
		  $('.controll-modal-body-messageList').load("${pageContext.request.contextPath}/message/messageList.do?empName=${memberLoggedIn.empName}",function(){
		        $('#messageList').modal({backdrop: 'static', keyboard: false});
		        $('#messageList').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
	    		$('#insertMessage').modal("hide");
		        
		    });
	    });
	  
})
$(".btn.btn-primary.submit").click(function(){
	var empName = $("#empName").val();
	var insertSender = $("#insertSender").val();
	console.log("inser"+insertSender);
	var meTitle = $("#meTitle2").val();
	console.log("metitle"+meTitle);
	var messageContent = $("#messageContent").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/message/insertMessage.do",
		data:{empName:empName,insertSender:insertSender,meTitle:meTitle,messageContent:messageContent},
		type:'POST',
		dataType:"json",
		success:data=>{
			console.log(data);
			$('#insertMessage').modal("hide");
			$('#answerMessage').modal("hide");
			alert("전송되었습니다");
			$('.controll-modal-body-messageList').load("${pageContext.request.contextPath}/message/messageList.do?empName=${memberLoggedIn.empName}",function(){
		        $('#messageList').modal({backdrop: 'static', keyboard: false});
		        $('#messageList').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
	    		$('#insertMessage').modal("hide");
				$('#answerMessage').modal("hide");
		    });
		},
        error : function(x,h,r, status) {
            alert(x,h,r + " : " + status);
        }
	});
})
  
</script>
