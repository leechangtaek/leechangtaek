<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주요청-modal</title>

<style>
.modal-body{
 height: 480px;
}
#searchModal {
  width: 60%;
  height: 150px;
}
#insert-container {
   width: 674px;
    height: 100%;
}
.modal-content{
	width:700px;
}
.ctm{
	width: 400px;
}
#formGroupExampleInput {
    width: 70%;
}
.form-control {
    display:inline;
    width: 60%;
}
.quality-comment {
	width:190%;
}
#insert-container .btn-primary{
    background-color:#777;
    border-color: #777;
    float:right;
    margin-right: 5px;

}
#insert-container .btn-primary:hover{
    background-color:#777;
    border-color: #777;
}

</style>
</head>
<body>
	<!-- search-container start -->
    <div id="insert-container">
        <form class="needs-validation"
        	  id="orderRequestForm"
        	  action="${pageContext.request.contextPath }/productplan/orderRequestEnd.do"
        	  method="POST" >	
	        <div class="form-row">
	            <div class="col-md-6 mb-3">
	            <label for="datepicker">요청일자</label>&emsp;
	            <input type="text" id="enrollDate" name="enrollDate" class="form-control enrollDate">
	            </div>
	            <div class="col-md-6 mb-3">
	            <label for="datepicker">납기일자</label>&emsp;
	            <input type="text" id="dueDate" name="dueDate" class="form-control dueDate">
	            </div>
	        </div>        
	        <div class="form-row">
	            <div class="col-md-6 mb-3">
	                <label for="type">원재료명</label>&emsp;
	                <input type="text" id="rmName" name="rmName" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" value="${rmName }" readonly>
	                <input type="hidden" name="rmNo" id="rmNo" value="${rmNo }"/>
	            </div>
	            <div class="col-md-6 mb-3">
	                <label for="storeNo">필요수량</label>&emsp;
	                <input type="number" id="requireAmount" name="requireAmount" class="form-control bg-light small" placeholder="" aria-label="Search" aria-describedby="basic-addon2" value="${requireAm }" readonly>
	            </div>
	        </div>
	        
	        <div class="form-row">
	            <div class="col-md-6 mb-3">
	                <label for="storeNo">전달 내용</label><br />

	                <textarea class="form-control quality-comment" name="orderContent" cols="100" rows="5" aria-label="With textarea" placeholder="내용을 입력하세요."></textarea>	
	            </div>
	        </div>
	        <div class="modal-footer">
	           <button id="enrollBtn" class="btn btn-primary" type="submit">등록</button>
	           <button id="cancelBtn" class="btn btn-primary" type="button" data-dismiss="modal">취소</button>
	        </div>
     	</form>
    </div>

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
		    ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		    ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		});
		
		//input을 datepicker로 선언
		$(".enrollDate").datepicker();           
		$(".dueDate").datepicker();           
		//From의 초기값을 오늘 날짜로 설정
		$('.enrollDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		$('.dueDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		
		//신규등록 취소버튼
		$("#cancel-btn").click(function(){
			$("#joModal").modal('hide');
		});
		
		$("#enrollBtn").click(function(){
			if(!confirm("등록하시겠습니까?")) return;
			
			/* var validate = $("#requireAmount")[0];
			if (validate.checkValidity() == false) {
				return;
			} */
			$("#orderRequestForm").submit();
			
		});
				
		$(".cancelBtn").click(function(){
			$("#joModal").modal('hide');
		});
		
	});
	</script>
</body>
</html>