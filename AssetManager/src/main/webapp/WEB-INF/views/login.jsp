<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		
		<title>�̿����� �ڻ�����ý���</title>
		
		<!-- Bootstrap core CSS -->
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="${pageContext.request.contextPath}/resources/css/signin.css" rel="stylesheet">
	</head>

	<body>
		<script type="text/javascript">
			var message='${loginAlert}';
			if(message)
				alert(message);
		</script>
	
	
		<div style="width: 100%">
			<form class="form-signin" action="/assetmanager/loginSubmit" method="POST">
				<h2 class="form-signin-heading" style="text-align: center">�α��� ���� �Է�</h2>
                <div style="display: flex; height: 100%; margin:auto">
                    <p>
                        <label class="form-control" style="border: 1; background: transparent; margin-bottom: -1px">USER ID</label>
                        <label class="form-control" style="border: 1; background: transparent">PASSWORD</label>
                    </p>
                    <p>
                        <input type="text" name="inputId" class="form-control" placeholder="ID" required autofocus>
                        <input type="password" name="inputPw" class="form-control" placeholder="Password" required>
                    </p>
                    <p style="margin-bottom: 15px">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" style="height: 100%">�α���</button>
                    </p>
                </div>
			</form>
			<button class="btn btn-lg btn-primary btn-block" style="width: 20%; margin:auto" onclick="location.href='/assetmanager/register'">ȸ������</button>
			
		</div> <!-- /container -->	
	</body>
</html>