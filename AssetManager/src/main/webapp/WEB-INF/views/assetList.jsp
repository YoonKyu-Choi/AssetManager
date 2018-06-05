<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<script type="text/javascript">
	$(function(){
		var isAdmin = "<%=session.getAttribute("isAdmin") %>";
		if(isAdmin == "TRUE"){
			$("div.admin").show();
		}
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
	
	$(function(){
		//$(document).on("click", ".table tbody td", function(){
		$(".table tbody tr").click(function(){
			document.location.href='/assetmanager/assetDetail?assetId='+$(this).data("href");
		});
		$(document).on('click', '.checkBtn', function(){
			console.log('checkbox clicked');
		});
		$(".tdNonClick").unbind('click');
		
	});
	
	$(function(){
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-300);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-300);
		});
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
		white-space: nowrap;
	}
	th{
		background-color:darkgray;
		color:white;
	}
	p{
		font-size:25px;
	}
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
	</style>
</head>
	<body>
	 <div class="container-fluid">
		<div class="row">
			<div class="main">
				<div class="page-header">
				<font size="6px" bold>자산 목록</font>
				<font size="4px">총 자산 수 : </font><span class="badge">${assetCount}</span>
				<font size="4px">사용 : </font><span class="badge">${assetCountByUse}</span>
				<font size="4px">사용불가 : </font><span class="badge">${assetCountByNotUse}</span>
				<font size="4px">반출 : </font><span class="badge">${assetCountByOut}</span>
				<font size="4px">폐기 대기 : </font><span class="badge">${assetCountByDispReady}</span>
				<font size="4px">폐기 : </font><span class="badge">${assetCountByDisposal}</span>
				<br>
				<div style="display:flex;">
				<select	class="form-controlmin" id="assetSearch" name="searchCategory">
						<option value="0">자산 분류</option>
						<option value="1">시리얼 번호</option>
						<option value="2">구입년도</option>
						<option value="3">관리 번호</option>
				</select>
				<input type="text" size="20" id="searchKeyword" name="employeeName"/>
				<input type="submit" value="검색" onclick="searchFunc();"/>
				</div>
				</div>
				<div class="table-responsive" style="overflow: scroll; height: 400px">
					<table class="table table-striped" data-toggle="table">
						<thead>
							<tr>
								<th>선택</th>
								<th data-sortable="true">관리 번호</th>
								<th data-sortable="true">자산 분류</th>
								<th data-sortable="true">사용자</th>
								<th data-sortable="true">상태</th>
								<th data-sortable="true">시리얼 번호</th>
								<th data-sortable="true">구매 날짜</th>
								<th data-sortable="true">구매 가격</th>
								<th data-sortable="true">구매처</th>
								<th data-sortable="true">제조사</th>
								<th data-sortable="true">모델명</th>
								<th data-sortable="true">용도</th>
								<th data-sortable="true">책임자</th>
								<th data-sortable="true">사용 위치</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${assetList}" var="asset">
							<tr class="clickable-row" data-href="${asset.assetId}">
								<td class="tdNonClick"><input type="checkBox" class="checkBtn"/>
								<td>${asset.assetId}</td>
								<td>${asset.assetCategory}</td>
								<td>${asset.assetUser}</td>
								<td>${asset.assetStatus}</td>
								<td>${asset.assetSerial}</td>
								<td>${asset.assetPurchaseDate}</td>
								<td>${asset.assetPurchasePrice}</td>
								<td>${asset.assetPurchaseShop}</td>
								<td>${asset.assetMaker}</td>
								<td>${asset.assetModel}</td>
								<td>${asset.assetUsage}</td>
								<td>${asset.assetManager}</td>
								<td>${asset.assetLocation}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<button class="btn btn-lg btn-primary" style="float:right; margin-top: 10px" onclick="location.href='/assetmanager/nameList2';">자산 등록</button>
				<div class="admin"> 
				<button class="btn btn-lg btn-primary" style="float:right; margin-top: 10px" onclick="location.href='/assetmanager/register';">폐기 신청</button>
				</div>
			</div>
		</div>
	</div>
</body>