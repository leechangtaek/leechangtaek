<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<style>
#empModify{
	z-index: 1060;
	width:100%;	
	height:100%;	
}
.modal-content{
	width:700px;
}
.steps {
	text-align: center;
	margin-top: 30px;
}

.table-box.enroll .btn {
	height: 33px;
	font-size: 13px;
	display: inline-block;
}

.table-box.enroll{
	margin: 0 auto;
	
	text-align: center;
}
.table-box.enroll td{
	width:350px;
	padding-top:9px;
}

.table-box.enroll  {
	position:relative;
	width:800px;
	margin: 0 auto;
	border-collapse: separate;
	border-spacing: 50px 10px;
}

.table-box.enroll .form-control {
	border-radius: 5px;
	border: 1px solid lightgray;
}
.table-box.enroll .input-text {
	width:350px;
}
.table-box.enroll .input-text-ssn {
	width:163px;
	display:inline-block;
}

.table-box.enroll #enroll-btn {
	margin:0 auto;
}

.table-box.enroll #button-group {
	padding: 0px 50px;
}

.table-box.enroll #button-group .step {
	margin-top: 0px;
}

.table-box.enroll .td-warn{
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
	var regExpSsn1 = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[01])$/;
	var regExpSsn2 = /^[1234]\d{6}$/;
	

<%--아이디 중복검사 이후 아이디를 변경한 경우--%>
<%--change이벤트는 blur할 경우, 값변경 내역을 감지한다.--%>
$("#email").change(function(){
	$("#emailValid").val(0);
});

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

$("#ssn1").keyup(function(event){
	var ssn1 = document.getElementById("ssn1");
	
	if($("#ssn1").val() == ""){
		$(".ssn1ValidateWarning").html('주민번호를 기입해 주시기 바랍니다.');
		$("#ssn1").attr("style","border-bottom: 2px solid red");
	}
	if(!regExpSsn1.test(ssn1.value)){
		$(".ssn1ValidateWarning").html('주민번호형식이 올바르지 않습니다.');
		$("#ssn1").attr("style","border-bottom: 2px solid red");
	}
	else{
		$("#ssn1").attr("style","border-bottom: 2px solid green");
		$(".ssn1ValidateWarning").html('');
	}
});	
$("#ssn2").keyup(function(event){
	var ssn2 = document.getElementById("ssn2");
	
	if($("#ssn2").val() == ""){
		$(".ssn2ValidateWarning").html('주민번호를 기입해 주시기 바랍니다.');
		$("#ssn2").attr("style","border-bottom: 2px solid red");
	}
	if(!regExpSsn2.test(ssn2.value)){
		$(".ssn2ValidateWarning").html('주민번호형식이 올바르지 않습니다.');
		$("#ssn2").attr("style","border-bottom: 2px solid red");
	}
	else{
		$("#ssn2").attr("style","border-bottom: 2px solid green");
		$(".ssn2ValidateWarning").html('');
	}
});	



})

<%--회원가입 유효성검사함수(폼제출)--%>
function enrollValidate(){
	var emp_name = document.getElementById("emp_name");
	var email = document.getElementById("email");
	var phone = document.getElementById("phone");
	var ssn1 = document.getElementById("ssn1");
	var ssn2 = document.getElementById("ssn2");
	var $emailValid = $("#emailValid");
	console.log($emailValid.val());
    <%--이메일 유효성검사--%>
	if(!regExpTest(/\w+@\w+\.\w+/g, email, "이메일 형식이 올바르지 않습니다.")){
        return false;
	}
	<%--이메일 중복검사를 하지않았을경우--%>
	if($emailValid.val() == 0){
		alert("이메일 중복 검사 해주세요.");
		return false;
	}
	<%--이름 유효성검사--%>
	if(!regExpTest(/^[가-힣]{2,4}$/, emp_name, "이름은 2~4자의 한글만 사용 가능합니다.")){
        return false;
	}
    
	<%--주민번호 유효성검사--%>
    if(isValidDate(ssn1.value)==false){
    	return false;
    }
    if(isValidDate(ssn2.value)==false){
    	return false;
    }
	
    <%--전화번호 유효성검사--%>
	if(!regExpTest(/^01[0179][0-9]{7,8}$/, phone, "전화번호 형식이 올바르지 않습니다.")){
        return false;
	}

	var regExp4 = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[01])$/;
	var regExp5 = /^[1234]\d{6}$/;
	if(!regExpTest(regExp4,ssn1,"숫자만 입력하세요."))
	    return false;
	if(!regExpTest(regExp5,ssn2,"숫자만 입력하세요."))
	    return false;
	if(!ssnCheck(ssn1.value,ssn2.value)){
	    alert("올바른 주민번호가 아닙니다.");
	    return false;
	}
	
	return true;
	
}


