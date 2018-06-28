<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/signin.css" rel="stylesheet">

<script>
	$(function(){
		// 플래시 메시지
		var flashmsg = "<c:out value="${msg}"/>";
		
		if(flashmsg != ""){
			alert(flashmsg);
		}
	});

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
				} else if(result=="2"){
					alert("퇴사된 상태라 로그인 할 수 없습니다. 관리자에게 문의하세요");
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

</head>

<body>
	<div style="width: 100%">
	<!-- 	<img alt="" src="${pageContext.request.contextPath}/resources/logo.jpg" style="display: block; margin-left: auto; margin-right: auto;">-->
		<form class="form-signin" onsubmit="return loginCheck();" method="POST">
			<h2 class="form-signin-heading" style="text-align: center"></h2>
            	<div style="display: flex; margin-left:80px">
                	<p>
                		<label class="form-control" style="border: 1; background: transparent; margin-bottom: -1px">USER ID</label>
						<label class="form-control" style="border: 1; background: transparent">PASSWORD</label>
					</p>
					<p>
						<input type="text" id="inputId" name="inputId" class="form-control" placeholder="ID" required autofocus>
						<input type="password" id="inputPw" name="inputPw" class="form-control" placeholder="Password" required>
					</p>
					<button class="btn btn-lg btn-primary" style="margin-bottom: 15px">로그인</button>
               </div>
		</form>
		<button class="btn btn-lg btn-primary btn-block" style="width: 15%; margin:auto" onclick="location.href='/assetmanager/register'">회원가입</button>
	</div> 
</body>
