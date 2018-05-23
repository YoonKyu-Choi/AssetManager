<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		
		<title>이에스이 자산관리시스템</title>
		
		<!-- Bootstrap core CSS -->
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="${pageContext.request.contextPath}/resources/css/signin.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	</head>

	<body>
		<script type="text/javascript">
			function loginCheck(){
	    		var id = $('#inputId').val();
	    		var pw = $('#inputPw').val();
	       		$.ajax({
	       			type	: 'POST',
	       			url		: 'loginSubmit',
	       			dataType: 'text',
	       			data	: {inputId:id, inputPw:pw},
	       			success	: function(result){
	       				if(result == "1"){
	       					alert("로그인되었습니다.");
	       				} else{
	       					alert("아이디와 비밀번호를 확인해주세요.");
	       				}
       					window.location.replace("/assetmanager/");
       					return true;
	       			},
	       			error	: function(request, status, error){
	       				alert("code:"+request.status+"\nmessage:"+request.responseText+"\nerror:"+error);
	       			}
	       		});
	       		return false;
	    	}
		</script>
			
		<div style="width: 100%">
			<form class="form-signin" onsubmit="return loginCheck();" method="POST">
				<h2 class="form-signin-heading" style="text-align: center">로그인 정보 입력</h2>
                <div style="display: flex; height: 100%; ">
                    <p>
                        <label class="form-control" style="border: 1; background: transparent; margin-bottom: -1px">USER ID</label>
                        <label class="form-control" style="border: 1; background: transparent">PASSWORD</label>
                    </p>
                    <p>
                        <input type="text" id="inputId" name="inputId" class="form-control" placeholder="ID" required autofocus>
                        <input type="password" id="inputPw" name="inputPw" class="form-control" placeholder="Password" required>
                    </p>
                    <p style="margin-bottom: 15px">
                        <button class="btn btn-lg btn-primary btn-block" style="height: 100%">로그인</button>
                    </p>
                </div>
			</form>
			<button class="btn btn-lg btn-primary btn-block" style="width: 20%; margin:auto" onclick="location.href='/assetmanager/register'">회원가입</button>
			
		</div> <!-- /container -->	
	</body>
</html>