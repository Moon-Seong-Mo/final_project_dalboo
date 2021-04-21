<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | MD 주문 목록</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/mdOrderList.css">
</head>
<body>

	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div class="outer">
				<h2 align="left">MD주문 목록</h2>
				
				<div align="left" id="topDiv">
					<b id="bStyleText">주문 현황</b>&nbsp;&nbsp;&nbsp;배송중 
					<b id="bStyle">${ ship }</b> 구매 확정 <b id="bStyle">${ end }</b>
					<p id="explain">
						동일한 주문번호라도 2개 이상의 브랜드에서 주문하신 경우 출고지 주소가 달라 각각 출고됩니다. (택배 박스를 2개 이상 수령 가능)
						<br><br>
						출고 완료 직후 교환 / 환불 요청을 하더라도 상품을 수령하신 후 택배 업체를 통해 보내주셔야 처리 가능합니다.
					</p>
				</div>			
				
				<div id="mdOrder-table">
					<table id="tableArea">
						<thead>
							<tr style="background:#e9e9e9; height:50px;">
								<th colspan="2">상품 정보</th>
								<th>주문일자</th>
								<th>주문금액</th>
								<th>주문 상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${ empty molist }">	
								<tr style="border-bottom:1px solid rgba(75, 75, 75, 0.33);">
									<td colspan="5"><h3>주문하신 상품이 없습니다!</h3></td>
								</tr>
							</c:if>
							
							<c:if test="${ !empty molist }">
								<c:forEach var="mo" items="${ molist }" varStatus="vs">
									<tr style="border-bottom: 1px solid rgba(75, 75, 75, 0.33);">
										<td width="15%"><a href="mdDetail.md?mdNum=+${ mo.mdNum }"><img src="${ contextPath }/resources/mdUploadFiles/${ flist[vs.index].changeName }" class="imgTd"></a></td>
										<td width="15%">
											${ mdlist[vs.index].mdName }<br><b><fmt:formatNumber value="${ mdlist[vs.index].mdPrice }" pattern="#,###" /></b>원 <br>
											<br>개수 : ${ mo.mdAmount }개
										</td>
										<td>${ mo.orderDate }</td>
										<td style="border-left:1px solid lightgray; border-right:1px solid lightgray;" >${mo.totalPrice }</td>
										<td>
											<c:if test="${ mo.mdShipStatus eq 0 }">
												<img src="${ contextPath }/resources/images/상품준비.PNG" width="100px">
												<br>상품 준비 중입니다. 
											</c:if> 
											<c:if test="${ mo.mdShipStatus eq 1 }">
												<img src="${ contextPath }/resources/images/배송중.PNG" width="100px"><br>배송중 
											</c:if> 
											<c:if test="${ mo.mdShipStatus eq 2 }">
												<img src="${ contextPath }/resources/images/배송완료.jpg" width="100px"><br>배송 완료 
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<c:if test="${ !empty molist }">
					<div align="center" id="pagingArea">
						<!-- 이전:비활성화 -->
						<c:if test="${ pi.currentPage <= 1 }">
							<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
						</c:if>
						
						<!-- 이전: 활성화 -->
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="mdBuyCompleteView.md">
								<c:param name="page" value="${ pi.currentPage - 1 }"/>
							</c:url>
							<input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
						</c:if>
						
						<!-- 페이지 -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:url var="pagination" value="${ mdBuyCompleteView.md }">
								<c:param name="page" value="${ p }" />
							</c:url>
							<c:if test="${ p eq pi.currentPage }">
								<input type="button" id="choosen" value="${ p }" disabled="disabled" style="pointer-events:none;">
							</c:if>
							<c:if test="${ p ne pi.currentPage }">
								<input type="button" class="numBtn" value="${ p }" onclick="location.href='${ pagination }'">
							</c:if>
						</c:forEach>
						<!-- 다음:비활성화 -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							<input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events:none;">
						</c:if>
	
						<!-- 다음:활성화 -->
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="${ mdBuyCompleteView.md }">
								<c:param name="page" value="${ pi.currentPage + 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
						</c:if>					
					</div>
				</c:if>
				
				<c:if test="${ empty molist }">
					<button id="MdBtn" onclick="location.href='mdMain.md?mdCategory=머그컵'">상품 둘러보기</button>
				</c:if>

			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>