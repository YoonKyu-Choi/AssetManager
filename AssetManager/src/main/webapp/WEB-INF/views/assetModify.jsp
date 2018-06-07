<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(
			function() {
				$("#assetStatus").val("${requestScope.assetVO.assetStatus}").prop("selected", true);
				$("#assetOutStatus").val("${requestScope.assetVO.assetOutStatus}").prop("selected", true);
				$("#assetUsage").val("${requestScope.assetVO.assetUsage}").prop("selected", true);
				$("#assetManager").val("${requestScope.assetVO.assetManager}").prop("selected", true);
				$("#assetLocation").val("${requestScope.assetVO.assetLocation}").prop("selected", true);
				$("#uploadImage").on("change",handleImgFileSelect);
		}
	)
			
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
			alert(${dSize});
			var counts = ${dSize};
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
						<b>자산 관리 > ${requestScope.assetVO.assetId}의 자산 정보 수정</b>
					</h1>
					<div class="table-responsive" id="inputDiv"
						style="overflow: scroll; height: 500px;">
						<h3>자산 공통사항</h3>
						<table class="table table-striped" id="assetTable">
							<tr>
								<th>분류</th>
								<th>${requestScope.assetVO.assetCategory}</th>
								<th>이름</th>
								<th>${requestScope.assetVO.assetUser}</th>
							</tr>
								<input type="hidden" id="assetCategory" name="assetCategory" value="${requestScope.assetVO.assetCategory}">
								<input type="hidden" id="assetUser" name="assetUser" value="${requestScope.assetVO.assetUser}">
							<tr>
								<th>관리 번호</th>
								<th>${requestScope.assetVO.assetId}</th>
								<th>시리얼 번호</th>
								<th><input type="text" id="assetSerial" name="assetSerial" value="${requestScope.assetVO.assetSerial}"></th>
							</tr>
								<input type="hidden" id="assetId" name="assetId" value="${requestScope.assetVO.assetId}">
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
										<option value="없음">반출 X</option>
										<option value="반출 중">반출 중</option>
										<option value="수리 중">수리 중</option>
										<option value="고장">고장</option>
								</select></th>
							</tr>
							<tr>
								<th>구입일</th>
								<th><input type="text" id="assetPurchaseDate" name="assetPurchaseDate" value="${requestScope.assetVO.assetPurchaseDate}"></th>
								<th>제조사</th>
								<th><input type="text" id="assetMaker" name="assetMaker" value="${requestScope.assetVO.assetMaker}"></th>
							</tr>
							<tr>
								<th>구입가</th>
								<th><input type="text" id="assetPurchasePrice" name="assetPurchasePrice" value="${requestScope.assetVO.assetPurchasePrice}"></th>
								<th>모델명</th>
								<th><input type="text" id="assetModel" name="assetModel" value="${requestScope.assetVO.assetModel}"></th>
							</tr>
							<tr>
								<th>구입처</th>
								<th><input type="text" id="assetPurchaseShop" name="assetPurchaseShop" value="${requestScope.assetVO.assetPurchaseShop}"></th>
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
						<h3>자산 세부사항</h3>
						<table class="table table-striped">
							<c:forEach items="${assetDetailList}" varStatus="i" step="2" end="${dSize}">
								<c:if test="${assetDetailList[i.index+1].assetItem !=null}">
									<tr>
										<th><input type="text" id="assetItem" name="assetItem" value="${assetDetailList[i.index].assetItem}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${assetDetailList[i.index].assetItemDetail}"></th>
										<th><input type="text" id="assetItem" name="assetItem" value="${assetDetailList[i.index+1].assetItem}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${assetDetailList[i.index+1].assetItemDetail}"></th>
									</tr>
								</c:if>
								<c:if test="${assetDetailList[i.index+1].assetItem ==null }">
									<tr>
										<th><input type="text" id="assetItem" name="assetItem" value="${assetDetailList[i.index].assetItem}" readonly></th>
										<th><input type="text" id="assetItemDetail" name="assetItemDetail" value="${assetDetailList[i.index].assetItemDetail}"></th>
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
							<img style="width: 400px; height: 400px;" src="${pageContext.request.contextPath}/resources/${requestScope.assetVO.assetReceiptUrl}">
							<h4>영수증 수정</h4>
							<input type="file" id="uploadImage" name="uploadImage">
						</div>
						<div class="img_wrap" style="display: flex;">
							<img id="img" />
						</div>
						<div style="margin-top:50px; margin-bottom:30px;">
						<h3>자산 코멘트</h3>
						<textArea name="assetComment" id="assetComment" style="resize: none; width: 600px; height: 200px" rows="10" cols="40" onKeyUp="javascript:byteCheck(this,'999')">${requestScope.assetVO.assetComment}</textArea>
						<span id="byteInfo">수정 시 측정</span> / 999 Byte
						</div>
					</div>
				</form>
			</div>
			<form id="assetForm" action="assetDetail" method="POST">
						<input type="hidden" name="assetId" value="${requestScope.assetVO.assetId}" />
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
