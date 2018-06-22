<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session = "false" %>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet">
	
<script>
	var trName = "";
    var userMenu = new BootstrapMenu('td', {
    	actions: [{
    		name: '상세 보기',
    		onClick: function() {
				document.location.href='/assetmanager/userDetail?employeeSeq=' + trName;
    		}
    	}]
    });
	var generalMenu = new BootstrapMenu('.container', {
		actions: [{
			name: '회원 추가',
			onClick: function(){
				location.href='/assetmanager/register';
			}
		}]
	});

	$(function(){
		// 사이드바 활성화
		$("#userLink").prop("class", "active");
		
		// 플래시 메시지
		var refreshCount = 1;
		
		$(".table-responsive").on("click", ".table tbody tr", function(){
			if(${userListData["userCount"]} > 0){
				document.location.href='/assetmanager/userDetail?employeeSeq='+$(this).data("href");
			}
		});
		var flashmsg = "<c:out value="${msg}"/>";
		
		if(refreshCount > 0){
			if(flashmsg != ""){
				alert(flashmsg);
			}
			refreshCount -= 1;
		}

		// 소트 클릭, 스크롤 연결
		$("#tableHead th").click(function(){
			var index = $("#tableHead th").index($(event.target).closest("th"));
			$("#tableBody th:eq("+index+") .sortable").click();
		});
		
		$("#divBody").scroll(function(){
			var scrollpos = $("#divBody").scrollLeft(); 
			$("#divHead .fixed-table-body").scrollLeft(scrollpos);
		});

		// 우클릭 시 해당 행의 관리 번호를 저장
		$("td").contextmenu(function(event){
			trName = $(event.target).closest("tr").attr('data-href');
		});

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-400);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-400);
		});

	});
	
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
		
	function searchFunc(){
		$.ajax({
			"type": "GET",
			"url": "userList",
			"dataType": "text",
			"data": {
				employeeName : $("#searchByName").val()
			},
			"success": function(list){
				alert("검색 완료 ");
			},
			"error": function(e){
				alert("오류 발생 : "+ e.responseText);
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
	#divHead{
		position: releative;
		height: 40px;
	}
	#divBody{
		z-index: -1;
		overflow-y: scroll;
	}
	#tableBody{
		overflow: auto;
		position: absolute;
	}
	#tableBody thead{
		visibility: collapse;
	}
</style>
	
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="listRefresh">
					<font size="6px"><b># 회원 관리</b></font>
					<label style="float: right; margin-top: 20px">
						<select>
							<option>회원 이름</option>
						</select>
						<input type="text" id="searchByName" name="employeeName">
						<input type="submit" value="검색" onclick="searchFunc();">
					</label>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;회원 수 : </font>
					<span class="badge">${userListData['userCount']}</span>
				</div>
				
				<div id="divHead">
				<div class="table-responsive">
					<table class="table table-striped" data-toggle="table" id="tableHead">
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
						<tbody style="visibility: collapse">
						<c:forEach items="${userListData['employeeList']}" var="employee">
							<input type="hidden" name='employeeSeq' value="${employee.employeeSeq}"/>
							<tr class="clickable-row" data-href="${employee.employeeSeq}">
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
				</div>
				
				<div class="table-responsive" id="divBody">
					<table class="table table-striped" data-toggle="table" id="tableBody">
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
						<c:forEach items="${userListData['employeeList']}" var="employee">
							<input type="hidden" name='employeeSeq' value="${employee.employeeSeq}"/>
							<tr class="clickable-row" data-href="${employee.employeeSeq}">
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
