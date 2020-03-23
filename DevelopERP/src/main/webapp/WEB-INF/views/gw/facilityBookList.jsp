<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="col-md-6 mb-3">
					<label for="datepicker">예약일자</label>&nbsp;&nbsp;&nbsp; <input
						type="text" id="date" name="bookDay"class="form-control datepicker startDate"  >
				</div>
				
				 <input type="text" id="facilityNo" name="facilityNo" class="form-control bg-light small" value=${facilityNo} aria-label="Search" aria-describedby="basic-addon2" hidden>
				   <table class="table table-bordered quality-table" id="dataTable" width="100%" cellspacing="0">
                  <thead >
                    <tr>
                      <th>이메일</th>
                      <th>예약 날짜</th>
                      <th>예약 시간</th>            
                    </tr>
                  </thead>                
                  <tbody id="bookList">
                	
                  </tbody>
                  
                </table>
                 <div class="form-row" style="text-align:right;float:right;display:inline;">
            	<div class="col-md-6 mb-3" style="display:inline;">
	              <input type="button" class="btn btn-outline-success"id="FrmBtn" value="닫기">
	              </div>
      </div>
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
.modal-body{
	text-align:center;
	}
</style>				
<script>

  $(function() {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                ,buttonImage: "${pageContext.request.contextPath}/resources/images/calendar.png" //버튼 이미지 경로
                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: "-0D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
            });
 
            //input을 datepicker로 선언
            $(".startDate").datepicker();           
            $(".endDate").datepicker();           
            //From의 초기값을 오늘 날짜로 설정
            $('.startDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $('.endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
			
            $(".search-excute-button").click(function(){
            		var bool = confirm("예약하시겠습니까?");
            		
            		if(bool) {
            			$("#updateQualityFrm").submit();
            		}
            	
            });
            $("#FrmBtn").click(function(){           	
            	$('#myModal').modal("hide");
            });
         
            $('#date').change(function(){ 
            var bookDay = $('#date').val();
            var facilityNo=$('#facilityNo').val();
        		$.ajax({
					url: "${pageContext.request.contextPath}/facility/facilityBookListGet.do?bookDay="+bookDay+"&facilityNo="+facilityNo,
					dataType: "json",
					success: data => {
						 $( '#bookList').empty();
						var html="";
						 if(data.length==0)
							 html+="<tr><td colspan='3'>예약 기록이 없습니다.</td></tr>"
						$.each(data,(idx, facility)=>{
							 var starttime = facility.bookStarttime.substring(0,2); 
							 var starttime2 = facility.bookStarttime.substring(2,4);
							 var endtime = facility.bookEndtime.substring(0,2); 
							 var endtime2 = facility.bookEndtime.substring(2,4);							
							 html+="<tr><td>"+facility.email+"</td>";
							html+="<td>"+facility.bookDay+"</td>";
							html+="<td>"+starttime+":"+starttime2+"~"+endtime+":"+endtime2+"</td>";
							
						});
							$("#bookList").append(html);					
						},
					error: (jqxhr, textStatus, errorThrown) => {
						console.log("ajax요청실패!", jqxhr, textStatus, errorThrown);
					}
				});
        	  });
        });
  
  $(document).ready(function(){
	   var bookDay = $('#date').val();
       var facilityNo=$('#facilityNo').val();
   		$.ajax({
				url: "${pageContext.request.contextPath}/facility/facilityBookListGet.do?bookDay="+bookDay+"&facilityNo="+facilityNo,
				dataType: "json",
				success: data => {
					var html="";
					 if(data.length==0)
						 html+="<tr><td colspan='3'>예약 기록이 없습니다.</td></tr>"
					$.each(data,(idx, facility)=>{
						 var starttime = facility.bookStarttime.substring(0,2); 
						 var starttime2 = facility.bookStarttime.substring(2,4);
						 var endtime = facility.bookEndtime.substring(0,2); 
						 var endtime2 = facility.bookEndtime.substring(2,4);							
						 html+="<tr><td>"+facility.email+"</td>";
						html+="<td>"+facility.bookDay+"</td>";
						html+="<td>"+starttime+":"+starttime2+"~"+endtime+":"+endtime2+"</td>";
						
					});
						$("#bookList").append(html);					
					},
				error: (jqxhr, textStatus, errorThrown) => {
					console.log("ajax요청실패!", jqxhr, textStatus, errorThrown);
				}
			});
   	  });
 
  
        </script>