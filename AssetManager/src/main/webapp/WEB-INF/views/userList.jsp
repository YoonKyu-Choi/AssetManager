<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session = "false" %>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags must come first in the head; any other head content must come after these tags -->
	<meta name="description" content="">
	<meta name="author" content="">
			
	<!-- Bootstrap core CSS -->
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
	
	<script>
		function depSort(a, b){
			if(a.dep < b.dep) return -1;
			if(a.dep > b.dep) return 1;
			return 0;
		}
		function rankSort(a, b){
			if(a.rank < b.rank) return -1;
			if(a.rank > b.rank) return 1;
			return 0;
		}
		
		$(function(){
			$(".table-responsive").on("click", ".table tbody tr", function(){
				document.location.href='/assetmanager/userDetail?employeeSeq='+$(this).data("href");
			});
				var flashmsg = "<c:out value="${msg}"/>";
			
			if(flashmsg != "")
				alert(flashmsg);
		});
		
		$(function(){
			
			var windowHeight = window.innerHeight;
			$(".table-responsive").css("height", windowHeight-300);
			$(window).resize(function(){
				windowHeight = $(window).height();
				$(".table-responsive").css("height", windowHeight-300);
				})
		});
		
		function searchFunc(){
			alert($("#searchByName").val());
			$.ajax({
			"type" : "GET",
				"url":"userList",
			"dataType":"text",
			"data" : {
				employeeName : $("#searchByName").val()
			},
			"success" : function(list){
				alert("검색 완료 ");
			},
				"error" : function(e){
				alert("오류 발생 : "+e.responseText);
			}
			});
		}
	</script>
	
	<style>
		th, td {
	text-align: center;
	}
	th{
	background-color:darkgray;
	color:white;
	}
	p{
			font-size:25px;
	}
	</style>
	
</head>
	<body>
	 <div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="listRefresh"><font size="6px" bold>회원 목록</font>&nbsp;&nbsp;&nbsp;&nbsp;<font size="4px">회원 수 : </font><span class="badge">${userCount}</span>
				<input type="text" id="searchCategory" name="searchCategory" value="회원 이름으로 검색" readonly>
				<input type="text" id="searchByName" name="employeeName">
				<input type="submit" value="검색" onclick="searchFunc();">
				</form>
				<div class="table-responsive" style="overflow: scroll; height: 400px">
					<table class="table table-striped" data-toggle="table">
						<thead>
							<tr>
								<th data-sortable="true">상태</th>
								<th data-sortable="true">이름</th>
								<th data-sortable="true">아이디</th>
								<th data-sortable="true" data-sorter="depSort" data-field="dep" data-sort-name="_dep_data">소속</th>
								<th data-sortable="true" data-sorter="rankSort" data-field="rank" data-sort-name="_rank_data">직급</th>
								<th data-sortable="true">위치</th>
								<th data-sortable="true">이메일</th>
								<th data-sortable="true">연락처</th>
							</tr>
						</thead>
						
						<tbody>
						<c:forEach items="${employeeList}" var="employee">
							<tr class="clickable-row" data-href="${employee.employeeSeq}">
								<input type="hidden" name="employeeSeq" value="${employee.employeeSeq}"/>
								<td>${employee.employeeStatus}</td>
								<td>${employee.employeeName}</td>
								<td>${employee.employeeId}</td>
								<td data-dep="${employee.departmentVO.employeeDepartment}">${employee.departmentVO.employeeDepartmentString}</td>
								<td data-rank="${employee.rankVO.employeeRank}">${employee.rankVO.employeeRankString}</td>
								<td>${employee.employeeLocation}</td>
								<td>${employee.employeeEmail}</td>
								<td>${employee.employeePhone}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<button class="btn btn-lg btn-primary" style="float:right; margin-top: 10px" onclick="location.href='/assetmanager/register';">회원 추가</button>
			</div>
		</div>
	</div>
</body>
