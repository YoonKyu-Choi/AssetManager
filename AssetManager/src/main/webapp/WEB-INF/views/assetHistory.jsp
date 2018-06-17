<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
<script>

	$(document).on("click", ".table tbody tr", function(event){	
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
		var outSeq = td.eq(0).text();
		var outComment = td.eq(6).text();
		$("#assetOutComment").val(outComment);
	});
	
</script>
<style>
	#displayNone{
		display:None;
	}
</style>

</head>
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
								<td>${assetFormerUser.assetUser}</td>
								<td>${assetFormerUser.assetStartDate} &nbsp;&nbsp;&nbsp;
								~ &nbsp;&nbsp;&nbsp; ${assetFormerUser.assetEndDate}
								</td>
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
								<th>반출/수리 번호</th>
								<th>반출/수리</th>
								<th>대상</th>
								<th>목적</th>
								<th>기간</th>
								<th>비용</th>
							</tr>
						<c:forEach items="${model['AssetTakeOutHistoryList']}" var="assetTakeOutHistory">
							<tr>
								<th>${assetTakeOutHistory.takeOutHistorySeq}</th>
								<th>${assetTakeOutHistory.assetOutStatus}</th>
								<th>${assetTakeOutHistory.assetOutObjective}</th>
								<th>${assetTakeOutHistory.assetOutPurpose}</th>
								<th>${assetTakeOutHistory.assetOutStartDate} 
										~ ${assetTakeOutHistory.assetOutEndDate}</th>
								<th>${assetTakeOutHistory.assetOutCost}</th>
								<th id="displayNone">${assetTakeOutHistory.assetOutComment}</th>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${model['AssetHistoryList'].size() ==0 }">
						<h3>자산 반출/수리 이력이 없습니다.</h3>
					</c:if>
						<h3>자산 이력 코멘트</h3>
					<div> 자산 반출/수리 이력를 클릭하시면 해당 이력을 확인 할 수 있습니다.<br>
					<input type="text" id="assetOutComment" style="width:500px;height:120px"/>
					</div>
				</div>
			</div>
			<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
		</div>
	</div>
</body>
