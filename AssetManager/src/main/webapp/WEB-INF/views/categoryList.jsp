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
		<!-- The above 3 meta tags must come first in the head; any other head content must come after these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		
		<title>사용자 목록</title>
		
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
					document.location.href='/assetmanager/categoryDetail?categoryName='+$(this).data("href");
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
				"success" : function(){
					alert("검색 완료");
					$("#employeeTable").load("userList #employeeTable");
					
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
					<form class="page-header" >
						<font size="6px" bold>분류 목록</font>&nbsp;&nbsp;&nbsp;&nbsp;
						<font size="4px">분류 수 : </font>
						<span class="badge">${categoryCount}</span>
						<label style="float:right">
							<input type="text" name="searchCategory" value="분류 이름으로 검색" readonly>
							<input type="text" name="assetCategory">
							<input type="submit" onclick="categoryList">
						</label>
					</form>
					<%int columnSize = (Integer)request.getAttribute("columnSize");%>
					<div class="table-responsive" style="overflow: scroll; height: 400px">
						<table class="table table-striped" data-toggle="table">
							<thead>
								<tr>
									<th data-sortable="true">분류 이름</th>
									<%for(int i=0; i<columnSize; i++){%>
									<th></th>
									<%}%>
								</tr>
							</thead>
							
							<tbody>
							<c:forEach items="${categoryItemList}" var="categoryItem">
								<tr class="clickable-row" data-href="${categoryItem.key}">
									<td>${categoryItem.key}</td>
									<%int i=0; %>
									<c:forEach items="${categoryItem.value}" var="item">
									<td>${item}</td>
									<%i += 1; %>
									</c:forEach>
									<%while(i<columnSize){
										i += 1;%>
									<td></td>
									<%}%>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div style="display:flex; float: right; margin-top: 10px">
						<button class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/categoryRegister';">등록</button>
						<button class="btn btn-lg btn-primary" style="margin-left: 10px" onclick="location.href='/assetmanager/categoryDelete';">삭제</button>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>