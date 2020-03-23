<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

      <!-- search-container start -->
      <div id="insert-container">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                    <label for="clubDate">일  자</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                <input type="text" id="clubDate" value="${clublist.clubDate}" readonly name="clubDate" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                    </div>
                </div> 
                  
                <div class="form-row">
	                <div class="col-md-6 mb-3">
	                	<label for="clubWriter">작성자</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="text" id=clubWriter value="${clublist.clubWriter}" readonly name="clubTitle" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
	                </div> 
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubName">동아리명</label>&nbsp;&nbsp;
                        <input type="text" id="clubName" value="${clublist.clubName}" readonly name="clubName" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>
                
                  <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubName">동아리명</label>&nbsp;&nbsp;
                        <input type="text" id="clubName" value="${clublist.clubName}" readonly name="clubName" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>
                
                  <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubName">동아리명</label>&nbsp;&nbsp;
                        <input type="text" id="clubName" value="${clublist.clubName}" readonly name="clubName" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>
                        
                  <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubTitle">제목</label>&nbsp;&nbsp;
                        <input type="text" id="clubTitle" value="${clublist.clubName}" readonly name="clubTitle" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>  
                
                 <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubWhere">장소</label>&nbsp;&nbsp;
                        <input type="text" id="clubWhere" value="${clublist.clubWhere}" readonly name="clubTitle" class="form-control bg-light small" aria-label="Search" aria-describedby="basic-addon2">
                	</div>
                </div>        
                  
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="clubComment">내 용</label>&nbsp;&nbsp;&nbsp;&nbsp;<br />
						<textarea class="form-control club-comment" placeholder="${clublist.clubComment}" readonly name="clubContent" cols="80" rows="5" aria-label="With textarea"></textarea>	
                    </div>
                </div>
           
                	
                </div>
               
                
      </div>
      
<style>
.modal-body{
 height: 500px;
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
.category-comment {
	width:200%;
	height:300%;
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
#searchDocument {
	z-index:1080;
}
#accordionSidebar{
	background-image : linear-gradient(180deg,#00475d 10%,#0a0f29 100%) !important;
}

</style>
