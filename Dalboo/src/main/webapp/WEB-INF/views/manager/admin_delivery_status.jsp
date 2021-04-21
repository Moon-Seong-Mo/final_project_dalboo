<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 가맹주 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/admin_delivery_status.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 

</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
      <br>
         <div class="outer"> 
            <h2>생산관리 > 납품현황</h2>
            <hr>
            
            <form action="order_delivery.ow" method="post"> 
            
            <div class="tableArea" align="center">
               <table>
                  <tr id="tr1">
                     <th width="180px;">매장명</th>
                     <th width="350px;">주소</th>
                     <th width="250px;">품명</th>
                     <th width="100px;">수량</th>
                     <th width="100px;">주문일</th>
                  </tr>
                     <c:forEach var="coffee" items="${ list}" >
                     <c:forEach var="store" items="${ list2 }">
                     <c:if test="${ store.store_num eq coffee.store_num }">
                  <tr>
                     <td>${store.store_name}</td>
                     <td>${store.store_address}</td>
                     <td>${coffee.materialName}</td>
                     <td>${coffee.materialAmount}</td>
                     <td>${coffee.uploadDate}</td>
                  </tr>
                  </c:if>
                     </c:forEach>
                     </c:forEach>
                  
               </table>
            </div>
            
            </form>
            
            
           <!-- 페이징  -->
            <div class="pagingArea" align="center">
               <!-- [이전 비활성화] -->
               <c:if test="${ pi.currentPage <= 1 }">
                  <input type="button" class="Btn" value="&lt;" disabled="disabled" style="pointer-events:none;">
               </c:if>
               
               <!-- [이전] -->
               <c:if test="${ pi.currentPage > 1 }">
                  <c:url var="before" value="admin_delivery_status.ow">
                     <c:param name="page" value="${ pi.currentPage - 1 }" />
                  </c:url>
                  <input type="button" class="Btn" value="&lt;"onclick="location.href='${ before }'">
               </c:if>

               <!-- [페이지] -->
               <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                  <c:url var="pagination" value="admin_delivery_status.ow">
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
                  <c:url var="after" value="admin_delivery_status.ow">
                     <c:param name="page" value="${ pi.currentPage + 1 }" />
                  </c:url>
                  <input type="button" class="Btn" value="&gt;" onclick="location.href='${ after }'">
               </c:if>
            </div>
            
       
            
            
         </div>      
                  
      </div>
   </div>
</body>
</html>