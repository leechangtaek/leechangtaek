<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<%-- nav bar tap start --%>
<ul class="nav nav-tabs">
  <li class="nav-item">
    <span class="nav-link active" id="messageAll" >전체</span>
  </li>
  <li class="nav-item">
    <span class="nav-link" id="messageConfirm" >확인</span>
  </li>
  <li class="nav-item">
    <span class="nav-link" id="messageNoConfirm" >미확인</span>
  </li>
  <li class="nav-item">
    <span class="nav-link" id="messageSenderForm" >보낸쪽지함</span>
  </li>
  <li class="nav-item" style="padding-left:80px; ">
    <span class="nav-link" id="message-insert-button">신규</span>
  </li>
</ul>
<%-- nav bar tap end --%>
     <table class="table table-bordered message-list-table" style="text-align:center;" id="dataTable" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th style="padding:12px 12px;">No</th>
           <th>제목</th>
           <th class="messageShow">보낸사람</th>
           <th class="messageHide">받는사람</th>
           <th>보낸날짜</th>
           <th>상태</th>
         </tr>
       </thead>
	   <tbody>
	   </tbody>
     </table>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>

<style>
.nav.nav-tabs{
	border:0;
}
.nav-item .nav-link.active{
	color:black;
	font-weight:bold;
	border-bottom:1px solid #dddfeb;
}
.message-list-table tbody tr:hover td{
	cursor : pointer;
	background-color:#ccc;
	color:black;
}
.message-list-table tbody tr td{
	text-align:center;
}
.modal-content.messeage{
	width:550px;
	height:665px; 
}
.nav-link{
	cursor:pointer;
}
.pageBar{
	cursor:pointer;
}

</style>

<script>
$(()=>{
	messagePage(0);
	$(".messageHide").hide();
	
});


	
	$(".message-list-table tbody").on('dblclick','tr',function(){
		var value = $(this).children().eq(1).html();
		var messageValue= $(this).attr("id");
			$('.controll-modal-body-detailMessage').load("${pageContext.request.contextPath}/message/detailMessageForm.do?meNo="+messageValue+"&empName=${memberLoggedIn.empName}",function(){
		        $('#detailMessage').modal({backdrop: 'static', keyboard: false});
		        $('#detailMessage').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
			});
	});

$("#message-insert-button").on('click',function(){
	 $('.controll-modal-body-insertMessage').load("${pageContext.request.contextPath}/message/insertMessageForm.do",function(){
	        $('#insertMessage').modal({backdrop: 'static', keyboard: false});
	        $('#insertMessage').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
        $('#messageList').modal("hide");
		});
	});

$(".messageListModal-end").click(function(){
	$('#messageList').modal("hide");
	location.reload();
}); 

$("#messageAll").on('click',function(){
	messageType = $(this).attr("id");
	$(".messageHide").hide();
	$(".messageShow").show();
	$(".nav-link").removeClass("active");
	$("#messageAll").addClass("active");
	messagePage(0);
});
function messagePage(a){
	var url_="";
	var empName="${memberLoggedIn.empName}";
	
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/message/messageListPage.do?cPage=1&empName=${memberLoggedIn.empName}";
	}
	else {
		url_="${pageContext.request.contextPath}/message/"+a;
	}
	
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var list = data.list;
			console.log(empName);
			$(".message-list-table tbody").children().remove();

			for(var i in list ) {
				let m = list[i];
					if(m==null ){
						$(".message-list-table tbody").append("<tr><td colspan='5' style='text-align:center;'>조회된 쪽지가 없습니다.</td></tr>");
					}else if(m.readYn=="y"){
						$(".message-list-table tbody").append("<tr id='"+m.meNo+"'  ><td>"+(Number(i)+(data.cPage-1)*7+1)+"</td><td>"+m.meTitle+"</td><td>"+m.sender+"</td><td>"+m.regDate+"</td><td>확인</td></tr>");
					}else if(m.readYn=="n"){
						$(".message-list-table tbody").append("<tr id='"+m.meNo+"' style='color:black;'><td>"+(Number(i)+(data.cPage-1)*7+1)+"</td><td>"+m.meTitle+"</td><td>"+m.sender+"</td><td>"+m.regDate+"</td><td>미확인</td></tr>");
					}
				
				}			
				
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"messagePage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
	});
}

