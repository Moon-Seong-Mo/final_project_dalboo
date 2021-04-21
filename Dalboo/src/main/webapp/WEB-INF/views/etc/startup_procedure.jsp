<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 창업절차</title>
<style>
	
</style>
</head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/etc/startup_procedure.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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
	
		<div id="contentArea">
			<div id="page-title"><h2>창업 절차</h2>
				<p>가맹점 창업을 위한 절차를 설명드리니 참고가 되시길 바랍니다.</p>
			</div>
			<div class="list-div">
				<h1 class="seq">1</h1>	
				<strong class="div-text">창업 설명회</strong>
				<p class="div-text">가맹지원서 및 상권조사표 작성</p>
			</div>
			<div class="list-div">
				<h1 class="seq">2</h1>		
				<strong class="div-text">점포문의 및 본부확인</strong>
				<p class="div-text">상권 및 입지확인<br>수도권:약1주, <br> 지방:약2주 소요</p>
			</div>
			<div class="list-div">
				<h1 class="seq">3</h1>		
				<strong class="div-text">본사 점주 승인</strong>
				<p class="div-text">검토 후 <br>가맹점 개설 여부 결정</p>
			</div>
			<div class="list-div">
				<h1 class="seq">4</h1>		
				<strong class="div-text">점포 개설 협의</strong>
				<p class="div-text">인테리어 및 시설공사 등<br>점포 개설 과정 협의</p>
			</div>
			<div class="list-div">
				<h1 class="seq">5</h1>		
				<strong class="div-text">당사 계약 체결</strong>
				<p class="div-text">최소 2년 계약, 이후 1년 단위 재계약<br>임대차 계약 후 가맹 계약 체결</p>
			</div>
			<div class="list-div">
				<h1 class="seq">6</h1>		
				<strong class="div-text">인테리어 & 시설공사</strong>
				<p class="div-text">약 3주 내외 소요, 현장 상황에 따라 변동 가능</p>
			</div>
			<div class="list-div">
				<h1 class="seq">7</h1>		
				<strong class="div-text">교육</strong>
				<p class="div-text">점주 포함 최소 2명,<br>교육 기간 최소 14일</p>
			</div>
			<div class="list-div">
				<h1 class="seq">8</h1>		
				<strong class="div-text">개점준비 & 가오픈</strong>
				<p class="div-text">운영 시뮬레이션을 통한 <br>오픈 준비사항 최종 점검</p>
			</div>
			<div class="list-div">
				<h1 class="seq">9</h1>		
				<strong class="div-text">개점</strong>
				<p class="div-text">가맹점 정식 오픈 및 인터넷<br> 매장 정보 등극</p>
			</div>
			<div class="list-div">
				<h1 class="seq">10</h1>		
				<strong class="div-text">사후 관리</strong>
				<p class="div-text">관리 본사 점검팀 순회를 통해 주기적인 매장 점검</p>
			</div>
						
			<div id="page-title"><h2>창업문의</h2>
				<p>잠깐, 꼭 확인하세요!</p>
			</div>
			
			<div id="Inquiry-area">
				<p id="seq">달보드레 창업 문의 시, 아래 사항을 꼭 기재해 주세요. 정확하고 빠른 창업 상담을 위해 필요한 정보입니다.</p>
				<div class="process-div">
					<h1 class="seq">1</h1>		
					<strong>창업 희망 지역</strong>
				</div>
				<div class="process-div">
					<h1 class="seq">2</h1>		
					<strong>점포의 층,전용 면적</strong>
				</div>
				<div class="process-div">
					<h1 class="seq">3</h1>		
					<strong>간판 설치 여부</strong>
				</div>
				<div class="process-div">
					<h1 class="seq">4</h1>		
					<strong>불법 건축물 여부</strong>
				</div>
				<div class="process-div">
					<h1 class="seq">5</h1>		
					<strong>점포의 임대료</strong>
				</div>
				<button id="sbm-btn" onclick="location.href='startupApplyView.etc'">달보드레 창업신청 바로가기</button>
			</div>				
		</div>
	</div>
</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>