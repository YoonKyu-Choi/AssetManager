<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>이에스이 자산관리시스템</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/css/dashboard.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		$("#uploadImage").on("change",handleImgFileSelect);
	});
	
	var counts = 0;
	function getCategoryDetailItem(){
		var plusCount = 1;
		$.ajax({
			"type":"POST",
			"url":"getCategoryDetailItem",
			"dataType":"text",
			"data":{
				assetCategory : $("#assetCategory option:selected").val()
			},
			"beforeSend" : function(b){
				$("#assetDetailTable tr:gt(0)").remove();
			},
			"success" : function(a){
				a = a.split("\"},{\"assetCategory\":null,\"assetItem\":\"");
				a[0] = a[0].split("{\"assetCategory\":null,\"assetItem\":\"")[1];
				a[a.length-1] = a[a.length-1].split("\"}]")[0];
				
				counts = a.length;
				for(var i=0;i<a.length;i++){
					if(plusCount % 2 == 1){
						$("#assetDetailTable tr:last").after('<tr><th><input type="text" id="assetItem" name="assetItem" value="'+a[i]+'" readonly></th><th><input type="text" id="assetItemDetail" name="assetItemDetail"></th></tr>');
					} else{
						$("#assetDetailTable tr:last th:last").after('<th><input type="text" id="assetItem" name="assetItem" value="'+a[i]+'" readonly></th><th><input type="text" id="assetItemDetail" name="assetItemDetail"></th>');
					}
						
						plusCount += 1;
				}
				console.log(items);
			},
			"error":function(){
				alert("에러");
			}					
		});
	}
	
	function submitCheck() {
		if (!confirm("등록하시겠습니까?")) {
			return false;
		} else {
		var items = [];
		var itemsDetail=[];
		for(var i=0;i<counts;i++){
			items.push($("th input[id='assetItem']:eq("+i+")").val());
			itemsDetail.push($("th input[id='assetItemDetail']:eq("+i+")").val());			
		}
		$("#items").val(items);
		$("#itemsDetail").val(itemsDetail);
		
		if($("#assetPurchaseDate").val()==''){
			$("#assetPurchaseDate").val("9999-01-01");
		}
		if($("#assetPurchasePrice").val()==''){
			$("#assetPurchasePrice").val("미입력");
		}
		if($("#assetPurchaseShop").val()==''){
			$("#assetPurchaseShop").val("미입력");
		}
		
		if ($("#assetCategory").val() == '0') {
			alert("분류를 선택해주세요.");			
			return false;
		} else if($("#assetStatus").val()=='0'){
			alert("자산 상태를 선택해주세요.");
			return false;
		} else if($("#assetOutStatus").val()=='0'){
			alert("자산 반출 상태를 선택해주세요.");
			return false;
		} else if($("#assetMaker").val()==''){
			alert("제조사를 입력해주세요.");
			$("#assetMaker").focus();
			return false;
		} else if($("#assetModel").val()==''){
			alert("모델명을 입력해주세요.");
			$("#assetModel").focus();
			return false;
		} else if($("#assetUsage").val()=='0'){
			alert("용도를 선택해주세요.");
			return false;
		} else if($("#assetManager").val()=='0'){
			alert("책임자를 선택해주세요.");
			return false;
		} else if($("#assetLocation").val()=='0'){
			alert("사용 위치를 선택해주세요.");
			return false;
		} else {
			/* 세부사항 유효성 체크 하다가 만거 이러면 체크는 하는데 submit 되는듯 ?
			for(var i=0;i<counts-1;i++){
				if($("th input[id='assetItemDetail']:eq("+i+")").val() ==''){
					alert("세부사항 내용을 입력해주세요.");
					return false;
				}
			}
			*/
				$("#registerSend").submit();
			}
		}
	};

	$(function(){
		var isAdmin = "<%=session.getAttribute("isAdmin")%>";
		if (isAdmin == "TRUE") {
			$(".admin").show();
		}
	});

	$(function() {
		var left = $('#rank').height();
		var right = $('.dropdown').height();
		$('.dropdown').height(left);
	});

	function byteCheck(obj, maxByte) {

		var str = obj.value;
		var strLength = str.length;

		var rbyte = 0;
		var rlen = 0;
		var oneChar = "";
		var str2 = "";

		for (var i = 0; i < strLength; i++) {
			oneChar = str.charAt(i);
			if (escape(oneChar).length > 4) {
				rbyte += 3;
			} else {
				rbyte++;
			}
			if (rbyte <= maxByte) {
				rlen = i + 1;
			}
		}

		if (rbyte > maxByte) {
			alert("글자를 초과했습니다.");
			str2 = str.substr(0, rlen);
			obj.value = str2;
			byteCheck(obj, maxByte);
		} else {
			document.getElementById('byteInfo').innerText = rbyte;
		}
	}

	$(function() {
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight - 250);
		$(window).resize(function() {
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight - 250);
		});
	});

	var selectedFile;

	function handleImgFileSelect(e) {

		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 가능합니다.");
				return false;
			}

			selectedFile = f;

			var reader = new FileReader();
			reader.onload = function(e) {
				$("#img").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});

	}
