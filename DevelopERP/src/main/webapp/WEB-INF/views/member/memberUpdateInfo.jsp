<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>

#enroll-btn {
	margin:0 auto;
}

#button-group {
	padding: 0px 50px;
}

#button-group .step {
	margin-top: 0px;
}

.td-warn{
	font-size: 14px;
    color: rgba(221, 30, 47, 1);
}
</style>
<script>
<%--onload function--%>
$(()=>{
	var regExpName = /^[가-힣]{2,4}$/;
	var regExpEmail = /\w+@\w+\.\w+/;
	var regExpPhone = /^01[0179][0-9]{7,8}$/;

$("#emp_name").keyup(function(event){
	var emp_name = document.getElementById("emp_name");
	
	if($("#emp_name").val() == ""){
		$(".nameValidateWarning").html('이름을 입력해 주시기 바랍니다.');
		$("#emp_name").attr("style","border-bottom: 2px solid red");
	}
	if(!regExpName.test(emp_name.value)){
		$(".nameValidateWarning").html('2~4자의 한글을 입력해 주시기 바랍니다.');
		$("#emp_name").attr("style","border-bottom: 2px solid red");
	}
	else{
		$("#emp_name").attr("style","border-bottom: 2px solid green");
		$(".nameValidateWarning").html('');
	}
});	

$("#phone").keyup(function(event){
	var phone = document.getElementById("phone");
	
	if($("#phone").val() == ""){
		$(".phoneValidateWarning").html('전화번호를 입력해 주시기 바랍니다.');
		$("#phone").attr("style","border-bottom: 2px solid red");
	}
	if(!regExpPhone.test(phone.value)){
		$(".phoneValidateWarning").html('10~11자의 숫자를 입력해주세요.( - 없이 입력) ');
		$("#phone").attr("style","border-bottom: 2px solid red");
	}
	else{
		$("#phone").attr("style","border-bottom: 2px solid green");
		$(".phoneValidateWarning").html('');
	}
});	


})

<%--회원가입 유효성검사함수(폼제출)--%>
function enrollValidate(){
	var emp_name = document.getElementById("emp_name");
	var phone = document.getElementById("phone");
	<%--이름 유효성검사--%>
	if(!regExpTest(/^[가-힣]{2,4}$/, emp_name, "이름은 2~4자의 한글만 사용 가능합니다.")){
        return false;
	}
    <%--전화번호 유효성검사--%>
	if(!regExpTest(/^01[0179][0-9]{7,8}$/, phone, "전화번호 형식이 올바르지 않습니다.")){
        return false;
	}
	return true;
	
}

<%--유효성검사 함수--%>		
function regExpTest(regExp, el, msg){
	if(regExp.test(el.value)){
	    return true;
	}else{
		<%--적합한 문자열이 아닌 경우--%>
		alert(msg);
		el.value="";
		el.focus();
		return false;
	}
}

</script>

<body>
<form action="${pageContext.request.contextPath}/member/memberUpdateInfoEnd.do" 
        	  name="memberUpdateInfoFrm" 
        	  method="post" 
        	  onsubmit="return enrollValidate();" >
		<div class="table-box">
			<table>
				<tr>
					<td>이메일주소&nbsp;&nbsp;</td>
					<td>
						<input class="form-control input-text" type="email"
						name="email" id="email" value="${memberLoggedIn.email }"  />
					</td>
				</tr>
				<tr>
					<td><input class="form-control input-text" type="hidden" 
						name="password" id="password" placeholder="비밀번호" value="1111" /></td>
				</tr>
				<tr>
					<td><input class="form-control input-text" type="hidden" 
						name="profileImage" id="profileImage" placeholder="프로필사진" value="${memberLoggedIn.profileImage}" /></td>
				</tr>
				<tr>
					<td><input class="form-control input-text" type="hidden" 
						name="ssn1" id="ssn1" placeholder="주민번호" value="${memberLoggedIn.empNo }" /></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>성명&nbsp;&nbsp;</td>
					<td><input class="form-control input-text" type="text"
						name="emp_name" id="emp_name" value="${memberLoggedIn.empName }" /></td>
				</tr>
				<tr>
					<td></td>
					<td class="nameValidateWarning td-warn"></td>
					<td></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<c:if test='${memberLoggedIn.email eq "admin@admin.com"}'>
				<tr>
					<td>부서명&nbsp;&nbsp;</td>
					<td>
						<select name="dept_code" id="dept_code" style="width:130px" required>
							<option value="${memberLoggedIn.deptCode}" selected >${dept_title.DEPT_TITLE}</option>
								<c:forEach items="${dept}" var="d">
									<option value="${d.DEPT_ID}">${d.DEPT_TITLE }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>직급명&nbsp;&nbsp;</td>
					<td>
						<select name="job_code" id="job_code" style="width:130px" required>
							<option value="${memberLoggedIn.jobCode}" selected  >${job_name.JOB_NAME}</option>
								<c:forEach items="${job}" var="j">
									<option value="${j.JOB_CODE}">${j.JOB_NAME }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				</c:if>
				<tr>
					<td>전화번호&nbsp;&nbsp;</td>
					<td>
						<input type="text" class="form-control input-text"
						name="phone" id="phone" value="${memberLoggedIn.phone}" />
					</td>
				</tr>
				<tr>
					<td></td>
					<td class="phoneValidateWarning td-warn"></td>
					<td></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
			</table>
			
			<div class="modal-footer">
        		<button type="submit" id="FrmBtn" name="submit" class="btn btn-primary">수정</button>
            	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        	</div>
		</div>
	</form>
</body>
</html>