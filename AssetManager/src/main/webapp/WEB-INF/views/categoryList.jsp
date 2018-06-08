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
		
		<title>분류 목록</title>
		
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
					if(${categoryCount} > 0){
						document.location.href='/assetmanager/categoryDetail?categoryName='+$(this).data("href");
					}
				});

				var flashmsg = "<c:out value='${msg}'/>";
				
				if(flashmsg != "")
					alert(flashmsg);
				
				var windowHeight = window.innerHeight;
				$(".table-responsive").css("height", windowHeight-350);
				$(window).resize(function(){
					windowHeight = $(window).height();
					$(".table-responsive").css("height", windowHeight-350);
				});
				
			});
			
			$(function(){
				var isSearch = "${search}";
				if(isSearch == "1"){
					var keyword = "${searchKeyword}";
					var mode = "${searchMode}";
					var result = [];
					if(mode == "1"){
						var count = "${categoryCount}";
						$("tr:gt(0) td:nth-child("+"${columnSize}"+1+"n+2)").each(function(){
							$(this).closest("tr").show();
							var name = $(this).text();
							var match = name.match(new RegExp(keyword, 'g'));
							if(match == null){
								$(this).closest("tr").hide();
								count -= 1;
							}
						});
						alert(count+"개의 분류 검색됨.");
					}
					else if(mode == "2"){
						var count = "${categoryCount}";
						var checkary = [];
						for(var i=0; i<count; i++){
							checkary.push(false)
						}
						$("tr:gt(0) td:not(:nth-child("+"${columnSize}"+1+"n+2))").each(function(){
							$(this).closest("tr").show();
							var name = $(this).text();
							var match = name.match(new RegExp(keyword, 'g'));
							if(match != null){
								var index = $("tr").index($(this).closest("tr"));
								checkary[index-1] = true;
							}
						});
						var count2 = count;
						for(var i=0; i<count; i++){
							if(checkary[i] == false){
								$("tr:eq("+(i+1)+")").hide();
								count2 -= 1;
							}
						}
						alert(count2+"개의 분류 검색됨.");
					}
				}
			});
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
					<form class="page-header" id="searchForm" action="categoryList">
						<font size="6px"><b>분류 관리 > 분류 목록</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
						<label style="float:right; margin-top: 20px">
							<select id="searchMode" name="searchMode">
								<option value="1">분류 이름</option>
								<option value="2">세부 항목</option>
							</select>
							<input type="text" id="searchKeyword" name="searchKeyword">
							<input type="submit" value="검색">
						</label>
					</form>
					<div style="margin-bottom: 10px">
						<font size="4px">&nbsp;&nbsp;분류 수 : </font>
						<span class="badge">${categoryCount}</span>
					</div>
					<%int columnSize = (Integer)request.getAttribute("columnSize");%>
					<div class="table-responsive" style="overflow: scroll; height: 400px">
						<table class="table table-striped" data-toggle="table">
							<thead>
								<tr>
									<th data-sortable="true">분류 코드</th>
									<th data-sortable="true">분류 이름</th>
									<%for(int i=0; i<columnSize; i++){%>
									<th>세부사항 <%=i+1 %></th>
									<%}%>
								</tr>
							</thead>
							
							<tbody>
							<c:forEach items="${categoryItemList}" var="categoryItem">
								<tr class="clickable-row" data-href="${categoryItem.key.assetCategory}">
									<td>${categoryItem.key.assetCategoryCode}</td>
									<td>${categoryItem.key.assetCategory}</td>
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
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>