<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 주문목록</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/member/my_coffee_order_list.css">

<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
			<div id="order-list-area">
				<br>	
				<h2 align="left" style="margin-left:100px;">주문 조회</h2>
				
				<e:if test="${ empty soList }">
					<table id="empty">
						<tr style="height: 80px;">
							<td>이용 내역이 없습니다.</td>
						</tr>
						<tr></tr>
						<tr>
							<td>사이렌 오더 이용하러가기! -> <button>주문!</button></td>
						</tr>
					</table>
				</e:if>
				
				<div align="center">
					<table style="width:800px; text-align: left;" >
						<e:if test="${ not empty soList }">
							<e:forEach var="s" items="${ soList }">
								<tr style="height: 80px;">
									<td style="font-size: 18px;">
										<e:forEach var="stock" items="${s.stockNames}">
											${ stock } 
										</e:forEach>
										<e:set var="time" value="${ s.so_time }"/><br><br>
										<b>${ s.so_date } &nbsp; ${fn:substring(time,0,5) }</b>  / <b>${ s.so_total_price }</b>원 / ${ s.store_name }								
									</td>
									<td>	
										<e:if test="${ s.so_status2 eq 'Y' }">
											<div id="order-status-ing">
												<span class="order-status">주문 완료</span>
											</div>
										</e:if>
										<e:if test="${ s.so_status2 ne 'Y' }">
											<div id="order-status-end">
												<span class="order-status">주문 완료</span>
											</div>
										</e:if>								
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<!-- <hr style="height:10px; border:0px; box-shadow: 0 10px 10px -10px #bbb inset;"> 그림자 점선 -->
										<hr id="dd">
									</td>
								</tr>
							</e:forEach>
						</e:if>
					</table>
				</div>
			
				<c:if test="${ !empty soList }">
					<div align="center" class="pagingArea">
						<!-- [이전 비활성화] -->
						<c:if test="${ pi.currentPage <= 1 }">
							<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events: none;">
						</c:if>

						<!-- [이전] -->
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="coffeeOrderView.me">
								<c:param name="page" value="${ pi.currentPage - 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&lt;" onclick="location.href='${ before }'">
						</c:if>

						<!-- [페이지] -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:url var="pagination" value="${ coffeeOrderView.me }">
								<c:param name="page" value="${ p }" />
							</c:url>
							<c:if test="${ p eq pi.currentPage }">
								<input type="button" id="choosen" value="${ p }" disabled="disabled" style="pointer-events: none;">
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
							<c:url var="after" value="${ coffeeOrderView.me }">
								<c:param name="page" value="${ pi.currentPage + 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
						</c:if>
					</div>
				</c:if>			
			
			
			
			
			
			
			</div>
			
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>