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
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">
					<b>자산 관리 > ${requestScope.assetId}의 자산 이력 정보</b>
				</h1>
				<div class="table-responsive" id="inputDiv" style="overflow: scroll; height: 500px;">
					
					<h3>자산 이전 사용자</h3>
					<c:if test="${requestScope.AssetFormerUserList !=null || requestScope.AssetFormerUserList != ''}">
					<table class="table table-striped">
						<c:forEach items="${AssetFormerUserList}" var="assetFormerUser">
							<tr>
								<th>${assetFormerUser.assetUser}</th>
								<th>${assetFormerUser.assetStartDate}
								~ ${assetFormerUser.assetEndDate}
								</th>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${requestScope.AssetFormerUserList ==null || requestScope.AssetFormerUserList == ''}">
						<h3>자산 이전 사용자가 없습니다.</h3>
					</c:if>
					
					<h3>자산 반출/수리 이력</h3>
					<c:if test="${requestScope.AssetFormerUserList !=null || requestScope.AssetFormerUserList != ''}">						
					<table class="table table-striped">
						<c:forEach items="${assetDetailList}" varStatus="i" step="2">
							<tr>
								<th>${assetDetailList[i.index].assetItem}</th>
								<th>${assetDetailList[i.index].assetItemDetail}</th>
							</tr>
						</c:forEach>
					</table>
					</c:if>
					<c:if test="${requestScope.AssetFormerUserList ==null || requestScope.AssetFormerUserList == ''}">
					</c:if>
					<div>
					
						<h3>자산 이력 코멘트</h3>
						<textArea style="resize: none; width: 600px; height: 200px" readonly>${requestScope.AssetHistoryVO.assetHistoryComment}</textArea>
					</div>
				</div>
			</div>
			<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
		</div>
	</div>
</body>
