<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet">


<script>
	var plusCount = 0;
	var nameChecked = false;
	var codeChecked = false;

	$(function(){
		// 사이드바 활성화
		$("#catgLink").prop("class", "active");
		
		// 세부사항 추가제거
		$(document).on("click", "#addItem", function(){		// .click("") style로 바꾸지 말 것. deprecated됨.
			plusCount += 1;
			if(plusCount % 2 == 1){
				$("#itemTable tr:last td:last").before('<td style="width: 50%"><input type="button" class="removeItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 80%" value="" maxlength="33"/></td>');
				$("#itemTable tr:last td:last").remove();
				$("#itemTable tr:last").after('<tr><td><input type="button" id="addItem" value="+"/></td></tr>');
			} else{
				$("#itemTable tr:last td:last").before('<td style="width: 50%"><input type="button" class="removeItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 80%" value="" maxlength="33"/></td>');
			}
		});
		
		$(document).on("click", ".removeItem", function(event){
			plusCount -= 1;
			var index = $("tr").index($(event.target).closest("tr"));
			$(event.target).closest("td").remove();
			$("tr:gt("+index+") td:nth-child(2n+1)").each(function(){
				$(this).closest("tr").prev().find("td:last").after($(this));
			});
			if(plusCount % 2 == 0){
				$("tr:last").remove();
			}
		});

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-330);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-330);
		});

	});
	
	function categoryRegister(){
		var items = [];
		var isEmpty = false;
		for(var i=0; i<plusCount+1; i++){
			var item = $("td input[type='text']:eq("+i+")").val();
			var pattern2 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 x
			if (pattern2.test(item)) {
				alert("세부사항에 특수문자를 사용할 수 없습니다.");
				return false;
			}
			items.push(item);
			if(item == ""){
				isEmpty = true;
			}
		}
		$("#items").val(items);
		$("#code").val($("#categoryCodeName").val());
		
		if($("#categoryName").val() == ""){
			alert("분류 이름을 입력해주세요.");
			return false;
		} else if(!nameChecked){
			alert("분류 이름 중복 확인을 체크해주세요.");
			return false;
		} else if(!codeChecked){
			alert("분류 코드 중복 확인을 체크해주세요.");
			return false;
		} else if($("#items").val() == ""){
			alert("세부사항을 입력해주세요.");
			return false;
		}
		else{
			if(!confirm('등록하겠습니까?')){
				return false;				
			}else{
				if(isEmpty){
					alert("빈 칸은 자동으로 제외하고 등록됩니다.");
				}
				$("#category").submit();
			}
		}
	}
	
	function cancelConfirm(){
		if(!confirm('취소하겠습니까?')){
				return false;				
		}else{
			location.href='/assetmanager/categoryList';
		}
	}
	
	function codeGen(){
		var name = $("#categoryName").val();
		var code;
		if(name.charCodeAt(0) >= 4352){
			code = toKorCho(name.charAt(0));
		} else{
			code = name.charAt(0);
		}
		if(name.length == 1){
			code += 'A';
		} else if(name.length > 1){
			if(name.charCodeAt(1) >= 0x3131){
				code += toKorCho(name.charAt(1));
			} else{
				code += name.charAt(1);
			}
		}
		if(name.length == 0){
			$("#categoryCodeName").prop("placeholder", "");
		}else{
			$("#categoryCodeName").prop("placeholder", code);
		}
	}
		
	function toKorCho(str) {
	    var cCho = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'];
	    var eCho = ['K', 'K', 'N', 'D', 'D', 'L', 'M', 'B', 'B', 'S', 'S', 'A', 'J', 'J', 'C', 'K', 'T', 'P', 'H'];
	    var hCho = {0x3131:'K', 0x3132:'K', 0x3134:'N', 0x3137:'D', 0x3138:'D', 0x3139:'L', 0x3141:'M', 0x3142:'B', 0x3143:'B', 0x3145:'S', 0x3146:'S', 0x3147:'A', 0x3148:'J', 0x3149:'J', 0x314a:'C', 0x314b:'K', 0x314c:'T', 0x314d:'P', 0x314e:'H'};
	    var cCode = str.charCodeAt(0) - 0xAC00; 
	    var jong = cCode % 28;
	    var jung = ((cCode - jong) / 28) % 21;
	    var cho = (((cCode - jong) / 28 ) - jung ) / 21;
	    if(cho == 11){
	    	if([0,1].includes(jung)){
	    		eCho[11] = 'A';
	    	} else if([2, 3, 6, 7, 12, 17].includes(jung)){
	    		eCho[11] = 'Y';
	    	} else if([4, 13, 18, 19].includes(jung)){
	    		eCho[11] = 'U';
	    	} else if(jung == 5){
	    		eCho[11] = 'E';
	    	} else if(jung == 8){
	    		eCho[11] = 'O';
	    	} else if([9, 10, 11, 14, 15, 16].includes(jung)){
	    		eCho[11] = 'W';
	    	} else if(jung == 20){
	    		eCho[11] = 'I';
	    	}
	    }
	    if(cCode < 0){
	    	return hCho[str.charCodeAt(0)];
	    } else{
	    	return eCho[cho];
	    }
	}
	
	function alphabetOnly(){
		var val = $("#categoryCodeName").val();
		var ch = val.slice(-1);
		if( !(ch.charCodeAt(0)>=65 && ch.charCodeAt(0)<=90) && !(ch.charCodeAt(0)>=48 && ch.charCodeAt(0)<=57) && !(ch.charCodeAt(0)>=97 && ch.charCodeAt(0)<=122) ){
			$("#categoryCodeName").val(val.slice(0,-1));
		} else if(ch.charCodeAt(0)>=97 && ch.charCodeAt(0)<=122){
			$("#categoryCodeName").val(val.slice(0,-1) + String.fromCharCode(ch.charCodeAt(0)-32));
		}
	}
	
	function nameCheck() {
		var name = $('#categoryName').val();
		$.ajax({
			"type" : "POST",
			"url" : "checkName",
			"dataType" : "text",
			"data" : {
				name : name
			},
			"success" : function(message) {
				if (message == '0'){
					alert("사용 가능한 이름입니다.");
					nameChecked = true;
					$("#categoryName").css("background", "lightgray").prop("readonly", true);
				} else if (message == '1') {
					alert("중복된 이름입니다.");
				}
			},
			"error" : function(request, status, error) {
				alert("code:" + request.status + "\nmessage:"
						+ request.responseText + "\nerror:" + error);
			}
		});
	}
		
	function codeCheck() {
		var code = $('#categoryCodeName').val();
		if(code == ""){
			code = $('#categoryCodeName').prop("placeholder");
			$("#categoryCodeName").val(code);
		}
		$.ajax({
			"type" : "POST",
			"url" : "checkCode",
			"dataType" : "text",
			"data" : {
				code : code
			},
			"success" : function(message) {
				if (message == '0'){
					alert("사용 가능한 코드입니다.");
					codeChecked = true;
					$("#categoryCodeName").css("background", "lightgray").prop("readonly", true);
				} else if (message == '1') {
					alert("중복된 코드입니다.");
				}
			},
			"error" : function(request, status, error) {
				alert("code:" + request.status + "\nmessage:"
						+ request.responseText + "\nerror:" + error);
			}
		});

	}
	
