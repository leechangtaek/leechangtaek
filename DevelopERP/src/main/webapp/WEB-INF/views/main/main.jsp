<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<meta charset='utf-8' />
<link href='${pageContext.request.contextPath}/resources/js/calendar2/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar2/daygrid/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar2/timegrid/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/calendar2/list/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/calendar2/core/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar2/core/locales-all.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar2/interaction/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar2/daygrid/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar2/timegrid/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/calendar2/list/main.js'></script>
<%String content = (String)request.getAttribute("content"); 
Date now = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); %>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var initialLocaleCode = 'en';
    var localeSelectorEl = document.getElementById('locale-selector');
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid', ],
      header: {
        left: 'prev,next ',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },
      defaultDate: '<%=sdf.format(now)%>',
      locale: initialLocaleCode,
      buttonIcons: true, // show the prev/next text
      weekNumbers: true,
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: [
        {
          title: 'All Day Event',
          start: '2019-08-01'
        }

        <%=content%>
      ]
    });

    calendar.render();

    // build the locale selector's options
    calendar.getAvailableLocaleCodes().forEach(function(localeCode) {
      var optionEl = document.createElement('option');
      optionEl.value = localeCode;
      optionEl.selected = localeCode == initialLocaleCode;
      optionEl.innerText = localeCode;
//       localeSelectorEl.appendChild(optionEl);
    });

    // when the selected option changes, dynamically change the calendar option
//     localeSelectorEl.addEventListener('change', function() {
//       if (this.value) {
//         calendar.setOption('locale', this.value);
//       }
//     });

    $(document).ready(function(){
    		$.ajax({
 				url: "${pageContext.request.contextPath}/schedule/schedulList.do?date="+'<%=sdf.format(now)%>'+"&email="+'${memberLoggedIn.email}',
 				dataType: "json",
 				success: data => {
 					console.log(data);
 					var html1="";
 					var html2="";
 					 if(data.length==0)
 						 html1+="<tr><td colspan='3'>예약 기록이 없습니다.</td></tr>";
 					$.each(data,(idx, schedule)=>{
//  						 var starttime = facility.bookStarttime.substring(0,2); 
//  						 var starttime2 = facility.bookStarttime.substring(2,4);
//  						 var endtime = facility.bookEndtime.substring(0,2); 
//  						 var endtime2 = facility.bookEndtime.substring(2,4);							
 						 var startScheduleTime=schedule.startScheduleTime.substring(0,10);
 						 var endScheduleTime=schedule.endScheduleTime.substring(0,10);
 						 if(startScheduleTime==endScheduleTime)
 							 {
 						  startScheduleTime=schedule.startScheduleTime.substring(11,16);
 						  endScheduleTime=schedule.endScheduleTime.substring(11,16); 						  
 						 html1+='<tr><td>'+startScheduleTime+" ~ "+endScheduleTime+'</td>';
 						 html1+="<td><p class='schedule-title'>"+schedule.title+'</p>'+schedule.content+"</td></tr>";
 						 console.log(startScheduleTime);
 							 }
 						 else{
 							startScheduleTime=schedule.startScheduleTime.substring(5,16);
 	 						  endScheduleTime=schedule.endScheduleTime.substring(5,16); 						  
 	 						 html2+='<tr><td>'+startScheduleTime+" ~ "+endScheduleTime+'</td>';
 	 						 html2+="<td><p class='schedule-title'>"+schedule.title+'</p>'+schedule.content+"</td></tr>";
 	 						 console.log(startScheduleTime);
 						 }
 						 
 					});
 						$("#list").append(html2);					
 						$("#list").append(html1);					
 					},
 				error: (jqxhr, textStatus, errorThrown) => {
 					console.log("ajax요청실패!", jqxhr, textStatus, errorThrown);
 				}
 			});
    	  });
    
    
    
    
  });
    function here(date){
    	 event.stopPropagation();
    	 $('.control-modal-body').load("${pageContext.request.contextPath}/schedule/schedule.do?date="+date,function(){
 	        $('#scheduleModal').modal({backdrop: 'static', keyboard: false});
 	        $('#scheduleModal').modal({show:true});
 	        $(".modal-backdrop.in").css('opacity', 0.4);
 	        $(".control-title").html("");
 	        $(".control-title").html("개인일정관리");
 		});
    };

function clickDate(date){
	 event.stopPropagation();
	 $('.scheduleManage-modal-body').load("${pageContext.request.contextPath}/schedule/scheduleManage.do?date="+date,function(){
	        $('#scheduleManageModal').modal({backdrop: 'static', keyboard: false});
	        $('#scheduleManageModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".scheduleManage-title").html("");
	        $(".scheduleManage-title").html(date+" 일정관리");
		});
};

</script>
<style>

.fc-right button{
display:none;}
	.fc-content{
	background-color:white;
	border-color: white;}
/* 	.fc.event{ */
/* 	background-color:white; */
/* 	border:1px solid white;} */
  body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #top {
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    font-size: 12px;
  }

  #calendar {
    width:45%;
    display: inline-block;
    float:left;
    height: 430px;
  }
  .schedule-title{
  	font-size:  20px;
  	font-weight: bold;
  }
.fc-day{
 cursor:pointer;}
 #schedule-table-container{
 	width:48%;
 	height: 430px;
 	display: inline-block;
 	float:right;
 }
  #schedule-table-container2{
 	width:98%;
 	height: 400px;
 	overflow-y: scroll;
 	both:clear;
 }
 .my-schedule-container{
 	width:100%;
 	height: 440px;
 	
 }
 .float-clear{
 	both:clear;
 }
 
 #list tr td:first-of-type{
 	border-right:1px solid rgba(0,0,0,0.2);
 }
 .schedule-title{
 	margin-bottom:0;
 }
 .fc-more-cell div{
 text-align:center;}
 
 
</style>
<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="scheduleModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title control-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body control-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="scheduleManageModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="scheduleManage-title scheduleManage-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body scheduleManage-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>


<div class='my-schedule-container'>
	<div id='calendar'></div>
	<div id='schedule-table-container'>
		<h3>오늘의 일정</h3>
		<hr></hr>
		<div id='schedule-table-container2'>	
		<table class="table table-striped">
		
		 
		  <tbody id="list">
		
		  </tbody>
		</table>
		</div>
	</div>
</div>
<br class='float-clear'/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
