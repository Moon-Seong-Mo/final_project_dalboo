<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/order/mdShipManagement.css">
<style>

#orderBtn {
	background-color: rgb(224, 224, 224);
	color: rgb(33, 33, 33);
	font-size: 17px;
	border: 0px;
	border-radius: 3px;
	margin-right: 10px;
	width: 100px;
	height: 30px;
	margin-bottom: 10px;
	cursor:pointer;
}
#selectBox{
	width:110px; height:35px; font-size: 15px;
	border : 2px solid lightgray;
	border-radius: 5px;
	text-align-last:center; 
}
</style>
</head>
<body>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<h2 align="left">MD주문 배송 현황</h2>
				<div style="display:inline; float:left; width:120px; text-align: left;">
					<select id="selectBox">
						<option value="all">전체</option>
						<option value="orderIng">주문 접수 중</option>
						<option value="shipIng">배송 중</option>
						<option value="shipEnd">배송 완료</option>
					</select>
				</div>
				
							
				<div id="tableArea">
					<table>	
						<thead>
							<tr style="background: #e9e9e9; height: 50px;">
								<td><input type="checkbox" name="all" id="all"></td>
								<td>받는 사람</td>
								<td>아이디</td>
								<td>상품 이름</td>
								<td>개수</td>
								<td width="13%">주소</td>
								<td>연락처</td>
								<td width="13%">배송 요청사항</td>
								<td >주문 날짜</td>
								<td>총 가격</td>
								<td >배송 상태</td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${ empty molist }">
								<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">
									<td colspan='11'></td>
								</tr>
							</c:if>
							<c:forEach var="mo" items="${ molist }" varStatus="vs">
								<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">
									<td><input type="checkbox" value="${ mo.mdOrderNum }" class="chk" name="chk"></td>
									<td>${ mo.receiver }</td>
									<td>${ mo.mId }</td>
									<td>
										<a href="mdDetail.md?mdNum=+${ mo.mdNum }"><img src="${ contextPath }/resources/mdUploadFiles/${ flist[vs.index].changeName }" class="imgTd"></a> 
										<br>${ mdlist[vs.index].mdName }
									</td>
									<td>${ mo.mdAmount }</td>
									<td>${ mo.address }</td>
									<td>${ mo.phone }</td>  
									<td>${ mo.addressRequest }</td>
									<td>${ mo.orderDate }</td>
									<td>${ mo.totalPrice }</td>
									<td>
										<c:if test="${ mo.mdShipStatus eq 0 }">
											<b style="color:red;">주문 접수 중</b>
										</c:if> 
										<c:if test="${ mo.mdShipStatus eq 1 }">
											<b style="color:rgb(227, 189, 152);">배송 중</b>
										</c:if> 
										<c:if test="${ mo.mdShipStatus eq 2 }">
											<b style="color:gray;">배송 완료<br>/구매확정</b>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<c:if test="${ !empty molist }">
					<div>
						<p style="color: gray; font-size: 17px; float:right; text-align:right;">
							주문 확인이 된 상품은 체크한 다음 <b>배송 시작</b> 버튼을 눌러주세요.<br>
							구매 확정이 된 상품은 <b>배송 완료</b> 버튼을 눌러주세요.
						</p><br><br><br>
					</div>
					<div id="btnArea">
						<button id="shipBtn" onclick="shipEnd()">배송 시작</button>
						<button id="orderBtn" onclick="orderEnd()">배송 완료</button>
					</div>
				</c:if>

				<c:if test="${ !empty molist }">
					<div align="center" class="pagingArea">
						<!-- [이전 비활성화] -->
						<c:if test="${ pi.currentPage <= 1 }">
							<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events: none;">
						</c:if>

						<!-- [이전] -->
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="mdShipManagement.md">
								<c:param name="page" value="${ pi.currentPage - 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&lt;" onclick="location.href='${ before }'">
						</c:if>

						<!-- [페이지] -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:url var="pagination" value="${ mdShipManagement.md }">
								<c:param name="page" value="${ p }" />
							</c:url>
							<c:if test="${ p eq pi.currentPage }">
								<input type="button" id="choosen" value="${ p }" disabled="disabled">
							</c:if>
							<c:if test="${ p ne pi.currentPage }">
								<input type="button" class="numBtn" value="${ p }" onclick="location.href='${ pagination }'">
							</c:if>
						</c:forEach>

						<!--[다음 비활성화] -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							<input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events: none;">
						</c:if>

						<!-- [다음] -->
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="${ mdShipManagement.md }">
								<c:param name="page" value="${ pi.currentPage + 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
						</c:if>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
		//전체 체크
		var leng = ${ molist.size() }
		
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
		
		function shipEnd(){
			var chkArr = new Array();
			$("input[name='chk']:checked").each(function(i){
				chkArr.push($(this).val());
			});
			
			if(chkArr.length == 0){
				alert("배송 완료하는 배송현황을 선택해주세요");
				return false;
			} else{
				location.href='shipEnd.md?chkArr='+chkArr;
			}
		}
		
		function orderEnd(){
			var chkArr = new Array();
			$("input[name='chk']:checked").each(function(i){
				chkArr.push($(this).val());
			});
			
			if(chkArr.length == 0){
				alert("구매 확정하는 배송현황을 선택해주세요");
				return false;
			} else{
				location.href='orderEnd.md?chkArr='+chkArr;
			}
		}
		
		
		$("#selectBox").change(function(){
			
			var selectVal = $(this).val();
			
			if(selectVal == 'all'){
				location.reload();
			}
			
			if(selectVal == 'orderIng'){
				$.ajax({
					url : 'orderIng.md',
					success : function(data){
				 		$tableBody = $("#tableArea tbody");
						$tableBody.html('');
						$pagingArea = $(".pagingArea");
						$pagingArea.html('');
						//리스트 새로 불러오기
						var $tr;
						var $chk;
						var $receiver;
						var $mId;
						var $mdName;
						var $mdAmount;
						var $address;
						var $phone;
						var $addressRequest;
						var $orderDate;
						var $totalPrice;
						var $ship;
						
						if(data.molist.length > 0){
							for(var i in data.molist){	
								
								$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
								$chk = $('<td><input type="checkbox" value="'+ data.molist[i].mdOrderNum + '" class="chk" name="chk" >');
								$receiver = $('<td>').text(data.molist[i].receiver);
								$mId = $('<td>').text(data.molist[i].mId);
								$mdName = $('<td><img src="${ contextPath }/resources/mdUploadFiles/' + data.flist[i].changeName + '" class="imgTd"><br><label>' + data.mdlist[i].mdName + '</label>');
								console.log(data.mdlist[i].mdName);
								$mdAmount = $("<td>").text(data.molist[i].mdAmount);
								$address = $("<td>").text(data.molist[i].address);
								$phone = $("<td>").text(data.molist[i].phone);
								$addressRequest=$("<td>").text(data.molist[i].addressRequest);
								$orderDate = $("<td>").text(data.molist[i].orderDate);
								$totalPrice = $("<td>").text(data.molist[i].totalPrice);
								
								$ship = $("<td>").text(data.molist[i].mdShipStatus);
								if($ship != ''){
									$ship = $("<td style='color:red; font-weight:bold;'>").text("주문 접수 중");
								}
								
								//붙이기
								$tr.append($chk).append($receiver).append($mId).append($mdName).append($mdAmount).
										append($address).append($phone).append($addressRequest).append($orderDate).append($totalPrice).append($ship);
								$tableBody.append($tr);
							}
						} else {
							$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
							$dd = $("<td colspan='11'>").text("주문 접수 중인 상품이 없습니다.");
							
							$tr.append($dd);
							$tableBody.append($tr);
						}
					}
					
				});
			} else if(selectVal == 'shipIng'){
				$.ajax({
					url : 'shipIng.md',
					success : function(data){
				 		$tableBody = $("#tableArea tbody");
						$tableBody.html('');
			              
						$pagingArea = $(".pagingArea");
						$pagingArea.html('');
						//리스트 새로 불러오기
						var $tr;
						var $chk;
						var $receiver;
						var $mId;
						var $mdName;
						var $mdAmount;
						var $address;
						var $phone;
						var $addressRequest;
						var $orderDate;
						var $totalPrice;
						var $ship;	
						
						if(data.molist.length > 0){
							for(var i in data.molist){	
								
								$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
								$chk = $('<td><input type="checkbox" value="'+ data.molist[i].mdOrderNum + '" class="chk" name="chk" >');
								$receiver = $('<td>').text(data.molist[i].receiver);
								$mId = $('<td>').text(data.molist[i].mId);
								$mdName = $('<td><img src="${ contextPath }/resources/mdUploadFiles/' + data.flist[i].changeName + '" class="imgTd"><br><label>' + data.mdlist[i].mdName + '</label>');
								console.log(data.mdlist[i].mdName);
								$mdAmount = $("<td>").text(data.molist[i].mdAmount);
								$address = $("<td>").text(data.molist[i].address);
								$phone = $("<td>").text(data.molist[i].phone);
								$addressRequest=$("<td>").text(data.molist[i].addressRequest);
								$orderDate = $("<td>").text(data.molist[i].orderDate);
								$totalPrice = $("<td>").text(data.molist[i].totalPrice);
								
								$ship = $("<td>").text(data.molist[i].mdShipStatus);
								if($ship != ''){
									$ship = $("<td style='color:rgb(227, 189, 152); font-weight:bold;'>").text("배송 중");
								}
								
								//붙이기
								$tr.append($chk).append($receiver).append($mId).append($mdName).append($mdAmount).
										append($address).append($phone).append($addressRequest).append($orderDate).append($totalPrice).append($ship);
								$tableBody.append($tr);
							}
						} else {
							$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
							$dd = $("<td colspan='11'>").text("배송 중인 상품이 없습니다.");
							
							$tr.append($dd);
							$tableBody.append($tr);
						}
						
					}
				});
			} else if(selectVal == 'shipEnd'){
				$.ajax({
					url : 'shipEndManager.md',
					success : function(data){
				 		$tableBody = $("#tableArea tbody");
						$tableBody.html('');
						$pagingArea = $(".pagingArea");
						$pagingArea.html('');			               
						//리스트 새로 불러오기
						var $tr;
						var $chk;
						var $receiver;
						var $mId;
						var $mdName;
						var $mdAmount;
						var $address;
						var $phone;
						var $addressRequest;
						var $orderDate;
						var $totalPrice;
						var $ship;	
						
						if(data.molist.length > 0){
							for(var i in data.molist){	
								
								$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
								$chk = $('<td><input type="checkbox" value="'+ data.molist[i].mdOrderNum + '" class="chk" name="chk" >');
								$receiver = $('<td>').text(data.molist[i].receiver);
								$mId = $('<td>').text(data.molist[i].mId);
								$mdName = $('<td><img src="${ contextPath }/resources/mdUploadFiles/' + data.flist[i].changeName + '" class="imgTd"><br><label>' + data.mdlist[i].mdName + '</label>');
								console.log(data.mdlist[i].mdName);
								$mdAmount = $("<td>").text(data.molist[i].mdAmount);
								$address = $("<td>").text(data.molist[i].address);
								$phone = $("<td>").text(data.molist[i].phone);
								$addressRequest=$("<td>").text(data.molist[i].addressRequest);
								$orderDate = $("<td>").text(data.molist[i].orderDate);
								$totalPrice = $("<td>").text(data.molist[i].totalPrice);
								
								$ship = $("<td>").text(data.molist[i].mdShipStatus);
								if($ship != ''){
									$ship = $("<td style='font-weight:bold;'>").text("배송 완료");
								}
								
								//붙이기
								$tr.append($chk).append($receiver).append($mId).append($mdName).append($mdAmount).
										append($address).append($phone).append($addressRequest).append($orderDate).append($totalPrice).append($ship);
								$tableBody.append($tr);
							}
						} else {
							$tr = $('<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33); height: 130px;">');
							$dd = $("<td colspan='11'>").text("배송 완료된 상품이 없습니다.");
							
							$tr.append($dd);
							$tableBody.append($tr);
						}
						
					}
				});				
			}
			
		});
		
		
	</script>
</body>
</html>