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
	<script src="${pageContext.request.contextPath}/resources/js/jquery.jqGrid.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/css/ui.jqgrid.css" rel="stylesheet"/>

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

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-330);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-330);
			$("#assetTable").setGridHeight(window.innerHeight-380, true);
		});

		// 검색
		var isSearch = "${categoryListData['search']}";
		var categoryListData = [];
		if(isSearch == "1"){
			var keyword = "${categoryListData['searchKeyword']}";
			var mode = "${categoryListData['searchMode']}";
			var count = 0;
			if(mode == "1"){		// 분류 이름
				<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
					var name = "${categoryItem.key.assetCategory}";
					var match = name.match(new RegExp(keyword, 'g'));
					if(match != null){
						categoryListData.push("${categoryItem.key.assetCategoryCode}");
						count += 1;
					}
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			} else if(mode == "2"){	// 세부 항목
				<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
					var flag = false;
					<c:forEach items="${categoryItem.value}" var="item">
						if(!flag){
							var name = "${item}";
							var match = name.match(new RegExp(keyword, 'g'));
							if(match != null){
								categoryListData.push("${categoryItem.key.assetCategoryCode}");
								count += 1;
								flag = true;
							}
						}
					</c:forEach>
				</c:forEach>
				alert(count+"개의 분류 검색됨.");
			} 
			
		} else{
			<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
				categoryListData.push("${categoryItem.key.assetCategoryCode}");
			</c:forEach>
		}

		
		// jqGrid 포매팅
		var myData = [];
		var maxIndex = 0;
		<c:forEach items="${categoryListData['categoryItemList']}" var="categoryItem">
			var dic = {};
			dic['assetCategoryCode'] = "${categoryItem.key.assetCategoryCode}";
			if(categoryListData.includes(dic['assetCategoryCode'])){
				dic['assetCategory'] = "${categoryItem.key.assetCategory}";
				var itemIndex = 0;
				var indexName = '';
				<c:forEach items="${categoryItem.value}" var="item">
					itemIndex += 1;
					indexName = '세부사항' + itemIndex;
					dic[indexName] = "${item}";
					if(maxIndex < itemIndex){
						maxIndex = itemIndex;
					}
				</c:forEach>
				myData.push(dic);
			}
		</c:forEach>

		var colNameRow = [];
		colNameRow.push('분류 코드');
		colNameRow.push('분류 이름');
		for(var j=1; j<=maxIndex; j++){
			var colNameItem = '세부사항' + j;
			colNameRow.push(colNameItem);
		}
		var colModelRow = [];
		colModelRow.push({name:'assetCategoryCode', index:'assetCategoryCode', width:120, hidden:true, frozen:true});
		colModelRow.push({name:'assetCategory', index:'assetCategory', width:120, frozen:true, align:'center'});
		for(var j=1; j<=maxIndex; j++){
			var colNameItem = '세부사항' + j;
			var colModelItem = {name:colNameItem, index:colNameItem, width:120, align:'center'};
			colModelRow.push(colModelItem);
		}
		
		
		var isSelected = false;
		$("#categoryTable").jqGrid({
			datatype: "local",
			data: myData,
			height: window.innerHeight-380,
			rowNum: Number("${categoryListData.categoryCount}"),
			multiselect: false,
			viewrecord: true,
			colNames: colNameRow,
			colModel: colModelRow,
			onRightClickRow: function(rowid){
				trName = $("#categoryTable").getRowData(rowid)['assetCategory'];
			}
		});
//		$("#categoryTable").jqGrid("setFrozenColumns");
		
		// 플래시 메시지
		var flashmsg = "<c:out value='${msg}'/>";
		
		if(flashmsg != ""){
			alert(flashmsg);
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
	.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
		background-color: #555;
		background-image: none;
	}
	.ui-jqgrid {
		font-size: 1.0em;
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

				<div class="table-responsive" style="overflow: auto">
					<table id="categoryTable"></table>
				</div>
					
				<div style="display:flex; float: right; margin-top: 10px">
					<button id="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/categoryRegister';">등록</button>
				</div>
			</div>
		</div>
	</div>
</body>