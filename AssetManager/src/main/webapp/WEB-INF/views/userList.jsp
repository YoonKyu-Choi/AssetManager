<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session = "false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		
		<title>사용자 목록</title>
		
		<!-- Bootstrap core CSS -->
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.js"></script>
		<script src="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.js"></script>
		<link href="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.css" rel="stylesheet"/>
		
	</head>

	<body>
	
		 <div class="container-fluid">
			<div class="row">
				<div class="main">
					<h1 class="page-header">사용자 목록</h1>
					
					<div class="table-responsive">
						<table class="table table-striped" data-toggle="table">
							<thead>
								<tr>
									<th data-sortable="true">번호</th>
									<th data-sortable="true">상태</th>
									<th data-sortable="true">이름</th>
									<th>아이디</th>
									<th data-sortable="true" data-sorter="depSort" data-field="dep" data-sort-name="_dep_data">소속</th>
									<th data-sortable="true" data-sorter="rankSort" data-field="rank" data-sort-name="_rank_data">직급</th>
									<th data-sortable="true">위치</th>
									<th>이메일</th>
									<th>연락처</th>
								</tr>
							</thead>
							<tbody>
							
							<script>
								function depSort(a, b){
									if(a.dep < b.dep) return -1;
									if(a.dep > b.dep) return 1;
									return 0;
								}
							</script>
							<script>
								function rankSort(a, b){
									if(a.rank < b.rank) return -1;
									if(a.rank > b.rank) return 1;
									return 0;
								}
							</script>
							
							<c:forEach items="${employeeList}" var="employee">
								<tr class="clickable-row" data-href="assetmanager/userList?employeeSeq=${employee.vo.employeeSeq}">
									<td>${employee.vo.employeeSeq}</td>
									<td>${employee.vo.employeeStatus}</td>
									<td>${employee.vo.employeeName}</td>
									<td>${employee.vo.employeeId}</td>
									<td data-dep="${employee.vo.employeeDepartment}">${employee.dep}</td>
									<td data-rank="${employee.vo.employeeRank}">${employee.rank}</td>
									<td>${employee.vo.employeeLocation}</td>
									<td>${employee.vo.employeeEmail}</td>
									<td>${employee.vo.employeePhone}</td>
								</tr>
							</c:forEach>

							</tbody>
						</table>
					</div>
					<button class="btn btn-lg btn-primary" style="float:right">회원 추가</button>
				</div>
			</div>
		</div>
		
	</body>
</html>
