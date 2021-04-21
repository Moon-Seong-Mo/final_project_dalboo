<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 메뉴</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/order/menu_list.css">
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
			<br>
			<h2>달보드레 메뉴</h2>
			<br>
			<hr>
			
			<div class="outer">
				<ul id="tab-btn">
					<li><a href="newmenu_list.cf">신메뉴</a></li> <b>|</b>
					<li><a href="coffee_list.cf">커피</a></li> <b>|</b>
					<li><a href="ade_list.cf"><b>에이드</b></a></li> <b>|</b>
					<li><a href="dessert_list.cf">디저트</a></li>
				</ul>
				
				
				
					
				<div id="menu-area">
				
				
				
				
						
						<c:forEach var="m" items="${ list }">
						<div class="menu-list-div">
						<c:if test="${ loginUser.rank_code eq '2' }">
						<input type="button" value="X" id="del_menu" onclick="deleteMenu(this);"/>
						<input type="hidden" class="menuNum" value="${ m.mNum }">
						</c:if>
								<img id = "menuimg"  src="resources/muploadFiles/${m.renameFileName }">
							<div class="menu-detail">
								<div class="menu_name">
								<b>${m.mName}</b>
								</div>
								<div class="menu_content">
								${m.mContent}<br>
								</div>
								<div class="menu_size">
								용량  ${m.mCapacity} ml
								</div>
							
							<div class="menu_incontent_table">	
							<ul class="menu_incontent">
								<li>
							 		<div>카페인(mg)  </div>  
							 		<div> ${m.mCaffeine } </div>
							 	</li>
							 	
								<li>
							 		<div>칼로리(kcal)  </div>  
							 		<div> ${m.mCalorie} </div>
							 	</li>
							 	
								<li>
							 		<div>나트륨(mg)   </div>  
							 		<div> ${m.mSodium} </div>
							 	</li>
							 	
							 	
								<li>
							 		<div>당류(g)  </div>  
							 		<div> ${m.mSugar} </div>
							 	</li>
							</ul>
						</div>
						</div>
						${m.mName}
						
						</div>
						</c:forEach>
				</div>
				<div id="btn-area">
					<c:if test="${ loginUser.rank_code eq '2' }">
						<button onclick="location.href='coffee_insertView.cf';" id="insert-btn">추가</button>
				  	</c:if>
				</div>
			</div>
			
			
			
			
			
			</div>
			
			
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<script>
	
	$('.menu-list-div').click(function(){
		 var is_display =  $(this).children('.menu-detail').css('opacity');
    		 console.log(is_display);
      	if(is_display == 0){
    		$(this).children('div').css('opacity','0.9');
      	}else{
      		$(this).children('div').css('opacity','0');
      	}
  });
	
	
	function deleteMenu(bt){
		var mNum = $(bt).next('.menuNum').val();
		
		if(confirm('삭제하시겠습니까?')){
			location.href='ade_delete.cf?mNum=' + mNum;
		}else{
			return false;
		}
	}
    
	
	</script>
</body>
</html>