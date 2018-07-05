<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<meta charset="utf-8">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">

<script>

	$(function(){
		// 사이드바 활성화
		$("#userLink").prop("class", "active");

		// 플래시 메시지
		var flashmsg = "<c:out value='${msg}'/>";
		if(flashmsg != ""){
			alert(flashmsg);
		}

		// 마스크 닫기
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

	    // 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-300);
		$(".window").css("top", (window.innerHeight-250)/2);
		$(".window").css("right", (window.innerWidth-300)/2);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-300);
			$(".window").css("top", (window.innerHeight-250)/2);
			$(".window").css("right", (window.innerWidth-300)/2);
		});

	});

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

	function wrapWindowByMask(){
	    // 화면의 높이와 너비를 변수로 만듭니다.
	    var maskHeight = $(window).height();
	    var maskWidth = $(window).width();
	
	    // 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
	    $('.mask').css({'width':maskWidth,'height':maskHeight});
	
	    // fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
	    $('.mask').fadeTo("slow",0.5);
	
// 		var position = $("#delbtn").offset();
		
	    // 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
// 	    var left = $(window).scrollLeft() +position['left'];
// 	    var top = $(window).scrollLeft() +position['top'];
	
	    // css 스타일을 변경합니다.
// 	    $('.window').css({'left':left,'top':top, 'position':'absolute'});
	
	    // 레이어 팝업을 띄웁니다.
	    $('.window').show();
	}
	
</script>

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
		z-index: 99999;
		width : 300px;
		height : 250px;
		background : white;
		color : black;
		position: absolute;
		text-align : center;
		border : 2px solid #000;
		display : none;
	}
	.container{
		top:0;
		left:0;
		bottom:0;
		right:0;
		height:100%;
		width:100%;
		margin-top: 1%;
	}
	.main{
		margin-left: 13%;
		width: 76%;
	}
	th:nth-child(2n+1){
		width: 25%;
		font-weight: bold;
	}
	th:nth-child(2n+2){
		width: 75%;
		font-weight: normal;
	}
	#button, #delbtn{
		color: black;
		border-color: #999;
		background-color: #aaa;
		font-weight: bold;
	}
	#button:hover, #delbtn:hover {
		color: white;
		background-color: #333;
	}
</style>

</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">
					
					<c:if test='${sessionScope.isAdmin == "TRUE" }'>
					<font size="6px"><b>회원 정보</b></font>
					</c:if>
					
					<c:if test='${sessionScope.isAdmin != "TRUE" }'>
					<font size="6px"><b>내 정보</b></font>
					</c:if>
					
				</h1>

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
				
				<c:if test='${sessionScope.isAdmin == "TRUE" }'>
<!-- 				<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/userList'" value="목록" />	-->
					<div style="display: flex; float: right; margin-top: 10px">
						<button class="btn btn-lg btn-primary" id="button" onclick="modifyConfirm();">수정</button>
						<c:if test='${requestScope.employeeVO.employeeId != "admin"}'>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-lg btn-primary" id="delbtn" onclick="deleteConfirm();">삭제</button>
						</c:if>
					</div>
				</c:if>
				
				<c:if test='${sessionScope.isAdmin != "TRUE" }'>
					<div style="display: flex; float: right">
						<button id="button" class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="modifyConfirm();">내 정보 수정</button>
					</div>
				</c:if>
					
					
					<div class="mask"></div>
				    <div class="window">
				    	<h3 class="page-header" style="margin-top: 30px;"><b>사용자 삭제</b></h3>
				    	<p>비밀번호를 입력해주세요.</p>

						<form id="idForm" action="userDelete" method="POST">
							<input type="hidden" name="employeeSeq" value=${requestScope.employeeVO.employeeSeq } />
							<input type="password" name="checkAdminPw" autofocus/>
				        	<div style="margin-top: 20px">
					        	<button id="button" class="btn btn-lg btn-primary" type="submit" style="margin-right: 20px">제출</button>
					        	<input id="button" class="btn btn-lg btn-primary" type="button" style="margin-left: 20px" value="취소" onclick="$('.mask').click();"/>
				        	</div>
						</form>

				    </div>
			    </div>
			</div>
		</div>
</body>
