<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

<style>
        .mask {
            position:absolute;
            left:0;
            top:0;
            z-index:9999;
            background-color:#000;
            display:none;
        }
        .window {
            display: none;
            background-color: #ffffff;
            z-index:99999;
        }
        
        #pop{
        width : 350px;
        height : 400px;
        background : #3d3d3d;
        color : #fff;
        position: absolute;
        top : 200px;
        right : 350px;
        text-align : center;
        border : 2px solid #000;
        }
        
        .popInput{
        color : #3d3d3d;
        }
        
</style>

<script>
	
	$(document).ready(function(){
		
		 $("#pop").hide();
		 $('#popSubmit').click(function() {
		       $('#pop').submit();
		 });
		 $('#popClose').click(function() {
		       $('#pop').hide();
		 });

	});

	function modifyConfirm() {
		if (!confirm("수정하시겠습니까?")) {
			return false;
		} else {
			$("#assetModifyForm").submit();
		}
	}
	function outConfirm() {
		if (!confirm("반출/수리 하겠습니까?")) {
			return false;
		} else {
			$("#pop").show();
		}
	}
	function dispReqConfirm() {
		if (!confirm("폐기 신청을 하시겠습니까?")) {
			return false;
		} else {
			var disposalAssetAry = [];
			var assetId = "${assetData['assetVO']['assetId']}";
			disposalAssetAry.push(assetId);
			
			$("#disposalAsset").val(disposalAssetAry);
			$("#assetDispForm").submit();
		}
	}
	
	function historyConfirm() {
		if (!confirm("이력을 확인하시겠습니까?")) {
			return false;
		} else {
			$("#assetHistoryForm").submit();
		}
	}
	
	function deleteConfirm() {
		if (!confirm("자산을 정말 삭제하시겠습니까?")) {
			return false;
		} else {
			$("#assetDeleteForm").submit();
		}
	}
	
	function payConfirm(){
		if (!confirm("자산을 정말 납입하시겠습니까?")) {
			return false;
		} else {
			$("#assetPaymentForm").submit();
		}
	}

	function wrapWindowByMask(){
	    // 화면의 높이와 너비를 변수로 만듭니다.
	    var maskHeight = $(window).height();
	    var maskWidth = $(window).width();
	
	    // 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
	    $('.mask').css({'width':maskWidth,'height':maskHeight});
	    // fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
	    $('.mask').fadeTo("slow",0.8);
	
		var position = $("#delbtn").offset();
		
	    // 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
	    var left = $(window).scrollLeft() +position['left'];
	    var top = $(window).scrollLeft() +position['top'];
	
	    // css 스타일을 변경합니다.
	    $('.window').css({'left':left,'top':top, 'position':'absolute'});
	
	    // 레이어 팝업을 띄웁니다.
	    $('.window').show();
	}
	
	$(function(){
	    // 닫기(close)를 눌렀을 때 작동합니다.
	    $('.window .close').click(function (e) {
	        e.preventDefault();
	        $('.mask, .window').hide();
	    });

	    // 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
        $('.mask').click(function () {
            $(this).hide();
            $('.window').hide();
        });	
	    
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-350);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-350);
		})

	});
	
	function printReport(){
		if(!confirm('현재 자산의 보고서를 출력하겠습니까?')){
			return false;
		}else{
			var printList = [];
			var assetId = "${assetData['assetVO']['assetId']}";
			printList.push(assetId);
			
			$("#printReportArray").val(printList);
			$("#printReportForm").submit();
			
		}
	}
