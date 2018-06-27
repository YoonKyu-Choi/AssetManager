<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
<style>
body { background-color: "darkblue"}
.error-template {padding: 40px 15px;text-align: center;}
.error-actions {margin-top:15px;margin-bottom:15px;}
.error-actions .btn { margin-right:10px; }
</style>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="error-template">
					<h1>Oops! 에러 발생 !</h1>
					<h2><c:out value="${msg}" /></h2>
					<div class="error-details">죄송합니다. 에러가 발생하여 요청하신 페이지를 찾지 못 했습니다.</div>
					<div class="error-details">Sorry, an error has occurred. Requested page is not found!</div>
					<div class="error-actions">
						<a href="javascript:history.back();" class="btn btn-primary btn-lg">
						<span class="glyphicon glyphicon-chevron-left"></span> Take Me Back </a>
						<a href="/assetmanager/assetList" class="btn btn-primary btn-lg">
						<span class="glyphicon glyphicon-tasks"></span> Go to AssetList </a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
