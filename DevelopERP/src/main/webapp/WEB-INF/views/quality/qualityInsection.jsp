<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- Custom styles for this page -->
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link href="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">품질 검사 관리</h1>
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="float:right;">
            <div class="input-group mb-3">
			  <div class="input-group-prepend">
			    <label class="input-group-text" for="inputGroupSelect01">제품군별 조회하기</label>
			  </div>
			  <select class="custom-select typeList" id="inputGroupSelect01" name="typeList">
			    <option ${empty type?"selected":"" } value=""> 전체</option>
			    <c:forEach items="${typeList}" var="t">
				    <option value="${t.content }" ${t.content eq type?"selected":"" }>${t.content }</option>
			    </c:forEach>
			  </select>
			</div>
          </form>
          <br />

          <!-- DataTales Example -->
          <div class="card shadow mb-4" style="clear:both;">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">미 검사 리스트</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered insection-table" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Lot번호</th>
                      <th>제품명</th>
                      <th>제품타입</th>
                      <th>창고명</th>
                      <th>수량</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                	<c:forEach items="${list }" var="l">
	                    <tr>
	                      <td>${l.LOT_NO }</td>
	                      <td>${l.PRODUCT_NAME }</td>
	                      <td>${l.TYPE}</td>
	                      <td>${l.STORE_NAME }</td>
	                      <td>${l.QUANTITY }</td>
	                      <td>${l.ENROLL_DATE }</td>
	                    </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
  <!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="InsectionModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title insection-title"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body insection-modal-body">
            <!-- <p>Modal body text goes here.</p> -->
        </div>
        
        </div>
    </div>
</div>
  
<script>
$(".insection-table tbody tr").click(function(){
	console.log($(this).children().eq(0).html());
	var lotNo = $(this).children().eq(0).html();
	
// 	var url = "${pageContext.request.contextPath}/quality/insertQualityForm.do";
// 	var title = "login";
// 	var spec = "left=350px, top=200px, width=600px, height=400px";
	
// 	open(url, title, spec);
	 $('.insection-modal-body').load("${pageContext.request.contextPath}/quality/insectionQualityForm.do?lotNo="+lotNo,function(){
	        $('#InsectionModal').modal({backdrop: 'static', keyboard: false});
	        $('#InsectionModal').modal({show:true});
	        $(".modal-backdrop.in").css('opacity', 0.4);
	        $(".insection-title").html("");
	        $(".insection-title").html(lotNo);
		});
});

$(".typeList").change(function(){
	var type = $(".typeList option:selected").val();
	location.href = "${pageContext.request.contextPath}/quality/qualityInsection.do?type="+type;
})

</script>
<style>
#InsectionModal{
	z-index: 1060;
}
.quality-table tbody tr td:hover{
	cursor:pointer;
}
</style>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/datatables-demo.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>