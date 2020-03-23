<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

      <!-- search-container start -->
      <div id="search-container">
          <form class="needs-validation" id="searchQualityFrm" name="searchQualityFrm" action="${pageContext.request.contextPath }/quality/searchSpecifyEnd.do" method="get">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
    	                <label for="startDate">시작일자</label>&nbsp;&nbsp;&nbsp;
        	            <input type="text" id="" name="startDate" class="form-control datepicker startDate">
                    </div>
                    <div class="col-md-6 mb-3">
            	       <label for="endDate">종료일자</label>&nbsp;&nbsp;&nbsp;
                       <input type="text" id="" name="endDate" class="form-control datepicker endDate">	
                    </div>
                </div>              
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="qualityNo"> 관리번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="qualityNo" name="qualityNo" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary searchSpec" type="button" value="qualityNo">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lotNo">로트번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="lotNo" name="lotNo" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary searchSpec" type="button" value="lotNo">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">제품타입 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="type" name="type" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary searchSpec" type="button" value="type">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">창고이름 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="storeNo" name="storeNo" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                        <button class="btn btn-primary searchSpec" type="button" value="storeNo">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
            </form>
            <div class="form-row">
            	<div class="col-md-6 mb-3">
            	</div>
                <div class="col-md-6 mb-3">
	              <button id="FrmBtn" class="btn btn-primary search-end-button">취소</button> &nbsp;&nbsp;&nbsp;
	              <button id="FrmBtn" class="btn btn-primary search-excute-button">조회</button> 
                </div>
            </div>
      </div>
      
      
<!--   <div class="modal" tabindex="-1" role="dialog" id="mySearchModal2"> -->
<!--     <div class="modal-dialog" role="document"> -->
<!--         <div class="modal-content"> -->
<!--         <div class="modal-header"> -->
<!--             <h5 class="modal-title search-title2" id="searchModalTitle2"> </h5> -->
<!--         </div> -->
<!--         <div class="modal-body searchModalBody2"> -->
<!--         </div> -->
<!--         <div class="modal-footer"> -->
<!--             <button type="button" class="btn btn-primary searchModal-end2">끝</button> -->
<!--         </div> -->
<!--         </div> -->
<!--     </div> -->
<!--   </div> -->


<style>
.modal-body{
 height: 240px;
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
/* #mySearchModal { */
/* 	z-index:1080; */
/* } */
/* #myControllModal{ */
/* 	z-index:1060; */
/* } */
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
        ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
    });

    //input을 datepicker로 선언
    $(".startDate").datepicker();           
    $(".endDate").datepicker();           
    //From의 초기값을 오늘 날짜로 설정
    $('.startDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    $('.endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	
});


  $(".searchSpec").click(function(){
		var title = $(this).siblings().html();
		$("#searchModalTitle").html(title);
		var searchType = $(this).val();
		console.log(searchType);
		 $('.searchModalBody').load("${pageContext.request.contextPath}/quality/searchSpecify.do?searchType="+searchType,function(){
		        $('#mySearchModal').modal({backdrop: 'static', keyboard: false});
		        $('#mySearchModal').modal({show:true});
		        $(".modal-backdrop.in").css('opacity', 0.4);
			});
	});
         
 
 $(".searchModal-end").click(function(){
 	$('#mySearchModal').modal("hide");
 });
 
 $(".search-end-button").click(function(){
 	
 	$('#qualityControllModal').modal("hide");
 });
 $(".search-excute-button").click(function(){
 		console.log($("[name=startDate]").val());
 		console.log($("[name=endDate]").val());
	 	var bool = confirm("변경된 값으로 조회하시겠습니까?");
 		
 		if(bool) {
 			$("#searchQualityFrm").submit();
 		}
 	
 });
</script>