</script>
<style>
.form-controlmin {
	display: block;
	width: 60%;
	height: 32px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

.img_wrap {
	margin-top: 50px;
}

.img_wrap img {
	max-width: 100%;
}
</style>
</head>

<body>
	<div style="text-align: center;" id="main">
		<form class="form" action="/assetmanager/assetRegisterSend" id="registerSend" method="POST" enctype="multipart/form-data">
			<h2 style="text-align: center">
				<b>자산 관리 > 자산 정보 입력</b>
			</h2>
			<div class="table-responsive" style="overflow: scroll;">
				자산 공통사항
				<div style="display: flex; margin-left: 90px">
					<input type="hidden" value="<%=session.getAttribute("Id")%>" name="assetUser" id="assetUser"/>
					<table class="table table-striped" id="assetTable">
						<tr>
							<th>분류</th>
							<th><select class="form-controlmin dropdown" id="assetCategory" name="assetCategory" onchange="getCategoryDetailItem();">
									<option value="0" selected>분류를 선택하세요.</option>
									<c:forEach items="${categoryList}" var="category">
										<option value="${category}">${category}</option>
									</c:forEach>
							</select></th>
							<th>이름</th>
							<th><%=session.getAttribute("Id")%></th>
						</tr>
						<tr>
							<th>관리 번호</th>
							<th>※ 자동 생성됩니다.</th>
							<th>시리얼 번호</th>
							<th><input type="text" id="assetSerial" name="assetSerial"></th>
						</tr>
						<tr>
							<th>자산 상태</th>
							<th><select class="form-controlmin dropdown" id="assetStatus" name="assetStatus">
									<option value="0">상태를 선택하세요.</option>
									<option value="사용 중">사용 중</option>
									<option value="사용 가능">사용 가능</option>
									<option value="사용 불가">사용 불가</option>
									<option value="폐기 대기">폐기 대기</option>
									<option value="폐기">폐기</option>
							</select></th>
							<th>자산 반출 상태</th>
							<th><select class="form-controlmin dropdown" id="assetOutStatus" name="assetOutStatus">
									<option value="0">반출 상태를 선택하세요.</option>
									<option value="반출 X">반출 X</option>
									<option value="반출 중">반출 중</option>
									<option value="수리 중">수리 중</option>
									<option value="고장">고장</option>
							</select></th>
						</tr>
						<tr>
							<th>구입일</th>
							<th><input type="text" id="assetPurchaseDate" name="assetPurchaseDate"></th>
							<th>제조사</th>
							<th><input type="text" id="assetMaker" name="assetMaker"></th>
						</tr>
						<tr>
							<th>구입가</th>
							<th><input type="text" id="assetPurchasePrice" name="assetPurchasePrice"></th>
							<th>모델명</th>
							<th><input type="text" id="assetModel" name="assetModel"></th>
						</tr>
						<tr>
							<th>구입처</th>
							<th><input type="text" id="assetPurchaseShop" name="assetPurchaseShop"></th>
							<th>용도</th>
							<th><select class="form-controlmin dropdown" id="assetUsage" name="assetUsage">
									<option value="0">용도를 선택하세요.</option>
									<option value="개발용">개발용</option>
									<option value="업무용">업무용</option>
							</select></th>
						</tr>
						<tr>
							<th>책임자</th>
							<th><select class="form-controlmin dropdown" name="assetManager" id="assetManager">
									<option value="0">책임자를 선택하세요.</option>
									<c:forEach items="${employeeNameList}" var="employee">
										<option value="${employee}">${employee}</option>
									</c:forEach>
							</select></th>
							<th>사용 위치</th>
							<th><select class="form-controlmin dropdown" id="assetLocation" name="assetLocation">
									<option value="0">위치를 선택하세요.</option>
									<option value="4층">4층</option>
									<option value="5층">5층</option>
							</select></th>
						</tr>
					</table>
				</div>
				자산 세부 사항
				<div style="display: flex; margin-left: 90px">
					<table class="table table-striped" id="assetDetailTable">
						<tr>
							<th>항목</th>
							<th>내용</th>
							<th>항목</th>
							<th>내용</th>
						</tr>
					</table>
					<input type="hidden" id="items" name="items">
					 <input type="hidden" id="itemsDetail" name="itemsDetail">
				</div>
				<div style="display: flex; margin-left: 90px">
					<h4>파일 업로드</h4>
					<input type="file" id="uploadImage" name="uploadImage">
				</div>
				<div class="img_wrap" style="display: flex; margin-left: 90px">
					<img id="img" />
				</div>

				<div>
					<textArea name="assetComment" id="assetComment" style="resize: none; width: 600px; height: 200px; margin-top: 50px;" rows="10" cols="40" onKeyUp="javascript:byteCheck(this,'999')"></textArea>
					<span id="byteInfo">0</span> / 999 Byte
				</div>
			</div>
		</form>
		<div style="display: flex; width: 300px; margin-left: 90px;">
			<input type="button" class="btn btn-lg btn-primary btn-block" id="registerBtn" onclick="submitCheck();" value="자산 등록" /> 
			<label style="opacity: 0; margin: 10px"></label>
			<input type="button" class="btn btn-lg btn-primary btn-block" onclick="location.href='/assetmanager/assetList'" value="취소" />

		</div>
	</div>
</body>