</script>

<style>
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
					<font size="6px"><b>분류 등록</b></font>
				</h1>
				<div style="margin-bottom: 10px">
					<div style="float: left; display:inline-block;">
						<form id="category" action="categoryRegisterSend" method="post">
							분류 이름: <input type="text" id="categoryName" name="categoryName" maxlength="33" onkeyup="codeGen()"/>
							<input type="button" class="btn" onclick="nameCheck();" value="중복 검사"/>
							<input type="hidden" id="items" name="items"/>
							<input type="hidden" id="code" name="code"/>
						</form>
					</div>
					<div style="float: right; display:inline-block;">
						<form id="categoryCode">
							분류 식별 코드: <input type="text" id="categoryCodeName" name="categoryCodeName" maxlength="2" onkeyup="alphabetOnly();"/>
							<input type="button" class="btn" onclick="codeCheck();" value="중복 검사"/>
						</form>
					</div>
				</div>
				<br><br>
				<div class="table-responsive">
					<table class="table table-striped" style="text-align: left; margin-top: 10px" id="itemTable" border="1">
						<tr>
							<td style="width: 50%">
								<input type="button" class="removeItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" style="width: 80%" maxlength="33"/>
							</td>
							<td style="width: 50%"><input type="button" id="addItem" value="+"/></td>
						</tr>
					</table>
				</div>
				<div style="display: flex; float: right; margin-top: 10px">
					<input type="button" id="button" class="btn btn-lg btn-primary" onclick="categoryRegister();" value="등록"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="button" class="btn btn-lg btn-primary" onclick="cancelConfirm();" value="취소"/>
				</div>
			</div>
		</div>
	</div>
</body>
