<%@page import="com.dev.erp.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
     <table class="table table-bordered messengerSelect-list-table" id="dataTable" width="100%" cellspacing="0">
       <thead>
         <tr>
           <th>No</th>
           <th>이름</th>
           <th>부서</th>
           <th>직급</th>
         </tr>
       </thead>
       <tbody>
       </tbody>
     </table>
     <div class="pageBar"></div>
<%--      ${pageBar} --%>

<style>
.messageSelect-list-table tbody tr:hover td{
	cursor : auto;
	background-color:#ccc;
}

</style>

<script>
$(()=>{
	messengerSelectPage(0);
	$(".emailHie").hide();
});


$(".messengerSelect-list-table tbody").on('dblclick','tr',function(){
	var value = $(this).attr("id");
	var email = $(this).children("td").attr("id");
	$("#messengerSelectList").modal('hide');
	if(value=="undefined"){
		makeChat(email);
	}else{
		goChat(value);
	}
});


function messengerSelectPage(a){
	var url_="";
	if(a==0) {
		url_ = "${pageContext.request.contextPath}/messenger/messengerListPage.do?cPage=1";
	}
	else {
		url_="${pageContext.request.contextPath}/messenger/"+a;
	}
	
	$.ajax({
		url : url_,
		dataType : "json",
		success : data => {
			var list = data.list;
			$(".messengerSelect-list-table tbody").children().remove();
			for(var i in list ) {
				let p = list[i];
				console.log(p);
				$(".messengerSelect-list-table tbody").append("<tr id="+p.chat_id+"><td id="+p.email+">"+p.emp_id+"</td><td>"+p.emp_name+"</td><td>"+p.dept_title+"</td><td>"+p.job_name+"</td></tr>");
			}
			$(".pageBar").html(data.pageBar);
			$("span.page-link").attr('onclick',"messengerSelectPage(this.id)");
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
		
	});
	
}
function goChat(chatId){
	console.log(chatId);
	$('.controll-modal-body-messengerChat').load("${pageContext.request.contextPath}/messenger/"+chatId+"/messengerChat.do/",function(){
        $('#messengerChat').modal({backdrop: 'static', keyboard: false});
        $('#messengerChat').modal({show:true});
        $(".modal-backdrop.in").css('opacity', 0.4);
       	$(".control-title-messengerChat").html("");
        $(".control-title-messengerChat").html("채팅방");
	});
};
function makeChat(email){
	
	$.ajax({
		url : "${pageContext.request.contextPath}/messenger/makeChatRoom.do?email="+email,
		dataType : "json",
		success : data => {
			console.log(data);
			$('.controll-modal-body-messengerChat').load("${pageContext.request.contextPath}/messenger/"+data.chatId+"/messengerChat.do/",function(){
		        $('#messengerChat').modal({backdrop: 'static', keyboard: false});
		        $('#messengerChat').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
		       	$(".control-title-messengerChat").html("");
		        $(".control-title-messengerChat").html("채팅방");
			});
		},
		error:(x,s,e)=>{
			console.log("ajax요청실패",x,s,e);
		}
		
	});
	
}




</script>

