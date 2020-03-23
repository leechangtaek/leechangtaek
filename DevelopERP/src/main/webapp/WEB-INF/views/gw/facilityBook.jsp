<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- Custom styles for this page -->
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
</head>

<body>
      <!-- search-container start -->
<!--       <div id="search-container"> -->
<!--           <form class="needs-validation" novalidate> -->

      <form name="facilityBook" action="${pageContext.request.contextPath}/facility/facilityBookInsert.do" method="post"
       onsubmit="return bookValidate();">
			<div class="form-row">
				<div class="col-md-6 mb-3">
					<label for="datepicker">예약일자</label>&nbsp;&nbsp;&nbsp; <input
						type="text" id="date" name="bookDay"class="form-control datepicker startDate"  >
				</div>
				<div class="col-md-6 mb-3">
<!-- 					<form name="form" method="post"> -->
						예약시간 :
						</p>
						- 예약 시작 시간 : <select name="bookStarttime" id="reservS"
							>

						</select> <br>
						</p>
						- 예약 종료 시간 : <select name="bookEndtime" id="reservE">
						</select>
				</div>
			</div>
			<div class="form-row">
                    <div class="col-md-6 mb-3">                      
                        <input type="text" id="facilityNo" name="facilityNo" class="form-control bg-light small" value=${facility.facilityNo} aria-label="Search" aria-describedby="basic-addon2" hidden>
                    </div>
                    </div>             
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="qualityNo"> 회원 아이디 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="email" name="email" class="form-control bg-light small" value='${memberLoggedIn.email}' aria-label="Search" aria-describedby="basic-addon2" readonly>
                        
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lotNo">시설명 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="facilityName" name="facilityName" class="form-control bg-light small" value=${facility.facilityName} aria-label="Search" aria-describedby="basic-addon2" readonly>
                       
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">전화번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="type" name="facilityPhone" class="form-control bg-light small" value=${facility.facilityPhone} aria-label="Search" aria-describedby="basic-addon2" readonly>
                       
                    </div>
                    <div class="col-md-6 mb-3" id="btn">
                        <label for="storeNo">장소&nbsp;&nbsp;&nbsp;&nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="facilityLocation" name="facilityLocation" class="form-control bg-light small"value='${facility.facilityLocation}' aria-label="Search" aria-describedby="basic-addon2" readonly>
                        
                    </div>
                </div>
         
            <div class="form-row" style="text-align:right;float:right;display:inline;">
            	<div class="col-md-6 mb-3" style="display:inline;">
	              <input type="submit" class="btn btn-outline-success" value="예약" >
	              <input type="button" class="btn btn-outline-success"id="FrmBtn" value="취소">
	              </div>
	              </div>
      </form>

      <br>


