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
				<h1 class="page-header">${requestScope.employeeVO.employeeName}님의 정보 수정</h1>

				<div class="table-responsive">
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
							<th>직급</th>
							<th><input type="text" value="${requestScope.employeeVO.rankVO.employeeRankString}"></th>
							<th><select	class="form-control dropdown" id="employeeRank" name="employeeRank">
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
							 </th>
						</tr>
						<tr>
							<th>소속</th>
							<th><input type="text" value="${requestScope.employeeVO.departmentVO.employeeDepartmentString}"></th>
						</tr>
						<tr>
							<th>위치</th>
							<th><input type="text" value="${requestScope.employeeVO.employeeLocation}"></th>
						</tr>
						<tr>
							<th>이메일</th>
							<th><input type="text" value="${requestScope.employeeVO.employeeEmail}"></th>
						</tr>
						<tr>
							<th>연락처</th>
							<th><input type="text" value="${requestScope.employeeVO.employeePhone}"></th>
						</tr>
						<tr>
							<th>상태</th>
							<th><input type="text" value="${requestScope.employeeVO.employeeStatus}"></th>
						</tr>
						<tr>
					</table>
				</div>
				
				<script>
					function cancelConfirm(){
						if(!confirm("취소하겠습니까?")){
							return false;
						}else{
							$("#idForm")
						}
					}
				</script>
				
				<form id="idForm" action="userDetail" method="POST">
					<input type="hidden" name="employeeSeq" value=${requestScope.employeeVO.employeeSeq} />
				</form>
				
				<div style="display:flex; float:right">
					<button class="btn btn-lg btn-primary" style="margin-right:10px">확인</button> 
					<button class="btn btn-lg btn-primary" onclick="cancelConfirm();">취소</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>