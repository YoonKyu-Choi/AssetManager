<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>사용자 상세보기</title>

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

<style>
        .mask {
            position:absolute;
            left:0;
            top:0;
            z-index:9999;
            background-color:#000;
            display:none;
        }
        .window {
            display: none;
            background-color: #ffffff;
            z-index:99999;
        }
    </style>


<script>
	function deleteConfirm() {
		if (!confirm("삭제하겠습니까?")) {
			return false;
		} else {
	        wrapWindowByMask();
		}
	}
	function modifyConfirm() {
		if (!confirm("수정하시겠습니까?")) {
			return false;
		} else {
			$("#modifyForm").submit();
		}
	}
</script>

<script>
	$(function(){
		var flashmsg = "<c:out value="${msg}"/>";
//		if(flashmsg != "")
			alert(flashmsg);
	});
</script>

<script>
	function wrapWindowByMask(){
	    // 화면의 높이와 너비를 변수로 만듭니다.
	    var maskHeight = $(window).height();
	    var maskWidth = $(window).width();
	
	    // 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
	    $('.mask').css({'width':maskWidth,'height':maskHeight});
	
	    // fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
	    $('.mask').fadeTo("slow",0.8);
	
		var position = $("#delbtn").offset();
		
	    // 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
	    var left = $(window).scrollLeft() +position['left'];
	    var top = $(window).scrollLeft() +position['top'];
	
	    // css 스타일을 변경합니다.
	    $('.window').css({'left':left,'top':top, 'position':'absolute'});
	
	    // 레이어 팝업을 띄웁니다.
	    $('.window').show();
	}
	
	$(function(){
	    // 닫기(close)를 눌렀을 때 작동합니다.
	    $('.window .close').click(function (e) {
	        e.preventDefault();
	        $('.mask, .window').hide();
	    });

	    // 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
        $('.mask').click(function () {
            $(this).hide();
            $('.window').hide();
        });	
	});

	$(function(){
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-300);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-300);
		});
	});
	
</script>


</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header"><b>회원 관리 > ${requestScope.employeeVO.employeeName}님 정보</b></h1>

				<div class="table-responsive">
					<table class="table table-striped">
						<tr>
							<th>이름</th>
							<th>${requestScope.employeeVO.employeeName}</th>
						</tr>
						<tr>
							<th>아이디</th>
							<th>${requestScope.employeeVO.employeeId}</th>
						</tr>
						<tr>
							<th>직급</th>
							<th>${requestScope.employeeVO.rankVO.employeeRankString}</th>
						</tr>
						<tr>
							<th>소속</th>
							<th>${requestScope.employeeVO.departmentVO.employeeDepartmentString}</th>
						</tr>
						<tr>
							<th>위치</th>
							<th>${requestScope.employeeVO.employeeLocation}</th>
						</tr>
						<tr>
							<th>이메일</th>
							<th>${requestScope.employeeVO.employeeEmail}</th>
						</tr>
						<tr>
							<th>연락처</th>
							<th>${requestScope.employeeVO.employeePhone}</th>
						</tr>
						<tr>
							<th>상태</th>
							<th>${requestScope.employeeVO.employeeStatus}</th>
						</tr>
						<tr>
					</table>
				</div>

				<form id="modifyForm" action="userModify" method="POST">
					<input type="hidden" name="employeeSeq" value=${requestScope.employeeVO.employeeSeq } />
				</form>
				<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/userList'" value="목록" />
				<div style="display: flex; float: right">
					<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();">회원 수정</button>
					<button class="btn btn-lg btn-primary" id="delbtn" onclick="deleteConfirm();">회원 삭제</button>
				
					<div class="mask"></div>
				    <div class="window">
				    	<p>비밀번호를 입력해주세요.</p>

						<form id="idForm" action="userDelete" method="POST">
							<input type="hidden" name="employeeSeq" value=${requestScope.employeeVO.employeeSeq } />
							<input type="password" name="checkAdminPw" autofocus/>
				        	<div style="margin-top: 20px">
					        	<button class="btn btn-lg btn-primary" type="submit">제출</button>
					        	<input class="btn btn-lg btn-primary close" type="button" value="취소"/>
				        	</div>
						</form>

				    </div>
			    </div>
				
			</div>
		</div>
	</div>

</body>
</html>