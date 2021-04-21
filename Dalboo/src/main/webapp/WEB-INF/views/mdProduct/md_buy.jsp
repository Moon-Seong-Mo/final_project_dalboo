<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD상품 구매</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/cartBuyView.css">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
#requestArea {
	float: right;
	margin-right: 80px;
	margin-top:50px;
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
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<form action="${ contextPath }/buyEndMd.md" method="post" id="buyEndMd">
					<h2 align="left">주문/결제</h2>
					<p align="right" style="color:gray;">장바구니> <b style="color:black;">주문/결제</b>  > 완료</p>
					<hr style="margin-top:0px; margin-bottom:10px;">
					
					<table id="table1">
						<tr style="background:#e9e9e9; height:50px;">
							<th colspan="2" width="30%">상품 정보</th>
							<th>판매처</th>
							<th colspan="2">상품 가격</th>
							<th colspan="2">배송비</th>
							<th>주문금액</th>
						</tr>
						<tr>
							<td>
								<img src="${ contextPath }/resources/mdUploadFiles/${ f[0].changeName }" style="width:100px; height:150px; align:left">
							</td>
							<td>	
								<p style="font-size:18px; font-weight:bold;">${ md.mdName }</p>
								<p>개수 : ${ amount }개</p>
							</td>
							<td style="border-right: 3px dashed rgba(51, 51, 51, 0.15);">달보드레</td>
							<td><fmt:formatNumber value="${ md.mdPrice }" pattern="#,###" /></td>
							<td><b>+</b></td>
							<td>2,500원</td>
							<td><b>=</b></td>
							<td>
								<c:set var="price" value="${ (amount * md.mdPrice)+2500 }"/>
								<%-- <label id="price" style="font-weight: bold;"> <fmt:formatNumber value="${ price }" pattern="#,###"/>원</label> --%>
								<label id="price" style="font-weight: bold;">${ price }</label>원
							</td>
						</tr>
					</table>
					
					<hr style="margin-top:0px; margin-bottom: 50px;">
					
					<div align="left" style=" height:250px;">
						
						<div id="requestArea">
							<p id="textP">배송 요청사항</p>	
							<textarea name="addressRequest" id="addressRequest"/></textarea><br>
							<select onChange="setOption(this.value)">
								<option onselect="focus">직접 입력</option>
								<option>배송 전에 미리 연락 바랍니다.</option>
								<option>부재 시 경비실에 맡겨 주세요.</option>
								<option>부재 시 전화 주시거나 문자 남겨 주세요.</option>
							</select>
						</div>
						<script>
						function setOption(req){
							if(addressRequest != "직접 입력"){
								document.getElementById("addressRequest").value = req;
							}
						}
						</script>
						
						<h4 align="left">배송지 정보</h4>
						<div>
							<label id="textLabel">&nbsp;&nbsp;배송지선택&nbsp;&nbsp;</label> &nbsp;&nbsp;
							<input type="radio" id="adcheck1" name="add" value="1" checked>기본주소 
							<input type="radio" id="adcheck2" name="add" value="2">신규배송지 &nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" id="chooseBtn" value="주소록선택" onclick="addrChose();">
						</div>
						<div class="addr_list_1" id="ad1" style="display: block">
							<c:forEach var="ad" items="${ adlist }">
								<c:if test="${ ad.adBaseAddress eq 1 }">
									<table class="memberTable">
										<tr>
											<td width="70px;">수령인</td>
											<td>${ ad.adReceiver }<input type="hidden" value="${ ad.adReceiver }" id="adReceiver"></td>
										</tr>
										<tr>
											<td>주소</td>
											<td>${ ad.adAddress }<input type="hidden" value="${ ad.adAddress }" id="adAddress"></td>
										</tr>
										<tr>
											<td>연락처</td>
											<td>${ ad.adPhone }<input type="hidden" value="${ ad.adPhone }" id="adPhone"></td>
										</tr>
									</table>
								</c:if>
							</c:forEach>
						</div>
						<div class="addr_list_2" id="ad2" style="display: none">
							<table class="memberTable">
								<tr>
									<td width="50px;">수령인</td>
									<td><input type="text" id="name2" name="name2" value=""></td>
								</tr>
								<tr>
									<td>주소</td>
									<td><input type="text" id="add2" name="ad2"  value=""></td>
								</tr>
								<tr>
									<td>연락처</td>
									<td><input type="text" id="phone2" name="phone2" value=""></td>
								</tr>
							</table>
						</div>
					</div>
					
					<hr>
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
					<hr>
					
					<div class="totalPriceDiv">
						<table class="totalTable">
							<tr>
								<td>상품합계</td>
								<td></td>
								<td>총 할인 금액</td>
								<td></td>
								<td>배송비</td>
								<td></td>
								<td>총 결제 금액</td>
							</tr>
								<tr class="totalText">
									<td>${ amount * md.mdPrice }원</td>
									<td><label class="textColor1">ㅡ</label></td>
									<td><label id="usingPriceLabel">0</label>원</td>
									<td><label class="textColor1">+</label></td>
									<td>2,500원</td>
									<td><label class="textColor1">=</label></td>
									<td><label class="textColor2" id="totalPrice" >${ price }</label><label class="textColor2">원</label></td>
								</tr>
						</table>
					</div>		
					
					<label><input type="checkbox" id="check" value="check">상품의 구매조건 확인 및 결제진행 동의</label>						
					
					<div align="center" style="margin-top:50px;">
						<!-- mdOrder에 담을 것 -->	
						<input type="hidden" name="mdAmount" value="${ amount }">
						<input type="hidden" name="totalPrice" id="realTotalPrice" value="${ price }">
						<input type="hidden" name="memberUsePoint" id="memberUsePoint" value="0">
						<input type="hidden" name="mdNum" value=${ md.mdNum }>
						<input type="hidden" name="mdPrice" value=${ md.mdPrice * amount }>
						<input type="hidden" name="receiver" id="reReceiver" value="">
						<input type="hidden" name="address" id="reAddress" value="">
						<input type="hidden" name="phone" id="rePhone" value="">
						<input type="button" class="buy" value="뒤로가기" style="background:lightgray;" onclick="location.href='javascript:history.back();'">
						<input type="button" class="buy" value="결제하기" onclick="checkPay(this)">  
					</div>		
				</form>					
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>


	<script>
		//포인트 한 번만 누를 수 있다!... 
		$("#pointGo").one('click', function() {

			//포인트 버튼 옆에 사용 포인트 띄우기 + 최종 금액 바꾸기

			//포인트 사용량 	 
			var havePoint = $("#havePoint").text();
			var totalPrice = $("#totalPrice").text();

			var have = parseInt(havePoint);
			var total = parseInt(totalPrice);

			$("#usingPoint").val(havePoint);
			$("#usingPriceLabel").text(havePoint);
			$("#totalPrice").text(total - have);
			$("#realTotalPrice").val(total - have);	//DB넘길 총 가격
			$("#memberUsePoint").val(havePoint);	//DB넘길 사용포인트

		});

		$("#usingPoint").change(function() {
			//토탈 금액 바뀌기

			var havePoint = $("#havePoint").text(); //현재 포인트	(alert창 띄우기 위해 필요)

			var usingPoint = $(this).val(); //사용 포인트
			var price = $("#price").text(); //현재 가겨

			var usingPoint = parseInt(usingPoint);
			var price = parseInt(price);

			total = price - usingPoint;

			if (usingPoint <= havePoint) {
				$("#usingPriceLabel").text(usingPoint);
				$("#totalPrice").text(total);
				$("#realTotalPrice").val(total);		//DB넘길 총 가격
				$("#memberUsePoint").val(usingPoint);	//DB넘길 사용포인트
			} else if (usingPoint > havePoint) {
				alert("보유 포인트 이상 사용은 불가능합니다.");
				$(this).val(havePoint);
			}
		});

		$('input[type=radio][name="add"]').change('click', function() {
			var chkValue = $('input[type=radio][name="add"]:checked').val();
			if (chkValue == '1') {
				$('.addr_list_1').css('display', 'block');
				$('.addr_list_2').css('display', 'none');
			} else {
				$('.addr_list_1').css('display', 'none');
				$('.addr_list_2').css('display', 'block');
				document.getElementById('name2').value = null;
				document.getElementById('phone2').value = null;
				document.getElementById('add2').value = null;
			}
		});

		function addrChose() {//배송지 정보 수정 팝업창
			window.open('choseaddress.md', 'choseaddress',
					'width=600, height=400 , left=500 , top = 300');
		}

		function checkPay(chk) {

			var check = document.getElementById("check").checked;

			var totalPrice = $("#realTotalPrice").val();

			var receiver;
			var address;
			var phone;

			if ($("#adcheck1").is(":checked")) {
				receiver = $("#adReceiver").val();
				address = $("#adAddress").val();
				phone = $("#adPhone").val();
			} else {
				receiver = $("#name2").val();
				address = $("#add2").val();
				phone = $("#phone2").val();
			}

			$("#reReceiver").val(receiver);
			$("#reAddress").val(address);
			$("#rePhone").val(phone);

			if (check && address != null && totalPrice > 0) {
				var IMP = window.IMP;
				IMP.init('imp74593327');
				IMP.request_pay({
					pg : 'html5_inicis',
					pay_method : 'vbank',
					merchant_uid : 'merchant_' + new Date().getTime(),
					name : '달보드레',
					amount : totalPrice,
					buyer_email : 'iamport@siot.do',
					buyer_name : receiver,
					buyer_tel : phone,
					buyer_addr : address
				}, function(rsp) {
					if (rsp.success) {
						$("#buyEndMd").submit();
						var msg = '결제에 성공하였습니다.';
					} else {
						var msg = '결제에 실패하였습니다.';
						location.href="${ contextPath }/mdMain.md?mdCategory=머그컵";
					}
					alert(msg);
				});
			} else if(!check) {
				alert("구매조건을 확인 후 체크해주세요");
			}else if(address == null) {
				alert("배송지를 적어주세요");
			} else if(totalPrice == 0){
				var bool = confirm("전액 포인트 사용으로 결제하시겠습니까?");
				if(bool){
					$("#buyEndMd").submit();
				} else {
					return false;
				}
			}
		}
	</script>
</body>
</html>