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
	<script src="${pageContext.request.contextPath}/resources/js/jquery.jqGrid.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/ui.jqgrid.css" rel="stylesheet"/>

<script>
	var trName = "";
	var multiSelected = false;
	var disposeCount = Number("${disposalListData['assetCountByDispReady']}") + Number("${disposalListData['assetCountByDisposal']}");
	var assetMenu = new BootstrapMenu('td', {
		actionsGroups: [
			['assetDetail', 'assetHistory', 'assetDispose'],
			['printList', 'printReport', 'printLabel']
		],
		actions: {
			assetDetail: {
	    		name: '상세 보기',
	    		onClick: function() {
					isAsset();
					$("#assetDetailForm").submit();
	    		},
			    isShown: function(){
					return !multiSelected;
				}
			},
			assetHistory: {
	    		name: '이력 보기',
	    		onClick: function() {
					isAsset();
					$("#assetHistoryForm input").val(trName); 
					$("#assetHistoryForm").submit();
	    		},
			    isShown: function(){
					return !multiSelected;
				}
			},
			assetDispose: {
				name: '폐기',
				onClick: function(){
					disposeAsset();
				},
				isEnabled: function(){
					return disposeActive;
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
		$("#dispLink").prop("class", "active");

		// 테이블이 비어있을 경우 클릭 불가
		$(".table-responsive").on("click", ".table tbody tr", function(){
			if(disposeCount > 0){
				if($(event.target).is(".chkbox")){
					return;
				}
				document.location.href='/assetmanager/assetDetail?assetId='+$(this).data("href");
			}
		});

		// 플래시 메시지
		var flashmsg = "<c:out value="${msg}"/>";
		
		if(flashmsg != ""){
			alert(flashmsg);
		}

		// 검색
		var isSearch = "${disposalListData['search']}";
		var assetListData = [];
		if(isSearch == "1"){
			var keyword = "${disposalListData['searchKeyword']}";
			var mode = "${disposalListData['searchMode']}";
			var count = 0;
			if(mode == "1"){		// 자산 분류
				<c:forEach items="${disposalListData['assetList']}" var="asset">
					var name = "${asset.assetCategory}";
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						assetListData.push("${asset.assetId}");
						count += 1;
					}
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "2"){	// 시리얼 번호
				<c:forEach items="${disposalListData['assetList']}" var="asset">
					var name = "${asset.assetSerial}";
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						assetListData.push("${asset.assetId}");
						count += 1;
					}
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "3"){	// 구입 년도
				<c:forEach items="${disposalListData['assetList']}" var="asset">
					var name = "${asset.assetPurchaseDate}";
					name = name.slice(0,4);
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						assetListData.push("${asset.assetId}");
						count += 1;
					}
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "4"){	// 관리 번호
				<c:forEach items="${disposalListData['assetList']}" var="asset">
					var name = "${asset.assetId}";
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						assetListData.push("${asset.assetId}");
						count += 1;
					}
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			}
		} else{
			<c:forEach items="${disposalListData['assetList']}" var="asset">
				assetListData.push("${asset.assetId}");
			</c:forEach>
		}

		
		// jqGrid 포매팅
		var myData = [];
		<c:forEach items="${disposalListData['assetList']}" var="asset">
			var dic = {};
			dic['assetId'] = "${asset.assetId}";
			if(assetListData.includes(dic['assetId'])){
				dic['assetCategory'] = "${asset.assetCategory}";
				dic['assetUser'] = "${asset.assetUser}";
				dic['assetStatus'] = "${asset.assetStatus}";
				dic['assetSerial'] = "${asset.assetSerial}";
				var assetPurchaseDate = "${asset.assetPurchaseDate}";
				if(assetPurchaseDate == "9999-01-01"){
					assetPurchaseDate = "미입력";
				}
				dic['assetPurchaseDate'] = assetPurchaseDate;

				var assetPurchasePrice = "${asset.assetPurchasePrice}";
				if(assetPurchasePrice=="미입력"){
					assetPurchasePrice == "미입력";
				} else {
					assetPurchasePrice = numberWithCommas("${asset.assetPurchasePrice}")+" 원";	
				}
				dic['assetPurchasePrice'] = assetPurchasePrice;
				dic['assetPurchaseShop'] = "${asset.assetPurchaseShop}";
				dic['assetMaker'] = "${asset.assetMaker}";
				dic['assetModel'] = "${asset.assetModel}";
				dic['assetUsage'] = "${asset.assetUsage}";
				dic['assetManager'] = "${asset.assetManager}";
				dic['assetLocation'] = "${asset.assetLocation}";
				myData.push(dic);
			}
		</c:forEach>

		var isSelected = false;
		$("#assetTable").jqGrid({
			datatype: "local",
			data: myData,
			height: window.innerHeight-380,
			rowNum: disposeCount,
			multiselect: true,
			viewrecord: true,
			colNames:['관리 번호', '자산 분류', '사용자', '상태', '시리얼 번호', '구매 날짜', '구매 가격', '구매처', '제조사', '모델명', '용도', '책임자', '위치'],
			colModel:[
				{name:'assetId',index:'assetId', width:120, align:'center'},
				{name:'assetCategory',index:'assetCategory', width:80, align:'center'},
				{name:'assetUser',index:'assetUser', width:100, align:'center'},
				{name:'assetStatus',index:'assetStatus', width:80, align:'center'},
				{name:'assetSerial',index:'assetSerial', width:120, align:'center'},
				{name:'assetPurchaseDate',index:'assetPurchaseDate', width:120, align:'center'},
				{name:'assetPurchasePrice',index:'assetPurchasePrice', width:120, align:'right'},
				{name:'assetPurchaseShop',index:'assetPurchaseShop', width:120, align:'center'},
				{name:'assetMaker',index:'assetMaker', width:120, align:'center'},
				{name:'assetModel',index:'assetModel', width:120, align:'center'},
				{name:'assetUsage',index:'assetUsage', width:80, align:'center'},
				{name:'assetManager',index:'assetManager', width:100, align:'center'},
				{name:'assetLocation',index:'assetLocation', width:40, align:'center'}
			],
			onRightClickRow: function(rowid){
				trName = $("#assetTable").getRowData(rowid)['assetId'];
				$("#assetId").val(trName);
				isSelected = $("#assetTable").find("input[type=checkbox]:eq("+(rowid-1)+")").prop("checked");
				if(isSelected == false){
					$("#assetTable").find("tr:eq("+rowid+")").click();
				}
				var selarrrow = $("#assetTable").getGridParam('selarrrow'); 
				if(selarrrow.length > 1){
					multiSelected = true;
				} else{
					multiSelected = false;
				}
				disposeActive = true;
				for(i in selarrrow){
					var assetStatus = $("#assetTable").getRowData(selarrrow[i])['assetStatus'];
					if(assetStatus == "폐기"){
						disposeActive = false;
					} 
				}
			},
			ondblClickRow: function(rowid) {
				trName = $("#assetTable").getRowData(rowid)['assetId'];
				$("#assetId").val(trName);
				$("#assetDetailForm").submit();
			}
		});
		
		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-330);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-330);
			$("#assetTable").setGridHeight(window.innerHeight-380, true);
		})

	});
	
	function disposeAsset(){
		if(!confirm('선택한 자산을 폐기하겠습니까?')){
			return false;
		}else{
			var disposeList = [];
			var arr = $("#assetTable").getGridParam('selarrrow');
			for(i in arr){
				var rowid = arr[Number(i)];
				var assetId = $("#assetTable").getRowData(rowid)['assetId'];
				disposeList.push(assetId);
			}

			$("#disposeArray").val(disposeList);
			$("#disposeForm").submit();
		}
	}
	
	function printList(){
		if(!confirm('선택한 자산의 목록을 출력하겠습니까?')){
			return false;
		}else{
			var printList = [];
			var arr = $("#assetTable").getGridParam('selarrrow');
			for(i in arr){
				var rowid = arr[Number(i)];
				var assetId = $("#assetTable").getRowData(rowid)['assetId'];
				printList.push(assetId);
			}
			
			$("#printArray").val(printList);
			$("#printForm").submit();
			
		}
	}
	
	function printReport(){
		if(!confirm('선택한 자산의 보고서를 출력하겠습니까?')){
			return false;
		}else{
			var printList = [];
			var arr = $("#assetTable").getGridParam('selarrrow');
			for(i in arr){
				var rowid = arr[Number(i)];
				var assetId = $("#assetTable").getRowData(rowid)['assetId'];
				printList.push(assetId);
			}
			
			$("#printReportArray").val(printList);
			$("#printReportForm").submit();
			
		}
	}
	
	function printLabel(){
		if(!confirm('선택한 자산들의 라벨을 출력하겠습니까?')){
			return false;
		}else{
			var printList = [];
			var arr = $("#assetTable").getGridParam('selarrrow');
			for(i in arr){
				var rowid = arr[Number(i)];
				var assetId = $("#assetTable").getRowData(rowid)['assetId'];
				printList.push(assetId);
			}
			
			$("#printLabelArray").val(printList);
			$("#printLabelForm").submit();
			
		}
	}
	
	function isAsset(){
		var assetnum = ${disposalListData['assetCountByDispReady']} + ${disposalListData['assetCountByDisposal']};
		if(assetnum == 0){
			alert("해당 자산이 없습니다.");
			return;
		}
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
	#button, #searchBtn{
		color: black;
		border-color: #999;
		background-color: #aaa;
		font-weight: bold;
	}
	#button:hover, #searchBtn:hover {
		color: white;
		background-color: #333;
	}
	.ui-jqgrid-hbox{
		background-color: #555;
	}
	.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
		background-color: #555;
		background-image: none;
		border: #555;
	}
	.ui-widget-content{
		border: #555
	}
	.ui-state-highlight, .ui-widget-content .ui-state-highlight{
		color: black;
		border: black;
	}
	.ui-widget-content .ui-state-hover {
		background-color: #777;
		color: white;
		border: white;
	}
	.ui-jqgrid-hdiv .ui-state-hover {
		font-weight: bold;
	}
	.ui-widget.ui-widget-content{
		border-color: #555
	}
	.ui-jqgrid {
		font-size: 1.0em;
	}
	.ui-state-default, .ui-widget-content .ui-state-default{
		border: white;
	}
	 #searchMode, #searchKeyword, #searchBtn{
    	height:27px;
		vertical-align:middle
    }
    #searchBtn{
    	padding-top: 3px;
    }
	
