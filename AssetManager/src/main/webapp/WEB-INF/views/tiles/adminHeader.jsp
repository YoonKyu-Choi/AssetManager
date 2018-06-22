<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<script>
	function logout(){
		document.querySelector("#logoutForm input").value = "true";
		alert("로그아웃 되었습니다.");
		document.querySelector("#logoutForm").submit();
	}
</script>

<form id="logoutForm" action="logout">
	<input type="hidden" name="logoutBtnClick" value="false">
</form>
<div class="collapse navbar-collapse" id="myNavbar">
	<label class="nav navbar-nav navbar-right" style="margin-top: 17px">
		<font color="white"><%=session.getAttribute("Id")%>님 환영합니다.</font>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="logout();"><span class="glyphicon glyphicon-log-in"></span>　Logout</a>
	</label>
</div>

