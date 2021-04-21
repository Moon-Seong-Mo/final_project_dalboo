<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품 : 장바구니</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.pC{text-align:left; width:150px; margin-top:30px; margin-left:80px;}
	hr{width:90%;}
	.textC{background:rgba(224, 224, 224, 0.23); width:300px; height:30px;}
	#amount{width:40px; height:30px; text-align:center; font-size:18px; border:0;}
	#Btn{background:rgb(224, 224, 224); color: gray; font-size: 15px; border: 0px; border-radius: 3px;
		margin-right: 10px; width: 100px; height: 30px; margin-bottom: 10px; }
	#orangeBtn{	background: rgb(227, 189, 152);color: gray; font-size: 15px; border: 0px; border-radius: 3px;
		margin-right: 10px; width: 100px; height: 30px; margin-bottom: 10px;}
</style>
</head>
<body>
	
	<form action="cartRotnModify.md">
		<div align="center">
			<h3>주문조건 추가/변경</h3><hr>
			
			<div style="float:left; margin-left:30px; width:350px; margin-bottom:10px;">
				<img src="${ contextPath }/resources/mdUploadFiles/${ f[0].changeName }" width="100px" height="100px" align="left">
				<p class="pC">${ c.mdName }<br><b><fmt:formatNumber value="${ c.mdPrice }" pattern="#,###" /></b>원 </p>
			</div>
			<hr>
			<div align="left" style="height:50px; margin-bottom:35px; margin-left:20px;">
				<table style="font-size:13px;">
					<tr>
						<td width="120px;">배송방법</td>
						<td class="textC">&nbsp;택배</td>
					</tr>
					<tr>
						<td>배송비 결제</td>
						<td class="textC">&nbsp;&nbsp;주문 금액에 포함</td>
					</tr>
				</table>
			</div>
			<hr>	
			<div style="float:left; margin-left:20px; margin-bottom:15px;">
				수량 <b><input type="number" id="amount" min="1" max="${ mdStock }" value="${ c.cartAmount }" name="cartAmount"></b>개
				<input type="hidden" name="cartNum" value="${ c.cartNum }">
			</div>
			<hr>
			<div>
				상품 금액 : <b><label id="total"></label></b>원
			</div>
			<div style="margin-top:30px;">
				<button onclick="window.close();" id="Btn">닫기</button>
				<input type="submit" id="orangeBtn" value="확인">
			</div>
		</div>
	</form>
 	<script>
 		$(function(){
 			var price = ${ c.mdPrice };
 			var amount = $('#amount').val();
 			
 			var total = price * amount;
 		 	var money = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
 			$("#total").text(money);
 		});
 	
		$('#amount').change(function(){
			var price = ${ c.mdPrice };
			var amount = $('#amount').val();
			$('#total').text(price*amount);
		});
	</script>
</body>
</html>