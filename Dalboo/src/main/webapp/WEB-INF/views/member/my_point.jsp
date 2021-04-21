<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 포인트 적립내역</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/member/my_point.css">
<style>

#my_point_area{
	width: 1000px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 5%;
}

#pLogo{
	width: 45px;
    height: 40px;
    position: relative;
    top: 8px;
}

#textP{
	font-size:25px;
	font-weight: bold;
	margin-bottom:3px;
}

.imgP{
	width:40px; 
	margin-bottom: 0px;}

#table-area{
	margin-top: 45px;
}

#pTable{
	width: 1000px;
	border-collapse:collapse;
    font-size: 18px;
}

#line{
	border-collapse: collapse;
}

#dotted td{
	border-bottom: 3px dotted lightgray;
}

#pTable thead{
	text-align: center;
}

#pTable tbody{
	text-align: center;
}

#empty td{
	font-size: 30px;
	font-weight: bold;
}


/* 페이징 처리 */
.pagingArea{
    margin-top: 30px;
}

.numBtn{
   border: 0px; 
   background-color:rgb(244, 244, 244);
   width:30px; 
   height:30px; 
   border-radius:5px;
   cursor: pointer;
}
   
.Btn{
   border: 0px; 
   background-color: rgb(244, 244, 244); 
   width:30px; 
   height:30px; 
   border-radius:5px;
   cursor: pointer;   
}

#choosen{
   border: 0px; 
   background-color: rgb(227, 189, 152); 
   color:white; 
   width:30px; 
   height:30px; 
   border-radius:5px;
   cursor: pointer;   
}



</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
		
		
			<div id="my_point_area">
				<br>
				<h2 align="left">포인트 적립 내역</h2>
				<hr>
					<p id="textP">보유 포인트 <img src="${ contextPath }/resources/images/포인트.png" class="imgP">${ loginUser.point }</p>
			
				<div id="table-area">
					<c:if test="${ !empty phList }">
						<table id="pTable">
							<thead>
								<tr style="background: #e9e9e9; height: 50px;">
									<th width="10%">유형</th>
									<th width="15%">날짜</th>
									<th width="25%">주문 내역</th>
									<th width="13%">주문 금액</th>
									<th width="12%">포인트</th>
									<th width="15%">총 포인트</th>
								</tr>
							</thead>
							<c:forEach var="ph" items="${ phList }">
								<tbody>
									<tr style="border-bottom: 2px solid rgba(75, 75, 75, 0.33);">
										<td>
											<c:if test="${ ph.conditions eq 0 }">
												<img src="${ contextPath }/resources/images/적립.png" width="100px">
											</c:if> <c:if test="${ ph.conditions eq 1 }">
												<img src="${ contextPath }/resources/images/사용.png" width="100px">
											</c:if>
										</td>
										<td>${ ph.eventDate }</td>
										<td>${ ph.event }</td>
										<td>
											<c:if test="${ ph.event eq '회원가입 이벤트' }"></c:if> 
											<c:if test="${ ph.event ne '회원가입 이벤트' }">
												<c:if test="${ ph.conditions eq 0 }"> ${ ph.changePoint * 10 }</c:if>
											</c:if>
										</td>
										<td><c:if test="${ ph.conditions eq 0 }">
													+${ ph.changePoint }
												</c:if> <c:if test="${ ph.conditions eq 1 }">
													-${ ph.changePoint }
												</c:if></td>
										<td><b>${ ph.afterPoint }</b></td>
									</tr>
								</tbody>
							</c:forEach>
						</table>
					</c:if>
					<c:if test="${ empty phList }">
						<h3>포인트 적립 내역이 없습니다.</h3> 
					</c:if>
				</div>

				<c:if test="${ !empty phList }">
					<div align="center" class="pagingArea">
						<!-- [이전 비활성화] -->
						<c:if test="${ pi.currentPage <= 1 }">
							<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events: none;">
						</c:if>

						<!-- [이전] -->
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="myPointList.me">
								<c:param name="page" value="${ pi.currentPage - 1 }" />
							</c:url>
							<input type="button" class="Btn" value="&lt;" onclick="location.href='${ before }'">
						</c:if>

						<!-- [페이지] -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:url var="pagination" value="${ myPointList.me }">
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
							<c:url var="after" value="${ myPointList.me }">
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