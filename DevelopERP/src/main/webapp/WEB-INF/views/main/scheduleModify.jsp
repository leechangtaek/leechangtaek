<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- search-container start -->
      <div id="insert-container">
          <form class="needs-validation" action="${pageContext.request.contextPath}/schedule/scheduleUpdate.do?" 
          		name="documentEnrollFrm2" method="post">
          		<div>
          		<input type="hidden" value="${memberLoggedIn.email}" id="email" name="email" />
          		<input type="hidden" value="${schedule.scheduleNo}" id="scheduleNo" name="scheduleNo" />
          		</div>
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                	<label for="documentTitle">제  목</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="text" id="title" name="title" class="form-control bg-light small" required aria-label="Search" aria-describedby="basic-addon2" value='${schedule.title}' readonly>
	                </div> 
                </div>
                <div class="form-row" style="width:550px;">
                    <div class="col-md-6 mb-3" >                  
                    <label >시 작 일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="date" id="startScheduleTime2" name="startScheduleTime" value='${schedule.startScheduleTime}' class="form-control bg-light small"readonly style="width:166px;">
                    
                </div>   
                    <input type="time" name="startTime" id="startTime2" class="form-control bg-light small" value='${schedule.startTime}'style="width:140px;"readonly>
                </div>   
                  	 <div class="form-row" style="width:550px;">
                    <div class="col-md-6 mb-3" >                  
                     <label >종 료 일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="date"id="endScheduleTime2" name="endScheduleTime" value='${schedule.endScheduleTime}'class="form-control bg-light small" readonly style="width:166px; ">
                    </div>
                    <input type="time" id="endTime2" name="endTime" class="form-control bg-light small"value='${schedule.endTime}' readonly style="width:140px;">                    
      </div>  
<!--                 <div class="form-row"> -->
<!--                     <div class="col-md-6 mb-3"> -->
<!--                         <label for="type">구  분 </label>&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--                         <input type="checkbox" id="check"> -->
                   
<!--                     </div> -->
<!--                 </div> -->
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">내  용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control document-comment" required name="content" cols="80" rows="5" aria-label="With textarea">${schedule.content}</textarea>	
                    </div>
                </div>
				<div class="modal-footer">
        			<button type="submit" id="FrmBtn" name="submit" class="btn btn-primary">수정</button>
            		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        		</div>       
            </form>
      </div>
         


<style>
.col-md-6 .mb-3 .col-md-6 .mb-3 .mb-4{
	width:350px !important;
}
.modify-modal-body.document{
  width: 60%;
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

// $('#endScheduleTime2').change(function(){ 
// 	startScheduleTime=$('#startScheduleTime2').val();
// 	endScheduleTime=$('#endScheduleTime2').val();
// 	if(startScheduleTime>endScheduleTime){
// 		alert("해당 날짜는 일정 등록이 불가능 합니다.");
// 		$('#endScheduleTime2').val(startScheduleTime);
// 	}
	
// });
// $('#endTime2').change(function(){ 
// 	alert("fdsfsdf");
// 	startScheduleTime=$('#startScheduleTime2').val();
// 	endScheduleTime=$('#endScheduleTime2').val();
// 	startTime=$('#startTime2').val();
// 	endTime=$('#endTime2').val();
// 	if(startScheduleTime==endScheduleTime&&startTime>endTime){
// 		alert("해당 날짜는 일정 등록이 불가능 합니다.");
// 		$('#endTime2').val(startTime);
// 	} 
	
	
// });
// $('#startTime2').change(function(){ 
// 	startScheduleTime=$('#startScheduleTime2').val();
// 	endScheduleTime=$('#endScheduleTime2').val();
// 	startTime=$('#startTime2').val();
// 	endTime=$('#endTime2').val();
// 	if(startScheduleTime==endScheduleTime&&startTime>endTime){
// 		alert("해당 날짜는 일정 등록이 불가능 합니다.");
// 		$('#startTime2').val(endTime);
// 	}
	
// });

</script> 