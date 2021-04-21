<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 사이렌오더</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/etc/store_list.css">

<!-- JQuery Modal Plugs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">

<!-- Daum Address API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- Kakao Map API & library -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a76d669609bbdc285414a8c651ed614a&libraries=services"></script>
</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/nav.jsp" %>
         <div id="content">
         
         <div id="store_list_area">
         
            <br>
            <h1>사이렌 오더</h1>
            <hr>
            <div id="store_search">
               
               <!-- Kakao MAP API 불러오는곳 -->
               <div id="map"></div>
               
               
                <form id="place">
               
               <h3>검색 조건</h3>
                 <select class="searchLocation" id="searchoption" name="searchLocation" style="width:300px;height:50px;">
                   <option value="지역">지역</option>
                   <option value="매장명">매장명</option>
                   <option value="주소">주소</option>
                 </select>
                 
                 <br><br>
               </form>
               
               <form id="shop">
                  <div>
                     <h3>매장 검색</h3>
                  </div>
                  <input type="text" class="searchT" id="searchT" name="searchT">
                  <input type="button" onclick="searchStore();" value='검색'>
                  <br>
                  <b>총 <span style="font-size: 25px;">${ pi.listCount }</span>개의 매장이 있습니다.</b>
               </form>
               
               <script>
                  function searchStore(){
                     var option = document.getElementById('searchoption').value;
                     var Text = document.getElementById('searchT').value;
                     if(Text == ""){
                        if(confirm("전체 매장을 검색하시겠습니까?")){
                           location.href='search.cf?option=' + option + '&searchText=' + Text + '&currentPage=' + ${pi.currentPage};
                        }else{
                           alert('취소하셨습니다.');
                           return false;
                        }
                     }else {
                        if(confirm("'"+option+"' 조건으로 매장을 검색하시겠습니까?")){
                           location.href='search.cf?option=' + option + '&searchText=' + Text + '&currentPage=' + ${pi.currentPage};
                        }else{
                           alert('취소하셨습니다.');
                           return false;
                        }
                     }
                  }
               </script>
               </div>
               
               
               
               <fieldset>
                  <div class="store">
                     <table class="storeinfo">
                     <colgroup>
                        <col width="10%">
                        <col width="20%">
                        <col width="20%">
                        <col width="10%">
                        <col width="10%">
                     </colgroup>
                        <thead id="head">
                           <tr>
                              <th class="name">지역</th>
                              <th>매장명</th>
                              <th>주소</th>
                              <th>전화번호</th>
                              <th>매장 선택</th>
                           </tr>
                        </thead>
                        <tbody align ="center">
                        <e:if test="${ pi.listCount gt 0 }">
                           <e:forEach var="s" items="${ list }">
                              
                              <script>
                                 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                                     mapOption = {
                                         center: new kakao.maps.LatLng(35.555142, 126.970436), // 지도의 중심좌표
                                         level: 13 // 지도의 확대 레벨
                                     };
                                          
                                 // 지도를 생성한다 
                                 var map = new kakao.maps.Map(mapContainer, mapOption); 
                                          
                                 // 주소 좌표 변환 객체
                                 var geocoder = new kakao.maps.services.Geocoder();
                              
                                 // 주소로 좌표를 검색합니다
                                 geocoder.addressSearch('${ s.store_address }', function(result, status) {
                                       
                                 //    좌표 검색이 정상일 경우
                                    if(status == kakao.maps.services.Status.OK){
                                          
                                       var location = new kakao.maps.LatLng(result[0].y, result[0].x);
                                          
                                       // 마커 생성
                                       var marker = new kakao.maps.Marker({
                                           map: map,
                                           position: location
                                       });
                                                                    
                                       // 인포 윈도우 생성
                                       var infowindow = new kakao.maps.InfoWindow({
                                          content: '<div style="width:140px;text-align:center;padding:6px 0; background">${ s.store_name }</div>'
                                       });
                                       // 인포 윈도우 표시
                                       infowindow.open(map, marker);
                                          
                                       // 지도의 중심을 결과값을 받은 위치로 이동
                                       map.setCenter(location);
                                    }
                                 });
                              </script>
                              <tr>
                                 <td>${ s.store_region }</td>
                                 <td>${ s.store_name }</td>
                                 <td>${ s.store_address }</td>
                                 <td>${ s.store_phone }</td>
                                 <td><input type="radio" id="selectStore" name="selectStore" value="${ s.store_num }"></td>
                              </tr>
                           </e:forEach>
                        </e:if>
                        <e:if test="${ pi.listCount le 0 }">
                              <script>
                                 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                                     mapOption = {
                                         center: new kakao.maps.LatLng(36.555142, 126.970436), // 지도의 중심좌표
                                         level: 13 // 지도의 확대 레벨
                                     };
                                 // 지도를 생성한다 
                                 var map = new kakao.maps.Map(mapContainer, mapOption);
                               </script>
                           <tr>
                              <td colspan="5">등록된 매장이 없습니다.</td>
                           </tr>
                        </e:if>
                        </tbody>
                     </table>
                  </div>
               </fieldset>
               <br><br>
               
               <!-- 페이징 넣기 -->
            <div id="pagingArea" align="center">
               <c:if test="${ pi.currentPage <= 1 }">
                  <button class="Btn" style="pointer-events:none;">&lt;</button>
               </c:if>
               <c:if test="${ pi.currentPage > 1 }">
                  <c:url var="before" value="siren.cf">
                     <c:param name="page" value="${ pi.currentPage - 1 }"/>
                  </c:url>
                  <button onclick='location.href="${ before }" class="Btn"'>&lt;</button>
               </c:if>
               
               <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                  <c:if test="${ p eq pi.currentPage }">
                     <button id="choosen" disabled  style="pointer-events:none;">${ p }</button>
                  </c:if>
                  
                  <c:if test="${ p ne pi.currentPage }">
                     <c:url var="pagination" value="siren.cf" >
                        <c:param name="page" value="${ p }" />
                     </c:url>
                     <button onclick='location.href="${ pagination }"' class="numBtn">${ p }</button>
                  </c:if>
               </c:forEach>
               
               <c:if test="${ pi.currentPage >= pi.maxPage }">
                  <button class="Btn" style="pointer-events:none;">&gt;</button>
               </c:if>
               <c:if test="${ pi.currentPage < pi.maxPage }">
                  <c:url var="after" value="siren.cf">
                     <c:param name="page" value="${ pi.currentPage + 1 }" />
                  </c:url> 
                  <button onclick='location.href="="${ after }"' class="Btn">&gt;</button> 
               </c:if>
            </div>
            <e:if test="${ not empty loginUser }">
               <div><input type="button" value="주문하기" class="orderBtn"></div>
            </e:if>
         </div>
      </div>
   </div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
   $('.orderBtn').click(function(){
      let store_num = $('input[name="selectStore"]:checked').val();
      if($.isEmptyObject(store_num)){
         alert("매장을 선택해 주세요.");
      }else{
         location.href="siren_order.cf?store_num=" + store_num;
      }
   });
</script>
</html>