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
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.js"></script>
<script
	src="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.js"></script>
<link
	href="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.css"
	rel="stylesheet" />

</head>
<body>

	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">${requestScope.employeeVO.employeeName}님 정보</h1>

				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>번호</th>
							<th>${requestScope.employeeVO.employeeSeq}</th>
						</tr>
						<tr>
							<th>이름</th>
							<th>${requestScope.employeeVO.employeeName}</th>
						</tr>
						<tr>
							<th>아이디</th>
							<th>${requestScope.employeeVO.employeeId}</th>
						</tr>
						<tr>
							<th>직급</th>
							<th>${requestScope.employeeVO.rankVO.employeeRankString}</th>
						</tr>
						<tr>
							<th>소속</th>
							<th>${requestScope.employeeVO.departmentVO.employeeDepartmentString}</th>
						</tr>
						<tr>
							<th>위치</th>
							<th>${requestScope.employeeVO.employeeLocation}</th>
						</tr>
						<tr>
							<th>이메일</th>
							<th>${requestScope.employeeVO.employeeEmail}</th>
						</tr>
						<tr>
							<th>연락처</th>
							<th>${requestScope.employeeVO.employeePhone}</th>
						</tr>
						<tr>
							<th>상태</th>
							<th>${requestScope.employeeVO.employeeStatus}</th>
						</tr>
						<tr>
					</table>
				</div>
				
				<script>
					function deleteConfirm(){
						if(!confirm("삭제하겠습니까?")){
							return false;
						}else{
							var pw = prompt("비밀번호를 입력해주세요.");
							$("input[name=checkAdminPw]").val(pw);
							$("#idForm").submit();
						}
					}
				</script>
				
				<form id="idForm" action="userDelete" method="POST">
					<input type="hidden" name="employeeSeq" value=${requestScope.employeeVO.employeeSeq} />
					<input type="hidden" name="checkAdminPw"/>
				</form>
				
				<div style="display:flex; float:right">
					<button class="btn btn-lg btn-primary" style="margin-right:10px">회원 수정</button>
					
					<button class="btn btn-lg btn-primary" onclick="deleteConfirm();">회원 삭제</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>