<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP Main</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
	  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath }/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath }/resources/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/demo/chart-area-demo.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/demo/chart-pie-demo.js"></script>
  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath }/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
  <!--  chart -->
  <style>
 .main-container{
    width: 1440px;
  }
  .bg-gradient-primary{
    background-image: linear-gradient(180deg,#00475d 10%,#0a0f29 100%);
  }
  </style>

</head>

	<div class="main-container">
    <body id="page-top">

      <!-- Page Wrapper -->
      <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

          <!-- Sidebar - Brand -->
          <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath }/main/main.do?email=${memberLoggedIn.email}" style="padding-left:0;">
          	<img src="${pageContext.request.contextPath }/resources/images/logo.png"  width=80px;/>
          	DevelopERP
          </a>

          <!-- Divider -->
          <hr class="sidebar-divider my-0">

          <!-- Nav Item - Dashboard -->
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath }/main/main.do?email=${memberLoggedIn.email}">
              <i class="fas fa-fw fa-tachometer-alt"></i>
              <span>메인페이지</span></a>
          </li>

          <!-- Divider -->
          <hr class="sidebar-divider">

          <!-- Heading -->
          <div class="sidebar-heading">
            COMMUNITY
          </div>

          <!-- Nav Item - Pages Collapse Menu -->
          <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
              <i class="fas fa-fw fa-user"></i>
              <span>그룹웨어</span>
            </a>
            <div id="collapseOne" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
              <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">Detail</h6>
                <a class="collapse-item" href="${pageContext.request.contextPath }/document/documentView.do">문서결재</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/attend/attendList.do">출결관리</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/board/boardList.do">게시판</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/facility/facilityList.do">시설물 예약</a>
              </div>
            </div>
          </li>

          <!-- Divider -->
          <hr class="sidebar-divider">

           <!-- Heading -->
           <div class="sidebar-heading">
            MANAGEMENT
          </div>

          <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
              <i class="fas fa-fw fa-cog"></i>
              <span>기초등록</span>
            </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
              <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">DETAIL</h6>
               	<a class="collapse-item" href="${pageContext.request.contextPath }/enrollment/vendorEnrollment.do">거래처등록</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/enrollment/warehouseEnrollment.do">창고등록</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/enrollment/productEnrollment.do">품목등록</a>
              </div>
            </div>
          </li>
          
          
          
          <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEight" aria-expanded="true" aria-controls="collapseEight">
              <i class="fas fa-fw fa-cog"></i>
              <span>구매관리</span>
            </a>
            <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordionSidebar">
              <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">DETAIL</h6>
                <a class="collapse-item" href="${pageContext.request.contextPath }/purchase/purchaseView.do">구매조회</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/purchase/purchaseInsertView.do">구매입력</a>
              </div>
            </div>
          </li>
          
          

          <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
              <i class="fas fa-fw fa-cog"></i>
              <span>생산관리</span>
            </a>
            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionSidebar">
              <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">DETAIL</h6>
                <a class="collapse-item" href="${pageContext.request.contextPath }/production/BOMListManagement.do">BOM 목록관리</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/production/warehousing.do">생산입고</a>
              </div>
            </div>
          </li>

          <li class="nav-item">
              <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                <i class="fas fa-fw fa-cog"></i>
                <span>생산 계획 관리</span>
              </a>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">DETAIL</h6>
                   <a class="collapse-item" href="${pageContext.request.contextPath}/productplan/productionPlan.do">월별 생산 계획</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath}/productplan/purchasePlan.do">원재료 구매 계획</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath}/productplan/jobOrder.do">작업 지시서</a>
                </div>
              </div>
            </li>

          
          <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFive" aria-expanded="true" aria-controls="collapseFive">
              <i class="fas fa-fw fa-cog"></i>
              <span>재고관리</span>
            </a>
            <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionSidebar">
              <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">DETAIL</h6>
                <a class="collapse-item" href="${pageContext.request.contextPath }/stock/rm/rmSnrView.do">원재료 입출고/재고관리</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/stock/product/productView.do">완제품 재고관리</a>
                <a class="collapse-item" href="${pageContext.request.contextPath }/stock/storage/storageView.do?storeNo=0">창고별 재고관리</a>
              </div>
            </div>
          </li>

          <li class="nav-item">
              <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSix" aria-expanded="true" aria-controls="collapseSix">
                <i class="fas fa-fw fa-cog"></i>
                <span>품질관리</span>
              </a>
              <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">DETAIL</h6>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/quality/doughnutHistoGraph.do">부적합 현황</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/quality/xbarGraphByProduct.do">제품별 Xbar 그래프</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/quality/searchCPk.do">공정 계수 조회</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/quality/qualityInsection.do">품질 검사 관리</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/quality/qualityControll.do">부적합 관리</a>
                </div>
              </div>
            </li>
            
          <li class="nav-item">
              <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseNine" aria-expanded="true" aria-controls="collapseEight">
                <i class="fas fa-fw fa-cog"></i>
                <span>영업관리</span>
              </a>
              <div id="collapseNine" class="collapse" aria-labelledby="headingNine" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">DETAIL</h6>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/sales/salesListManagement.do">영업관리</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath }/sales/xbarGraphByProduct.do">제품별 판매 조회</a>
                </div>
              </div>
            </li>

          <!-- Divider -->
          <hr class="sidebar-divider">

          <!-- Heading -->
           <c:if test='${memberLoggedIn.email eq "admin@admin.com"}'>
          <div class="sidebar-heading">
            Admin
          </div>
          <li class="nav-item">
              <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="true" aria-controls="collapseSeven">
                <i class="fas fa-fw fa-cog"></i>
                <span>관리자페이지</span>
              </a>
              <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">DETAIL</h6>
                  <a class="collapse-item" href="${pageContext.request.contextPath}/member/memberEnroll.do">신입사원등록</a>
                  <a class="collapse-item" href="${pageContext.request.contextPath}/member/memberManage.do">사원 조회/수정</a>
                </div>
              </div>
            </li>
            </c:if>


        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

          <!-- Main Content -->
          <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

              <!-- Sidebar Toggle (Topbar) -->
              <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                <i class="fa fa-bars"></i>
              </button>

              <!-- Topbar Search -->
                <div class="input-group headerText">
                  <input type="text" class="form-control bg-light border-0 small headerText" id="searchKeyword" name="searchKeyword" placeholder="Search for..." >
                  <ul id="search_AutoSearch"></ul>
                    <button class="btn btn-primary headerText" type="button">
                      <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
                

              <!-- Topbar Navbar -->
              <ul class="navbar-nav ml-auto">

