<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>

<script>
	$(document).ready(function() {
		bridgeForm.submit();
	});
</script>

<style>
#center {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 300px;
	height: 200px;
	overflow: hidden;
	margin-top: -150px;
	margin-left: -100px;
}
</style>
</head>
<body>
	<div id="center">
		<h1>로딩 중</h1>
	</div>

	<form id="bridgeForm" action="assetHistory" method="POST">
		<input type="hidden" name="assetId" value=${requestScope.assetId } />
	</form>
</body>
