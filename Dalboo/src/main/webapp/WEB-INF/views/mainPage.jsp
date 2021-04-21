<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 메인</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/mainPage.css">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<style>
</style>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
         
         <div id="content">
            
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
      
        
         <div>
                <div class="center-banner-menuArea" id="center-banner-menu1" style="background-image:url('resources/images/mainCoffeeimg5.jpg'); width:59%; height:400px;">
                  <div class="center-banner-menu-btnArea">
                  <button class="center-banner-btn1" onclick="location.href='coffee_list.cf'"   >+</button><br>
                  <span class="center-banner-menu-span" style="font-size: 2.8rem; font-weight:bold; color:#6b4d30;">FRESH COFFEE</span>
                     <p style="font-size: 1.45rem; color:#6b4d30;">신선한 원두로 만든 커피!</p>
               </div>
               </div>
               <div class="center-banner-menuArea" id="center-banner-menu2" style="background-image:url('resources/images/mainMdimg.jpg'); width:40%; height:400px;">
                  <div class="center-banner-menu-btnArea">
                  <button class="center-banner-btn1"   onclick="location.href='mdMain.md?mdCategory=머그컵'" >+</button>
                  <span class="center-banner-menu-span" style="font-size: 2.8rem; font-weight:bold; color:white;">MD's PICK</span>
                     <p style="font-size: 1.45rem; color:white;">달보드레의 다양한 상품을 선물하세요!</p>
               </div>
               </div> 
            </div>
            
            
          <!-- div 영역 -->
         <div id="center-banner" style="background-image:url('resources/images/메인창업이미지.jpg'); ">               
            <div id="center-banner-btnArea">
               <div  style="float:left; margin-left:10%; margin-top:100px; font-size:30px; font-weight:bold; color:white;">
                  <span id="center-banner-sapn">DALBODRE COFFEE STARTUPS</span><br>
                  <button class="center-banner-btn2" onclick="location.href='startUpProcedureView.etc'">창업절차</button>
                  <button class="center-banner-btn2" onclick="location.href='startupApplyView.etc'">창업문의</button>
                  <div
                    id="kakao-talk-channel-chat-button"
                    data-channel-public-id="_wqJmK"
                    data-title="consult"
                    data-size="small"
                    data-color="yellow"
                    data-shape="pc"
                    data-support-multiple-densities="true"
                  ></div>                                 
               </div>               
            </div>
         </div>
            
            
         <div style="margin:0 auto;">    
         <div class="service-banner" style="width:500px;">
               <!-- 매장 검색 -->
               <div class="service-banner-div" >
                  <div style="background-color: rgba( 255, 255, 255, 0.5 ); width:350px; height:250px; position:relative;">
                     <h2 class="service-banner-font">STORE</h2>
                     <p align="left" style="margin-left:15px;">주변의 매장을 검색해보세요!</p>
                     <span class="service-banner-Orderbtn">
                     <input type="text" placeholder="매장명을 입력하세요." id="storeSearchInput">
                  </span>
                  </div>
               </div>
                  <script>
                  $("#storeSearchInput").keydown(function(key) {
                     var option = "매장명";
                     var Text = $(this).val();
                     var currentPage = Number(0);
                     if (key.keyCode == 13) {
                        if(confirm('검색 페이지로 이동하시겠습니까?')){
                           location.href='search.etc?option=' + option + '&searchText=' + Text + '&currentPage=' + currentPage;
                       return true;                       
                        }else{
                           return false;
                        }
                     }
                     });
                  </script>    
               <!-- 사이렌 오더 -->
               <div class="service-banner-div" style="margin-top:20px; cursor:pointer;" onclick="location.href='siren.cf'">
                  <div style="background-color: rgba( 255, 255, 255, 0.5 ); width:350px; height:250px; position:relative;">
                     <h2 class="service-banner-font">SIREN ORDER</h2>
                     <p align="left" style="margin-left:15px;">간편하게 주문해보세요!</p>
                     <span class="service-banner-Orderbtn" >
                        <img src="resources/images/smartphone.png" width="50px" height="40px" style="margin-top: 62px; float:left;">
                        <img src="resources/images/mainBeans.png" width="50px" height="40px" style="float: right; width: 140px; height: 120px;">
                     </span>
                  </div>
               </div>                  
         </div>
         <div class="service-banner" >
            <h1>이벤트 소식</h1>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                  <div class="swiper-slide">
                     <div class="bx_group">
                        <div style="background-image:url('resources/images/MainVoteResult.png'); background-size:cover;"></div>
                     </div>
                 </div>
                 <div class="swiper-slide">
                     <div class="bx_group">
                        <div style="background-image:url('resources/images/MainSlideImg1.jpg'); background-size:cover;"></div>
                     </div>
                 </div>
                  <div class="swiper-slide">
                     <div class="bx_group">
                        <div style="background-image:url('resources/images/MainSlideImg2.jpg'); background-size:cover;"></div>
                     </div>
                 </div>
                  <div class="swiper-slide">
                     <div class="bx_group">
                        <div style="background-image:url('resources/images/MainSlideImg3.jpg'); background-size:cover;"></div>
                     </div>
                 </div>
                </div>
            
             </div>      
            
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
          <script>
          var swiper = new Swiper('.swiper-container', {
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
         
         
         
         <script>
           window.kakaoAsyncInit = function() {
             Kakao.Channel.createChatButton({
               container: '#kakao-talk-channel-chat-button',
             });
           };
         
           (function(d, s, id) {
             var js, fjs = d.getElementsByTagName(s)[0];
             if (d.getElementById(id)) return;
             js = d.createElement(s); js.id = id;
             js.src = 'https://developers.kakao.com/sdk/js/kakao.channel.min.js';
             fjs.parentNode.insertBefore(js, fjs);
           })(document, 'script', 'kakao-js-sdk');
         </script>
         
         
         </div>      
      </div>
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
         
      </div>
</body>
</html>