<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/signin.css" rel="stylesheet">

<script>
	$(function(){
		// 권한별 버튼 보이기
		var isAdmin = "<%=session.getAttribute("isAdmin") %>";
		if(isAdmin == "TRUE"){
			$(".admin").show();
		}
		
		// 드롭다운 사이즈 조정
		var left = $('#rank').height();
		var right = $('.dropdown').height();
		$('.dropdown').height(left);
	});

	function idCheck() {
		var id = $('#employeeId').val();
		$.ajax({
			"type" : "POST",
			"url" : "checkId",
			"dataType" : "text",
			"data" : {
				id : id
			},
			"beforeSend" : function() {
				var flag = idInputCheck();
				if (flag == false){
					return false;
				}
			},
			"success" : function(message) {
				if (message == 'new') {
					alert("사용 가능한 아이디입니다.");
					$("#employeeId").addClass("disable");
					$("#idInputCheck").val("true");
					$("#employeeId").attr("readonly", true);
				} else if (message == 'duplicated') {
					alert("중복된 아이디입니다.");
					$("#employeeId").val("");
					$("#idInputCheck").val("false");
				} else if (message == 'empty') {
					alert("사용할 아이디를 입력해주세요.");
					$("#idInputCheck").val("false");
				}
			},
			"error" : function(request, status, error) {
				alert("code:" + request.status + "\nmessage:"
						+ request.responseText + "\nerror:" + error);
			}
		});

	}

	function isEmail(email) {
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		return regex.test(email);
	}

	function isPhone(phone) {
		var regex = /\d{3}[\-]\d{4}[\-]\d{4}/;
		return regex.test(phone);
	}

	function submitCheck() {
		nameInputCheck();
		if(!isEmail($("#employeeEmail").val())){
			alert("이메일 형식이 올바르지 않습니다. 다시 입력해주세요. (example@exm.com)");
			$("#employeeEmail").focus();
			return false;
		} else if(!isPhone($("#employeePhone").val())){
			alert("연락처 형식이 올바르지 않습니다. 다시 입력해주세요. (010-1234-5678)");
			$("#employeePhone").focus();
			return false;
		} else if ($("#idInputCheck").val() == 'false') {
			alert("아이디 중복확인을 체크해주세요.");			
			return false;
		} else if($("#employeeName").val()==''){
			alert("이름을 입력해주세요.");
			$("#employeeName").focus();
			return false;
		} else if($("#employeePw").val()==''){
			alert("비밀번호를 입력해주세요.");
			$("#employeePw").focus();
			return false;
		} else if($("#employeeRank").val()=='0'){
			alert("직급을 선택해주세요.");
			return false;
		} else if($("#employeeDepartment").val()=='0'){
			alert("소속을 선택해주세요.");
			return false;
		} else if($("#employeeLocation").val()=='0'){
			alert("위치를 선택해주세요.");
			return false;
		} else if($("#employeeEmail").val()==''){
			alert("이메일을 입력해주세요.");
			$("#employeeEmail").focus();
			return false;
		} else if($("#employeePhone").val()==''){
			alert("연락처를 입력해주세요.");
			$("#employeePhone").focus();
			return false;
		} else {
			$("#registerSend").submit();
		}
	};
	
	function idInputCheck() {
		var str = $("#employeeId").val();
		var pattern1 = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글 x
		var pattern2 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 x
		var pattern3 = /[\s]/; // 공백 x

		if (pattern1.test(str)) {
			alert("아이디로 한글은 사용할 수 없습니다.");
			$("#employeeId").val("");
			$("#employeeId").focus();
			return false;
		}
		if (pattern2.test(str)) {
			alert("아이디는 특수문자를 사용할 수 없습니다.");
			$("#employeeId").val("");
			$("#employeeId").focus();
			return false;
		}
		if (pattern3.test(str)) {
			alert("아이디에 공백을 넣을 수 없습니다.");
			$("#employeeId").val("");
			$("#employeeId").focus();
			return false;
		};
	}

	function nameInputCheck() {
		var str = $("#employeeName").val();
		var pattern2 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 x

		if (pattern2.test(str)) {
			alert("이름에 특수문자를 사용할 수 없습니다.");
			$("#employeeName").val("");
			$("#employeeName").focus();
			return false;
		}
	}

	function registerCancel(){
		var isAdmin = "<%=session.getAttribute("isAdmin")%>"; 
		if(isAdmin == "TRUE"){
			location.href='/assetmanager/userList';
		} else{
			location.href='/assetmanager/';
		}
	}
