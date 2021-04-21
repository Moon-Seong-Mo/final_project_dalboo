<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품 : 장바구니</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/myCartList.css">
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<h2 align="left">장바구니 목록</h2>
				<p align="right" style="color:gray;"><b style="color:black;">장바구니</b> > 주문/결제 > 완료</p>
				<hr>
				<table id="tableArea">
					<tr style="background:#e9e9e9; height:50px;">
						<th width="5%"><input type="checkbox" name="all" id="all"></th>
						<th colspan="2">상품 정보</th>
						<th width="200px">옵션</th>
						<th>금액</th>
						<th>배송비</th>
					</tr>
					<c:if test="${ empty clist }">
						<tr>
							<td colspan="6"><h2>장바구니가 비어있습니다.</h2></td>
						</tr>
						<tr>
							<td colspan="6"><input type="button" onclick="location.href='mdMain.md?mdCategory=머그컵'" value="상품 둘러보기" id="goBtn"></td>
						</tr>
					</c:if>
					<c:forEach var="c" items="${ clist }" varStatus="vs">
							<tr style="border-bottom:1px solid rgba(75, 75, 75, 0.33);">
								<td><input type="checkbox" class="chk" name="chk" value="${ c.cartNum }"></td>
								<td><a href="mdDetail.md?mdNum=+${ c.mdNum }"><img src="${ contextPath }/resources/mdUploadFiles/${ f[vs.index].changeName }" class="imgTd"></a></td>
								<td>
									${ c.mdName }<br><br> <b style="font-size:16px;"><fmt:formatNumber value="${ c.mdPrice }" pattern="#,###" /></b>원
								</td>
								<td>
									개수 : ${ c.cartAmount }개 <div class="hrDiv"></div>
									<input type="button" value="개수변경" class="rotnBtn">
								</td>
								<td>
									<c:set var="totalPrice" value="${ c.mdPrice * c.cartAmount  }"/>
									<b><fmt:formatNumber value="${ totalPrice }" pattern="#,###" /></b>원<br><br>
									<br><input type="button" value="구매하기" class="puchBtn">
								</td>
								<td>2,500원</td>
							</tr>
					</c:forEach>
				</table>
					<div id="btn-area" align="right">
						<c:if test="${!empty clist }">
							<button onclick="deleteCart()" class="cartBtn" id="Btn">삭제</button>
							<button onclick="buyCart()" class="cartBtn" id="orangeBtn">구매</button>
						</c:if>
					</div>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
	
	//전체 체크
	var leng = ${ clist.size() }
	
	$("#all").click(function(){
		if($('#all').is(":checked")){
			$(".chk").prop("checked", true);
		} else{
			$(".chk").prop("checked", false);
		}
	});

	$(".chk").click(function(){
		if($("input[name='chk']:checked").length == leng){
			$("#all").prop("checked", true);
		} else {
			$('#all').prop("checked", false);
		}
	});
	
	//장바구니 삭제
	function deleteCart(){
		var chkArr = [];
	    $("input[name='chk']:checked").each(function(i){
	    	chkArr.push($(this).val());   
	    });
		
	    if(chkArr.length == 0){
	    	alert("삭제하실 상품을 골라주세요");
	    	return false;
	    }
	    
		var bool = confirm(chkArr.length+ "개 제품을 장바구니에서 삭제 하시겠습니까?");
		
		if(bool){
			location.href='deleteCart.md?chkArr='+chkArr;
		}
		
	}
	
	//개수변경
	$('.rotnBtn').click(function(){
		var cartNum = $(this).parent().parent().children().eq(0).children().val();
		
		var w = window.open('cartRotnModifyView.md?cartNum='+cartNum, 'insertAddress', 'width=500, height=450 , left=800 , top = 300');
	
	});
	//031 463 3879
	//개별구매
	$('.puchBtn').click(function(){
		var chkArr = $(this).parent().parent().children().eq(0).children().val();
		 location.href="cartsBuyView.md?chkArr="+chkArr;
	});
	
	//체크구매
	function buyCart(){
		var chkArr = new Array();
	    $("input[name='chk']:checked").each(function(i){
	    	chkArr.push($(this).val());   
	    });
		
	    if(chkArr.length == 0){
	    	alert("구매하실 상품을 골라주세요");
	    	return false;
	    }
	    location.href="cartsBuyView.md?chkArr="+chkArr;
	}
	
	
</script>
</html>