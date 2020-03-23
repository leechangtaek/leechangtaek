<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<fmt:requestEncoding value="utf-8"/>
<%String content = (String)request.getAttribute("content");
String attendDate = (String)request.getAttribute("attendDate");
String endDate = (String)request.getAttribute("endDate");
String earlyDate = (String)request.getAttribute("earlyDate");
String holiday = (String)request.getAttribute("holidayInfo");
String date = (String)request.getAttribute("date");
Date now = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
String today=sdf.format(now);

%>
<title>출/퇴근 기록부</title>
<script>

function printClock() {
    
    var clock = document.getElementById("clock");            // 출력할 장소 선택
    var currentDate = new Date();                                     // 현재시간
    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
    var amPm = 'AM'; // 초기값 AM
    var currentHours = addZeros(currentDate.getHours(),2); 
    var currentMinute = addZeros(currentDate.getMinutes() ,2);
    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
    
    if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
    	amPm = 'PM';
    	currentHours = addZeros(currentHours - 12,2);
    }

    if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
       currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
    }
    clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:30px;'>"+ amPm+"</span>"; //날짜를 출력해 줌
    
    setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
}

function addZeros(num, digit) { // 자릿수 맞춰주기
	  var zero = '';
	  num = num.toString();
	  if (num.length < digit) {
	    for (i = 0; i < digit - num.length; i++) {
	      zero += '0';
	    }
	  }
	  return zero + num;
}

function attend(date,email){
	location.href = "${pageContext.request.contextPath}/attend/attendant.do?date="+date+"&email="+email;
}
function leave(date,email){
	var currentDate = new Date(); 
	 if(currentDate.getHours()<17)
		alert("아직퇴근시간이 아닙니다.");
	 else
	location.href = "${pageContext.request.contextPath}/attend/leave.do?date="+date+"&email="+email;
}
function earlyleave(email){
	var reason=document.getElementById("reason");
	if(reason.value.trim().length==0)
		alert("조퇴 내용을 입력해 주세요");
	else
	location.href = "${pageContext.request.contextPath}/attend/earlyleave.do?reason="+reason.value+"&email="+email;
}
</script>
	
<body onload="printClock()">
	<div style=" width:400px; height:121px; line-height:114px; color:#005B9E;font-size:60px; text-align:right;" id="clock">
	</div>
	<button type="button" 
				class="btn btn-outline-success btn-block" disabled style="border:0; outline:0; width:480px; ">
				
			<table>
				<tr>
					<td>이메일주소<span>*</span></td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${memberLoggedIn.email}
<!-- 						<input class="form-control input-text" type="email" -->
<!-- 						name="email" id="email" value=${memberLoggedIn.email} readonly/> -->
					</td>			
				</tr>		
				<tr>
					<td>성명<span>*</span></td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${memberLoggedIn.empName}
<!-- 					<input class="form-control input-text" type="text" -->
<!-- 						name="emp_name" id="emp_name" value=${memberLoggedIn.empName} readonly/> -->
						</td>
				</tr>				
				<tr>
					<td>부서명<span>*</span></td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${dept_title.DEPT_TITLE} 
<!-- 						<input class="form-control input-text" type="text" -->
<!-- 						name="dept_code" id="dept_code" value=${memberLoggedIn.deptCode} readonly/> -->
					</td>
				</tr>
				<tr>					
					<td>직급<span>*</span></td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${job_name.JOB_NAME}
<!-- 						<input class="form-control input-text" type="text" -->
<!-- 						name="job_code" id="job_code" value=${memberLoggedIn.jobCode} readonly/> -->
					</td>
					</td>
				</tr>				
				<tr>
					<td>전화번호<span>*</span></td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${memberLoggedIn.phone}
<!-- 						<input type="text" class="form-control input-text" -->
<%-- 						name="phone" id="phone" value="${memberLoggedIn.phone}"/> --%>
					</td>
				</tr>
				
				
			</table>
			<br>
				</button>
					<div >
		<%if(today.equals(date)&&holiday==null){%>
		<%if(attendDate==null){%>
					<input type="button" class="attend-button" onclick='attend("${date}","${memberLoggedIn.email}")' value="출근" style="width:57px;height:25px;background-color:#005B9E; color:white;border:0; outline:0;cursor:pointer;"/>
					<%}else if(earlyDate==null&& endDate==null){ %>
					<span>조퇴사유: <input type="text"id="reason" placeholder="*조퇴시 필수 작성"/></span>
					<br>
					<br>
					<input type="button" class="attend-button" onclick='earlyleave("${memberLoggedIn.email}")' value="조퇴" style="width:57px;height:25px;background-color:#005B9E; color:white;border:0; outline:0;cursor:pointer;"/>
				
					<input type="button" class="attend-button" onclick='leave("${date}","${memberLoggedIn.email}")' value="퇴근" style="width:57px;height:25px;background-color:#005B9E; color:white;border:0; outline:0;cursor:pointer;" />	
<!-- 					text-align:right;float:right;display:inline; -->
					<%} }%>
					</div>
					
				
			



