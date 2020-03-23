<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%String content = (String)request.getAttribute("content");
Date now = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
System.out.println("현재시간  : " +sdf.format(now)); 
%>


<meta charset='utf-8' />
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<link href='${pageContext.request.contextPath}/resources/js/calendar/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar/daygrid/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar/timegrid/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar/list/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/calendar/core/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar/interaction/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar/daygrid/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar/timegrid/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar/list/main.js'></script>
<script>
$(document).ready(function(){
	var len=$(".fc-title");
	 console.log($(".fc-content").closest("span"));
	 for(var i=0;i<len.length;i++)
		 {
		 if(len.eq(i).text().includes('휴가'))
			 len.eq(i).closest("div").addClass("holiday");
		 }

});
document.addEventListener('DOMContentLoaded', function() {	
			    var calendarEl = document.getElementById('calendar');				
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			      plugins: [ 'interaction', 'dayGrid',  ],
			      header: {
			        left: 'prev,next ',
			        center: 'title',
			        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
			      },
			      defaultDate: '<%=sdf.format(now)%>',
			      navLinks: true, // can click day/week names to navigate views
			      businessHours: true, // display business hours
			      editable: true,
			      events: [

			        {
			          start: '2019-08-06',
			          end: '2019-08-08',
			          overlap: false,
			          rendering: 'background',
			          color: '#ff9f89'
			        }
			 		<%=content%>
			      ]
			    });

			    calendar.render();
			 
		
		
	});

  


  function here(date){
	 	var url = "<%=request.getContextPath()%>/attend/attendForm.do?date="+date+"&email="+'${memberLoggedIn.email}';
		var title = "출/퇴근 기록부";
		var spec = "left=500px, top=100px, width=470px, height=310px";
		var popup = open("", title, spec);
		
		var frm = document.attendForm;
		
		frm.action = url;
		frm.target = title;
		frm.method = "POST";
		//frm.memberId.value = $memberId.val().trim();
		frm.submit();
	
  }
 
</script>
<form name="attendForm">
		<input type="hidden" name="Id" val= />
	</form>
<style>

.fc-content.holiday{
	text-align:center;
	background-color:lightblue;
}
a.fc-day-number{
cursor:pointer;}
/*   body {*/
/*     margin: 40px 10px; */
/*     padding: 0; */
/*     font-family: Arial, Helvetica Neue, Helvetica, sans-serif; */
/*     font-size: 14px; */
/*   } */

body .calendar-container #calendar{
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
font-size: 14px;
}

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }
  .calendar-caontainer{
/*   font-family: Arial, Helvetica Neue, Helvetica, sans-serif !important; */
/*   font-size: 14px !important; */
  width:100%;}

</style>
<div class="calendar-container">
  <div id='calendar' ></div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>