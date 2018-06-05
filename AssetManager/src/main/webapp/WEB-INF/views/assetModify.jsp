<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function cancelConfirm() {
	if (!confirm("취소하겠습니까?")) {
		return false;
	} else {
		location.href='/assetmanager/assetDetail?assetId='+${requestScope.assetVO.assetId};
		$("#idForm").submit();
	}
}
function modifyConfirm() {
	if (!confirm("수정하겠습니까?")) {
		return false;
	} else {
		$("#modifySend").submit();
	}
}
</script>
<style>

</style>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header"><b>자산 관리 > ${requestScope.assetVO.assetId}의 자산 정보 수정</b></h1>
				<div class="table-responsive" id="inputDiv" style="overflow: scroll;height: 500px;">
				<h3>자산 공통사항</h3>
					<table class="table table-striped">
						<tr>
							<th>분류</th>
							<th>${requestScope.assetVO.assetCategory}</th>
							<th>이름</th>
							<th>${requestScope.assetVO.assetUser}</th>
						</tr>
						<tr>
							<th>관리 번호</th>
							<th>${requestScope.assetVO.assetId}</th>
							<th>자산 상태</th>
							<th>${requestScope.assetVO.assetStatus}</th>
						</tr>
						<tr>
							<th>시리얼 번호</th>
							<th>${requestScope.assetVO.assetSerial}</th>
							<th>구입일</th>
							<th>${requestScope.assetVO.assetPurchaseDate}</th>
						</tr>
						<tr>
							<th>제조사</th>
							<th>${requestScope.assetVO.assetMaker}</th>
							<th>구입가</th>
							<th>${requestScope.assetVO.assetPurchasePrice}</th>
						</tr>
						<tr>
							<th>모델명</th>
							<th>${requestScope.assetVO.assetModel}</th>
							<th>구입처</th>
							<th>${requestScope.assetVO.assetPurchaseShop}</th>
						</tr>
						<tr>
							<th>용도</th>
							<th>${requestScope.assetVO.assetUsage}</th>
							<th>책임자</th>
							<th>${requestScope.assetVO.assetManager}</th>
						</tr>
						<tr>
							<th>사용 위치</th>
							<th>${requestScope.assetVO.assetLocation}</th>
						</tr>
					</table>
					<h3>자산 세부사항</h3>
					<table class="table table-striped">
						<c:forEach items="${assetDetailList}" var="assetDetail">
						<tr>
								<th>${assetDetail.assetItem}</th>
								<th>${assetDetail.assetItemDetail}</th>
						</tr>
							</c:forEach>
					</table>
					<div>
					<c:choose>
					<c:when test="${requestScope.assetVO.assetReceiptUrl}==null">
					<h4>영수증 사진은 없습니다.</h4>
					</c:when>
					<c:otherwise>
					<h3>영수증 사진</h3>
					<img style="width:400px;height:400px;" src="${pageContext.request.contextPath}/resources/${requestScope.assetVO.assetReceiptUrl}">
					</c:otherwise>
					</c:choose>
					<h3>자산 코멘트</h3>
					<text border="0" readonly>${requestScope.assetVO.assetComment}</text>					
					</div>
				</div>

				<form id="modifyForm" action="userModify" method="POST">
					<input type="hidden" name="assetId" value="${requestScope.assetVO.assetId}" />
				</form>
				<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
				<div style="display: flex; float: right">
					<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();">수정</button>
					<button class="btn btn-lg btn-primary" id="delbtn" onclick="cancelConfirm();">취소</button>
					<div class="mask"></div>
			    </div>
				
			</div>
		</div>
	</div>

</body>
