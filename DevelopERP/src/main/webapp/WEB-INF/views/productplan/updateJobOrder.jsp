<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업지시자 수정 입력창-modal body</title>


<style>

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
.sd-modal-body tbody tr:hover td{
	cursor : pointer;
	background-color:#ccc;
}
.sd-modal-body{
	text-align: center;
}
</style>
</head>
<body>
	<!-- search-container start -->
    <div id="insert-container">
        <form class="needs-validation"
        	  id="updateJoFrm"
        	  action="${pageContext.request.contextPath }/productplan/updateJobOrderEnd.do?joNo=${joNo }"
        	  method="POST" >	
	        <div class="form-row">
	            <div class="col-md-6 mb-3 jResize">
	            <label for="datepicker">발생일자</label>&emsp;
	            <input type="text" id="enrollDate" name="enrollDate" class="form-control enrollDate" value="${enrollDate}" readonly>
	            </div>
	            <div class="col-md-6 mb-3 jResize">
	            <label for="datepicker">납기일자</label>&emsp;
	            <input type="text" id="dueDate" name="dueDate" class="form-control dueDate" value="${load.dueDate }">
	            </div>
	        </div>        
	        <div class="form-row">
	            <div class="col-md-6 mb-3 jResize">
	                <label for="lotNo">납품처</label>&emsp;&emsp;
	                <input type="text" id="customer" name="customer" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" value="${load.customer }" readonly>
	                <button class="btn btn-primary searchSpec" type="button" value="customer" data-toggle="modal" data-target="#exampleModal">
	                
	                    <i class="fas fa-search fa-sm"></i>
	                </button>
	                
	            </div>
	            <div class="col-md-6 mb-3 jResize">
	                <label for="lotNo">담당자 </label>&emsp;&emsp;
	                <input type="text" id="manager" name="manager" class="form-control bg-light small" placeholder="" aria-label="Search" aria-describedby="basic-addon2" value="${load.manager }"readonly>
	                
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-6 mb-3 jResize">
	                <label for="type">제품명 </label>&emsp;&emsp;
	                <input type="text" id="productName" name="productName" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" value="${load.productName }" readonly>
	                <button class="btn btn-primary searchSpec" type="button" value="productName">
	                    <i class="fas fa-search fa-sm"></i>
	                </button>
	            </div>
	            <div class="col-md-6 mb-3 jResize">
	                <label for="storeNo">지시수량 </label>&emsp;
	                <input type="number" id="quantity" name="quantity" class="form-control bg-light small" placeholder="" aria-label="Search" aria-describedby="basic-addon2" value="${load.orderQuantity }">
	            </div>
	        </div>
	        
	        <div class="form-row">
	            <div class="col-md-6 mb-3 jResize">
	                <label for="storeNo">지시 내용</label><br />
	                <textarea class="form-control quality-comment" name="orderContent" cols="100" rows="5" aria-label="With textarea" placeholder="내용을 입력하세요." >${load.orderContent }</textarea>	
	            </div>
	        </div>
	        <div class="modal-footer">
	           <button id="enrollBtn" class="btn btn-primary" type="submit">수정</button>
	           <button id="cancelBtn" class="btn btn-primary" type="button" data-dismiss="modal">취소</button>
	        </div>
     	</form>
    </div>
    
   	<!-- Modal -->
	<div class="modal" tabindex="-1" role="dialog" id="searchDetailsModal">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        <div class="modal-header">
	            <h5 class="modal-title controll-title" id="sc-title"></h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">&times;</span>
	            </button>
	        </div>
	        <div class="modal-body sd-modal-body">
	            <!-- <p>Modal body text goes here.</p> -->
	        </div>
	        </div>
	    </div>
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
		/* $(".enrollDate").datepicker(); */           
		$(".dueDate").datepicker();           
		//From의 초기값을 오늘 날짜로 설정
		/* $('.enrollDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) */
		/* $('.dueDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) */
		
		//신규등록 취소버튼
		$("#cancel-btn").click(function(){
			$("#joModal").modal('hide');
		});
		
		//각 요소 조회 버튼 이벤트핸들러
		$(".searchSpec").click(function(){
			var title = $(this).siblings().html();
			console.log("title="+title);
			$("#sc-title").html(title);
			var searchType = $(this).val();
			console.log("searchType="+searchType);
			
			$('.sd-modal-body').load("${pageContext.request.contextPath}/productplan/searchDetails.do?searchType="+searchType,function(){
		        $('#searchDetailsModal').modal({backdrop: 'static', keyboard: false});
		        $('#searchDetailsModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
			});
		});
		
		$("#enrollBtn").click(function(){
			if(!confirm("수정하시겠습니까?")) return;
			$("#updateJoFrm").submit();
		});
				
				
		$(".cancelBtn").click(function(){
			$("#joModal").modal('hide');
		});
		
		
		
				
	});
	</script>
</body>
</html>