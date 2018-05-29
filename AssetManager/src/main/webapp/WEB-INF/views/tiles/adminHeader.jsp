<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript">
	function logout(){
		alert("로그아웃되었습니다.");
		window.location.replace("logout");
	}
</script>

<div class="collapse navbar-collapse" id="myNavbar">
	<ul class="nav navbar-nav">
		<li class="active"><a>관리자</a></li>
	</ul>
	<ul class="nav navbar-nav" style="position:absolute; right:50%; ">
		<li style="margin-right: 40px"><a href="/assetmanager/assetList">자산 관리</a></li>
		<li style="margin-right: 20px"><a href="/assetmanager/userList">회원 관리</a></li>
	</ul>
	<ul class="nav navbar-nav" style="position:absolute; left:50%; ">
		<li style="margin-left: 20px"><a href="/assetmanager/loginGet">폐기 관리</a></li>
		<li style="margin-left: 40px"><a href="/assetmanager/categoryList">분류 관리</a></li>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<li><a onclick="logout();"><span class="glyphicon glyphicon-log-in"/>　Logout</a></li>
	</ul>
</div>

