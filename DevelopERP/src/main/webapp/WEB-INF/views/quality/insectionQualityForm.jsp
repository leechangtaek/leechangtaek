<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <!-- search-container start -->
      <div id="insert-container">
          <form class="needs-validation" id="insectionQualityFrm" name="insectionQualityFrm" action="${pageContext.request.contextPath }/quality/insectionQualityFormEnd.do" method="post">
                         
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="datepicker">검사일</label>&nbsp;&nbsp;&nbsp;
                    <input type="text" name="regDate" class="form-control updateQuality-datepicker" value="${insectionContent.ENROLL_DATE}" required readonly>
                    <input type="hidden" name="plRmNo" value=${insectionContent.PL_NO } />
                    </div>
                </div>              
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="lotNo">로트번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="lotNo" name="lotNo" class="form-control bg-light small" value="${insectionContent.LOT_NO}" aria-label="Search" aria-describedby="basic-addon2" readOnly>
                        
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="productName">제 품 명 &nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="productName"  class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" value="${insectionContent.PRODUCT_NAME}"  readOnly>
                        
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">제품타입 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="type" name="type" class="form-control bg-light small" value="${insectionContent.TYPE}" aria-label="Search" aria-describedby="basic-addon2" required>
                     	<button class="btn btn-primary searchSpec" type="button" value="type">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">창고이름 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="storeNo" name="storeNo" class="form-control bg-light small" value="${insectionContent.STORE_NAME}" aria-label="Search" aria-describedby="basic-addon2" required>
                        <button class="btn btn-primary searchSpec" type="button" value="storeNo">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="spec">기 준 값 &nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <span id="spec">${insectionContent.SPEC}</span>&nbsp;±&nbsp;<span id="tol">${insectionContent.TOL}</span>%
<%--                         <input type="Number" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" name="spec" value="${insectionContent.SPEC}" readOnly>± --%>
<%--                         <input type="number" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" name="spec" value="${insectionContent.TOL}" readOnly> --%>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="measurement">실 측정치 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="measurement" name="measurement" class="form-control bg-light small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" required>
                        <input type="hidden" value="N" name="qualityYN" id="qualityYN"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="qualityComment">부적합 내용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control quality-comment" cols="80" rows="5" aria-label="With textarea" name="qualityComment" readOnly></textarea>	
                    </div>
                </div>
              
            </form>
            <div class="form-row">
            	<div class="col-md-6 mb-3">
            	</div>
                <div class="col-md-6 mb-3">
	              <button id="FrmBtn" class="btn btn-primary insection-end-button">취소</button> &nbsp;&nbsp;&nbsp;
	              <button id="FrmBtn" class="btn btn-primary insection-excute-button">등록</button> 
                </div>
            </div>
      </div>
      
       <div class="modal" tabindex="-1" role="dialog" id="mySearchModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title search-title" id="searchModalTitle"> </h5>
        </div>
        <div class="modal-body searchModalBody">
            <p>Modal body text goes here.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary searchModal-end">끝</button>
        </div>
        </div>
    </div>
  </div>
    

  </div>

<style>
.modal-body{
 height: 480px;
}
#searchModal {
  width: 60%;
  height: 150px;
}
#insert-container {
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
.quality-comment {
	width:190%;
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
#accordionSidebar{
	background-image : linear-gradient(180deg,#00475d 10%,#0a0f29 100%) !important;
}

</style>
<script>    
  $(function() {

       $(".insection-end-button").click(function(){
       	
       	$('#InsectionModal').modal("hide");
       });
       $(".insection-excute-button").click(function(){
       		var bool = confirm("변경된 값으로 검사를 완료하시겠습니까?");
       		
       		if(bool) {
       			$("#insectionQualityFrm").submit();
       		}
       	
       });
   });
  
$("#measurement").keyup(function(){
	
	var measurement = $("#measurement").val();
	var spec = Number($("#spec").text());
	var tol = Number($("#tol").text());
	var upperLimit = spec + (spec*tol);
	var lowerLimit = spec - (spec*tol);
	
	if(measurement<lowerLimit||measurement>upperLimit) {
		$(".quality-comment").removeAttr("readonly");
		$("#measurement").css("border-bottom","3px solid red");
		$("#qualityYN").val('N');
	}
	else {
		$(".quality-comment").attr("readonly",true);
		$("#measurement").css("border-bottom","3px solid springgreen");
		$("#qualityYN").val('Y');
	}
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


</script>