</style>
		
</head>

<body>
	 <div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="searchForm" action="disposalList">
					<font size="6px"><b>폐기 관리</b></font>
					<span class="badge">${disposalListData['categoryCount']}</span>
					<label style="float:right; margin-top: 20px">
						<select id="searchMode" name="searchMode" style="height:27px">
							<option value="1">자산 분류</option>
							<option value="2">시리얼 번호</option>
							<option value="3">구입년도</option>
							<option value="4">관리번호</option>
						</select>
						<input type="text" id="searchKeyword" name="searchKeyword">
						<input type="submit" class="btn btn-primary" id="searchBtn" value="검색">
					</label>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;폐기 대기 : </font><span class="badge">${disposalListData['assetCountByDispReady']}</span>
					<font size="4px">&nbsp;&nbsp;폐기 : </font><span class="badge">${disposalListData['assetCountByDisposal']}</span>
				</div>

				<div class="table-responsive" style="overflow: auto">
				<table id="assetTable"></table>
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
				
				<form id="disposeForm" action="disposeAsset" method="post">
					<input type="hidden" id="disposeArray" name="disposeArray"/>
				</form>
				<form id="assetDetailForm" action="assetDetail" method="post">
					<input type="hidden" id="assetId" name="assetId"/>
				</form>
				
				<div style="display: flex; float: left; margin-top: 5px; bottom: 60px; position: absolute">
					<img src="${pageContext.request.contextPath}/resources/mouseRightClick.png" width="25px" height="25px">
					&nbsp;&nbsp;Menu
				</div>
				<div style="display:flex; float: right; margin-top: 10px">
					<button id="button" class="btn btn-lg btn-primary" id="disposalButton" onclick="disposeAsset();" >폐기</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