<!--                 Nav Item - Alerts -->
<!--                 <li class="nav-item dropdown no-arrow mx-1"> -->
<!--                   <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--                     <i class="fas fa-bell fa-fw"></i> -->
<!--                     Counter - Alerts -->
<!--                     <span class="badge badge-danger badge-counter">3+</span> -->
<!--                   </a> -->
<!--                   Dropdown - Alerts -->
<!--                   <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown"> -->
<!--                     <h6 class="dropdown-header"> -->
<!--                       Alerts Center -->
<!--                     </h6> -->
<!--                     <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                       <div class="mr-3"> -->
<!--                         <div class="icon-circle bg-primary"> -->
<!--                           <i class="fas fa-file-alt text-white"></i> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                       <div> -->
<!--                         <div class="small text-gray-500">December 12, 2019</div> -->
<!--                         <span class="font-weight-bold">A new monthly report is ready to download!</span> -->
<!--                       </div> -->
<!--                     </a> -->
<!--                     <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                       <div class="mr-3"> -->
<!--                         <div class="icon-circle bg-success"> -->
<!--                           <i class="fas fa-donate text-white"></i> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                       <div> -->
<!--                         <div class="small text-gray-500">December 7, 2019</div> -->
<!--                         $290.29 has been deposited into your account! -->
<!--                       </div> -->
<!--                     </a> -->
<!--                     <a class="dropdown-item d-flex align-items-center" href="#"> -->
<!--                       <div class="mr-3"> -->
<!--                         <div class="icon-circle bg-warning"> -->
<!--                           <i class="fas fa-exclamation-triangle text-white"></i> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                       <div> -->
<!--                         <div class="small text-gray-500">December 2, 2019</div> -->
<!--                         Spending Alert: We've noticed unusually high spending for your account. -->
<!--                       </div> -->
<!--                     </a> -->
<!--                     <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a> -->
<!--                   </div> -->
<!--                 </li> -->

                <!-- Nav Item - Messages -->
                <li class="nav-item dropdown no-arrow mx-1 message">
                  <span class="nav-link dropdown-toggle message" id="messagesDropdown" >
                    <i class="fas fa-envelope fa-fw" style="cursor:pointer;"></i>
                    <!-- Counter - Messages -->
                    <span class="badge badge-danger badge-counter message"></span>
                  </span>
                </li>



                  <!-- Nav Item - Messenger -->
                  <li class="nav-item dropdown no-arrow mx-1">
                      <span class="nav-link dropdown-toggle messenger "id="messagesDropdown">
                        <i class="fas fa-fw fa-comment"></i>
                        <!-- Counter - Messages -->
                        <span class="badge badge-danger badge-counter messenger"></span>
                      </span>
                    </li>
                
                <div class="topbar-divider d-none d-sm-block"></div>

                <!-- Nav Item - User Information -->
                <li class="nav-item dropdown no-arrow mypage">
                  <a class="nav-link dropdown-toggle mypage" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">${memberLoggedIn.empName}</span>
                    <img class="img-profile rounded-circle" src="${pageContext.request.contextPath }/resources/images/account_circle_black.png">
                  </a>
                  <!-- Dropdown - User Information -->
                  <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in mypage" aria-labelledby="userDropdown">
                 	<div class="mypage_head">
                 		<form action="<%=request.getContextPath()%>/member/memberProfile.do" id="profileImgSubmit" method="POST" enctype="multipart/form-data">
	                 		<input type="file" id="profileImage" name="uploadFile" onchange="changeValue(this)"/>
	                 		<input type="hidden" id="email" name="email" value="${memberLoggedIn.email }"/>
	                 		<img src="${pageContext.request.contextPath}/resources/upload/member/${memberLoggedIn.profileImage}"  class="mypage_image" />
                 		</form>
                 		<span class="mypage_alterpassword" onclick="mypage_alterpassword();">
                 			<img src="${pageContext.request.contextPath}/resources/images/lock.png" class="mypage_lock" />
                 			비밀번호 변경
                 		</span>
                 	</div>
                 	<div class="mypage_blank"></div>
                    <span class="dropdown-item empNameBold" onclick="mypage_updateName();">
                    	${memberLoggedIn.empName}
                    </span>
                    <span class="dropdown-item"onclick="mypage_updateName();" >
                    	${dept_title.DEPT_TITLE}  /  ${job_name.JOB_NAME}
                    </span>
                    <span class="dropdown-item" onclick="mypage_updateName();">
                    	<img src="${pageContext.request.contextPath}/resources/images/phone.png" class="mypage_phoneimg" />
                    	${memberLoggedIn.phone}   
                    	<i class="fas fa-envelope fa-fw"></i>
                    	${memberLoggedIn.email }
                    </span>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item mypageLogout" href="${pageContext.request.contextPath}/member/memberLogOut.do">
                      <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                      Logout
                    </a>
                  </div>
                </li>

              </ul>

            </nav>
            <!-- End of Topbar -->
            <style>
            .mypage_head{
            background-color:steelblue; width:400px; height:100px;
            }
            .dropdown-menu{
            padding:0;
            }
            .mypage_head .mypage_image{
            width:90px; height:90px; position:absolute; top:13%; left:40%; box-shadow:0px 1px 3px 2px #ccc;
            cursor:pointer;
            }
            .mypage_phoneimg{
            width:25px; height:25px;
            }
            .mypage_alterpassword{
            color:white; position:absolute; top:30%; right:1%; cursor:pointer;
            }
            .mypage_alterpassword .mypage_lock{
            width:30px; height:30px; position:absolute; top:-29%; left:-32%;
            }
            .mypage_blank{
            height:31px;
            }
            .dropdown-item{
          	text-align:center;
          	cursor:pointer;
            }
            .empNameBold{
            font-weight:bold;
            }
            .mypageLogout{
            text-align:left;
            }
            #profileImage{
            display:none;
            }
            .modal-content.updatePassword{
            	width:500px;
            }
            .modal-content.updateInfo{
            	width:500px;
            	height:100%;
            }
            </style>
            
             <!-- 비밀번호변경 Modal -->
			<div class="modal" tabindex="-1" role="dialog" id="updatePassword">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content updatePassword">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-updatePassword">비밀번호 변경</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-updatePassword">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        
			        </div>
			    </div>
			</div>
			
             <!-- 이름변경 Modal -->
			<div class="modal" tabindex="-1" role="dialog" id=updateInfo>
			    <div class="modal-dialog" role="document">
			        <div class="modal-content updateInfo">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-updateInfo">내정보 변경</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-updateInfo">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        
			        </div>
			    </div>
			</div>
			
             <!-- message Modal -->
			<div class="modal" tabindex="-1" role="dialog" id="messageList">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content messeage">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-messageList">쪽지함</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-messageList">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        <div class="modal-footer">
			          <button type="button" class="btn btn-primary messageListModal-end">닫기</button>
			      </div>
			        
			        </div>
			    </div>
			</div>
			
             <!-- insert message Modal -->
			<div class="modal" tabindex="-1" role="dialog" id="insertMessage">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content messeage">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-insertMessage">새쪽지</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-insertMessage">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        
			        
			        </div>
			    </div>
			</div>
             <!-- detail message Modal -->
			<div class="modal" tabindex="-1" role="dialog" id="detailMessage">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content messeage">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-detailMessage">쪽지보기</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-detailMessage">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        
			        </div>
			    </div>
			</div>
             <!-- answer message Modal -->
			<div class="modal" tabindex="-1" role="dialog" id="answerMessage">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content messeage">
			        <div class="modal-header">
			            <h5 class="modal-title controll-title-answerMessage">답장보기</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			            <span aria-hidden="true">&times;</span>
			            </button>
			        </div>
			        <div class="modal-body controll-modal-body-answerMessage">
			            <!-- <p>Modal body text goes here.</p> -->
			        </div>
			        </div>
			    </div>
			</div>
						<%--messenger modal --%>
			<div class="modal" tabindex="-1" role="dialog" id="messengerList">
			  <div class="modal-dialog" role="document">
			      <div class="modal-content messenger">
			      <div class="modal-header">
			          <h5 class="modal-title control-title-messengerList" id="messengerList">Messenger </h5>
			          <div class="form-row" >
	                    <div class="col-md-6">
	                        <button class="btn btn-primary messenger" type="button">
	                            <i class="fas fa-search fa-sm"></i>
	                        </button>
	                    </div>
                  </div>
			      </div>
			      <div class="modal-body controll-modal-body-messengerList">
			      </div>
			      <div class="modal-footer">
			          <button type="button" class="btn btn-primary messengerList-end">닫기</button>
			      </div>
			      </div>
			  </div>
			</div>
			
						<%--documentLastApproval modal --%>
			<div class="modal" tabindex="-1" role="dialog" id="searhMessageList">
			  <div class="modal-dialog" role="document">
			      <div class="modal-content messeage">
			      <div class="modal-header">
			          <h5 class="modal-title control-title-searhMessageList" id="searhMessageList"> </h5>
			      </div>
			      <div class="modal-body controll-modal-body-searhMessageList">
			      </div>
			      <div class="modal-footer">
			          <button type="button" class="btn btn-primary searchModal-end">닫기</button>
			      </div>
			      </div>
			  </div>
			</div>
			
			
			
			<script>
			$(function(){
				$(".mypage_image").click(function (e){
					$("#profileImage").click();
				});
			});
			
			function changeValue(obj){
					$("#profileImgSubmit").submit();
	    	       	$("li.nav-item.dropdown.no-arrow.mypage").addClass("show");
	    	       	$("a#userDropdown.nav-link.dropdown-toggle.mypage").attr("aria-expanded","true");
	    	       	$("div.dropdown-menu.dropdown-menu-right.shadow.animated--grow-in.mypage").addClass("show");

	         };

			function mypage_alterpassword(){
			    $('.controll-modal-body-updatePassword').load("${pageContext.request.contextPath}/member/memberAlterPassword.do",function(){
			        $('#updatePassword').modal({backdrop: 'static', keyboard: false});
			        $('#updatePassword').modal({show:true});
			        $(".modal-backdrop.in").css('opacity', 0.4);
			        
			    });
					$("#updatePassword").modal();			        
			};
			function mypage_updateName(){
			    $('.controll-modal-body-updateInfo').load("${pageContext.request.contextPath}/member/memberUpdateInfo.do",function(){
			        $('#updateInfo').modal({backdrop: 'static', keyboard: false});
			        $('#updateInfo').modal({show:true});
			        $(".modal-backdrop.in").css('opacity', 0.4);
			        
			    });
					$("#updateInfo").modal();			        
			};
			
				
			$(".nav-link.dropdown-toggle.message").on("click",function(){
					$('.controll-modal-body-messageList').load("${pageContext.request.contextPath}/message/messageList.do?empName=${memberLoggedIn.empName}",function(){
				        $('#messageList').modal({backdrop: 'static', keyboard: false});
				        $('#messageList').modal({show:true});
				        $(".modal-backdrop.in").css('opacity', 0.4);
				    });
			});
			
		
			
			$(".nav-link.dropdown-toggle.messenger").on("click",function(){
					$('.controll-modal-body-messengerList').load("${pageContext.request.contextPath}/messenger/messengerList.do",function(){
				        $('#messengerList').modal({backdrop: 'static', keyboard: false});
				        $('#messengerList').modal({show:true});
				        $(".modal-backdrop.in").css('opacity', 0.4);
				        
				    });
				
			});
			
		
			$(()=>{
				$.ajax({
					url:"${pageContext.request.contextPath}/message/messageCount.do?empName=${memberLoggedIn.empName}",
					dataType:"json",
					success:data=>{
						$(".badge-counter.message").html(data.messageCount);
					}
				})
				$.ajax({
					url:"${pageContext.request.contextPath}/messenger/messengerCount.do",
					dataType:"json",
					success:data=>{
						$(".badge-counter.messenger").html(data.messengerCount);
					}
				})
				
				
			});
			$(".btn.btn-primary.headerText").click(function(){
				var searchKeyword = $("#searchKeyword").val();
				$.ajax({
					url:"${pageContext.request.contextPath}/search/searchKeywordInfo.do?searchKeyword="+searchKeyword,
					type:"get",
					dataType:"json",
					success:data=>{
							location.href="${pageContext.request.contextPath}"+data.SEARCH_ADDRESS;
					},
					error:function(jqxhr,textStatus, errorThrown){
						console.log("ajax처리실패!",jqxhr, textStatus, errorThrown);
					}
				})
				
			});
			
			var $autoSearch = $("#search_AutoSearch");
			$autoSearch.hide();
			
			$("#searchKeyword").on('keyup',function(e){
			
				var $sel = $(".sel");
				var $li = $autoSearch.children("li");
				
				if(e.key == "ArrowDown"){
					
					if($sel.length ==0){
						$li.first().addClass("sel");
					}
					else{
						$sel.removeClass("sel")
							.next()
							.addClass("sel")
					}
				}
				else if(e.key=='ArrowUp'){
					if($sel.length != 0){
						$sel.removeClass("sel")
							.prev()
							.addClass("sel");
					}
					else{
						$li.last().addClass("sel");
					}
				}
				else if(e.key =='Enter'){
					var $name = $(".sel").text();
					$("#searchKeyword").val($name);
					var searchKeyword= $("#searchKeyword").val();	
					$.ajax({
						url:"${pageContext.request.contextPath}/search/searchKeywordInfo.do?searchKeyword="+searchKeyword,
						type:"get",
						dataType:"json",
						success:data=>{
  							location.href="${pageContext.request.contextPath}"+data.SEARCH_ADDRESS;
						},
						error:function(jqxhr,textStatus, errorThrown){
							console.log("ajax처리실패!",jqxhr, textStatus, errorThrown);
						}
					})
				}
				else{
					var srchNameVal =$(this).val().trim();
					if(srchNameVal.length ==0) return;
					$.ajax({
						url:"${pageContext.request.contextPath}/search/headerSearch.do",
						type:"get",
						data:{srchName : srchNameVal},
						dataType:"json",
						success : data=>{
							console.log(data);
							var html="";
							if(data.csv.trim().length==0){
								html="<li class='noSearch'>조회된 결과가 없습니다. </li>";
								$autoSearch.html(html).fadeIn(300);
							}else{
								var dataArr = data.csv.split("^");
								$.each(dataArr, (idx,val)=>{
									html += "<li>"+val.replace(srchNameVal,'<span class = "srchval">'+srchNameVal+'</span>')+"</li>";		
								});
								$autoSearch.html(html).fadeIn(300);
							}
						},
						error:function(jqxhr,textStatus, errorThrown){
							console.log("ajax처리실패!",jqxhr, textStatus, errorThrown);
						}
					});
				}
				
				$autoSearch.on('click','li',e=>{
					var $name = $(e.target).text();
					
					$('#searchKeyword').val($(e.target).text());
					$autoSearch.hide()
							   .children()
							   .remove();
				}).on('mouseover','li',e=>{
					$(e.target).addClass("sel")
							   .siblings()
							   .removeClass("sel");
				}).on('mouseout','li',e=>{
					$(e.target).removeClass("sel");
				});
				
			});
			
			
			
			
			</script>
			  <style>
			  div.input-group.headerText{position: relative; width:400px; }
			  	#searchKeyword{box-shadow:none;}
				ul#search_AutoSearch{background-color: #f8f9fc; min-width: 362px; border: 1px solid #bac8f3; 
									position: absolute; top: 37px; padding:0; margin:0; z-index:1000;
									border-top:0 !important;     box-shadow: 0 0 0 0.2rem rgba(78,115,223,.25);   
									    border-radius: .35rem; box-shadow-top:0;}  
				ul#search_AutoSearch li{padding:13px 28px 0px; list-style:none; cursor:pointer;}
				ul#search_AutoSearch li hr{margin:0;}
				ul#search_AutoSearch li.sel{background:#bac8f3; color:white;}
				span.srchval{color:red;}
			  .noSearch{
			  	padding:13px 28px 11px !important;
			  	color:black;
			  	text-align:center;
			  	cursor:none;
			  }
			  li #searchIcon{
				position:absolute;
				left:1%;
			    display: block;
			    margin:2px 0 0 6px;
			    width: 15px;
			    height: 15px;
			    background-image: url(../resources/images/images.png);
			    background-size: 15px 15px;
			    background-repeat:no-repeat;
			}
			  </style>
  

            <!-- 페이지 내용(Begin Page Content) -->
            <div class="container-fluid">
