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
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet" />
	
<script>
	var itemSize = Number("<c:out value="${categoryData.itemSize}"/>");
	var plusCount = itemSize;
	var deleteItems = [];

	$(function(){
		// 사이드바 활성화
		$("#catgLink").prop("class", "active");
		
		// 세부사항 추가제거
		if(itemSize % 2 == 1){
			var index = Math.floor(itemSize/2);
			$("tr:eq("+index+") td:last").remove();
			$("tr:gt("+index+") td:nth-child(2n+1)").each(function(){
				$(this).closest("tr").prev().find("td:last").after($(this));
			});
			$("tr:last").remove();
		}
		
		$(document).on("click", "#addItem", function(){		// .click("") style로 바꾸지 말 것. deprecated됨.
			if(plusCount % 2 == 0){
				$("#itemTable tr:last td:last").before('<td style="width: 50%"><input type="button" class="removeItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 80%" value=""/></td>');
			} else if(plusCount % 2 == 1){
				$("#itemTable tr:last td:last").before('<td style="width: 50%"><input type="button" class="removeItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 80%" value=""/></td>');
				$("#itemTable tr:last td:last").remove();
				$("#itemTable tr:last").after('<tr><td><input type="button" id="addItem" value="+"/></td></tr>');
			}
			plusCount += 1;
		});
		
		$(document).on("click", ".deleteItem", function(event){
			if(!$(event.target).hasClass("deleteItemCancel")){
				$(event.target).closest("td").find("input:last").prop("readonly", true).css('background', 'gray');
				$(event.target).addClass("deleteItemCancel");
			} else{
				$(event.target).closest("td").find("input:last").prop("readonly", false).css('background', 'white');
				$(event.target).removeClass("deleteItemCancel");
			}
		});
	
		$(".removeItem").click(function(event){
			var index = $("tr").index($(event.target).closest("tr"));
			$(event.target).closest("td").remove();
			$("tr:gt("+index+") td:nth-child(2n+1)").each(function(){
				$(this).closest("tr").prev().find("td:last").after($(this));
			});
			if(plusCount % 2 == 0){
				$("tr:last").remove();
			}
			plusCount -= 1;
		});

		// 반응성 윈도우 사이즈
		var windowHeight = window.innerHeight;
		$(".table-responsive").css("height", windowHeight-350);
		$(window).resize(function(){
			windowHeight = $(window).height();
			$(".table-responsive").css("height", windowHeight-350);
		});

	});

	function categoryModify(){
		if (!confirm("이대로 수정하겠습니까?")) {
			return false;
		} else {
			var items = [];
			var isEmpty = false;
			for(var i=0; i<plusCount; i++){
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
			
/*			if($("#categoryName").val() != $("#categoryOriName").val()){
				if(!confirm("분류 이름을 수정하면 해당 분류의 모든 자산 정보가 변경됩니다. 계속할까요?")){
					return false;
				}
			}
*/
			for(var i=0; i<itemSize; i++){
				if($("td:eq("+i+")").find("input:last").prop("readonly")){
					deleteItems.push(i);
				}
			}

			$("#deleteItems").val(deleteItems);

/*			if(plusCount == itemSize && deleteItems.length == itemSize){
				if(!confirm("모든 세부사항이 사라지므로 해당 분류가 삭제됩니다. 계속할까요?")){
					deleteItems = [];
					$("#deleteItems").val(deleteItems);
					return false;
				}
			}
*/			
			if(isEmpty){
				alert("빈 칸은 자동으로 제외하고 등록됩니다.");
			}
			
			if((items.length == itemSize) && (deleteItems.length == 0)){
				alert("수정 사항이 없습니다.");
				return false;
			}
			$("#category").submit();

		}
	}
	
	function cancelConfirm(){
		if(!confirm('취소하겠습니까?')){
				return false;				
		}else{
			location.href='/assetmanager/categoryList';
		}
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
</style>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">
					<font size="6px"><b># 분류 수정</b></font>
				</h1>
				<div>
					<div style="float: left; display:inline-block;">
						<form id="category" action="categoryModifySend" method="post">
							<input type="hidden" id="categoryOriName" name="categoryOriName" value="${categoryData['name']}" />
							분류 이름: <input type="text" id="categoryName" name="categoryName" value="${categoryData['name']}" style="background:lightgray" readonly/>
							<input type="hidden" id="items" name="items"/>
							<input type="hidden" id="deleteItems" name="deleteItems"/>
						</form>
					</div>
					<div style="float: right; display:inline-block;">
						분류 식별 코드: <input type="text" value="${categoryData['code']}" style="background:lightgray" readonly/>
					</div>
				</div>
				<br><br>
				<div class="table-responsive">
					<table class="table table-striped" style="text-align: left; margin-top: 10px" id="itemTable" border="1">
				
						<c:forEach items="${categoryData.items}" var="categoryItem" varStatus="i" step="2">
						<tr>
							<td style="width: 50%; background: lightgray">
								<input type="button" class="deleteItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" style="width: 80%" value="${categoryData.items[i.index]}"/>
							</td>
							<td style="width: 50%; background: lightgray">
								<input type="button" class="deleteItem" value="-"/>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" style="width: 80%" value="${categoryData.items[i.index+1]}"/>
							</td>
						</tr>
						</c:forEach>
						<tr>
							<td style="width: 50%"><input type="button" id="addItem" value="+"/></td>
						</tr>
					</table>
				</div>
				<div style="display: flex; float: right">
					<input type="button" class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="categoryModify();" value="수정"/>
					<input type="button" class="btn btn-lg btn-primary" onclick="cancelConfirm();" value="취소"/>
				</div>
			</div>
		</div>
	</div>
</body>
