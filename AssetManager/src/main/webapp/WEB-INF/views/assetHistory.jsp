<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">


</head>

<script>
	var windowHeight = window.innerHeight;
	$(".table-responsive").css("height", windowHeight-350);
	$(window).resize(function(){
		windowHeight = $(window).height();
		$(".table-responsive").css("height", windowHeight-300);
	})

</script>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">
					<b>자산 관리 > ${model['assetId']}의 자산 이력 정보</b>
				</h1>
				<div class="table-responsive" id="inputDiv" style="overflow: scroll; height: 500px;">
					
					<h3>자산 이전 사용자</h3>
					<c:if test="${model['AssetFormerUserList'].size() != 0 }">
					<table class="table table-striped">
						<c:forEach items="${model['AssetFormerUserList']}" var="assetFormerUser">
							<tr>
								<th>${assetFormerUser.assetUser}</th>
								<th>${assetFormerUser.assetStartDate} &nbsp;&nbsp;&nbsp;
								~ &nbsp;&nbsp;&nbsp; ${assetFormerUser.assetEndDate}
								</th>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${model['AssetFormerUserList'].size() ==0 }">
						<h3>자산 이전 사용자가 없습니다.</h3>
					</c:if>
					
					<h3>자산 반출/수리 이력</h3>
					<c:if test="${model['AssetHistoryList'].size() != 0 }">						
					<table class="table table-striped">
							<tr>
								<th>반출/수리</th>
								<th>대상</th>
								<th>목적</th>
								<th>기간</th>
								<th>비용</th>
							</tr>
						<c:forEach items="${model['AssetTakeOutHistoryList']}" var="assetTakeOutHistory">
							<tr>
								<th>${assetTakeOutHistory.assetOutStatus}</th>
								<th>${assetTakeOutHistory.assetOutObjective}</th>
								<th>${assetTakeOutHistory.assetOutPurpose}</th>
								<th>${assetTakeOutHistory.assetOutStartDate} 
										~ ${assetTakeOutHistory.assetOutEndDate}</th>
								<th>${assetTakeOutHistory.assetOutCost}</th>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${model['AssetHistoryList'].size() ==0 }">
						<h3>자산 반출/수리 이력이 없습니다.</h3>
					</c:if>
					<div>
					
						<h3>자산 이력 코멘트</h3>
						<textArea style="resize: none; width: 600px; height: 200px" readonly>${model['AssetHistoryVO']['assetHistoryComment']}</textArea>
					</div>
				</div>
			</div>
			<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
		</div>
	</div>
</body>
