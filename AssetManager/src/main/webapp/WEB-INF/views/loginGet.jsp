<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/authority.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>

<script type="text/javascript">
$(function(){
	var isAdmin = "<%=session.getAttribute("isAdmin")%>
	if (isAdmin == "TRUE") {
		$("div.admin").show();
	}
});
</script>
</head>

<body>
	<div>
		<button onclick="logout();">로그아웃</button>
	</div>
	<div>로그인에 성공하면 이리로 넘어온다</div>
	<div>
		isUser:
		<%=session.getAttribute("isUser")%>
	</div>
	<div>
		isAdmin:
		<%=session.getAttribute("isAdmin")%>
	</div>

	<div class="admin">이 부분은 관리자만 볼 수 있다</div>
</body>
</html>