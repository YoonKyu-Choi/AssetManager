<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page session = "false" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">

<script>
	var trName = "";
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
		// 사이드바 활성화
		$("#catgLink").prop("class", "active");

		// 테이블이 비어있을 경우 클릭 불가
		$(".table-responsive").on("click", ".table tbody tr", function(){
			if(${categoryListData["categoryCount"]} > 0){
				document.location.href='/assetmanager/categoryDetail?categoryName='+$(this).data("href");
			}
		});

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-400);
		var rightHeight = $("#wrapper").height()-55;
		$("#divLeft").height(rightHeight);
		var rightWidth = $("#divLeft").width();
		$("#divHeadLeft").width(rightWidth);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-400);
			rightHeight = $("#wrapper").height()-55;
			$("#divLeft").height(rightHeight);
		});

		// 검색
		var isSearch = "${categoryListData['search']}";
		if(isSearch == "1"){
			var keyword = "${categoryListData['searchKeyword']}";
			var mode = "${categoryListData['searchMode']}";
			var result = [];
			if(mode == "1"){		// 분류 이름
				var count = "${categoryListData['categoryCount']}";
				$("#tableBody tr:gt(0) td:nth-child("+"${categoryListData['columnSize']}"+1+"n+1)").each(function(){
					var index = $(this).closest("tr").find("input").val();
					var name = $(this).text();
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						$("#tableLeft").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			}
			else if(mode == "2"){	// 세부 항목
				var count = "${categoryListData['categoryCount']}";
				var checkary = [];
				for(var i=0; i<count; i++){
					checkary.push(false)
				}
				$("#tableBody tr:gt(0) td:not(:nth-child("+"${categoryListData['columnSize']}"+1+"n+1))").each(function(){
					var index = $(this).closest("tr").find("input").val();

					var name = $(this).text();
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						checkary[index] = true;
					}
				});
				var count2 = count;
				for(var i=0; i<count; i++){
					if(checkary[i] == false){
						$("#tableBody").bootstrapTable('hideRow', {'index': i, isIdField: true});
						$("#tableLeft").bootstrapTable('hideRow', {'index': i, isIdField: true});
						count2 -= 1;
					}
				}
				alert(count2+"개의 분류 검색됨.");
			}
		}
		
		// 우클릭 시 해당 행의 관리 번호를 저장
		$("td").contextmenu(function(event){
			trName = $(event.target).closest("tr").find("td:eq(0)").text();
		});

		// 플래시 메시지
		var flashmsg = "<c:out value='${msg}'/>";
		
		if(flashmsg != ""){
			alert(flashmsg);
		}

		// 테이블 스크롤, 소트 클릭 연결
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
		overflow-x: hidden;
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
					<font size="6px"><b># 분류 관리</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
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
				<% 
				HashMap categoryListData = (HashMap)request.getAttribute("categoryListData");
				int columnSize = (Integer)categoryListData.get("columnSize");
				%>

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
									<%int index = 0; %>
									<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
										<tr class="clickable-row" data-href="${categoryItem.key.assetCategory}">
											<td>${categoryItem.key.assetCategory}<input type="hidden" value="<%=index %>"></td>
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
										<%index += 1; %>
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