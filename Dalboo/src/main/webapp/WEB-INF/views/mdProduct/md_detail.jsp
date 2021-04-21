<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품 : ${ md.mdName }</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/md_detail.css">
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<h3 id="top">${ md.mdCategory }</h3>
				<hr>
				<div id="imageArea">
					<img src="${ contextPath }/resources/mdUploadFiles/${ f[0].changeName }" id="cf" width="300px" height="460px" align="left">
					<p id="mdName">${ md.mdName }</p>
				</div>
				<div id="tableArea">
					<table>
						<tr>
							<td>재질</td>
							<td>${ md.mdMaterial }</td>
						</tr>
						<tr>
							<td>무게</td>
							<td>${ md.mdCapacity }g</td>
						</tr>
						<tr>
							<td>기능</td>
							<td>보온, 보냉</td>
						</tr>
						<tr>
							<td>제조국</td>
							<td>한국</td>
						</tr>
						<tr>
							<td>제조사</td>
							<td>(주)달보드레</td>
						</tr>
						<tr>
							<td>판매처</td>
							<td>(주)달보드레</td>
						</tr>
						<tr>
							<td>반품 및 교환</td>
							<td>반품 및 교환 불가한 상품입니다.</td>
						</tr>
						<tr>
							<td>주의사항</td>
							<td>* 제품에 강한 충격을 가하지 마십시오.<br> 
								* 식기세척기 또는 식기건조기는 사용하지 마십시오.<br> 
								* 드라이아이스 및 탄산음료는 넣지 마십시오.<br> 
								* 음료를 넣고 장시간 방치하지 마십시오.<br> 
								* 다른 단단한 물체와 닿지 않도록 하십시오.
							</td>
						</tr>
						<tr>
							<c:if test="${ !empty loginUser }">
								<td><b>주문 수량</b></td>
								<td><b><input type="number" id="amount" min="1" max="${ md.mdStock }" value="1">개</b></td>
							</c:if>
						</tr>
					</table>
				</div>
				<div id="priceArea">
					판매가격 : <b><label id="price"><fmt:formatNumber value="${ md.mdPrice}" pattern="#,###" /></label></b>원
				</div>
				
				<div align="right">
					<input type="button" value="장바구니" id="gray" class="Btn" onclick="cart();"> 
					<input type="button" value="구매하기" id="orange" class="Btn" onclick="buy();">
				</div>

				<hr>

				<div id="mdDetail" align="center">
					<P>제품 상세 정보</P>
					<br>
					<br> <img src="${ contextPath }/resources/mdUploadFiles/${ f[1].changeName }" width="600px" ><br> 
						<img src="${ contextPath }/resources/mdUploadFiles/${ f[2].changeName }" width="600px">
				</div>

				<div align="center">
					<input type="button" id="lastBtn" value="뒤로가기"
						onclick="history.back(-1);">
				</div>
				
				<input type="hidden" value="${ loginUser.id }" id="id">
				<input type="hidden" value="${ md.mdNum }" id="mdNum">

				<div align="right">
					<c:if test="${ loginUser.rank_code eq 2}">
						<input type="button" value="수정" class="adminModifyBtn" onclick="location.href='${ contextPath}/mdModifyView.md?mdNum=${ md.mdNum }'">
						<input type="button" class="adminBtnOrange" onclick="mdDelete();" value="삭제">
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		$('#amount').change(function(){
			var price = ${ md.mdPrice };
			var amount = $('#amount').val();
			
			$('#price').text(price*amount);
			
		});
			
		function mdDelete(){
			var yn = confirm("${ md.mdNum }번 '${ md.mdName }'상품을 삭제하시겠습니까?");
			if(yn){
				location.href='mdDelete.md?mdNum=${ md.mdNum }';
			}
		}
	
		function cart(){
			
			var mdNum = $("#mdNum").val();
			var mdName = $("#mdName").text();
			var amount = $("#amount").val();
			var price = ${ md.mdPrice };
			var id = $('#id').val();
			
			if(id == ''){
				alert("로그인 후 이용해주세요");
				location.href='login.me';
			}
			
			$.ajax({
				url:"mdCartInsert.md",
				data:{mdNum:mdNum, mdName:mdName ,amount:amount, price:price},
				success : function(data){
					if(data > 0){
						var bool = window.confirm("장바구니에 상품이 담겼습니다." + "\n" + "장바구니로 이동하시겠습니까?");
						if(bool){
							location.href='myCartList.md';
						} 
					}
				}						
			}); 
		}
		
		
		function buy(){
			var mdNum = $("#mdNum").val();
			var amount = $("#amount").val();
	
			var id = $('#id').val();
			if(id == ''){
				alert("로그인 후 이용해주세요");
				location.href='login.me';
			} else{
				
				var mdName = $("#mdName").text();
				var bool = window.confirm( "'" + mdName + "' " + "상품을 구매하시겠습니까?"); 
				
				if(bool){
					location.href="md_buy.md?mdNum="+mdNum+"&amount="+amount;
				}
			}
			
		}
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>