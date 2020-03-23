<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
table.table th, table.table td {text-align: center;}
.messenger-list-table tbody tr:hover td{
	cursor : pointer;
	background-color:#ccc;
}
.message-list-table tbody tr td{
	text-align:center;
}
.modal-content.messenger{
	width:550px;
	height:665px; 
}
.nav-link{
	cursor:pointer;
}
.pageBar{
	cursor:pointer;
}
.col-md-6 .mb-3 .col-md-6 .mb-3 .mb-4{
	width:350px !important;
}
.form-control {
    display:inline;
}
.controll-modal-body-messengerList{
	height:530px;
	overflow-y:auto;
}
</style>

<table class="table">
  <thead class="theadFixed" >
    <tr >
      <th scope="col">No</th>
      <th scope="col">회원아이디</th>
      <th scope="col">메세지</th>
      <th scope="col">안읽은 메세지수</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${recentList }" var="m" varStatus="vs">
    <tr chatNo='<c:out value="${m.CHATID}.${m.EMAIL}"/>'>  <%-- el의 문자열 더하기 연산대신 jstl out태그 사용 --%>
      <th scope="row">${vs.count}</th>
      <td><a href="javascript:goChat('${m.CHATID}')">${m.EMP_NAME}</a></td>
      <td>${m.MSG }</td>
      <td><span class="badge badge-light">${m.CNT }</span></td>
    </tr>
  </c:forEach>
  </tbody>
</table>
			<%--searhMessengerList  modal --%>
			<div class="modal" tabindex="-1" role="dialog" id="searhMessengerList">
			  <div class="modal-dialog" role="document">
			      <div class="modal-content messenger">
			      <div class="modal-header">
			          <h5 class="modal-title control-title-searhMessengerList" id="searhMessengerList"> </h5>
			      </div>
			      <div class="modal-body controll-modal-body-searhMessengerList">
			      </div>
			      <div class="modal-footer">
			          <button type="button" class="btn btn-primary searhMessengerList-end">닫기</button>
			      </div>
			      </div>
			  </div>
			</div>
			<%--messengerChat modal --%>
			<div class="modal" tabindex="-1" role="dialog" id="messengerChat">
			  <div class="modal-dialog" role="document">
			      <div class="modal-content messenger">
			      <div class="modal-header">
			          <h5 class="modal-title control-title-messengerChat" id="messengerChat"> </h5>
			      </div>
			      <div class="modal-body controll-modal-body-messengerChat">
			      </div>
			      <div class="input-group mb-3" style="width:510px; margin:0 auto; " >
					  <input type="text" id="message" class="form-control" placeholder="Message" style="color: black;">
					  <div class="input-group-append" style="padding: 0px;">
					    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
					  </div>
					</div>
			      <div class="modal-footer">
			          <button type="button" class="btn btn-primary messengerChat-end">닫기</button>
			      </div>
			      </div>
			  </div>
			</div>
			
<script>
$(()=>{
	
	$(".btn-primary.messenger").click(function(){
		 $('.controll-modal-body-searhMessengerList').load("${pageContext.request.contextPath}/messenger/messengerSelectList.do",function(){
	        $('#searhMessengerList').modal({backdrop: 'static', keyboard: false});
	        $('#searhMessengerList').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	       	$(".control-title-searhMessengerList").html("");
	        $(".control-title-searhMessengerList").html("회원리스트");
		});
	       
	});
	$(".messengerChat-end").click(function(){
		$("#messengerChat").modal('hide');
		$("#searhMessengerList").modal('hide');
		$('.controll-modal-body-messengerList').load("${pageContext.request.contextPath}/messenger/messengerList.do",function(){
	        $('#messengerList').modal({backdrop: 'static', keyboard: false});
	        $('#messengerList').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        
	    });
	})
	$(".searhMessengerList-end").click(function(){
		$("#searhMessengerList").modal('hide');
	});
	
	$(".btn.messengerList-end").click(function(){
		$("#messengerList").modal('hide');
		$("#searhMessengerList").modal('hide');
		$("#messengerChat").modal('hide');
		location.reload();
	})
	
	
});



function goChat(chatId){
	$('.controll-modal-body-messengerChat').load("${pageContext.request.contextPath}/messenger/"+chatId+"/messengerChat.do/",function(){
        $('#messengerChat').modal({backdrop: 'static', keyboard: false});
        $('#messengerChat').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
       	$(".control-title-messengerChat").html("");
        $(".control-title-messengerChat").html("MessengerChat");
	});
};


</script>
