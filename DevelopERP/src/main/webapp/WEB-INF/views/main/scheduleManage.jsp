<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

  <div class="resize">
					
				
				   <table class="table table-bordered quality-table" id="scheduleListTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>날짜</th>
                      <th>제목</th>
                      <th>내용</th>
                      <th>수정</th>
                      <th>삭제</th>
                    </tr>
                  </thead>                
                  <tbody id="tableManageList">
                 </tbody>
                	
                </table>
              </div>
           
          
<div class="modal" tabindex="-1" role="dialog" id="scheduleModifyModal">
<div class="modal-dialog" role="document">
    <div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title modify-title"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body modify-modal-body">
        <!-- <p>Modal body text goes here.</p> -->
    </div>
    	
    </div>
</div>
</div>
  
<script>

$("#scheduleListTable tbody").on('click','input:button',function(){
	var startScheduleTime=$(this).parent().siblings().eq(1).children("#startScheduleTime").val();
	var endScheduleTime=$(this).parent().siblings().eq(1).children("#endScheduleTime").val();
	var scheduleNo=$(this).parent().siblings().eq(1).children("#scheduleNo").val();
	var title=$(this).parent().siblings().eq(1).text();
	var content=$(this).parent().siblings().eq(2).text();
	location.href = "${pageContext.request.contextPath}/schedule/scheduleDelete.do?scheduleNo="+scheduleNo;
	
});

$("#scheduleListTable tbody").on('click','button',function(){
	var startScheduleTime=$(this).parent().siblings().eq(1).children("#startScheduleTime").val();
	var endScheduleTime=$(this).parent().siblings().eq(1).children("#endScheduleTime").val();
	var scheduleNo=$(this).parent().siblings().eq(1).children("#scheduleNo").val();
	var endTime=endScheduleTime.substring(11,19);
	var startTime=startScheduleTime.substring(11,19);
	endScheduleTime=endScheduleTime.substring(0,10);
	console.log(startScheduleTime.substring(0,10));
	startScheduleTime=startScheduleTime.substring(0,10);
	var title=$(this).parent().siblings().eq(1).text();
	var content=$(this).parent().siblings().eq(2).text();
	var title1=title.split(' ');
	var content1=content.split(' ');
	console.log(title);
	content=$.escapeSelector(content);
	console.log(startScheduleTime);
	console.log(endScheduleTime);
	console.log(endTime);
	console.log(startTime);
	console.log(title);
	console.log(content);
	console.log("DFD"+scheduleNo);
	 $('.modify-modal-body').load("${pageContext.request.contextPath}/schedule/scheduleModify.do?title1="+title1+"&content1="+content1+"&scheduleNo="+scheduleNo+"&startScheduleTime="+startScheduleTime+"&endScheduleTime="+endScheduleTime+"&startTime="+startTime+"&endTime="+endTime,function(){
	        $('#scheduleModifyModal').modal({backdrop: 'static', keyboard: false});
	        $('#scheduleModifyModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".modify-title").html("");
	        $(".modify-title").html("일정 수정");
		});
});

$(document).ready(function(){
	$.ajax({
			url: "${pageContext.request.contextPath}/schedule/scheduleManageList.do?date=${date}&email=${memberLoggedIn.email}",
			dataType: "json",
			success: data => {
				console.log(data);
				var html1="";
				var html2="";
				 if(data.length==0)
					 html1+="<tr><td colspan='5'>등록된 일정이 없습니다.</td></tr>"
				$.each(data,(idx, schedule)=>{
//					 var starttime = facility.bookStarttime.substring(0,2); 
//					 var starttime2 = facility.bookStarttime.substring(2,4);
//					 var endtime = facility.bookEndtime.substring(0,2); 
//					 var endtime2 = facility.bookEndtime.substring(2,4);							
					 var startScheduleTime=schedule.startScheduleTime.substring(0,10);
					 var endScheduleTime=schedule.endScheduleTime.substring(0,10);
					 console.log(startScheduleTime);
					 console.log(endScheduleTime);
					 if(startScheduleTime==endScheduleTime)
						 {
					  startScheduleTime=schedule.startScheduleTime.substring(11,16);
					  endScheduleTime=schedule.endScheduleTime.substring(11,16); 		
					 
					 html2+='<tr><td>'+startScheduleTime+" ~ "+endScheduleTime+'</td>';
					 html2+="<td>"+schedule.title;
					  html2+='<input type="text" id="startScheduleTime" value="'+schedule.startScheduleTime+'" hidden>';
					  html2+='<input type="text" id="endScheduleTime" value="'+schedule.endScheduleTime+'" hidden>';
					  html2+='<input type="text" id="scheduleNo" value="'+schedule.scheduleNo+'" hidden></td>';
					 html2+="<td>"+schedule.content+"</td>";
					 html2+='<td><button type="submit" id="Modify" name="submit" class="btn btn-primary">수정</button></td>';
					 html2+='<td><input type="button" id="Delete" name="submit" class="btn btn-primary"  value="삭제"/></td></tr>';
					 console.log(startScheduleTime);
						 }
					 else{
						startScheduleTime=schedule.startScheduleTime.substring(5,16);
						  endScheduleTime=schedule.endScheduleTime.substring(5,16); 		
						  html1+='<tr><td>'+startScheduleTime+" ~ "+endScheduleTime+'</td>';
							 html1+="<td>"+schedule.title;
							  html1+='<input type="text" id="startScheduleTime" value="'+schedule.startScheduleTime+'" hidden>';
							  html1+='<input type="text" id="endScheduleTime" value="'+schedule.endScheduleTime+'" hidden>';
							  html1+='<input type="text" id="scheduleNo" value="'+schedule.scheduleNo+'" hidden></td>';
							 html1+="<td>"+schedule.content+"</td>";
							 html1+='<td><button type="submit" id="FrmBtn" name="submit" class="btn btn-primary">수정</button></td>';
							 html1+='<td><input type="button" id="Delete" name="submit" class="btn btn-primary"   value="삭제"/></td></tr>';
// 						  html1+='<input type="text" id="startScheduleTime" value="'+schedule.startScheduleTime+'" hidden>';
// 						  html1+='<input type="text" id="endScheduleTime" value="'+schedule.endScheduleTime+'" hidden>';
						 console.log(startScheduleTime);
					 }
					 
				});
				console.log(html2);
				console.log(html1);
					$("#scheduleManageModal #tableManageList").append(html1);
					$("#scheduleManageModal #tableManageList").append(html2);					
				console.log("ajax완료");
				
				},
			error: (jqxhr, textStatus, errorThrown) => {
				console.log("ajax요청실패!", jqxhr, textStatus, errorThrown);
			}
		});
  });


 </script>
<style>
.searchModalBody{
 height: 500px;
}
#searchModal {
  width: 60%;
  height: 150px;
}
#search-container {
    width:660px;
    height: 150px;
}
.modal-content{
	width:700px;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
#search-container .btn-primary{
    background-color:#777;
    border-color: #777;

}
#search-container .btn-primary:hover{
    background-color:#777;
    border-color: #777;
}
#search-container #FrmBtn{
    float:right;
    margin-right: 5px;
}
#mySearchModal {
	z-index:1080;
}
table{
text-align:center;
}
.resize{
	width: 100%!important;
}
.document-comment{
width:200%;}
</style>			
