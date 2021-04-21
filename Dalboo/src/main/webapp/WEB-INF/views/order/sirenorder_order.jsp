<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 사이렌오더</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/sirenorder_order.css">
<!-- Kakao Map API & library -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a76d669609bbdc285414a8c651ed614a&libraries=services"></script>
<!-- i'mport library -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>

h4 {
	margin-bottom: 50px;
}
.Btn {
	font-size: 16px;
	border: 0px;
	border-radius: 5px;
	margin-right: 30px;
	width: 80px;
	height: 30px;
}

.Btn:hover {
	cursor: pointer;
}
input[type="number"]{
	
	width:100px;
	height:30px;
	border : 0.5px solid gray;
	border-radius: 5px;
	text-align:center;
	font-size:15px;
	margin-left:20px; margin-right: 20px;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			<div id="content">
			
	<div id="sirenorder_order_wrap">
			
	<div id="order">
	<img src="<%= request.getContextPath() %>/resources/images/orderbell.PNG" align="left">
	<h2 align="left">주문하기</h2>
	</div>
	<!-- <hr> -->

	<fieldset>
		<div class="store">
			<table class="orderlist">
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="50%">
				<col width="5%">
				<col width="10%">
				<col width="5%">
				<col width="20%">
			</colgroup>
				<thead id="head">
					<tr>
						<th>삭제</th>
						<th class="name">NO</th>
						<th>NAME</th>
						<th></th>
						<th>AMOUNT</th>
						<th></th>
						<th>PRICE</th>
					</tr>
				</thead>
				<tbody align ="center">
				<e:if test="${ not empty socList  }">
				<e:forEach var="m" items="${ socList }">
				<input type="hidden" value="${ m.store_name }" class="stoName">
				<input type="hidden" value="${ m.store_num }" class="store_num">
				<input type="hidden" value="${ m.stock_num }" class="stock_num">
				<tr>
					<td>
					<form action="deleteCart.cf" method="post" onsubmit="return warn();">
						<input type="hidden" value="${ m.so_cartNum }" class="so_cartNum" name="so_cartNum">
						<input type="submit" value="X" class="deleteBtn">
					</form>
					</td>
					<td><p id="no">${ m.so_cartNum }</p></td>
					<td>${ m.materialname }</td>
					<td>
					<e:if test="${ m.so_cartAmount gt '1' }">
					<form action="minus.cf" method="post">
						<input type="hidden" value="${ m.so_cartNum }" class="so_cartNum" name="so_cartNum">
						<input type="submit" value="-" class="amountBtn">
					</form>
					</e:if>
					</td>
					<td id="amount">
						<input type="text" class="menuAmount" value="${ m.so_cartAmount }" readonly required>
					</td>
					<td>
					<e:if test="${ m.materialamount gt m.so_cartAmount }">
					<form action="plus.cf" method="post">
						<input type="hidden" value="${ m.so_cartNum }" class="so_cartNum" name="so_cartNum">
						<input type="submit" value="+" class="amountBtn">
					</form>
					</e:if>
					</td>
					<td id="menuPrice"><span>${ m.materialprice * m.so_cartAmount }</span> Won</td>
				</tr>
				</e:forEach>
				</e:if>
				<e:if test="${ empty socList }">
					<tr><td colspan="7">주문 할 목록이 없습니다.</td>
					</tr>
				</e:if>
				
				</tbody>
			</table>
		</div>
	</fieldset>
	
	<div id="total">
	<span>총액 : </span> &nbsp;
	<span class="totalPrice">${ totalPrice }</span> Won
	</div>
	
	<script>
	function warn(){
		if(confirm('메뉴를 삭제하시겠습니까?')){
			return true;
		} else{
			return false;
		}
	}

	
	</script>
	
	<br>
	
	<div class="selectshop">
		선택매장 : <span id="storeName">${ s.store_name }</span>
	</div>
	
	<div id="map"></div>
	
<%-- 	<div id="myPoint">
		보유 포인트 : <span>${ loginUser.point }</span>
	</div> --%>
	
	<h4 align="left">할인 및 포인트</h4>
	<table>
		<tr>
			<td>보유 표인트</td>
			<c:set var="point" value="${ loginUser.point }"/>
			<td><label id="havePoint">${ point }</label>&nbsp;P</td>
		</tr>
		<tr>
			<td>사용 포인트</td>
			<td><input type="number" id="usingPoint" name="usingPoint" max=${ point } min="0"></td>
			<td><input type="button" class="Btn" value="전액 사용" id="pointGo" onclick="this.onclick=null;"></td>
		</tr>
	</table>
	
	<div id="paymentAll">
		<table class="totalTable">
			<tr>
				<td>총액</td>
				<td></td>
				<td>포인트 사용</td>
				<td></td>
				<td>총 결제 금액</td>
			</tr>
			<tr class="totalpayment">
				<td>${ totalPrice }원</td>
				<td><label class="textColor1">ㅡ</label></td>
				<td><label id="usingPriceLabel">0</label>원</td>
				<td><label class="textColor1">=</label></td>
				<td><label class="textColor2" id="totalPriceLabel" >${ totalPrice }</label><label class="textColor2">원</label></td>
			</tr>
		</table>
		<input type="hidden" name="memberUsePoint" id="memberUsePoint" value="0">
	</div>
	
	<script>
	
	
		//포인트 한 번만 누를 수 있다!... 
		$("#pointGo").one('click', function() {
	
			//포인트 버튼 옆에 사용 포인트 띄우기 + 최종 금액 바꾸기
	
			//포인트 사용량 	 
			var havePoint = $("#havePoint").text();
			var totalPrice = $("#totalPriceLabel").text();
	
			var have = parseInt(havePoint);
			var total = parseInt(totalPrice);
	
			$("#usingPoint").val(havePoint);
			$("#usingPriceLabel").text(havePoint);
			$("#totalPriceLabel").text(total - have);
			$("#memberUsePoint").val(havePoint);	//DB넘길 사용포인트
	
		});
	
		$("#usingPoint").change(function() {
			//토탈 금액 바뀌기
	
			var havePoint = $("#havePoint").text(); //현재 포인트	(alert창 띄우기 위해 필요)
	
			var usingPoint = $(this).val(); //사용 포인트
			var totalPrice = $(".totalPrice").text(); //현재 가겨
	
			var usingPoint = parseInt(usingPoint);
			var price = parseInt(totalPrice);
	
			total = price - usingPoint;
	
			if (usingPoint <= havePoint) {
				$("#usingPriceLabel").text(usingPoint);
				$("#totalPriceLabel").text(total);
				$("#memberUsePoint").val(usingPoint);	//DB넘길 사용포인트
			} else if (usingPoint > havePoint) {
				alert("보유 포인트 이상 사용은 불가능합니다.");
				$(this).val(havePoint);
			}
		});
		
	
	
	</script>
	
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(35.555142, 126.970436), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};
															
	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소 좌표 변환 객체
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${ s.store_address }', function(result, status) {

	// 	좌표 검색이 정상일 경우
	if(status == kakao.maps.services.Status.OK){

		var location = new kakao.maps.LatLng(result[0].y, result[0].x);
																
		// 마커 생성
		var marker = new kakao.maps.Marker({
			map: map,
			position: location
		});
																						        
		// 인포 윈도우 생성
		var infowindow = new kakao.maps.InfoWindow({
			content: '<div style="width:140px;text-align:center;padding:6px 0; background">${ s.store_name }</div>'
		});
		// 인포 윈도우 표시
		infowindow.open(map, marker);
																
		// 지도의 중심을 결과값을 받은 위치로 이동
		map.setCenter(location);
	}
});
</script>
	<br>
	<e:if test="${ not empty socList }">
		<div id="btn">
			<input type="button" value='취소' id="cancel" onclick="history.go(-1)">
			<input type="button" value='결제하기' id="buy" onclick="payment();">
		</div>
	</e:if>

	<e:url var="upstock" value="updateStock.me">
		<e:forEach var="m" items="${ socList }">
			<e:param name="stock_num" value="${ m.stock_num }"/>
			<e:param name="so_cartAmount" value="${ m.so_cartAmount }"/>
		</e:forEach>
	</e:url>
