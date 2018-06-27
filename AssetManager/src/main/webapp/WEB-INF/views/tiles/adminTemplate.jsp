<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>ESE 자산관리시스템</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>

<script>
	function userDetail(){
		$("#employeeSeq").val(<%=session.getAttribute("employeeSeq") %>);
		$("#userDetailForm").submit();
	}
	
	function myAssetDetail(){
		$("#assetEmployeeSeq").val(<%=session.getAttribute("employeeSeq") %>);
		$("#myAssetForm").submit();
	}
</script>

<style>

footer {
	bottom:0;
	width:100%;
	background-color: #222;
	color: white;
	padding: 15px;
	position:absolute;
}

ul {
	margin: 0;
	padding: 0;
	width: 12.5%;
	min-width: 100px;
	text-align: center;
	background-color: #666;
	position: fixed;
	height: 100%;
}

#systemlogo{
	color: white;
	padding-top: 20px;
	padding-bottom: 20px;
	font-size: 150%;
	font-weight: bold;
}

li a {
	display: block;
	background-color: #eee;
	color: #000;
	padding: 8px 16px;
}

li a.active {
	background-color: #aaa;
	color: white;
}

li a:hover {
	background-color: #444;
	color: white;
}

</style>
</head>
<body>
	<header class="navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-target="#myNavbar"></button>
				<label class="navbar-brand" style="padding-top: 17px">ESE</label>
			</div>
			<tiles:insertAttribute name="adminHeader" />
		</div>
	</header>
	<c:if test='${sessionScope.isAdmin == "TRUE" }'>
		<ul>
			<li id="systemlogo"><font>자산관리시스템</font></li>
			<li><a id="asstLink" href="/assetmanager/assetList">자산 관리</a></li>
			<li><a id="userLink" href="/assetmanager/userList">회원 관리</a></li>
			<li><a id="dispLink" href="/assetmanager/disposalList">폐기 관리</a></li>
			<li><a id="catgLink" href="/assetmanager/categoryList">분류 관리</a></li>
		</ul>
	</c:if>
	<c:if test='${sessionScope.isAdmin != "TRUE" }'>
		<ul>
			<li id="systemlogo"><font>자산관리시스템</font></li>
			<li><a id="asstLink" href="/assetmanager/assetList">자산 관리</a></li>
			<li><a id="userLink" href="javascript:userDetail();">내 정보</a></li>
			<li><a id="myAssetLink" href="javascript:myAssetDetail();">내 자산</a></li>
		</ul>
	</c:if>
	<div class="container">
		<tiles:insertAttribute name="content" />
	</div>
	<form id="userDetailForm" action="userDetail" method="post">
		<input type="hidden" id="employeeSeq" name="employeeSeq"/>
	</form>
	<form id="myAssetForm" action="myAssetList" method="post">
		<input type="hidden" id="assetEmployeeSeq" name="employeeSeq"/>
	</form>

	<footer class="container-fluid text-left" >
		<div class="footer-container">
			<tiles:insertAttribute name="footer" />
		</div>
	</footer>
</body>

</html>

