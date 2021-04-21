<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 매장 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/owner/owner_inventory_list.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 

</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
      <br>
         <div class="outer"> 
            <h2>생산관리</h2>
            <hr>
            <form action="order_inventory.ow" method="post"> 
            <div class="tableArea" align="center">
               <table>
                  <tr id="tr1">
                     <th>No.</th>
                     <th>품명</th>
                     <th>현재고</th>
                  </tr>
                  
                  <c:forEach var="coffee" items="${ list}">
                  <tr>
                     <td>${coffee.stock_num}<input type="hidden" name="store_num" value="${coffee.store_num}"></td>
                     <td>${coffee.materialName}</td>
                     <td>${coffee.materialAmount}</td>
                  </tr>
                  </c:forEach>
               </table>
            </div>
            
            </form>
            

            
            

            
         </div>      
                  
      </div>
   </div>
</body>
</html>