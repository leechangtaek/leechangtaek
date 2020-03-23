	<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <!-- search-container start -->
      <div id="update-container">
          <form class="needs-validation" id="updateSalesFrm" name="updateSalesFrm" action="${pageContext.request.contextPath }/sales/cancleSalesFormEnd.do" method="post">
                         
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="salesDate">출 고 일&nbsp;</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" name="salesDate" class="form-control updateQuality-datepicker" value="${map.SALES_DATE}" disabled readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="salesNo">판매번호 </label>&nbsp;
                        <input type="text" class="form-control bg-light small" value="${map.SALES_NO }" name="salesNo" aria-label="Search" aria-describedby="basic-addon2" requiered readonly>
                    </div>
                </div>              
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="lotNo">로트번호 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="lotNo" name="lotNo" class="form-control bg-light small" value="${map.LOT_NO }" aria-label="Search" aria-describedby="basic-addon2" requiered readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="plNo">제품번호 </label>&nbsp;
                        <input type="text" class="form-control bg-light small" name="plNo" value="${map.PL_NO}" aria-label="Search" aria-describedby="basic-addon2" disabled readonly>
                    </div>
                    
                </div>
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="type">판 매 량&nbsp; </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="quantity" name="quantity" class="form-control bg-light small" value="${map.QUANTITY }" aria-label="Search" aria-describedby="basic-addon2" requiered readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="storeNo">출고가격 </label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="text" id="storeNo" name="storeNo" class="form-control bg-light small" value="${map.OUTPRICE }" aria-label="Search" aria-describedby="basic-addon2" disabled readonly>
                    </div>
                </div>
            </form>
            <div class="form-row">
            	<div class="col-md-6 mb-3">
            	</div>
                <div class="col-md-6 mb-3">
	              <button id="FrmBtn" class="btn btn-primary update-end-button">닫기</button> &nbsp;&nbsp;&nbsp;
	              <button id="FrmBtn" class="btn btn-primary update-excute-button">출고 취소하기</button> 
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
 height: 240px;
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
      			$("#updateSalesFrm").submit();
      		}
      	
      });
      
  });
  
  
  $(".searchModal-end").click(function(){
		$('#mySearchModal').modal("hide");
	});
