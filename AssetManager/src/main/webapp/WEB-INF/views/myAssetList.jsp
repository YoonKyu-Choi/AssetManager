<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.oLoader.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.jqGrid.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/ui.jqgrid.css" rel="stylesheet"/>

<script>

	var trName = "";
	var multiSelected = false;
	var disposeActive = true;
	var assetCount = ${assetListData['assetCount']};
    var assetMenu = new BootstrapMenu('td', {
    	actionsGroups:[
			['assetDetail', 'assetHistory', 'assetDisposeRequest'],
			['printList', 'printReport', 'printLabel']
		],
    	actions: {
    		assetDetail: {
	    		name: '상세 보기',
	    		onClick: function() {
					isAsset();
					$("#myAssetDetailForm").submit();
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
			assetDisposeRequest: {
				name: '폐기 신청',
				onClick: function(){
					dispRequest();
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
		$("#myAssetLink").prop("class", "active");
		
		// 권한별 버튼 활성화
		var isAdmin = "<%=session.getAttribute("isAdmin") %>";
		if(isAdmin == "TRUE"){
			$("div.admin").show();
		}
		
		// 반응성 윈도우 크기
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-330);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-330);
			$("#assetTable").setGridHeight(window.innerHeight-380, true);
		});

		// 플래시 메시지
		var flashmsg = "<c:out value='${msg}'/>";
		if(flashmsg != ""){
			alert(flashmsg);
		}

		// jqGrid 포매팅
		var myData = [];
		<c:forEach items="${assetListData['assetList']}" var="asset">
			var dic = {};
			dic['assetId'] = "${asset.assetId}";
			dic['assetCategory'] = "${asset.assetCategory}";
			dic['assetUser'] = "${asset.assetUser}";
			dic['assetStatus'] = "${asset.assetStatus}";
			dic['assetOutStatus'] = "${asset.assetOutStatus}";
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
		</c:forEach>

		var isSelected = false;
		$("#assetTable").jqGrid({
			datatype: "local",
			data: myData,
			height: window.innerHeight-380,
			rowNum: assetCount,
			multiselect: true,
			viewrecord: true,
			colNames:['관리 번호', '자산 분류', '사용자', '상태', '반출 상태', '시리얼 번호', '구매 날짜', '구매 가격', '구매처', '제조사', '모델명', '용도', '책임자', '위치'],
			colModel:[
				{name:'assetId',index:'assetId', width:100, align:'center'},
				{name:'assetCategory',index:'assetCategory', width:80, align:'center'},
				{name:'assetUser',index:'assetUser', width:60, align:'center'},
				{name:'assetStatus',index:'assetStatus', width:80, align:'center'},
				{name:'assetOutStatus',index:'assetOutStatus', width:100, align:'center'},
				{name:'assetSerial',index:'assetSerial', width:120, align:'center'},
				{name:'assetPurchaseDate',index:'assetPurchaseDate', width:100, align:'center'},
				{name:'assetPurchasePrice',index:'assetPurchasePrice', width:100, align:'right'},
				{name:'assetPurchaseShop',index:'assetPurchaseShop', width:120, align:'center'},
				{name:'assetMaker',index:'assetMaker', width:120, align:'center'},
				{name:'assetModel',index:'assetModel', width:120, align:'center'},
				{name:'assetUsage',index:'assetUsage', width:60, align:'center'},
				{name:'assetManager',index:'assetManager', width:60, align:'center'},
				{name:'assetLocation',index:'assetLocation', width:40, align:'center'}
			],
			loadComplete:function(){
				if(assetCount == 0){
					$("#assetTable >tbody").append("<tr><td id='' align='center' colspan='14'>검색 결과가 없습니다.</td></tr>")
				}
			},
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
					if(assetStatus == "폐기 대기" || assetStatus == "폐기"){
						disposeActive = false;
					}
				}
			},
			ondblClickRow: function(rowid) {
				trName = $("#assetTable").getRowData(rowid)['assetId'];
				$("#assetId").val(trName);
				$("#myAssetDetailForm").submit();
			}
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
	
	function dispRequest(){
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
	
	function isAsset(){
		if(assetCount == 0){
			alert("해당 자산이 없습니다.");
			return;
		}
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
</script>
		
<style>
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
	#button{
		color: black;
		border-color: #999;
		background-color: #aaa;
		font-weight: bold;
	}
	#button:hover {
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
</style>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="searchForm" action="assetList">
					<font size="6px"><b>내 자산 관리</b></font>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;총 자산 수 : </font><span class="badge">${assetListData['assetCount']}</span>
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
				<form id="assetDispForm" action="assetDisposal" method="post">
					<input type="hidden" id="dispReqArray" name="assetIdList"/>
				</form>
				<form id="myAssetDetailForm" action="assetDetail" method="post">
					<input type="hidden" id="assetId" name="assetId"/>
				</form>

				<div style="display: flex; float: left; margin-top: 5px; bottom: 60px; position: absolute">
					<img src="${pageContext.request.contextPath}/resources/mouseRightClick.png" width="25px" height="25px">
					&nbsp;&nbsp;Menu
				</div>
				<div style="display:flex; float:right; margin-top: 10px">
					<button id="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetRegister';">자산 등록</button>
				</div>
				
			</div>
		</div>
	</div>
</body>
