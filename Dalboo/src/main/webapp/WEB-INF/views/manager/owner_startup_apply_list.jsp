<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 가맹주 창업신청서 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/owner_startup_apply_list.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
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
			
			<div id="owner_notice">
			<br>
			<h2>창업신청 내역</h2>
			<hr>
			<table id="tb">
			<thead>
				<tr>
					<th width="10%">No.</th>
					<th width="30%">제목</th>
					<th width="10%">작성자</th>
					<th width="20%">등록일</th>
					<th width="10%">승인여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="b" items="${ list }">
						<tr class="trContent">
							<td align="center">${ b.sNum }</td>
							<td align="center">
								<c:if test="${ !empty loginUser }">
									<c:url var="applydetail" value="applydetail.ow">
										<c:param name="sNum" value="${ b.sNum }"/>
										<c:param name="page" value="${ pi.currentPage }"/>
									</c:url>
									<a href="${ applydetail  }">${ b.sTitle }</a>
								</c:if>
								<c:if test="${ empty loginUser }">
									${ b.sTitle }		
								</c:if>
							</td>
							
							<td align="center">${ b.sName }</td>
							<td align="center">${ b.startDate }</td>
							<td align="center">${ b.sConfirm }</td>
					   </tr>
					</c:forEach>
			</tbody>		
			</table>
			
			<!-- 페이징  -->
				<div class="pagingArea" align="center">
					<!-- [이전 비활성화] -->
					<c:if test="${ pi.currentPage <= 1 }">
						<input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
					</c:if>
					
					<!-- [이전] -->
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="startUpList.ow">
							<c:param name="page" value="${ pi.currentPage - 1 }" />
						</c:url>
						<input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
					</c:if>

					<!-- [페이지] -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:url var="pagination" value="startUpList.ow">
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
						<c:url var="after" value="startUpList.ow">
							<c:param name="page" value="${ pi.currentPage + 1 }" />
						</c:url>
						<input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
					</c:if>
				</div>
         	
         	
         	
         	<div id="searchArea">
         	<select name="search" id="searchCate">
                <option>제목</option>
                <option>작성자</option>
            </select>
            <input type="text" id="searchText" placeholder="제목을 입력해주세요.">
            <button type="button" id="search" onclick="searchBtn();">검색</button>
         	
            </div>
			</div>
		</div>
	</div>
			
			<script>
				function searchBtn(){

					var option = document.getElementById('searchCate').value;
					var title = document.getElementById('searchText').value;
					
					
					$.ajax({
						url: 'searchApply.ow',
						data: {title:title,
							   option:option},
						success:function(data){
							$tableBody = $('#tb tbody');
			   				$tableBody.html('');
			   				
			   				if(data.length == 0){
			   					alert('검색결과가 존재하지 않습니다.');
			   				}
			   				for(var i in data){
			   					var $tr = $('<tr>');
			   					var $sNum = $('<td>').text(data[i].sNum);
			   					var $sTitle = $('<td>').text(data[i].sTitle);
			   					var $sWriter = $('<td>').text(data[i].sName);
			   					var $sCreateDate = $('<td>').text(data[i].startDate);
			   					var $sStatus = $('<td>').text(data[i].sStatus);
			   					
			   					
			   					$tr.append($sNum);
			   					$tr.append($sTitle);
			   					$tr.append($sWriter);
			   					$tr.append($sCreateDate);
			   					$tr.append($sStatus);
			   					
			   					$tableBody.append($tr);
			   					
			   					$(document).ready(function(){
			   					    $('tr').attr({
			   					        "class" : "trContent"
			   					    });   
			   					});
			   					
			   					$(function(){
			   						$('.trContent').mouseenter(function(){
			   							$(this).css({'font-weight':'bold','cursor':'pointer'});
			   						}).mouseout(function(){
			   							$(this).css({'font-weight':'normal'});
			   						}).click(function(){
			   							var bId = $(this).children('td').eq(0).text();
			   							
			   							
			   								location.href='applydetail.ow?sNum=' + bId + '&page=' + ${pi.currentPage};
			   							
			   						});
			   					});
			   				} 
						}
						
					});
				}
			</script>
		
</body>
</html>