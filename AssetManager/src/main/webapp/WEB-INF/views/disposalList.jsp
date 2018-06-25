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
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet">

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
		actionsGroups: [
			['assetDispose'],
			['printList', 'printReport']
		],
		actions: {
			assetDispose: {
				name: '폐기',
				onClick: function(){
					disposeAsset();
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
			}
		}
	});
	$(function(){
		// 사이드바 활성화
		$("#dispLink").prop("class", "active");

		// 테이블이 비어있을 경우 클릭 불가
		$(".table-responsive").on("click", ".table tbody tr", function(){
			if(Number("${disposalListData['assetCountByDispReady']}") + Number("${disposalListData['assetCountByDisposal']}") > 0){
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
		if(isSearch == "1"){
			var keyword = "${disposalListData['searchKeyword']}";
			var mode = "${disposalListData['searchMode']}";
			var result = [];
			var count = Number("${disposalListData['assetCountByDispReady']}") + Number("${disposalListData['assetCountByDisposal']}");

			if(mode == "1"){
				$("tr:gt(0) td:nth-child(16n+4)").each(function(){
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
			else if(mode == "2"){
				$("tr:gt(0) td:nth-child(16n+7)").each(function(){
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
			else if(mode == "3"){
				$("tr:gt(0) td:nth-child(16n+8)").each(function(){
					var index = $(this).closest("tr").find("input:eq(1)").val();
					var name = $(this).text().slice(0,4);
					var match = name.match(new RegExp(keyword, 'g'));
					if(match == null){
						$("#tableBody").bootstrapTable('hideRow', {'index': index, isIdField: true});
						count -= 1;
					}
				});
				alert(count+"개의 분류 검색됨.");
			}
			else if(mode == "4"){
				$("#tableBody tr:gt(0) td:nth-child(16n+3)").each(function(){
					var id = $(this).closest("tr").find("td:nth-child(16n+3)").text();
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
		
		// 소트 클릭, 스크롤 연결
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
			trName = $(event.target).closest("tr").find("td:eq(2)").text();
		});

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-400);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-400);
		})

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
		var status = $(chkbox).closest("tr").find("td:eq(1)").text();
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
		else if(status =="폐기 대기"){
			if(chkbox.checked == true){
				checkCount += 1;
			}
			else{
				checkCount -= 1;
			}
		}
	}
	
	function allClick(){
		$(".chkbox").each(function(){
			$(this).click();
		});
	}

	function disposeAsset(){
		if(checkCount == 0){
			alert("자산을 선택해주세요.");
			return false;
		}
		else{
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
				$("#disposeForm").submit();
			}
		}
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
						var id = $(this).closest("tr").find("td:eq(2)").text()
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
						var id = $(this).closest("tr").find("td:eq(2)").text()
						printList.push(id);
					}
				});
				
				$("#printReportArray").val(printList);
				console.log($("#printReportArray").val());
				$("#printReportForm").submit();
				
			}
		}
	}
	
	function isAsset(){
		var assetnum = ${disposalListData['assetCountByDispReady']} + ${disposalListData['assetCountByDisposal']};
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
	#divHead{
		position: releative;
		height: 40px;
		overflow-y: scroll; 
	}
	#tableHead{
		overflow-y: scroll; 
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
</style>
		
</head>

<body>
	 <div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="page-header" id="searchForm" action="disposalList">
					<font size="6px"><b># 폐기 관리</b></font>
					<span class="badge">${disposalListData['categoryCount']}</span>
					<label style="float:right; margin-top: 20px">
						<select id="searchMode" name="searchMode">
							<option value="1">자산 분류</option>
							<option value="2">SID</option>
							<option value="3">구입년도</option>
							<option value="4">관리번호</option>
						</select>
						<input type="text" id="searchKeyword" name="searchKeyword">
						<input type="submit" value="검색">
					</label>
				</form>
				<div style="margin-bottom: 10px">
					<font size="4px">&nbsp;&nbsp;폐기 대기 : </font><span class="badge">${disposalListData['assetCountByDispReady']}</span>
					<font size="4px">&nbsp;&nbsp;폐기 : </font><span class="badge">${disposalListData['assetCountByDisposal']}</span>
				</div>

				<div style="overflow: auto">
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
				
				<form id="disposeForm" action="disposeAsset" method="post">
					<input type="hidden" id="disposeArray" name="disposeArray"/>
				</form>
				<div style="display:flex; float: right; margin-top: 10px">
					<button class="btn btn-lg btn-primary" id="disposalButton" onclick="disposeAsset();" >폐기</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
