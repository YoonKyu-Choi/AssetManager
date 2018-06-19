<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
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
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
		
		<!-- Custom styles for this template -->
		<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
		
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
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
					if(${categoryListData['categoryCount']} > 0){
						document.location.href='/assetmanager/categoryDetail?categoryName='+$(this).data("href");
					}
				});
				
				var windowHeight = window.innerHeight;
				$(".table-responsive").css("height", windowHeight-400);
				var rightHeight = $("#wrapper").height()-40;
				$("#divLeft").height(rightHeight);
				var rightWidth = $("#divLeft").width();
				$("#divHeadLeft").width(rightWidth);
				$(window).resize(function(){
					windowHeight = $(window).height();
					$(".table-responsive").css("height", windowHeight-400);
					rightHeight = $("#wrapper").height();
					$("#divLeft").height(rightHeight);
				});
				
			});
			
			$(function(){
				var isSearch = "${categoryListData['search']}";
				if(isSearch == "1"){
					var keyword = "${categoryListData['searchKeyword']}";
					var mode = "${categoryListData['searchMode']}";
					var result = [];
					if(mode == "1"){		// 분류 이름
						var count = "${categoryListData['categoryCount']}";
						$("#tableBody tr:gt(0) td:nth-child("+"${categoryListData['columnSize']}"+1+"n+1)").each(function(){
							$(this).closest("tr").show();
							var index = $("#tableBody tr").index($(this).closest("tr"));
							$("#divLeft tr:eq("+index+")").show();
							$("#divLeft tr:eq("+index+")").css("background-color", "transparent");
							var name = $(this).text();
							var match = name.match(new RegExp(keyword, 'g'));
							if(match == null){
								$(this).closest("tr").hide();
								$("#divLeft tr:eq("+index+")").hide();
								count -= 1;
							}
						});
						$("#divLeft td").css("background-color", "yellow");
						alert(count+"개의 분류 검색됨.");
					}
					else if(mode == "2"){	// 세부 항목
						var count = "${categoryListData['categoryCount']}";
						var checkary = [];
						for(var i=0; i<count; i++){
							checkary.push(false)
						}
						$("#tableBody tr:gt(0) td:not(:nth-child("+"${categoryListData['columnSize']}"+1+"n+1))").each(function(){
							$(this).css("background-color", "transparent");
							$(this).closest("tr").show();
							var index = $("#tableBody tr").index($(this).closest("tr"));
							$("#divLeft tr:eq("+index+")").show();
							var name = $(this).text();
							var match = name.match(new RegExp(keyword, 'g'));
							if(match != null){
								checkary[index-1] = true;
								$(this).css("background-color", "yellow");
							}
						});
						var count2 = count;
						for(var i=0; i<count; i++){
							if(checkary[i] == false){
								$("#tableBody tr:eq("+(i+1)+")").hide();
								$("#divLeft tr:eq("+(i+1)+")").hide();
								count2 -= 1;
							}
						}
						alert(count2+"개의 분류 검색됨.");
					}
				}
			});
			
			var trName = "";
			$(function(){
				$("td").contextmenu(function(event){
					trName = $(event.target).closest("tr").find("td:eq(0)").text();
				});
			});
		    var categoryMenu = new BootstrapMenu('td', {
		    	actions: {
		    		assetDetail: {
			    		name: '상세 보기',
			    		onClick: function() {
							var categorynum = ${categoryListData['categoryCount']};
							if(categorynum == 0){
								alert("해당 분류가 없습니다.");
								return;
							}
							document.location.href='/assetmanager/categoryDetail?categoryName=' + trName;
			    		}
		    		}
		    	}
		    });
			var generalMenu = new BootstrapMenu('.container', {
				actions: [{
					name: '분류 등록',
					onClick: function(){
						location.href='/assetmanager/categoryRegister';
					}
				}]
			});

			$(function(){
				var flashmsg = "<c:out value='${msg}'/>";
				
				if(flashmsg != ""){
					alert(flashmsg);
				}
			});

			$(function(){
				$("#tableHeadLeft th").click(function(){
					var index = $("#tableHeadLeft th").index($(event.target).closest("th"));
					$("#tableLeft th:eq("+index+") .sortable").click();
					$("#tableBody th:eq("+index+") .sortable").click();
				});
				$("#divBody").scroll(function(){
					var hscrollpos = $("#divBody").scrollLeft(); 
					$("#divHead .fixed-table-body").scrollLeft(hscrollpos);
					var vscrollpos = $("#divBody").scrollTop(); 
					$("#divLeft").scrollTop(vscrollpos);
				});
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
			.container{
				top:0;
				left:0;
				bottom:0;
				right:0;
				height:100%;
				width:100%;
			}
			.main{
				margin: auto;
				width: 60%;
			}
			#divHeadLeft{
				z-index: 9999;
				position: fixed;
				height: 40px;
			}
			#divLeft{
				z-index: 9999;
				margin-top: 40px;
				position: fixed;
				background-color: white;
				overflow-x: scroll;
				overflow-y: hidden;
			}
			#divLeft thead{
				visibility: collapse;
			}
			#divHead{
				position: releative;
				height: 40px;
			}
			#divBody{
				overflow-y: scroll;
			}
			#tableBody{
				overflow: auto;
				position: absolute;
			}
			#tableBody thead{
				visibility: collapse;
			}
			#box{
				display: flex;
			}
			#wrapper{
				flex: 1;
				display: flex;
				overflow: auto;
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
						<span class="badge">${categoryListData['categoryCount']}</span>
					</div>
					<% HashMap categoryListData = (HashMap)request.getAttribute("categoryListData");
					int columnSize = (Integer)categoryListData.get("columnSize");%>

					<div id="wrapper">
						<div id="box">
							<div id="divHeadLeft">
								<table class="table table-striped" data-toggle="table" id="tableHeadLeft">
									<thead>
										<tr>
											<th data-sortable="true">분류 이름</th>
										</tr>
									</thead>
								</table>
							</div>
						
							<div id="divLeft">
								<table class="table table-striped" data-toggle="table" id="tableLeft">
									<thead>
										<tr>
											<th data-sortable="true">분류 이름</th>
										</tr>
									</thead>
									
									<tbody>
									<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
										<tr class="clickable-row" data-href="${categoryItem.key.assetCategory}">
											<td>${categoryItem.key.assetCategory}</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
	
							<div id="rightWrap">
								<div id="divHead">
								<div class="table-responsive">
									<table class="table table-striped" data-toggle="table" id="tableHead">
										<thead>
											<tr>
												<th data-sortable="true">분류 이름</th>
												<%for(int i=0; i<columnSize; i++){%>
												<th>세부사항 <%=i+1 %></th>
												<%}%>
											</tr>
										</thead>
										
										<tbody style="visibility: collapse">
										<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
											<tr class="clickable-row" data-href="${categoryItem.key.assetCategory}">
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
								</div>
			
								<div class="table-responsive" id="divBody">
									<table class="table table-striped" data-toggle="table" id="tableBody">
										<thead>
											<tr>
												<th data-sortable="true">분류 이름</th>
												<%for(int i=0; i<columnSize; i++){%>
												<th>세부사항 <%=i+1 %></th>
												<%}%>
											</tr>
										</thead>
										
										<tbody>
										<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
											<tr class="clickable-row" data-href="${categoryItem.key.assetCategory}">
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
							</div>
						</div>
					</div>
						
					<div style="display:flex; float: right; margin-top: 10px">
						<button class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/categoryRegister';">등록</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>