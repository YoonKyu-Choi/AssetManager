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
	var disableCount = 0;
	var checkCount = 0;
	
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
	
	function dis(chkbox){
		var status = $(chkbox).closest("tr").find("td:eq(4)").text();
		if(status == "폐기"){
            if(chkbox.checked == true){
                $("#disposalButton").prop("disabled", true);
                disableCount += 1;
                checkCount += 1;
            }
            else{
                disableCount -= 1;
                checkCount -= 1;
                if(disableCount == 0){
                    $("#disposalButton").prop("disabled", false);
                }
            }
		}
		else{
			if(chkbox.checked == true){
				checkCount += 1;
			}
			else{
				checkCount -= 1;
			}
		}
	}

	function allClick(){
		var allChecked = $("#allCheck").prop("checked");
		$(".chkbox").each(function(){
			if($(this).prop("checked") != allChecked){
				$(this).click();
			}
		});
	}
	
	$(function(){
		
		$(document).on("click", ".table tbody tr", function(event){
			if(${assetListData['assetCount']} > 0){
				if($(event.target).is(".chkbox") || $(event.target).is(".tdNonClick")){
					return;
				}
				document.location.href='/assetmanager/assetDetail?assetId='+$(this).data("href");
			}
		});
		
	});
	
	$(function(){
		var windowHeight = window.innerHeight;
		$("#divBody").css("height", windowHeight-400);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$("#divBody").css("height", windowHeight-400);
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
	
	function printList(){
		if(checkCount == 0){
			alert("자산을 선택해주세요.");
			return false;
		}
		else{
			if(!confirm('선택한 자산의 목록을 출력하겠습니까?')){
				return false;
			}else{
				var printList = [];
				$(".chkbox").each(function(){
					if($(this).prop("checked")){
						var id = $(this).closest("tr").find("td:eq(1)").text()
						printList.push(id);
					}
				});
				
				$("#printArray").val(printList);
				$("#printForm").submit();
				
			}
		}
	}
	
	function printReport(){
		if(checkCount == 0){
			alert("자산을 선택해주세요.");
			return false;
		}
		else{
			if(!confirm('선택한 자산의 보고서를 출력하겠습니까?')){
				return false;
			}else{
				var printList = [];
				$(".chkbox").each(function(){
					if($(this).prop("checked")){
						var id = $(this).closest("tr").find("td:eq(1)").text()
						printList.push(id);
					}
				});
				
				$("#printReportArray").val(printList);
				$("#printReportForm").submit();
				
			}
		}
	}
	
	function printLabel(){
		if(checkCount == 0){
			alert("자산을 선택해주세요.");
			return false;
		}
		else{
			if(!confirm('선택한 자산들의 라벨을 출력하겠습니까?')){
				return false;
			}else{
				var printList = [];
				$(".chkbox").each(function(){
					if($(this).prop("checked")){
						var id = $(this).closest("tr").find("td:eq(1)").text()
						printList.push(id);
					}
				});
				
				$("#printLabelArray").val(printList);
				$("#printLabelForm").submit();
				
			}
		}
	}
	
	function dispRequest(){
		if(checkCount == 0){
			alert("자산을 선택해주세요.");
			return false;
		}
		else{
			if(!confirm('선택한 자산들을 폐기 신청하겠습니까?')){
				return false;
			}else{
				var printList = [];
				$(".chkbox").each(function(){
					if($(this).prop("checked")){
						var id = $(this).closest("tr").find("td:eq(1)").text()
						printList.push(id);
					}
				});
				
				$("#dispReqArray").val(printList);
				$("#assetDispForm").submit();
				
			}
		}
	}
	
	/*
	$(function(){
		var isSearch = "${search}";
		if(isSearch == "1"){
			var keyword = "${searchKeyword}";
			var mode = "${searchMode}";
			var result = [];
			if(mode == "1"){
				var count = "${assetCount}";
				$("tr:gt(0) td:nth-child("+"${columnSize}"+1+"n+1)").each(function(){
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
				var count = "${assetCount}";
				var checkary = [];
				for(var i=0; i<count; i++){
					checkary.push(false)
				}
				$("tr:gt(0) td:not(:nth-child("+"${columnSize}"+1+"n+1))").each(function(){
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
	*/
	$(function(){
		var flashmsg = "<c:out value='${msg}'/>";
		if(flashmsg != "")
				alert(flashmsg);
	 
	$(function(){
		$("#tableHead th").click(function(){
			var index = $("#tableHead th").index($(event.target).closest("th"));
			$("#tableBody th:eq("+index+") .sortable").click();
		});
		
		$("#divBody").scroll(function(){
			var scrollpos = $("#divBody").scrollLeft(); 
			$("#divOut .fixed-table-body").scrollLeft(scrollpos);
		});
	});
	
</script>

	
<style>
	th, td {
		text-align: center;
		white-space: nowrap;
	}
	th{
		background-color: darkgray;
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
	#divOut{
		position: releative;
		height: 40px;
		overflow-y: scroll;
	}
	#divBody{
		z-index: -1;
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
				<form class="page-header" id="searchForm" action="assetList">
					<font size="6px"><b>자산 관리 > 자산 목록</b></font>
					<label style="float:right; margin-top: 20px">
						<!-- 	
						<select id="searchMode" name="searchMode">
								<option value="0">자산 분류</option>
								<option value="1">시리얼 번호</option>
								<option value="2">구입년도</option>
								<option value="3">관리 번호</option>
						</select>
							<input type="text" id="searchKeyword" name="searchKeyword">
							<input type="submit" value="검색">
						 -->
						</label>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;총 자산 수 : </font><span class="badge">${assetListData['assetCount']}</span>
					<font size="4px">&nbsp;&nbsp;사용 중: </font><span class="badge">${assetListData['assetCountByUse']}</span>
					<font size="4px">&nbsp;&nbsp;사용 가능: </font><span class="badge">${assetListData['assetCountCanUse']}</span>
					<font size="4px">&nbsp;&nbsp;사용불가 : </font><span class="badge">${assetListData['assetCountByNotUse']}</span>
					<font size="4px">&nbsp;&nbsp;반출 : </font><span class="badge">${assetListData['assetCountByOut']}</span>
					<font size="4px">&nbsp;&nbsp;폐기 대기 : </font><span class="badge">${assetListData['assetCountByDispReady']}</span>
					<font size="4px">&nbsp;&nbsp;폐기 : </font><span class="badge">${assetListData['assetCountByDisposal']}</span>
				</div>
				<div id="divOut">
				<div class="table-responsive" id="divHead">
					<table class="table" data-toggle="table" id="tableHead">
						<thead>
							<tr>
								<th class="tdNonClick"><input type="checkbox" style="transform:scale(1.5)" id="allCheck" onclick="allClick();"/></th>
								<th data-sortable="true">관리 번호</th>
								<th data-sortable="true">자산 분류</th>
								<th data-sortable="true">사용자</th>
								<th data-sortable="true">현재 상태</th>
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
						<tbody style="display:none">
						</tbody>
					</table>
				</div>
				</div>
				
				<div class="table-responsive" id="divBody">
					<table class="table table-striped" id="tableBody" data-toggle="table">
						<thead>
							<tr>
								<th class="tdNonClick"><input type="checkbox" style="transform:scale(1.5)" id="allCheck" onclick="allClick();"/></th>
								<th data-sortable="true">관리 번호</th>
								<th data-sortable="true">자산 분류</th>
								<th data-sortable="true">사용자</th>
								<th data-sortable="true">현재 상태</th>
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
						<c:forEach items="${assetListData['assetList']}" var="asset">
							<tr class="clickable-row" data-href="${asset.assetId}">
								<td class="tdNonClick"><input type="checkBox" style="transform:scale(1.5)" class="chkbox" onclick="dis(this);"/></td>
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

				<form id="printForm" action="printList" method="post">
					<input type="hidden" id="printArray" name="assetIdList"/>
				</form>
				<div style="display:flex; float: left; margin-top: 10px">
					<button class="btn btn-lg btn-primary" onclick="printList();" >목록 출력</button>
				</div>
				<form id="printReportForm" action="printReport" method="post">
					<input type="hidden" id="printReportArray" name="assetIdList"/>
				</form>
				<form id="printLabelForm" action="printLabel" method="post">
					<input type="hidden" id="printLabelArray" name="assetIdList"/>
				</form>
				<div style="display:flex; float: left; margin-top: 10px">
					<button class="btn btn-lg btn-primary" onclick="printReport();" >보고서 출력</button>
				</div>
				<div style="display:flex; float: left; margin-top: 10px">
					<button class="btn btn-lg btn-primary" onclick="printLabel();" >라벨 출력</button>
				</div>
				
				<div style="display:flex; float:right; margin-top: 10px">
					<button class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetRegister';">자산 등록</button>
					<div class="admin"> 
						<button class="btn btn-lg btn-primary" id="disposalButton"onclick="dispRequest();">폐기 신청</button>
						<form id="assetDispForm" action="assetDisposal" method="post">
							<input type="hidden" id="dispReqArray" name="assetIdList"/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>