</script>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header"><b>자산 관리 > ${assetData['assetVO']['assetId']}의 자산 정보</b></h1>
				<div class="table-responsive" id="inputDiv" style="overflow: scroll;height: 500px;">
				<h3>자산 공통사항</h3>
					<table class="table table-striped">
						<tr>
							<th>분류</th>
							<th>${assetData['assetVO']['assetCategory']}</th>
							<th>이름</th>
							<th>${assetData['assetVO']['assetUser']}</th>
						</tr>
						<tr>
							<th>관리 번호</th>
							<th>${assetData['assetVO']['assetId']}</th>
							<th>시리얼 번호</th>
							<th>${assetData['assetVO']['assetSerial']}</th>
						</tr>
						<tr>
							<th>자산 상태</th>
							<th>${assetData['assetVO']['assetStatus']}</th>
							<th>반출 상태</th>
							<th>${assetData['assetVO']['assetOutStatus']}</th>
						</tr>
						<tr>
							<th>구입일</th>
							<th>${assetData['assetVO']['assetPurchaseDate']}</th>
							<th>제조사</th>
							<th>${assetData['assetVO']['assetMaker']}</th>
						</tr>
						<tr>
							<th>구입가(원)</th>
							<th>${assetData['assetVO']['assetPurchasePrice']}</th>
							<th>모델명</th>
							<th>${assetData['assetVO']['assetModel']}</th>
						</tr>
						<tr>
							<th>구입처</th>
							<th>${assetData['assetVO']['assetPurchaseShop']}</th>
							<th>용도</th>
							<th>${assetData['assetVO']['assetUsage']}</th>
						</tr>
						<tr>
							<th>책임자</th>
							<th>${assetData['assetVO']['assetManager']}</th>
							<th>사용 위치</th>
							<th>${assetData['assetVO']['assetLocation']}</th>
						</tr>
					</table>
					<h3>자산 세부사항</h3>
					<table class="table table-striped">
					<c:forEach items="${assetData['assetDetailList']}" varStatus="i" step="2">
						<tr>
							<th>${assetData['assetDetailList'][i.index]['assetItem']}</th>
							<th>${assetData['assetDetailList'][i.index]['assetItemDetail']}</th>
							<th>${assetData['assetDetailList'][i.index+1]['assetItem']}</th>
							<th>${assetData['assetDetailList'][i.index+1]['assetItemDetail']}</th>
						</tr>
					</c:forEach>
					</table>
					<div>
					<br>
					<c:if test="${assetData['assetVO']['assetReceiptUrl'] !=null && assetData['assetVO']['assetReceiptUrl'] != ''}">
						<h3>영수증 사진</h3>
						<img style="width:400px;height:400px;" src="${pageContext.request.contextPath}/resources/${assetData['assetVO']['assetReceiptUrl']}">
					</c:if>
					<c:if test="${assetData['assetVO']['assetReceiptUrl'] ==null || assetData['assetVO']['assetReceiptUrl'] == ''}">	
						<h3>영수증 사진이 없습니다.</h3>
					</c:if>
					<br>					
						<h3>자산 코멘트</h3>
						<textArea style="resize: none; width:600px; height:200px" readonly>${assetData['assetVO']['assetComment']}</textArea>
 					</div>
				</div>
					
			</div>
			<div style="display:flex; float: left; margin-top: 10px">
				<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
				<button class="btn btn-lg btn-primary" onclick="printReport();" >보고서 출력</button>
			</div>
			
			<div style="display: flex; float: right">
				<c:choose>
					<c:when test="${assetData['assetVO']['assetStatus'] == '폐기 대기'}">
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="historyConfirm();">자산 이력</button>
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();">수정</button>
					</c:when>
					
					<c:when test="${assetData['assetVO']['assetStatus'] == '폐기'}">
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="historyConfirm();">자산 이력</button>
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="deleteConfirm();">자산 삭제</button>
					</c:when>
					
					<c:when test="${assetData['assetVO']['assetOutStatus'] == '반출 중' || assetData['assetVO']['assetOutStatus'] == '수리 중'}">
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="payConfirm();">납입</button>
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="historyConfirm();">자산 이력</button>
					</c:when>
					
					<c:otherwise>	
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();">수정</button>
						<button class="btn btn-lg btn-primary" id="outBtn" onclick='$("#pop").show();'>반출/수리</button>
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="dispReqConfirm();">폐기 신청</button>
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="historyConfirm();">자산 이력</button>
						<div class="mask"></div>
					</c:otherwise>
				</c:choose>
				
				<!-- 컨트롤러 이동 form -->
				<form id="printReportForm" action="printReport" method="post">
					<input type="hidden" id="printReportArray" name="assetIdList"/>
				</form>
				<form id="assetModifyForm" action="assetModify" method="POST">
					<input type="hidden" name="assetId" value=${assetData['assetVO']['assetId'] } />
				</form>
				<form id="assetDispForm" action="assetDisposal" method="post">
					<input type="hidden" id="disposalAsset" name="assetIdList" />
				</form>
				<form id="assetDeleteForm" action="assetDelete" method="POST">
					<input type="hidden" name="assetId" value=${assetData['assetVO']['assetId'] } />
				</form>
				<form id="assetHistoryForm" action="assetHistory" method="post">
					<input type="hidden" name="assetId" value=${assetData['assetVO']['assetId'] } />
				</form>
				<form id="assetPaymentForm" action="assetPayment" method="post">
					<input type="hidden" name="assetId" value=${assetData['assetVO']['assetId'] } />
					<input type="hidden" name="assetUser" value=${assetData['assetVO']['assetUser'] } />
				</form>
				
				<!-- 반출/수리 레이어 팝업 -->
				<form id="pop" action="assetTakeOutHistory" method="post">
					<table style="margin-top:100px;margin-left:20px;">
						<tr>
							<th>용도</th>
							<th class="popInput">
								<select class="form-controlmin dropdown" id="assetOutStatus" name="assetOutStatus">
										<option value="0">용도를 선택하세요.</option>
										<option value="반출 중">반출 중</option>
										<option value="수리 중">수리 중</option>
										<option value="고장">고장</option>
								</select>
							</th>
						</tr>
						<tr>
							<th>대상</th>
							<th class="popInput"><input type="text" name="assetOutObjective" id="assetOutObjective"/></th>
						</tr>
						<tr>
							<th>목적</th>
							<th class="popInput"><input type="text" name="assetOutPurpose" id="assetOutPurpose"/></th>
						</tr>
						<tr>
							<th>신청날짜</th>
							<th class="popInput"><input type="text" name="assetOutStartDate" id="assetOutStartDate"/></th>
						</tr>
						<tr>
							<th>비용</th>
							<th class="popInput"><input type="text" name="assetOutCost" id="assetOutCost"/></th>
						</tr>
					</table>
						<input type="hidden" id="assetId" name="assetId" value="${assetData['assetVO']['assetId'] }"/>
						<input type="button" id="popSubmit" style="margin:30px; background:#3d3d3d" value="submit"/>
						<input type="button" id="popClose" style="margin:30px; background:#3d3d3d" value="close"/>											
				</form>
				
		    </div>
		</div>
	</div>
</body>