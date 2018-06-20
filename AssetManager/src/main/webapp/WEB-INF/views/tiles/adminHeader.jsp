<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<script type="text/javascript">
	function logout(){
		alert("로그아웃 되었습니다.");
		window.location.replace("logout");
	}
</script>

<div class="collapse navbar-collapse" id="myNavbar">
	<label class="nav navbar-nav navbar-right" style="margin-top: 17px">
		<font color="white"><%=session.getAttribute("Id")%></font>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="logout();"><span class="glyphicon glyphicon-log-in"></span>　Logout</a>
	</label>
</div>