<%--중복검사 ajax--%>
function emailDuplicatedCheck(){
	var regExpEmail = /\w+@\w+\.\w+/g;
	var email=$(".table-box #email").val().trim();
	console.log(email);
	$.ajax({
		url: "${pageContext.request.contextPath}/member/memberEmailDuplicatedCheck.do",
		data:{email:email},
		dataType: "json",
		success: data => {
			console.log(data);
			
			if((data.result ==0 && (data.isUsable==true) && regExpEmail.test(email))){
				$(".emailValidateWarning").html('사용가능한 이메일입니다.');
				$(".emailValidateWarning").attr("style","color:#00c500");
				$("#email").attr("style","border-bottom: 2px solid #00c500");
				$("#emailValid").val(1);
			}
			else if(!regExpEmail.test(email)){
				$(".emailValidateWarning").html('이메일 형식이 올바르지 않습니다.');
				$("#email").val("");
				$("#email").attr("style","border-bottom: 2px solid red");
				$("#emailValid").val(0);
				
			} 
			else {
				$(".emailValidateWarning").html('중복된 이메일입니다.');
				$("#email").val("");
				$(".emailValidateWarning").attr("style","red");
				$("#email").attr("style","border-bottom: 2px solid red");
				$("#emailValid").val(0);
			}
		},
		error : (jqxhr, textStatus, errorThrown)=>{
			console.log(jqxhr, textStatus, errorThrown);
		}
	});
}



<%--유효성검사 함수--%>		
function regExpTest(regExp, el, msg){
	if(regExp.test(el.value)){
	    return true;
	}
	<%--적합한 문자열이 아닌 경우--%>
	alert(msg);
	el.value="";
	el.focus();
	return false;
}
$("#FrmBtn").click(function(){           	
	$('#empModify').modal("hide");
});

</script>
<section>


	<form action="${pageContext.request.contextPath}/member/memberManageModifyEnd.do" 
        	  name="memberEnrollFrm" 
        	  method="post" 
        	  onsubmit="return enrollValidate();" >
		<div class="table-box enroll">
			<table>
				<tr>
					<td>이메일주소<span>*</span></td>
					<td>
						<input class="form-control input-text" type="email"
						name="email" id="email" value="${member.email}" readonly/>
					</td>
					
				</tr>
				<tr>
					<td></td>
					<td class="emailValidateWarning td-warn"></td>
					<td></td>
				</tr>
				<tr>
					<td><input class="form-control input-text" type="hidden" 
						name="password" id="password" placeholder="비밀번호" value="1111" /></td>
				</tr>
				<tr>
					<td>성명<span>*</span></td>
					<td><input class="form-control input-text" type="text"
						name="empName" id="emp_name" value="${member.empName}" /></td>
				</tr>
				<tr>
					<td></td>
					<td class="nameValidateWarning td-warn"></td>
					<td></td>
				</tr>
				<tr>
					<td>부서명<span>*</span></td>
					<td>
						<select name="deptCode" id="dept_code" style="width:100px">
							<option value="" selected disabled >부서명</option>
								<c:forEach items="${dept}" var="d">								
									<option value="${d.DEPT_ID}"${d.DEPT_TITLE eq member.deptCode? 'selected':"" }>${d.DEPT_TITLE }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>직급명<span>*</span></td>
					<td>
						<select name="jobCode" id="job_code" style="width:100px">
							<option value="" selected disabled >직급명</option>
								<c:forEach items="${job}" var="j">
									<option value="${j.JOB_CODE}" ${j.JOB_NAME eq member.jobCode? 'selected':"" }>${j.JOB_NAME }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>주민번호<span>*</span></td>
					<td><input class="form-control input-text-ssn" type="text"
						name="empNo1" id="ssn1" value='${empNo1}' /> &nbsp;-&nbsp;
						
						<input class="form-control input-text-ssn" 
						name="empNo2" id="ssn2" value='${empNo2}' /></td>
				</tr>
				<tr>
					<td></td>
					<td class="ssn1ValidateWarning td-warn"></td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="ssn2ValidateWarning td-warn"></td>
					<td></td>
				</tr>
				
				<tr>
					<td>전화번호<span>*</span></td>
					<td>
						<input type="text" class="form-control input-text"
						name="phone" id="phone" value='${member.phone}' />
					</td>
				</tr>
				<tr>
					<td></td>
					<td class="phoneValidateWarning td-warn"></td>
					<td></td>
				</tr>
			</table>
			
			   <div class="form-row" style="text-align:right;display:inline;">
            	<div class="col-md-6 mb-3" >
	              <input type="submit" class="btn btn-outline-success" value="수정하기" >
	                <input type="button" class="btn btn-outline-success"id="FrmBtn" value="닫기">
	              </div>
	              </div>
		</div>
	</form>
</section>