$("#messageConfirm").on('click',function(){
	messageType = $(this).attr("id");
	console.log(messageType);
	$(".messageHide").hide();
	$(".messageShow").show();
	$(".nav-link").removeClass("active");
	$("#messageConfirm").addClass("active");
	messageConfirmPage(0);
});

function messageConfirmPage(a){
	console.log("a==="+a);
	var url_="";
	var empName="${memberLoggedIn.empName}";
	
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/message/messageConfirmPage.do?cPage=1&empName=${memberLoggedIn.empName}";
	}
	else {
		url_="${pageContext.request.contextPath}/message/"+a;
	}
	
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var list = data.list;
			console.log(empName);
			$(".message-list-table tbody").children().remove();

			for(var i in list ) {
				let m = list[i];
				var readYn ="";
				if(m.readYn=="y"){
					readYn="확인";
				}else{
					readYn="미확인";
				}
					if(m==null ){
						$(".message-list-table tbody").append("<tr><td colspan='5' style='text-align:center;'>조회된 쪽지가 없습니다.</td></tr>");
					}else{
						$(".message-list-table tbody").append("<tr id='"+m.meNo+"' ><td>"+(Number(i)+(data.cPage-1)*7+1)+"</td><td>"+m.meTitle+"</td><td>"+m.sender+"</td><td>"+m.regDate+"</td><td>"+readYn+"</td></tr>");
					}
				
				}			
				
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"messageConfirmPage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
	});
}
$("#messageNoConfirm").on('click',function(){
	messageType = $(this).attr("id");
	console.log(messageType);
	$(".messageHide").hide();
	$(".messageShow").show();

	$(".nav-link").removeClass("active");
	$("#messageNoConfirm").addClass("active");
	messageNoConfirmPage(0);
})
function messageNoConfirmPage(a){
	console.log("a==="+a);
	var url_="";
	var empName="${memberLoggedIn.empName}";
	
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/message/messageNoConfirmPage.do?cPage=1&empName=${memberLoggedIn.empName}";
	}
	else {
		url_="${pageContext.request.contextPath}/message/"+a;
	}
	
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var list = data.list;
			console.log(empName);
			$(".message-list-table tbody").children().remove();

			for(var i in list ) {
				let m = list[i];
				var readYn ="";
				if(m.readYn=="y"){
					readYn="확인";
				}else{
					readYn="미확인";
				}
				console.log(m);	
					if(m==null ){
						$(".message-list-table tbody").append("<tr><td colspan='5' style='text-align:center;'>조회된 쪽지가 없습니다.</td></tr>");
					}else{
						$(".message-list-table tbody").append("<tr id='"+m.meNo+"' ><td>"+(Number(i)+(data.cPage-1)*7+1)+"</td><td>"+m.meTitle+"</td><td>"+m.sender+"</td><td>"+m.regDate+"</td><td>"+readYn+"</td></tr>");
					}
				
				}			
				
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"messageNoConfirmPage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
	});
}

$("#messageSenderForm").on('click',function(){
	messageType = $(this).attr("id");
	console.log(messageType);
	$(".nav-link").removeClass("active");
	$("#messageSenderForm").addClass("active");
	$(".messageHide").show();
	$(".messageShow").hide();
	messageSenderFormPage(0);
})
function messageSenderFormPage(a){
	console.log("a==="+a);
	var url_="";
	var empName="${memberLoggedIn.empName}";
	
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/message/messageSenderFormPage.do?cPage=1&empName=${memberLoggedIn.empName}";
	}
	else {
		url_="${pageContext.request.contextPath}/message/"+a;
	}
	
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var list = data.list;
			$(".message-list-table tbody").children().remove();

			for(var i in list ) {
				let m = list[i];
				var readYn ="";
				if(m.readYn=="y"){
					readYn="확인";
				}else{
					readYn="미확인";
				}
				console.log(m);	
					if(m==null ){
						$(".message-list-table tbody").append("<tr><td colspan='5' style='text-align:center;'>조회된 쪽지가 없습니다.</td></tr>");
					}else{
						$(".message-list-table tbody").append("<tr id='"+m.meNo+"' ><td>"+(Number(i)+(data.cPage-1)*7+1)+"</td><td>"+m.meTitle+"</td><td>"+m.reciever+"</td><td>"+m.regDate+"</td><td>"+readYn+"</td></tr>");
					}
				
				}			
				
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"messageSenderFormPage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
	});
}






</script>

