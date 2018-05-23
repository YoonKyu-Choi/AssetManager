<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>이에스이 자산관리시스템</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/resources/css/signin.css"
	rel="stylesheet">
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript">
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
					if (flag == false)
						return false;
				},
				"success" : function(message) {
					if (message == 'new') {
						alert("사용 가능한 아이디입니다.");
						$("#employeeId").addClass("disable");
						$("#idInputCheck").val("true");
						$("#employeeId").attr("readonly", true);
					} else if (message == 'deplicated') {
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

		function submitCheck() {
			if ($("#idInputCheck").val() == 'false') {
				alert("아이디 중복확인을 체크해주세요.");
				return false;
			} 
			else if($("#employeeRank").val()=='0'){
				alert($("#employeeRank").val());
				alert("직급을 선택해주세요.");
				return false;
			} else if($("#employeeDepartment").val()=='0'){
				alert("소속을 선택해주세요.");
				return false;
			} else if($("#employeeLocation").val()=='0'){
				alert("위치를 선택해주세요.");
				return false;
			}
			else {
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
				alert("아이디는 특수문자를 사용할 수 없습니다");
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
	</script>
	<input type="hidden" value="false" id="idInputCheck">
	<div style="text-align: center" id="main">
		<form class="form-signin" id="registerSend" method="POST" action="/assetmanager/registerSend">
			<h2 class="form-signin-heading" style="text-align: center">로그인
				정보 입력</h2>
			<div style="display: flex; margin-left: 90px">
				<p>
					<label class="form-control"
						style="background: transparent; margin-bottom: 0px">이름</label> <label
						class="form-control"
						style="background: transparent; margin-bottom: 0px">아이디</label> <label
						class="form-control"
						style="background: transparent; margin-bottom: 0px">비밀번호</label> <label
						class="form-control"
						style="background: transparent; margin-bottom: 0px" id="rank">직급</label>
					<label class="form-control"
						style="background: transparent; margin-bottom: 0px">소속</label> <label
						class="form-control"
						style="background: transparent; margin-bottom: 0px">위치</label> <label
						class="form-control"
						style="background: transparent; margin-bottom: 0px">이메일</label> <label
						class="form-control" style="background: transparent">연락처</label>
				</p>
				<p style="margin: 0; justify-content: center" id="inputs">
					<input type="text" class="form-control" name="employeeName" required autofocus> 
					<input type="text" class="form-control" id="employeeId" name="employeeId" required autofocus> 
					<input type="password" class="form-control" name="employeePw" required autofocus> 
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
						<option value="2">└ 경영전략기획실</option>
						<option value="3">└ 관리팀</option>
						<option value="4">└ 경영전략팀</option>
						<option value="5">└ 품질관리팀</option>
						<option value="6">└ 리노기술연구소</option>
						<option value="7">└ 연구개발1팀</option>
						<option value="8">└ 연구개발2팀</option>
						<option value="9">└ 스마트사업본부</option>
						<option value="10">└ 전략사업TF</option>
						<option value="11">└ 스마트시티팀</option>
						<option value="12">└ 스마트타운팀</option>
						<option value="13">└ 중국지사</option>
						<option value="14">└ 스마트TS본부</option>
						<option value="15">└ TS1팀</option>
						<option value="16">└ TS2팀</option>
						<option value="17">└ TS3팀</option>
					</select> 
					<select class="form-control dropdown" id="employeeLocation" name="employeeLocation">
						<option value="0">위치를 선택하세요</option>
						<option value="4층">4층</option>
						<option value="5층">5층</option>
					</select> <input type="email" class="form-control" name="employeeEmail"
						required autofocus> <input type="text"
						class="form-control" name="employeePhone" required autofocus>
					<input type="hidden" name="employeeStatus" value="재직">
				</p>

				<script type="text/javascript">
					var left = $('#rank').height();
					var right = $('.dropdown').height();
					$('.dropdown').height(left);
				</script>

				<p style="margin-left: 10px">
					<label class="form-control" style="opacity: 0; margin-bottom: -1px">위치</label>
					<input type="button" class="btn btn-lg btn-primary btn-block"
						onclick="idCheck();" value="중복확인" />
				</p>
			</div>
			<div style="display: flex; width: 300px; margin-left: 90px">
				<input type="button" class="btn btn-lg btn-primary btn-block"
					id="registerBtn" onclick="submitCheck();" value="회원가입" /> <label
					style="opacity: 0; margin: 10px"></label> <input type="button"
					class="btn btn-lg btn-primary btn-block"
					onclick="location.href='/assetmanager/'" value="취소" />
			</div>
		</form>
	</div>
</body>
</html>