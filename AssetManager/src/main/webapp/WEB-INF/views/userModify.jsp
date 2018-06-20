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

<title>사용자 상세보기</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/css/dashboard.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#userLink").prop("class", "active");
	});
	
	$(function(){
		$("#employeeRank").val("${requestScope.employeeVO.employeeRank}").prop("selected", true);
		$("#employeeDepartment").val("${requestScope.employeeVO.employeeDepartment}").prop("selected", true);
		$("#employeeLocation").val("${requestScope.employeeVO.employeeLocation}").prop("selected", true);
		$("#employeeStatus").val("${requestScope.employeeVO.employeeStatus}").attr("selected", "selected");
	});

	function cancelConfirm() {
		if (!confirm("취소하겠습니까?")) {
			return false;
		} else {
			$("#idForm").submit();
		}
	}
	function modifyConfirm() {
		if (!confirm("수정하겠습니까?")) {
			return false;
		} else {
			$("#modifySend").submit();
		}
	}
	
	$(function(){
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-400);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-400);
		});
	});
	
</script>
<style>
	.form-controlmin {
		display: block;
		width: 12%;
		height: 34px; 
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.42857143;
		color: #555;
		background-color: #fff;
		background-image: none;
		border: 1px solid #ccc;
		border-radius: 4px;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
		-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
		transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}
	.form-controlmin2 {
		display: block;
		width: 25%;
		height: 34px;
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.42857143;
		color: #555;
		background-color: #fff;
		background-image: none;
		border: 1px solid #ccc;
		border-radius: 4px;
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
		-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
		transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}
	.container{
		top:0;
		left:0;
		bottom:0;
		right:0;
		height:100%;
		width:100%;
		margin-top: 1%;
	}
	.main{
		margin-left: 13%;
		width: 76%;
	}
	th:nth-child(2n+1){
		width: 25%;
		font-weight: bold;
	}
	th:nth-child(2n+2){
		width: 75%;
		font-weight: normal;
	}
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header"><b># 회원 정보 수정</b></h1>
				<div class="table-responsive">
					<form id="modifySend" method="POST" action="/assetmanager/userModifyConfirm">
						<input type="hidden" name="employeeSeq" value="${requestScope.employeeVO.employeeSeq}"/>
						<table class="table table-striped">
							<tr>
								<th>이름</th>
								<th>${requestScope.employeeVO.employeeName}</th>
							</tr>
							<tr>
								<th>아이디</th>
								<th>${requestScope.employeeVO.employeeId}</th>
							</tr>
							<tr>
								<th>비밀번호</th>
								<th><input type="password" name="employeePw" value="${requestScope.employeeVO.employeePw}"></th>
							</tr>
							<tr>
								<th>직급</th>
								<th><select class="form-controlmin dropdown" id="employeeRank"
									name="employeeRank">
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
								</select></th>
							</tr>
							<tr>
								<th>소속</th>
								<th><select class="form-controlmin2 dropdown" id="employeeDepartment" name="employeeDepartment">
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
								</select></th>
							</tr>
							<tr>
								<th>위치</th>
								<th><select class="form-controlmin dropdown" id="employeeLocation" name="employeeLocation">
										<option value="0">위치를 선택하세요</option>
										<option value="4층">4층</option>
										<option value="5층">5층</option>
								</select></th>
							</tr>
							<tr>
								<th>이메일</th>
								<th><input type="text" name="employeeEmail" value="${requestScope.employeeVO.employeeEmail}"></th>
							</tr>
							<tr>
								<th>연락처</th>
								<th><input type="text" name="employeePhone" value="${requestScope.employeeVO.employeePhone}"></th>
							</tr>
							<tr>
								<th>상태</th>
								<th><select class="form-controlmin dropdown admin" id="employeeStatus" name="employeeStatus">
										<option value="재직" selected>재직</option>
										<option value="휴직">휴직</option>
										<option value="퇴사">퇴사</option>
								</select></th>
							</tr>
							<tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div style="display: flex; float: right">
		<input type="button" class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();" value="확인" />
		<input type="button" class="btn btn-lg btn-primary" onclick="cancelConfirm();" value="취소" />
	</div>
	<form id="idForm" action="userDetail" method="POST">
		<input type="hidden" name="employeeSeq"	value=${requestScope.employeeVO.employeeSeq } />
	</form>

</body>
</html>