<script>
	var stocks = $('input[class=stock_num]');
	var stock_num = new Array();
	for(var i=0; i<stocks.length; i++){
		stock_num.push(document.getElementsByClassName("stock_num")[i].value);
		console.log("stocks : " + stock_num);
	}
	console.log("ss : " + stock_num);
	
	var store_num = ${ s.store_num };
	var totalprice = $("#totalPriceLabel").text();
	
	function payment() {
		if(confirm("주문하시겠습니까?")){
			var IMP = window.IMP;
		    IMP.init("imp74593327"); // 가맹점 식별코드 (고유코드)
		    //IMP.init("imp55592976"); // 가맹점 식별코드 (고유코드)

		    IMP.request_pay({ // param
		    pg : "html5_inicis", // 이니시스 결제방식
		    pay_method : "vbank", // card : 카드 결제
		    //pay_method : "card", // card : 카드 결제

		    merchant_uid : 'merchant_' + new Date().getTime(),
		    amount : $("#totalPriceLabel").text(),
		    name : '메뉴',
		    buyer_name : '${ loginUser.name}',
		    buyer_email: '${ loginUser.email}',
		    buyer_tel: '${ loginuser.phone }'
			    
			}, function(rsp){
				if(rsp.success){
					var msg = '결제를 완료하였습니다.';
					console.log("stock_num", stock_num);
					$.ajax({
						url: "insertSirenOrder.cf",
						data: {
							store_num: store_num,
							stock_num: stock_num,
							totalprice: $("#totalPriceLabel").text(),
							usingPoint : $("#memberUsePoint").val()
						},
						async: false,
						success: function(data){
							console.log(data.result);
							if(data.result > 0){
								alert("결제 내역을 저장하였습니다.");
								location.href='${ upstock }';
								// location.href="coffeeOrderView.me";
							} else{
								alert("결제 내역 저장에 실패하였습니다.");
							}
						}
					});
				} else {
					var msg = '결제에 실패하였습니다.';
				}
				alert(msg);
			});
		}else{
			return false;
		}
	}
</script>
			
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>