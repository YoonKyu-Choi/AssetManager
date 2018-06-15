<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(function() {
		$("#assetUser").val("${model['assetVO']['assetUser']}").prop("selected", true);
		$("#assetStatus").val("${model['assetVO']['assetStatus']}").prop("selected", true);
		$("#assetOutStatus").val("${model['assetVO']['assetOutStatus']}").prop("selected", true);
		$("#assetUsage").val("${model['assetVO']['assetUsage']}").prop("selected", true);
		$("#assetManager").val("${model['assetVO']['assetManager']}").prop("selected", true);
		$("#assetLocation").val("${model['assetVO']['assetLocation']}").prop("selected", true);
		$("#uploadImage").on("change",handleImgFileSelect);

		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-350);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-300);
		});
	});
	
	
			
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
	}
	
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
	}
	
	function cancelConfirm() {
		if (!confirm("취소하겠습니까?")) {
			return false;
		} else {
			$("#idForm").submit();
		}
	}
	
	function modifyConfirm() {
		
	}
	
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
			} else if($("#assetItemDetail").val()==''){
				alert("항목 내용을 입력해주세요.");
				return false;
			}else {
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
    }
    
    function fn_press_han(obj)
    {
        //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
        || event.keyCode == 46 ){
            return;
        }
        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
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
	  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}

</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<form class="form" action="/assetmanager/assetModifySend"
					id="modifySend" method="POST" enctype="multipart/form-data">
					<h1 class="page-header">
						<b>자산 관리 > ${model['assetVO']['assetId']}의 자산 정보 수정</b>
					</h1>
					<div class="table-responsive" id="inputDiv"
						style="overflow: scroll; height: 500px;">
						<h3>자산 공통사항</h3>
						<table class="table table-striped" id="assetTable">
							<tr>
								<th>분류</th>
								<th>${model['assetVO']['assetCategory']}</th>
								<th>이름</th>
								<th>
									<select class="form-controlmin dropdown" name="assetUser" id="assetUser">
										<option value="0">사용자를 선택하세요.</option>
										<c:forEach items="${model['employeeNameList']}" var="employee">
											<option value="${employee}">${employee}</option>
										</c:forEach>
									</select>
								</th>
							</tr>
								<input type="hidden" id="employeeId" name="employeeId" value='<%=session.getAttribute("Id")%>'>
								<input type="hidden" id="assetCategory" name="assetCategory" value="${model['assetVO']['assetCategory']}">
								<!-- 
								<input type="hidden" id="assetUser" name="assetUser" value="${requestScope.assetVO.assetUser}">
								 -->
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
								<th><input type="text" id="assetPurchaseDate" name="assetPurchaseDate" value="${model['assetVO']['assetPurchaseDate']}"></th>
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
						<h3>자산 세부사항</h3>
						<table class="table table-striped">
							<c:forEach items="${model['assetDetailList']}" varStatus="i" step="2" end="${model['dSize']}">
								<c:if test="${model['assetDetailList'][i.index+1]['assetItem'] !=null}">
									<tr>
										<th><input type="text" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index]['assetItem']}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index]['assetItemDetail']}"></th>
										<th><input type="text" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index+1]['assetItem']}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index+1]['assetItemDetail']}"></th>
									</tr>
								</c:if>
								<c:if test="${model['assetDetailList'][i.index+1]['assetItem'] ==null }">
									<tr>
										<th><input type="text" id="assetItem" name="assetItem" value="${model['assetDetailList'][i.index]['assetItem']}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${model['assetDetailList'][i.index]['assetItemDetail']}"></th>
										<th></th>
										<th></th>
									</tr>
								</c:if>
							</c:forEach>
						</table>
						<input type="hidden" id="items" name="items">
					 	<input type="hidden" id="itemsDetail" name="itemsDetail">
						<div>
							<h3>기존 영수증 사진</h3><br>
							<img style="width: 400px; height: 400px;" src="${pageContext.request.contextPath}/resources/${model['assetVO']['assetReceiptUrl']}">
							<h4>영수증 수정</h4>
							<input type="file" id="uploadImage" name="uploadImage">
						</div>
						<div class="img_wrap" style="display: flex;">
							<img id="img" />
						</div>
						<div style="margin-top:50px; margin-bottom:30px;">
						<h3>자산 코멘트</h3>
						<textArea name="assetComment" id="assetComment" style="resize: none; width: 600px; height: 200px" rows="10" cols="40" onKeyUp="javascript:byteCheck(this,'999')">${model['assetVO']['assetComment']}</textArea>
						<span id="byteInfo">수정 시 측정</span> / 999 Byte
						</div>
					</div>
				</form>
			</div>
			<form id="assetForm" action="assetDetail" method="POST">
						<input type="hidden" name="assetId" value="${model['assetVO']['assetId']}" />
					</form>
					<input type="button" class="btn btn-lg btn-primary" onclick="location.href='/assetmanager/assetList'" value="목록" />
					<div style="display: flex; float: right">
						<button class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="submitCheck();">수정</button>
						<button class="btn btn-lg btn-primary" id="delbtn" onclick="cancelConfirm();">취소</button>
						<div class="mask"></div>
					</div>
			</div>
		</div>
</body>
