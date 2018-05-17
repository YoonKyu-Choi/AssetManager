<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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

		<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	</head>

	<body>
        <script type="text/javascript">
        	function idCheck(){
        		var id = $('#employeeId').val();
        		if(id.length == 0){
        			alert("���̵� �Է��� �ּ���.");
        			return;
        		} else{
	        		$.ajax({
	        			type	: 'POST',
	        			url		: 'checkId',
	        			dataType: 'text',
	        			data	: {checkId:id},
	        			success	: function(result){
	        				if(result==1){
	        					alert("��� �Ұ����� ���̵��Դϴ�.");
	        					return false;
	        				} else{
	        					alert("��� ������ ���̵��Դϴ�.");
	        					return false;
	        				}
	        			},
	        			error	: function(request, status, error){
	        				alert("code:"+request.status+"\nmessage:"+request.responseText+"\nerror:"+error);
	        			}
	        		});
	        		return;
        		}
        	}
        </script>
        <script type="text/javascript">
        	$(function(){
        		var idCheckMessage = ${idCheckAlert};
        		alert(idCheckMessage);
        	});
        </script>
        
		<div style="width: 100%" align="center">
			<form class="form-signin" action="assetmanager/registerSend" method="POST">
				<h2 class="form-signin-heading" style="text-align: center">�α��� ���� �Է�</h2>
                <div style="display: flex; height: 100%; margin: 0; margin-left: 100px; auto;">
                    <p>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">�̸�</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">���̵�</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">��й�ȣ</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">����</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">�Ҽ�</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">��ġ</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">�̸���</label>
                        <label class="form-control" style="background: transparent">����ó</label>
                    </p>
                    <p>
                        <input type="text" class="form-control" name="employeeName" required autofocus>
                        <input type="text" class="form-control" id="employeeId" name="employeeId" required autofocus>
                        <input type="password" class="form-control" name="employeePw" required autofocus>
                        <select class="form-control dropdown" name="employeeRank">
                            <option>������ �����ϼ���</option>
                            <option value="1">��ǥ�̻�</option>
                            <option value="2">�λ���</option>
                            <option value="3">�����̻�</option>
                            <option value="4">���̻�</option>
                            <option value="5">�̻�</option>
                            <option value="6">����</option>
                            <option value="7">����</option>
                            <option value="8">����</option>
                            <option value="9">�븮</option>
                            <option value="10">����</option>
                            <option value="11">���</option>
                        </select>
                        <select class="form-control dropdown" name="employeeDepartment">
                            <option>�Ҽ��� �����ϼ���</option>
                            <option value="1">�̿�����</option>
                            <option value="2">�� �濵������ȹ��</option>
                            <option value="3">���� ������</option>
                            <option value="4">���� �濵������</option>
                            <option value="5">�� ǰ��������</option>
                            <option value="6">�� ������������</option>
                            <option value="7">���� ��������1��</option>
                            <option value="8">���� ��������2��</option>
                            <option value="9">�� ����Ʈ�������</option>
                            <option value="10">���� �������TF</option>
                            <option value="11">���� ����Ʈ��Ƽ��</option>
                            <option value="12">���� ����ƮŸ����</option>
                            <option value="13">���� �߱�����</option>
                            <option value="14">�� ����ƮTS����</option>
                            <option value="15">���� TS1��</option>
                            <option value="16">���� TS2��</option>
                            <option value="17">���� TS3��</option>
                        </select>
                        <select class="form-control dropdown" name="employeeLocation">             
                            <option>��ġ�� �����ϼ���</option>
                            <option value="4��">4��</option>
                            <option value="5��">5��</option>
                        </select>
                        <input type="email" class="form-control" name="employeeEmail" required autofocus>
                        <input type="text" class="form-control" name="employeePhone" required autofocus>
                    </p>
                    <p style="margin-bottom: 15px; margin-left: 30px">
                        <label class="form-control" style="opacity: 0; margin-bottom: -1px">��ġ</label>
                        <input type="button" class="btn btn-lg btn-primary btn-block" onclick="idCheck();" value="�ߺ�Ȯ��"/>
                    </p>
                </div>
                <div style="display: flex; width: 300px">
	                <button class="btn btn-lg btn-primary btn-block" type="submit">ȸ������</button>
                    <label style="opacity: 0; margin: 10px"></label>
                    <input type="button" class="btn btn-lg btn-primary btn-block" onclick="location.href='/assetmanager/'" value="���"/>
                </div>
			</form>
			
		</div> <!-- /container -->	
	</body>
</html>