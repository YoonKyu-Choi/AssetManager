<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>

<script>

	var disableCount = 0;
	var checkCount = 0;
	var trName = "";
    var assetMenu = new BootstrapMenu('td', {
    	actions: {
    		assetDetail: {
	    		name: '상세 보기',
	    		onClick: function() {
					isAsset();
					document.location.href='/assetmanager/assetDetail?assetId=' + trName;
	    		}
    		},
    		assetHistory: {
	    		name: '이력 보기',
	    		onClick: function() {
					isAsset();
					$("#assetHistoryForm input").val(trName); 
					$("#assetHistoryForm").submit();
	    		}
    		}
    	}
    });

    var generalMenu = new BootstrapMenu('.container', {
		actionsGroups:[
			['assetRegister', 'assetDisposeRequest'],
			['printList', 'printReport', 'printLabel']
		],
		actions: {
			assetRegister: {
				name: '자산 등록',
				onClick: function(){
					location.href='/assetmanager/assetRegister';
				}
			},
			assetDisposeRequest: {
				name: '폐기 신청',
				onClick: function(){
					dispRequest();
				}
			},
			printList: {
				name: '목록 출력',
				onClick: function(){
					printList();
				}
			},
			printReport: {
				name: '보고서 출력',
				onClick: function(){
					printReport();
				}
			},
			printLabel: {
				name: '라벨 출력',
				onClick: function(){
					printLabel();
				}
			}
		}
	});

	$(function(){
		// 사이드바 활성화
		$("#asstLink").prop("class", "active");
		
		// 권한별 버튼 활성화
		var isAdmin = "<%=session.getAttribute("isAdmin") %>";
		if(isAdmin == "TRUE"){
			$("div.admin").show();
		}
		
		// 테이블이 비어있을 경우 클릭 불가
		$(document).on("click", ".table tbody tr", function(event){
			if(${assetListData['assetCount']} > 0){
				if($(event.target).is(".chkbox") || $(event.target).is(".tdNonClick")){
					return;
				}
				document.location.href='/assetmanager/assetDetail?assetId='+$(this).data("href");
			}
		});

		// 반응성 윈도우 크기
		var windowHeight = window.innerHeight;
		$("#divBody").css("height", windowHeight-330);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$("#divBody").css("height", windowHeight-330);
		});

		// 검색
		var isSearch = "${assetListData['search']}";
		if(isSearch == "1"){
			var keyword = "${assetListData['searchKeyword']}";
			var mode = "${assetListData['searchMode']}";
			var result = [];
			if(mode == "1"){		// 자산 분류
				var count = "${assetListData['assetCount']}";
				$("tr:gt(0) td:nth-child(14n+3)").each(function(){
					var index = $(this).closest("tr").find("input:eq(1)").val();
					var name = $(this).text();
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "2"){	// 시리얼 번호
				var count = "${assetListData['assetCount']}";
				$("tr:gt(0) td:nth-child(14n+6)").each(function(){
					var index = $(this).closest("tr").find("input:eq(1)").val();
					var name = $(this).text();
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "3"){	// 구입 년도
				var count = "${assetListData['assetCount']}";
				$("tr:gt(0) td:nth-child(14n+7)").each(function(){
					var index = $(this).closest("tr").find("input:eq(1)").val();
					var name = $(this).text().slice(0,4);
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "4"){	// 관리 번호
				var count = "${assetListData['assetCount']}";
				$("tr:gt(0) td:nth-child(14n+2)").each(function(){
					var index = $(this).closest("tr").find("input:eq(1)").val();
					var name = $(this).text();
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			}
		}
		
		// 플래시 메시지
		var flashmsg = "<c:out value='${msg}'/>";
		if(flashmsg != ""){
			alert(flashmsg);
		}

		// 테이블 헤더 소트 연결
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
			trName = $(event.target).closest("tr").find("td:eq(1)").text();
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
	
	function isAsset(){
		var assetnum = ${assetListData['assetCount']};
		if(assetnum == 0){
			alert("해당 자산이 없습니다.");
			return;
		}
	}
	

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
	#divHead{
		position: releative;
		height: 40px;
		overflow-y: scroll;
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
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="searchForm" action="assetList">
					<font size="6px"><b># 자산 관리</b></font>
					<label style="float:right; margin-top: 20px">
						<select id="searchMode" name="searchMode">
							<option value="1">자산 분류</option>
							<option value="2">시리얼 번호</option>
							<option value="3">구입 년도</option>
							<option value="4">관리 번호</option>
						</select>
						<input type="text" id="searchKeyword" name="searchKeyword">
						<input type="submit" value="검색">
					</label>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;총 자산 수 : </font><span class="badge">${assetListData['assetCount']}</span>
				</div>
				<div id="divHead">
				<div class="table-responsive">
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
						<%int index = 0; %>
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
								<td>${asset.assetLocation}<input type="hidden" value="<%=index %>"></td>
							</tr>
							<%index += 1; %>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<form id="assetHistoryForm" action="assetHistory" method="post">
					<input type="hidden" name="assetId"/>
				</form>
				<form id="printForm" action="printList" method="post">
					<input type="hidden" id="printArray" name="assetIdList"/>
				</form>
				<form id="printReportForm" action="printReport" method="post">
					<input type="hidden" id="printReportArray" name="assetIdList"/>
				</form>
				<form id="printLabelForm" action="printLabel" method="post">
					<input type="hidden" id="printLabelArray" name="assetIdList"/>
				</form>
				<form id="assetDispForm" action="assetDisposal" method="post">
					<input type="hidden" id="dispReqArray" name="assetIdList"/>
				</form>

<!-- 
				<div style="display:flex; float: left; margin-top: 10px">
					<button class="btn btn-lg btn-primary" onclick="printList();" >목록 출력</button>
				</div>
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
					</div>
				</div>
-->				
			</div>
		</div>
	</div>
</body>