<style>
#myModal{
	z-index: 1060;
	width:100%;	
	height:100%;	
}
.modal-body{
}
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
</style>
<script>    
function bookValidate(){
	var startTime =document.getElementById("reservS");
	var endTime =document.getElementById("reservE");	
	if(startTime.options[startTime.selectedIndex].value=='')
		{
		alert("시작 시간을 선택해 주세요.")
		return false;
		}
	if(endTime.options[endTime.selectedIndex].value=='')
		{
		alert("종료 시간을 선택해 주세요.")		
		return false;		
		}
	else
		return true;
}
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
			
            $("#FrmBtn").click(function(){           	
            	$('#myModal').modal("hide");
            });

		
            $('#date').change(function(){ 
            var bookDay = $('#date').val();
			var facilityNo=$('#facilityNo').val();
        		$.ajax({
					url: "${pageContext.request.contextPath}/facility/facilityTime.do?bookDay="+bookDay+"&facilityNo="+facilityNo,
					dataType: "json",
					success: data => {
						  var rsSi = parseInt('0600'.substring(0,2)); 
						    var rsBun = '0600'.substring(2,4); 
					
						   $("#reservS option").each(function() { 
						        $(this).remove(); 
						     }); 
						     $("#reservS").append("<option value=''>시간선택(시작)</option>"); 
						$("#reservS option:eq("+0+")").attr("selected","selected");
						     for(var i=0; i<40; i++){						  						    						    	
						       if(rsBun == 30){ 
						         rsSi = rsSi + 1; 
						         rsBun = "00"; 
						         }else if(rsBun == 00){ 
						         rsBun = "30"; 
						      } 
						       
						      if(rsSi > 9){ 
						    	  if(rsSi>23&&rsBun==30)
						    		  break;
						        $("#reservS").append("<option value='"+ rsSi + rsBun + "'>"+ rsSi + ":" + rsBun + "</option>"); 
						        } else { 
						        $("#reservS").append("<option value='0"+ rsSi + rsBun + "'>0"+ rsSi + ":" + rsBun + "</option>"); 
						     } 
						     }
						   $("#reservE option").each(function() { 
						        $(this).remove(); 
						     }); 
						     $("#reservE").append("<option value=''>시간선택(종료)</option>"); 
						var reservS = document.getElementById('reservS');
						var count = reservS.childElementCount;
						var str='';
						for(var i=1;i<count;i++){
							$("#reservS option:eq("+i+")").prop('disabled',false);
							var text=$("#reservS option:eq("+i+")").text();
							var text=text.substring(0,5);
							$("#reservS option:eq("+i+")").text(text);
						}
						
						$.each(data,(idx, facility)=>{
							for(var i=1;i<count;i++){
							var flag=0;
							var flag2=0;
						var num=$("#reservS option:eq("+i+")").val()*1;
						
							if((facility.bookStarttime*1)<=num&&(facility.bookEndtime*1)>=num)
								{
								$("#reservS option:eq("+i+")").prop('disabled',true);
								var text=$("#reservS option:eq("+i+")").text();	
								if(!text.match('마감'))
								$("#reservS option:eq("+i+")").text(text+'(마감)');
								
								}

							}
						});
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
				url: "${pageContext.request.contextPath}/facility/facilityTime.do?bookDay="+bookDay+"&facilityNo="+facilityNo,
				dataType: "json",
				success: data => {
					  var rsSi = parseInt('0600'.substring(0,2)); 
					    var rsBun = '0600'.substring(2,4); 
				
					   $("#reservS option").each(function() { 
					        $(this).remove(); 
					     }); 
					     $("#reservS").append("<option value=''>시간선택(시작)</option>"); 
					$("#reservS option:eq("+0+")").attr("selected","selected");
					     for(var i=0; i<40; i++){						  						    						    	
					       if(rsBun == 30){ 
					         rsSi = rsSi + 1; 
					         rsBun = "00"; 
					         }else if(rsBun == 00){ 
					         rsBun = "30"; 
					      } 
					       
					      if(rsSi > 9){ 
					    	  if(rsSi>23&&rsBun==30)
					    		  break;
					        $("#reservS").append("<option value='"+ rsSi + rsBun + "'>"+ rsSi + ":" + rsBun + "</option>"); 
					        } else { 
					        $("#reservS").append("<option value='0"+ rsSi + rsBun + "'>0"+ rsSi + ":" + rsBun + "</option>"); 
					     } 
					     }
					var reservS = document.getElementById('reservS');
					var count = reservS.childElementCount;
					var str='';
					for(var i=1;i<count;i++){
						$("#reservS option:eq("+i+")").prop('disabled',false);
						var text=$("#reservS option:eq("+i+")").text();
						var text=text.substring(0,5);
						$("#reservS option:eq("+i+")").text(text);
					}
					
					$.each(data,(idx, facility)=>{
						for(var i=1;i<count;i++){
						var flag=0;
						var flag2=0;
					var num=$("#reservS option:eq("+i+")").val()*1;
					
						if((facility.bookStarttime*1)<=num&&(facility.bookEndtime*1)>num)
							{
							$("#reservS option:eq("+i+")").prop('disabled',true);
							var text=$("#reservS option:eq("+i+")").text();
							$("#reservS option:eq("+i+")").text(text+'(마감)');
							}
						}
					});
					},
				error: (jqxhr, textStatus, errorThrown) => {
					console.log("ajax요청실패!", jqxhr, textStatus, errorThrown);
				}
			});
  	  });
  
  $(document).ready(function() { 
	
	  $("#reservE").append("<option value=''>시간선택(종료)</option>"); 
	
	  $('#reservS').change(function(){ 
	    var rstart = $("#reservS").val(); 
	  var index=  $("#reservS option").index($("#reservS option:selected"));
	  var reservS = document.getElementById('reservS');
		var count = reservS.childElementCount;

	    var rsSi = parseInt(rstart.substring(0,2)); 
	    var rsBun = rstart.substring(2,4); 
	    if(rstart != ''){ 
	      $("#reservE option").each(function() { 
	        $(this).remove(); 
	     }); 
	     $("#reservE").append("<option value=''>시간선택(종료)</option>"); 
	     for(var i=0; i<count+3-index; i++){
	    	 var num=i+index
	    	 var isDisabled=$("#reservS option:eq("+num+")").attr('disabled');
	    	
	    	 if(isDisabled=='disabled')
	    		 break;
	       if(rsBun == 30){ 
	         rsSi = rsSi + 1; 
	         rsBun = "00"; 
	         }else if(rsBun == 00){ 
	         rsBun = "30"; 
	      } 
	       
	      if(rsSi > 9){ 
	    	  if(rsSi>23&&rsBun==30)
	    		  break;
	        $("#reservE").append("<option value='"+ rsSi + rsBun + "'>"+ rsSi + ":" + rsBun + "</option>"); 
	        } else { 
	        $("#reservE").append("<option value='0"+ rsSi + rsBun + "'>0"+ rsSi + ":" + rsBun + "</option>"); 
	     } 
	  } 
	  }else{ 
	  $("#reservE option").each(function() { 
	    $(this).remove(); 
	 }); 
	  $("#reservE").append("<option value=''>시간선택(종료)</option>"); 
	} 
	}); 
	}); 

</script>
</body>
</html>