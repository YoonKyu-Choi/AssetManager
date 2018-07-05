<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-menu.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/jquery-ui-1-12-1.min.css" rel="stylesheet"/>  
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui-1-12-1.min.js"></script>

<script>

	$(function(){
		// 사이드바 활성화
		$("#asstLink").prop("class", "active");
		
		// 기존 설정
		$("#assetUser").val("${sessionScope.Id}").prop("selected", true).css("background-color","lightgray");
		$("#assetStatus").val("${model['assetVO']['assetStatus']}").prop("selected", true);
		$("#assetOutStatus").val("${model['assetVO']['assetOutStatus']}").prop("selected", true).css("background-color","lightgray");
		$("#assetOutStatus").prop("disabled", true);
		$("#assetUsage").val("${model['assetVO']['assetUsage']}").prop("selected", true);
		$("#assetManager").val("${model['assetVO']['assetManager']}").prop("selected", true);
		$("#assetLocation").val("${model['assetVO']['assetLocation']}").prop("selected", true);
		$("#uploadImage").on("change",handleImgFileSelect);
		var windowHeight = window.innerHeight;

		if($("#assetStatus option:selected").val() == "사용 가능"
				|| $("#assetStatus option:selected").val() == "사용 불가"
				|| $("#assetStatus option:selected").val() == "폐기"){
			$("#assetUser").prepend("<option value='NoUser'>사용자 없음</option>");
			$("#assetUser").val("NoUser").prop("selected",true);
			$("#assetUser").prop("disabled",true).css("background-color","lightgray"); 
		};
		
		if("${model['assetVO']['assetPurchaseDate']}" == "9997"){
			$("#assetPurchaseDate").val("미입력");
		};
		
		// 반응성 윈도우 사이즈	
		$(".table-responsive").css("height", windowHeight-300);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-300);
		});

		// 달력
		$("#assetPurchaseDate").datepicker({
			dateFormat : "yy-mm-dd",
			dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			changeMonth: true, 
			changeYear: true,
			nextText: '다음 달',
			prevText: '이전 달' 
       });
	
	});
		
	// 등록, 수정 시 자산 상태를 사용 가능,불가능,폐기으로 했을 경우 -> 이름 disabled, 사용자없음 
	function changeFunc(){
		var count = 0; // 사용자가 없는 자산 상태가 아닌것 끼리 변경 할 때 오류 방지 
		if($("#assetStatus option:selected").val() == "사용 가능"
				|| $("#assetStatus option:selected").val() == "사용 불가"
				|| $("#assetStatus option:selected").val() == "폐기"){
			$("#assetUser").prepend("<option value='NoUser'>사용자 없음</option>");
			$("#assetUser").val("NoUser").prop("selected",true);
			$("#assetUser").prop("disabled",true).css("background-color","lightgray"); 
		} else{
			if($("#assetUser").val()=="NoUser"){
				$("#assetUser option:first").remove();
			}
			if("${model['assetVO']['assetUser']}" == "NoUser"
					|| "${model['assetVO']['assetUser']}" == ""
					|| "${model['assetVO']['assetUser']}" == null){
				$("#assetUser option:eq[0]").prop("selected", true);
			}else{
				$("#assetUser").val("${model['assetVO']['assetUser']}").prop("selected", true);
			}
			$("#assetUser").prop("disabled",true).css("background-color","lightgray"); 
		}
	};
	
	function handleImgFileSelect(e){
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.");
				return false;
			}			
			
		selectedFile = f;
			
		var reader = new FileReader();
		reader.onload = function(e){
			$("#img").attr("src",e.target.result);
		}
		reader.readAsDataURL(f);
		
		});
	};
	
	function byteCheck(obj,maxByte){
		
		var str = obj.value;
		var strLength = str.length;
		var rbyte = 0;
		var rlen = 0; 
		var oneChar = "";
		var str2="";
		
		for(var i=0;i<strLength;i++){
			oneChar = str.charAt(i);
			if(escape(oneChar).length >4){
				rbyte += 3;
			} else {
				rbyte++;
			}
			if(rbyte <= maxByte){
				rlen = i+1;
			}
		}
		if(rbyte>maxByte){
			alert("글자를 초과했습니다.");
			str2 = str.substr(0,rlen);
			obj.value = str2;
			byteCheck(obj,maxByte);
		}else {
			document.getElementById('byteInfo').innerText = rbyte;
		}
	};
	
	function cancelConfirm() {
		if (!confirm("취소하겠습니까?")) {
			return false;
		} else {
			$("#cancelForm").submit();
		}
	};
	
	function submitCheck() {
		if (!confirm("수정하겠습니까?")) {
			return false;
		} else {
			var counts = ${model['dSize']};
			var items = [];
			var itemsDetail=[];
			for(var i=0;i<counts;i++){
				items.push($("th input[id='assetItem']:eq("+i+")").val());
				itemsDetail.push($("th input[id='assetItemDetail']:eq("+i+")").val());			
			}
			$("#items").val(items);
			$("#itemsDetail").val(itemsDetail);
			
			if ($("#assetCategory").val() == '0') {
				alert("분류를 선택해주세요.");
				$("#assetCategory").focus();
						return false;
			} else if($("#assetUser").val()=='0'){
				alert("이름을 선택해주세요.");
				$("#assetUser").focus();
				return false;
			} else if($("#assetSerial").val()==''){
				alert("시리얼 번호를 입력해주세요.");
				$("#assetSerial").focus();
				return false;
			} else if($("#assetStatus").val()=='0'){
				alert("자산 상태를 선택해주세요.");
				$("#assetStatus").focus();
				return false;
			} else if($("#assetOutStatus").val()=='0'){
				alert("자산 반출 상태를 선택해주세요.");
				$("#assetOutStatus").focus();
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
				$("#assetUsage").focus();
				return false;
			} else if($("#assetManager").val()=='0'){
				alert("책임자를 선택해주세요.");
				$("#assetManager").focus();
				return false;
			} else if($("#assetLocation").val()=='0'){
				alert("사용 위치를 선택해주세요.");
				$("#assetLocation").focus();
				return false;
			} else {
				// 얘네는 not null이 아니기 때문에 미입력 시 default값 지정
				if($("#assetPurchaseDate").val()==''){
					$("#assetPurchaseDate").val("9999-01-01");
				}
				if($("#assetPurchasePrice").val()==''){
					$("#assetPurchasePrice").val("미입력");
				}
				if($("#assetPurchaseShop").val()==''){
					$("#assetPurchaseShop").val("미입력");
				}
				
				// 세부사항 유효성 검사
				for(var i=0;i<counts;i++){
					if($("th input[id='assetItemDetail']:eq("+i+")").val() ==''){
						alert("세부사항을 전부 입력해주세요.");
						return false;
					}
				}
				if(($("#assetUser").val() == "${model['assetVO']['assetUser']}")
					&& ($("#assetSerial").val() == "${model['assetVO']['assetSerial']}")
					&& ($("#assetStatus").val() == "${model['assetVO']['assetStatus']}")
					&& ($("#assetOutStatus").val() == "${model['assetVO']['assetOutStatus']}")
					&& ($("#assetPurchaseDate").val() == "${model['assetVO']['assetPurchaseDate']}")
					&& ($("#assetMaker").val() == "${model['assetVO']['assetMaker']}")
					&& ($("#assetPurchasePrice").val() == "${model['assetVO']['assetPurchasePrice']}")
					&& ($("#assetModel").val() == "${model['assetVO']['assetModel']}")
					&& ($("#assetPurchaseShop").val() == "${model['assetVO']['assetPurchaseShop']}")
					&& ($("#assetUsage").val() == "${model['assetVO']['assetUsage']}")
					&& ($("#assetManager").val() == "${model['assetVO']['assetManager']}")
					&& ($("#assetLocation").val() == "${model['assetVO']['assetLocation']}")
					&& ($("#assetComment").val() == "${model['assetVO']['assetComment']}")){
					alert("수정 사항이 없습니다.");
					return false;
				}
				$("#assetOutStatus").prop("disabled", false);
				$("#assetUser").prop("disabled",false);
				$("#modifySend").submit();
			}
		}
	};
	
	// 입력 키 숫자/한글 판정
	function fn_press(event, type) {
        if(type == "numbers") {
            if(event.keyCode < 48 || event.keyCode > 57){
                return false;
            }
        }
    };
    
    function fn_press_han(obj){
        //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 ){
            return;
        }
        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
    };
    
