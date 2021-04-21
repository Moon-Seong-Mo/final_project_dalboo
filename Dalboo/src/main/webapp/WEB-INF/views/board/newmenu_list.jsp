<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 신메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/newmenu_list.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp" %>
		<div id="content">
				
			<!-- 슬라이드 영역-->
			
			<div class="main-slide-container">
			    <div class="swiper-wrapper">
			      <div class="swiper-slide">
						 <div class="main-slide-img-div">
					  	 	<div><img src="resources/images/slideImage.JPG" width="100%" height="100%"></div>
					  	 </div>
				  </div>
				  <div class="swiper-slide">
						 <div class="main-slide-img-div">
					  	 	<div><img src="resources/images/slideImage2.jpg" width="100%" height="100%"></div>
					  	 </div>
				  </div>
				  <div class="swiper-slide">
						 <div class="main-slide-img-div">
					  	 	<div><img src="resources/images/slideImage3.jpg" width="100%" height="100%"></div>
					  	 </div>
				  </div>
			    </div>
			    <div class="swiper-pagination"></div>
			    <div class="main-swiper-button-next"></div>
			    <div class="main-swiper-button-prev"></div>
			  </div>
			  
		  <script>
    		var main = new Swiper('.main-slide-container', {
		      navigation: {
		        nextEl: '.swiper-button-next',
		        prevEl: '.swiper-button-prev',
		      },
		      autoplay: {
		          delay: 2500,
		          disableOnInteraction: false,
		        }
		    });
		   </script>
	<!-- 여기까지 -->
	<div class="outer">
		<br>
		<ul id="tab-btn">
		
			<li><a href="notice_list.bo">공지사항</a></li> <b>|</b>
			<li><a href="event_list.bo">이벤트 </a></li> <b>|</b>
			<li><a href="nList.bo">이달의 신메뉴</a></li>
			
		</ul>
		<div class="listArea">
			<div id="title-Page">
				<h2>이달의 신메뉴</h2>
				<table id="tableArea">
					<tr>
						<th id="no">글번호</th>
						<th id="title" width="650px">글제목</th>
						<th id="writer" width="150px">작성자</th>
						<th id="date" width="150px">작성일</th>
						<th id="count">조회수</th>
					</tr>
					<c:forEach var="b" items="${ list }">
						<tr class="tr-content">
							<td align="center">${ b.nNum }</td>
							<td align="center">
								<c:if test="${ !empty loginUser }">
									<c:url var="nmdetail" value="nmdetail.bo">
										<c:param name="nNum" value="${ b.nNum }"/>
										<c:param name="page" value="${ pi.currentPage }"/>
									</c:url>
									<a href="${ nmdetail }">${ b.title }</a>
								</c:if>
								<c:if test="${ empty loginUser }">
									${ b.title }		
								</c:if>
							</td>
							
							<td align="center">${ b.mId }</td>
							<td align="center">${ b.createDate }</td>
							<td align="center">${ b.views }</td>
					   </tr>
					</c:forEach>
				</table>
				<!-- 페이징  -->
				<div class="pagingArea" align="center">
					<!-- [이전 비활성화] -->
					<c:if test="${ pi.currentPage <= 1 }">
						<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
					</c:if>
					
					<!-- [이전] -->
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="nList.bo">
							<c:param name="page" value="${ pi.currentPage - 1 }" />
						</c:url>
						<input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
					</c:if>

					<!-- [페이지] -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:url var="pagination" value="nList.bo">
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
						<input type="button" class="Btn" value="&gt;" disabled="disabled" style="pointer-events:none;">
					</c:if>

					<!-- [다음] -->
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="nList.bo">
							<c:param name="page" value="${ pi.currentPage + 1 }" />
						</c:url>
						<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
					</c:if>
				</div>
				<script>
				$(function(){
					$('.tr-content').mouseenter(function(){
						$(this).css({'font-weight':'bold','cursor':'pointer'});
					}).mouseout(function(){
						$(this).css({'font-weight':'normal'});
					}).click(function(){
						var bId = $(this).children('td').eq(0).text();						
					});
				});
				</script>
			</div>	
		</div>	
			<c:if test="${ loginUser.rank_code eq '2'}">
				<button id="newMenuInsert" onclick="location.href='menuWrite.bo'">작성하기</button>		
			</c:if>
		</div>
	</div>
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>