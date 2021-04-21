<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/owner_startup_apply_detail.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
   #my-spinner {
   width: 100%; height: 100%;
   top: 0; left: 0;
   display: none;
   opacity: .6;
   background: silver;
   position: fixed;
}
#my-spinner div {
   width: 100%; height: 100%;
   display: table;
}
#my-spinner span {
   display: table-cell;
   text-align: center;
   vertical-align: middle;
}
#my-spinner img {
   background: white;
   padding: 1em;
   border-radius: .7em;
}
</style>

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
          
          
          
          
          
       <h2>창업신청 내역</h2>
       <hr>
        <div id="startup_detail_area">
        
       <div id="startup_content">
               <br>
               <font style="margin-left : 15px;font-size: 25px; font-weight: bold;">${ s.sTitle }</font><br><br>
               <font style="margin-left : 15px; font-weight: bold; font-size: 22px;">${ s.sName }</font><br>
               <font style="margin-left : 15px;font-size: 18px;">${ s.startDate }</font><br>
               <br>
               <hr><br>
            
               <table>
                  <tr>
                     <th>이름</th>
                     <td>${ s.sName }</td>
                  </tr>
                  <tr>
                     <th>연락처</th>
                     <td>${ s.sPhone }</td>
                  </tr>
                  <tr>
                     <th>매장명</th>
                     <td>${ s.storeName }</td>
                  </tr>
                  <tr>
                     <th>창업 희망 지역</th>
                     <td>${ s.sAddress }</td>
                  </tr>
                  <tr>
                     <td colspan="2"></td>
                  </tr>
                  <tr>
                     <th>내용 / 창업 계획</th>
                     <td>
                     <textarea id="startUpContent" cols="50" rows="10" readonly>${ s.sContent }</textarea>   
                     </td>
                  </tr>
                  
               </table>
               
               
         </div>
         <button id="list"  onclick="location.href='startUpList.ow'">목록으로</button>
           <button  id="delete" value="삭제" onclick="deleteApply();">삭제</button>
         <c:if test="${ s.sConfirm eq '대기' }">
            <button id="accept" value="승인" onclick="statusApply(this);">승인</button>
             <button id="refusal" value="거절" onclick="statusApply(this);">거절</button>
         </c:if>   
        
        <script>
   
        function deleteApply(){
               var con = confirm("정말 삭제하시겠습니까?");
            if(con){
               var sNum = ${s.sNum}   
               location.href='deleteApply.ow?sNum=' + sNum;
            } else{
               alert('취소하셨습니다.');
               return false;
            }
      }
   

        function statusApply(chk){
         console.log($(chk).val());
           var chkBtn = $(chk).val();
           var sNum = ${s.sNum};
          var con = confirm(chkBtn + "하시겠습니까?");
              if(con){
                    $.ajax({
                       url: 'startUpApplyChk.ow',
                       data: {sNum:sNum, 
                             chkBtn:chkBtn},
                             success:function(data){
                          if(data == 'ok'){
                             alert(chkBtn + '처리되었습니다.');
                             location.reload();
                          }else{
                             alert(chkBtn + '에 실패했습니다.');
                          }
                       }
                    });
                    }else{
                       alert("취소하셨습니다.");
                       return false;
                    }                              
         }
        </script>
        <script>
           $(document).ready(function(){
             $('#my-spinner').hide(); //첫 시작시 로딩바를 숨겨준다.
         })
         .ajaxStart(function(){
            $('#my-spinner').show(); //ajax실행시 로딩바를 보여준다.
         })
         .ajaxStop(function(){
            $('#my-spinner').hide(); //ajax종료시 로딩바를 숨겨준다.
         });
        </script>
        <div id='my-spinner'>
          <div><span>
             <img src='//cdnjs.cloudflare.com/ajax/libs/galleriffic/2.0.1/css/loader.gif'>
          </span></div>
         </div>
          
      </div>
     </div> 
   </div>
   
   
</body>
</html>

