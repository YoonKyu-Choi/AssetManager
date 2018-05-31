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
		
		<title>폐기 자산 목록</title>
		
		<!-- Bootstrap core CSS -->
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
		
		<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
		<script>
			var disableCount = 0;
		
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
			
			function dis(chkbox){
				var status = $(chkbox).closest("tr").find("td:eq(1)").text();
				if(status == "폐기"){
	                if(chkbox.checked == true){
                        $("#disposalButton").prop("disabled", true);
	                    disableCount += 1;
	                }
	                else{
	                    disableCount -= 1;
	                    if(disableCount == 0){
	                        $("#disposalButton").prop("disabled", false);
	                    }
	                }
				}
			}
			
			$(function(){
			
				$(".table-responsive").on("click", ".table tbody tr", function(){
//					document.location.href='/assetmanager/assetDetail?assetId='+$(this).data("href");
				});

				var flashmsg = "<c:out value="${msg}"/>";
				
				if(flashmsg != "")
					alert(flashmsg);
				
				var windowHeight = window.innerHeight;
				$(".table-responsive").css("height", windowHeight-300);
				$(window).resize(function(){
					windowHeight = $(window).height();
					$(".table-responsive").css("height", windowHeight-300);
				})
				
			});
			
			$(function(){
				var isSearch = "${search}";
				if(isSearch == "1"){
					var keyword = "${searchKeyword}";
					var mode = "${searchMode}";
					var result = [];
					var count = Number("${assetCountByDispReady}") + Number("${assetCountByDisposal}");
	
					if(mode == "1"){
						$("tr:gt(0) td:nth-child(16n+4)").each(function(){
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
						$("tr:gt(0) td:nth-child(16n+7)").each(function(){
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
					else if(mode == "3"){
						$("tr:gt(0) td:nth-child(16n+8)").each(function(){
							$(this).closest("tr").show();
							var name = $(this).text().slice(0,4);
							var match = name.match(new RegExp(keyword, 'g'));
							if(match == null){
								$(this).closest("tr").hide();
								count -= 1;
							}
						});
						alert(count+"개의 분류 검색됨.");
					}
					else if(mode == "4"){
						$("tr:gt(0) td:nth-child(16n+3)").each(function(){
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
				}
			});
			
			function disposeAsset(){
				if(!confirm('선택한 자산을 폐기하겠습니까?')){
					return false;
				}else{
					var disposeList = [];
					$(".chkbox").each(function(){
						if($(this).prop("checked")){
							var id = $(this).closest("tr").find("td:eq(2)").text()
							disposeList.push(id);
						}
					});
					
					$("#disposeArray").val(disposeList);
//					alert($("#disposeArray").val());
					$("#disposeForm").submit();
				}
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
		</style>
		
	</head>

	<body>
		 <div class="container-fluid">
			<div class="row">
				<div class="main">
					<form class="page-header" id="searchForm" action="disposalList">
						<font size="6px" bold>폐기 자산 목록</font>&nbsp;&nbsp;&nbsp;&nbsp;
						<font size="4px">폐기 대기 : </font><span class="badge">${assetCountByDispReady}</span>
						<font size="4px">폐기 : </font><span class="badge">${assetCountByDisposal}</span>
						<span class="badge">${categoryCount}</span>
						<label style="float:right">
							<select id="searchMode" name="searchMode">
								<option value="1">자산 분류</option>
								<option value="2">SID</option>
								<option value="3">구입년도</option>
								<option value="4">관리번호</option>
							</select>
							<input type="text" id="searchKeyword" name="searchKeyword">
							<input type="button" value="검색">
						</label>
					</form>
					<div class="table-responsive" style="overflow: scroll; height: 400px">
						<table class="table table-striped" data-toggle="table" data-sort-name="status" data-sort-order="desc">
							<thead>
								<tr>
									<th>선택</th>
									<th data-sortable="true" data-field="status">상태</th>
									<th data-sortable="true">관리번호</th>
									<th data-sortable="true">분류</th>
									<th data-sortable="true">사용자</th>
									<th data-sortable="true">반출</th>
									<th data-sortable="true">SID</th>
									<th data-sortable="true">구입일</th>
									<th data-sortable="true">구입가</th>
									<th data-sortable="true">구입처</th>
									<th data-sortable="true">제조사</th>
									<th data-sortable="true">모델명</th>
									<th data-sortable="true">용도</th>
									<th data-sortable="true">관리자</th>
									<th data-sortable="true">위치</th>
									<th data-sortable="true">추가사항</th>
								</tr>
							</thead>
							
							<tbody>
							<c:forEach items="${assetList}" var="asset">
								<tr class="clickable-row" data-href="${asset.assetId}">
									<td class="tdNonClick"><input type="checkBox" class="chkbox" onclick="dis(this);"/></td>
									<td>${asset.assetStatus}</td>
									<td>${asset.assetId}</td>
									<td>${asset.assetCategory}</td>
									<td>${asset.assetUser}</td>
									<td>${asset.assetOutStatus}</td>
									<td>${asset.assetSerial}</td>
									<td>${asset.assetPurchaseDate}</td>
									<td>${asset.assetPurchasePrice}</td>
									<td>${asset.assetPurchaseShop}</td>
									<td>${asset.assetMaker}</td>
									<td>${asset.assetModel}</td>
									<td>${asset.assetUsage}</td>
									<td>${asset.assetManager}</td>
									<td>${asset.assetLocation}</td>
									<td>${asset.assetComment}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<div style="display:flex; float: right; margin-top: 10px">
						<form id="disposeForm" action="disposeAsset" method="post">
							<input type="hidden" id="disposeArray" name="disposeArray"/>
						</form>
						<button class="btn btn-lg btn-primary" id="disposalButton" onclick="disposeAsset();" >폐기</button>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>