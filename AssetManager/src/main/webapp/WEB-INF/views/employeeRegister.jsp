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
		
		<title>이에스이 자산관리시스템</title>
		
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
        			alert("아이디를 입력해 주세요.");
        			return;
        		} else{
	        		$.ajax({
	        			type	: 'POST',
	        			url		: 'checkId',
	        			dataType: 'text',
	        			data	: {checkId:id},
	        			success	: function(result){
	        				if(result==1){
	        					alert("사용 불가능한 아이디입니다.");
	        					return false;
	        				} else{
	        					alert("사용 가능한 아이디입니다.");
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
				<h2 class="form-signin-heading" style="text-align: center">로그인 정보 입력</h2>
                <div style="display: flex; height: 100%; margin: 0; margin-left: 100px; auto;">
                    <p>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">이름</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">아이디</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">비밀번호</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">직급</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">소속</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">위치</label>
                        <label class="form-control" style="background: transparent; margin-bottom: 0px">이메일</label>
                        <label class="form-control" style="background: transparent">연락처</label>
                    </p>
                    <p>
                        <input type="text" class="form-control" name="employeeName" required autofocus>
                        <input type="text" class="form-control" id="employeeId" name="employeeId" required autofocus>
                        <input type="password" class="form-control" name="employeePw" required autofocus>
                        <select class="form-control dropdown" name="employeeRank">
                            <option>직급을 선택하세요</option>
                            <option value="1">대표이사</option>
                            <option value="2">부사장</option>
                            <option value="3">전무이사</option>
                            <option value="4">상무이사</option>
                            <option value="5">이사</option>
                            <option value="6">부장</option>
                            <option value="7">차장</option>
                            <option value="8">과장</option>
                            <option value="9">대리</option>
                            <option value="10">주임</option>
                            <option value="11">사원</option>
                        </select>
                        <select class="form-control dropdown" name="employeeDepartment">
                            <option>소속을 선택하세요</option>
                            <option value="1">이에스이</option>
                            <option value="2">└ 경영전략기획실</option>
                            <option value="3">　└ 관리팀</option>
                            <option value="4">　└ 경영전략팀</option>
                            <option value="5">└ 품질관리팀</option>
                            <option value="6">└ 리노기술연구소</option>
                            <option value="7">　└ 연구개발1팀</option>
                            <option value="8">　└ 연구개발2팀</option>
                            <option value="9">└ 스마트사업본부</option>
                            <option value="10">　└ 전략사업TF</option>
                            <option value="11">　└ 스마트시티팀</option>
                            <option value="12">　└ 스마트타운팀</option>
                            <option value="13">　└ 중국지사</option>
                            <option value="14">└ 스마트TS본부</option>
                            <option value="15">　└ TS1팀</option>
                            <option value="16">　└ TS2팀</option>
                            <option value="17">　└ TS3팀</option>
                        </select>
                        <select class="form-control dropdown" name="employeeLocation">             
                            <option>위치를 선택하세요</option>
                            <option value="4층">4층</option>
                            <option value="5층">5층</option>
                        </select>
                        <input type="email" class="form-control" name="employeeEmail" required autofocus>
                        <input type="text" class="form-control" name="employeePhone" required autofocus>
                    </p>
                    <p style="margin-bottom: 15px; margin-left: 30px">
                        <label class="form-control" style="opacity: 0; margin-bottom: -1px">위치</label>
                        <input type="button" class="btn btn-lg btn-primary btn-block" onclick="idCheck();" value="중복확인"/>
                    </p>
                </div>
                <div style="display: flex; width: 300px">
	                <button class="btn btn-lg btn-primary btn-block" type="submit">회원가입</button>
                    <label style="opacity: 0; margin: 10px"></label>
                    <input type="button" class="btn btn-lg btn-primary btn-block" onclick="location.href='/assetmanager/'" value="취소"/>
                </div>
			</form>
			
		</div> <!-- /container -->	
	</body>
</html>