</script>

<style>
	.form-controlmin {
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
	
	th:not(".ui-datepicker-week-end")
	th {
		height: 50px;
		width: 25%;
		vertical-align: middle;
	}
	th:nth-child(4n+1), th:nth-child(4n+3){
		font-weight: bold;
	}
	th:nth-child(4n+2), th:nth-child(4n+4){
		font-weight: normal;
	}
	hr {
		height: 1px;
		width: 100%;
		border: 1;
		background-color: gray;
		background-image: linear-gradient(to right, #ccc, #333, #ccc);
	}
	#button, #registerBtn{
		color: black;
		border-color: #999;
		background-color: #aaa;
		font-weight: bold;
	}
	#button:hover, #registerBtn:hover {
		color: white;
		background-color: #333;
	}
	.dropdown, input:not([type="button"]){
		width: 200px
	}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="form" action="/assetmanager/assetModifySend" id="modifySend" method="POST" enctype="multipart/form-data">
					<h1 class="page-header">
						<font size="6px"><b>자산 정보 수정</b></font>
					</h1>
					<div class="table-responsive" id="inputDiv"	style="overflow: scroll; height: 500px;">
						<h3>자산 공통사항</h3> 
						<table class="table table-striped" id="assetTable">
							<tr>
								<th>분류</th>
								<th>${model['assetVO']['assetCategory']}</th>
								<c:if test="${sessionScope.isAdmin != 'TRUE' }">
									<th>사용자 (변경불가)</th>
									<th>
										<select class="form-controlmin dropdown" name="assetUser" id="assetUser" disabled>
											<option value="0">책임자를 선택하세요.</option>
											<c:forEach items="${model['employeeNameList']}" var="employee">
												<option value="${employee.employee_id}">${employee.employee_name} (${employee.employee_department_string})</option>
											</c:forEach>
										</select>
									</th>
									</c:if>
									<c:if test="${sessionScope.isAdmin == 'TRUE' }">
									<th>사용자</th>
									<th>
										<select class="form-controlmin dropdown" name="assetUser" id="assetUser">
											<option value="0">책임자를 선택하세요.</option>
											<c:forEach items="${model['employeeNameList']}" var="employee">
												<option value="${employee.employee_id}">${employee.employee_name} (${employee.employee_department_string})</option>
											</c:forEach>
										</select>
									</th>
									</c:if>
							</tr>
							<input type="hidden" id="employeeId" name="employeeId" value='<%=session.getAttribute("Id")%>'>
							<input type="hidden" id="assetCategory" name="assetCategory" value="${model['assetVO']['assetCategory']}">
							<tr>
								<th>관리 번호</th>
								<th>${model['assetVO']['assetId']}</th>
								<th>시리얼 번호</th>
								<th><input type="text" id="assetSerial" name="assetSerial" value="${model['assetVO']['assetSerial']}"></th>
							</tr>
								<input type="hidden" id="assetId" name="assetId" value="${model['assetVO']['assetId']}">
								<input type="hidden" id="beforeUser" name="beforeUser" value="${model['beforeUser']}">
							<tr>
								<th>자산 상태</th>
								<th><select class="form-controlmin dropdown" id="assetStatus" name="assetStatus" onchange="changeFunc();">
										<option value="0">상태를 선택하세요.</option>
										<option value="사용 중">사용 중</option>
										<option value="사용 가능">사용 가능</option>
										<option value="사용 불가">사용 불가</option>
										<option value="폐기 대기">폐기 대기</option>
										<c:if test="${sessionScope.isAdmin == 'TRUE' }">
										<option value="폐기">폐기</option>
										</c:if>
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
								<th><input type="text" id="assetPurchaseDate" name="assetPurchaseDate" value="${model['assetVO']['assetPurchaseDate']}" readonly></th>
								<th>제조사</th>
								<th><input type="text" id="assetMaker" name="assetMaker" value="${model['assetVO']['assetMaker']}"></th>
							</tr>
							<tr>
								<th>구입가(원)</th>
								<th><input type="text" id="assetPurchasePrice" name="assetPurchasePrice" maxlength="10" onkeypress="return fn_press(event, 'numbers');" onkeydown="fn_press_han(this);" value="${model['assetVO']['assetPurchasePrice']}"></th>
								<th>모델명</th>
								<th><input type="text" id="assetModel" name="assetModel" value="${model['assetVO']['assetModel']}"></th>
							</tr>
							<tr>
								<th>구입처</th>
								<th><input type="text" id="assetPurchaseShop" name="assetPurchaseShop" value="${model['assetVO']['assetPurchaseShop']}"></th>
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
										<c:forEach items="${model['employeeNameList']}" var="employee">
											<option value="${employee.employee_id}">${employee.employee_name} (${employee.employee_department_string})</option>
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
						<hr>
						<h3>자산 세부사항</h3>
						<table class="table table-striped">
							<c:forEach items="${model['assetDetailList']}" varStatus="i" step="2" end="${model['dSize']}">
								<c:if test="${model['assetDetailList'][i.index+1]['assetItem'] !=null}">
									<input type="hidden" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index]['assetItem']}">
									<input type="hidden" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index+1]['assetItem']}">
									<tr>
										<th>${model['assetDetailList'][i.index]['assetItem']}</th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index]['assetItemDetail']}"></th>
										<th>${model['assetDetailList'][i.index+1]['assetItem']}</th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index+1]['assetItemDetail']}"></th>
									</tr>
								</c:if>
								<c:if test="${model['assetDetailList'][i.index+1]['assetItem'] ==null }">
									<input type="hidden" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index]['assetItem']}">
									<tr>
										<th>${model['assetDetailList'][i.index]['assetItem']}</th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index]['assetItemDetail']}"></th>
										<th></th>
										<th></th>
									</tr>
								</c:if>
							</c:forEach>
						</table>
						<input type="hidden" id="items" name="items">
					 	<input type="hidden" id="itemsDetail" name="itemsDetail">
					 	<hr>
						<div>
							<c:if test="${assetData['assetVO']['assetReceiptUrl'] !=null && assetData['assetVO']['assetReceiptUrl'] != ''}">
								<h3>기존 영수증 사진</h3><br>
								<img style="width: 400px; height: 400px;" src="${pageContext.request.contextPath}/resources/${model['assetVO']['assetReceiptUrl']}">
							</c:if>
							<c:if test="${assetData['assetVO']['assetReceiptUrl'] ==null || assetData['assetVO']['assetReceiptUrl'] == ''}">	
								<h3>영수증 사진이 없습니다.</h3>
							</c:if>
							<h4>영수증 등록/수정</h4>
							<input type="file" id="uploadImage" name="uploadImage">
						</div>
						<div class="img_wrap" style="display: flex;">
							<img id="img" />
						</div>
						<hr>
						<div style="margin-top:50px; margin-bottom:30px;">
						<h3>자산 코멘트</h3>
						<textArea name="assetComment" id="assetComment" style="resize: none; width: 600px; height: 200px" rows="10" cols="40" onKeyUp="javascript:byteCheck(this,'999')">${model['assetVO']['assetComment']}</textArea>
						<span id="byteInfo">수정 시 측정</span> / 999 Byte
						</div>
					</div>
				</form>
				<form id="cancelForm" action="assetDetail" method="POST">
					<input type="hidden" name="assetId" value="${model['assetVO']['assetId']}" />
				</form>
<!-- 			<input type="button" id="button" style="margin-top: 10px" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />	-->
				<div style="display: flex; float: right; margin-top: 10px">
					<button id="button" class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="submitCheck();">수정</button>
					<button id="button" class="btn btn-lg btn-primary" onclick="cancelConfirm();">취소</button>
					<div class="mask"></div>
				</div>
			</div>
		</div>
	</div>
</body>
