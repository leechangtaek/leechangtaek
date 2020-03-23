	<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <!-- search-container start -->
      <div id="update-container">
          <form class="needs-validation" id="updateQualityFrm" name="updateQualityFrm" action="${pageContext.request.contextPath }/quality/updateQualtyFormEnd.do" method="post">
                         
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="">발생일자</label>&nbsp;&nbsp;&nbsp;
                    <input type="text" name="regDate" class="form-control updateQuality-datepicker" value="${qualityContent.REG_DATE}" required readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="qualityNo">부적합번호 </label>&nbsp;
                        <input type="text" class="form-control bg-light small" value="${qualityContent.QUALITY_NO }" name="qualityNo" aria-label="Search" aria-describedby="basic-addon2" required readonly>
                    </div>
                </div>              
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="lotNo">로트번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="lotNo" name="lotNo" class="form-control bg-light small" value="${qualityContent.LOT_NO }" aria-label="Search" aria-describedby="basic-addon2" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="qualityNo">제품명 </label>&nbsp;
                        <input type="text" class="form-control bg-light small" value="${qualityContent.PNAME}" aria-label="Search" aria-describedby="basic-addon2" readonly>
                    </div>
                    
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">제품타입 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="type" name="type" class="form-control bg-light small" value="${qualityContent.TYPE }" aria-label="Search" aria-describedby="basic-addon2" required>
                        <button class="btn btn-primary searchSpec" type="button" value="type">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">창고이름 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="storeNo" name="storeNo" class="form-control bg-light small" value="${qualityContent.STORE_NAME }" aria-label="Search" aria-describedby="basic-addon2" required>
                        <button class="btn btn-primary searchSpec" type="button" value="storeNo">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">기 준 값 &nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" class="form-control bg-light small" value="${qualityContent.SPEC }"placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" readOnly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="measurement">실 측정치 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" class="form-control bg-light small" value="${qualityContent.MEASUREMENT }" name="measurement" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="qualityComment">부적합 내용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        <textarea class="form-control quality-comment" cols="80" rows="5" aria-label="With textarea" name="qualityComment" >${qualityContent.QUALITY_COMMENT }</textarea>	
                    </div>
                </div>
              
            </form>
            <div class="form-row">
            	<div class="col-md-6 mb-3">
            	</div>
                <div class="col-md-6 mb-3">
	              <button id="FrmBtn" class="btn btn-primary update-end-button">취소</button> &nbsp;&nbsp;&nbsp;
	              <button id="FrmBtn" class="btn btn-primary update-excute-button">수정</button> 
                </div>
            </div>
      </div>
      
<!--       <div class="modal" tabindex="-1" role="dialog" id="mySearchModal"> -->
<!-- 	    <div class="modal-dialog" role="document"> -->
<!-- 	        <div class="modal-content"> -->
<!-- 	        <div class="modal-header"> -->
<!-- 	            <h5 class="modal-title search-title" id="searchModalTitle"> </h5> -->
<!-- 	        </div> -->
<!-- 	        <div class="modal-body searchModalBody"> -->
<!-- 	            <p>Modal body text goes here.</p> -->
<!-- 	        </div> -->
<!-- 	        <div class="modal-footer"> -->
<!-- 	            <button type="button" class="btn btn-primary searchModal-end">끝</button> -->
<!-- 	        </div> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	  </div> -->


<style>
.modal-body{
 height: 480px;
}
#searchModal {
  width: 60%;
  height: 150px;
}
#update-container {
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
#update-container .btn-primary{
    background-color:#777;
    border-color: #777;

}
#update-container .btn-primary:hover{
/*     background-color:#777; */
    border-color: #777;
}
#update-container #FrmBtn{
    float:right;
    margin-right: 5px;
}
#accordionSidebar{
	background-image : linear-gradient(180deg,#00475d 10%,#0a0f29 100%) !important;
}

</style>
<script>    
  $(function() {

      $(".update-end-button").click(function(){
      	
      	$('#myUpdateModal').modal("hide");
      });
      $(".update-excute-button").click(function(){
      		var bool = confirm("변경된 값으로 수정하시겠습니까?");
      		
      		if(bool) {
      			$("#updateQualityFrm").submit();
      		}
      	
      });
      
      console.log($("#updateQualityFrm").html());
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