</script>

</head>

<body>
	<input type="hidden" value="false" id="idInputCheck">
	<div style="text-align: center" id="main">
		<form class="form-signin" id="registerSend" method="POST" action="/assetmanager/registerSend">
			<h2 class="form-signin-heading" style="text-align: center">회원가입 정보 입력</h2>
			<div style="display: flex; margin-left: 90px">
				<p>
					<label class="form-control"	style="background: transparent; margin-bottom: 0px">이름</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px">아이디</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px">비밀번호</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px" id="rank">직급</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px">소속</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px">위치</label>
					<label class="form-control" style="background: transparent; margin-bottom: 0px">이메일</label>
					<label class="form-control admin" style="background: transparent; margin-bottom: 0px; display:none">상태</label>
					<label class="form-control" style="background: transparent">연락처</label>
				</p>
				<p style="margin: 0; justify-content: center" id="inputs">
					<input type="text" class="form-control" id="employeeName" name="employeeName" maxlength="6"> 
					<input type="text" class="form-control" id="employeeId" name="employeeId" maxlength="10"> 
					<input type="password" class="form-control" id="employeePw" name="employeePw" maxlength="10"> 
					<select	class="form-control dropdown" id="employeeRank" name="employeeRank">
						<option value="0">직급을 선택하세요</option>
						<option value="1">대표이사</option>
						<option value="2">부사장</option>
						<option value="3">전무이사</option>
						<option value="4">상무이사</option>
						<option value="5">이사</option>
						<option value="6">부장</option>
						<option value="7">차장</option>
						<option value="8">과장</option>
						<option value="9">대리</option>
						<option value="10">주임</option>
						<option value="11">사원</option>
					</select> 
					<select class="form-control dropdown" id="employeeDepartment" name="employeeDepartment">
						<option value="0">소속을 선택하세요</option>
						<option value="1">이에스이</option>
						<option value="2">　└ 경영지원본부</option>
						<option value="3">　　└ 관리팀</option>
						<option value="4">　└ 전략사업본부</option>
						<option value="5">　　└ 본사</option>
						<option value="6">　　└ 중국지사</option>
						<option value="7">　└ 솔루션영업본부</option>
						<option value="8">　　└ 영업팀</option>
						<option value="9">　　└ 사업전략팀</option>
						<option value="10">　└ 솔루션사업본부</option>
						<option value="11">　　└ 기획팀</option>
						<option value="12">　　└ 솔루션개발팀</option>
						<option value="13">　　└ 사업수행팀</option>
						<option value="14">　└ 기술연구소</option>
						<option value="15">　　└ 연구1팀</option>
						<option value="16">　　└ 연구2팀</option>
						<option value="17">　　└ 품질관리팀</option>
						<option value="18">　└ 개발사업본부</option>
						<option value="19">　　└ 개발1팀</option>
						<option value="20">　　└ 개발2팀</option>
					</select> 
					<select class="form-control dropdown" id="employeeLocation" name="employeeLocation">
						<option value="0">위치를 선택하세요</option>
						<option value="4층">4층</option>
						<option value="5층">5층</option>
					</select>
					<input type="email" class="form-control" id="employeeEmail" name="employeeEmail" maxlength="100" required autofocus>
					<select class="form-control dropdown admin" style="display:none" id="employeeStatus" name="employeeStatus">
						<option value="재직" selected>재직</option>
						<option value="휴직">휴직</option>
						<option value="퇴사">퇴사</option>
					</select>
					<input type="text" class="form-control" id="employeePhone" name="employeePhone" maxlength="20">
				</p>

				<p style="margin-left: 10px">
					<label class="form-control" style="opacity: 0; margin-bottom: -1px">위치</label>
					<input type="button" class="btn btn-lg btn-primary btn-block" onclick="idCheck();" value="중복확인" />
				</p>
			</div>
			
			<div style="display: flex; width: 300px; margin-left: 90px">
				<input type="button" class="btn btn-lg btn-primary btn-block" id="registerBtn" onclick="submitCheck();" value="회원가입" />
				<label style="opacity: 0; margin: 10px"></label>
				<input type="button" class="btn btn-lg btn-primary btn-block" onclick="registerCancel();" value="취소" />
			</div>
		</form>
	</div>
</body>
