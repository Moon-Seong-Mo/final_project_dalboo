<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 이벤트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/board/list.css">
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
				
			<h2>이벤트</h2>
			<table id="tableArea">
		      <tr>
		         <th id="no">글 번호</th>
		         <th id="title">제목</th>
		         <th id="writer">작성자</th>
		         <th id="date">날짜</th>
		         <th id="views">조회수</th>
		      </tr>
		      <c:forEach var="b" items="${ list }">
		      <tr class="contentTR">
		         <td align="center">${ b.bNum }</td>
		         
		         <td align="left">
		            <c:if test="${ !empty loginUser }">
		               <c:url var="bdetail" value="event_detail.bo">
		                  <c:param name="bNum" value="${ b.bNum }"/>
		                  <c:param name="page" value="${ pi.currentPage }"/>
		               </c:url>
		               <a href="${ bdetail }">${ b.bTitle }</a>
		            </c:if>
		            <c:if test="${ empty loginUser }">
		               ${ b.bTitle }      
		            </c:if>
		         </td>
		         
		         <td align="center">${ b.bWriter }</td>
		         <td align="center">${ b.bCreateDate }</td>
		         <td align="center">${ b.bViews }</td>
		      </tr>
		      </c:forEach>
		   </table>
		   
		   
		   

		        

		      
		      
		      
		      <!-- 페이징 처리 -->
		      <div id="buttonTab">
		         
		            <!-- [이전] -->
		            <c:if test="${ pi.currentPage <= 1 }">
		               <a class="Btn">&lt;</a>
		            </c:if>
		            <c:if test="${ pi.currentPage > 1 }"  >
		               <c:url var="before" value="event_list.bo">
		                  <c:param name="page" value="${ pi.currentPage - 1 }"/>
		               </c:url>
		               <a href="${ before }" class="Btn">&lt;</a> 
		            </c:if>
		            
		            <!-- 페이지 -->
		            <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
		               <c:if test="${ p eq pi.currentPage }">
		                  <font  id="choosen" >${ p }</font>
		               </c:if>
		               
		               <c:if test="${ p ne pi.currentPage }">
		                  <c:url var="pagination" value="event_list.bo">
		                     <c:param name="page" value="${ p }"/>
		                  </c:url>
		                  <a href="${ pagination }" class="Btn">${ p }</a> 
		               </c:if>
		            </c:forEach>
		            
		            <!-- [다음] -->
		            <c:if test="${ pi.currentPage >= pi.maxPage }" >
		               <a class="Btn">&gt; </a>
		            </c:if>
		            <c:if test="${ pi.currentPage < pi.maxPage }">
		               <c:url var="after" value="event_list.bo">
		                  <c:param name="page" value="${ pi.currentPage + 1 }"/>
		               </c:url> 
		               <a href="${ after }" class="Btn">&gt;</a>
		            </c:if>
		      </div>

			 <div id="buttonTab">
		            <c:if test="${ loginUser.rank_code eq '2'}">
		               &nbsp; &nbsp; &nbsp;
		               <button onclick="location.href='event_insertView.bo';" id="insertbt">작성하기</button>
		            </c:if>
         	</div>
      

      
					
					
					
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>