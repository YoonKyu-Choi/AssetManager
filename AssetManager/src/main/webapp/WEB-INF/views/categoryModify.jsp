<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>분류 수정</title>

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-2-1-1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment-2-20-1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-table.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

<script>
	var itemSize = Number("<c:out value="${categoryData.itemSize}"/>");
	var plusCount = itemSize;
	var deleteItems = [];
	$(function(){
		if(itemSize % 2 == 1){
			var index = Math.floor(itemSize/2);
			$("tr:eq("+index+") td:last").remove();
			$("tr:gt("+index+") td:nth-child(2n+1)").each(function(){
				$(this).closest("tr").prev().find("td:last").after($(this));
			});
			$("tr:last").remove();
		}
		
		$(document).on("click", "#addItem", function(){
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
	
		$(document).on("click", ".removeItem", function(event){
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
	});
</script>

<script>
	function categoryModify(){
//		$("td input[type='text']").css('background', 'red');
		var items = [];
		for(var i=0; i<plusCount; i++){
			items.push($("td input[type='text']:eq("+i+")").val());
		}
		$("#items").val(items);
		
		for(var i=0; i<itemSize; i++){
			if($("td:eq("+i+")").find("input:last").prop("readonly")){
				deleteItems.push(i);
			}
		}
		$("#deleteItems").val(deleteItems);
		$("#category").submit();
	}
	
	function cancelConfirm(){
		if(!confirm('취소하겠습니까?')){
				return false;				
		}else{
			location.href='/assetmanager/categoryList';
		}
	}
</script>


</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="main">
				<h1 class="page-header">${categoryData["name"]} 분류 수정</h1>
				<form id="category" action="categoryModifySend" method="post">
					<input type="hidden" name="categoryOriName" value="${categoryData['name']}" />
					분류 이름: <input type="text" name="categoryName" value="${categoryData['name']}" />
					<input type="hidden" id="items" name="items"/>
					<input type="hidden" id="deleteItems" name="deleteItems"/>
				</form>
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
				<div style="display: flex; float: right">
					<input type="button" class="btn btn-lg btn-primary" style="margin-right: 10px" onclick="categoryModify();" value="수정"/>
					<input type="button" class="btn btn-lg btn-primary" onclick="cancelConfirm();" value="취소"/>
				</div>
			</div>
		</div>
	</div>


</body>
</html>