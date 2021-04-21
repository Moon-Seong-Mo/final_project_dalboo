<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>달보드레 | 가맹주 관리</title>


<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/common/ownerPagebase.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/manager/admin_delivery_manage.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
</head>
<body>
   <%@ include file="/WEB-INF/views/common/ownerPageHeader.jsp" %>
   <div id="wrap">
      <%@ include file="/WEB-INF/views/common/ownerPageNav.jsp" %>
      <div id="section">
      
      <div class="contents">
      <h2>생산관리</h2>
      <hr>
         <div id="storelist">
            <table class="store_table"> 
            <c:forEach var="store" items="${ list2 }">
            <thead class="table_head"> 
               
               <tr>
                  <th colspan="2"><hr></th>
               </tr>
               
               <tr>
                  <th align="left">
                     <input type="hidden" class="hidden_num" name="store_num" value="${ store.store_num }">
                     ${store.store_name } 
                     ${store.store_address}
                  </th>
                  <th class="open">▼ </th>
               </tr>
                  
               <tr>
                  <td colspan="2"><hr></td>
               </tr>
                  
               
               
            </thead>
            <tbody>
               <tr class="table_body">
                  <td class="tbody_name">재료 이름</td>
                  <td>발주 수량</td>
               </tr>
               <c:forEach var="coffee" items="${ list }">
               <c:if test="${ coffee.store_num eq store.store_num}">
               <tr class="table_body2">
                        
                        <input type="hidden" name="store_num" value="${ coffee.store_num }">
                        <input type="hidden" name="stock_num" value="${ coffee.stock_num }">
                        <input type="hidden" value="${ coffee.allStockNum }">
                        
                        <td>${coffee.materialName }</td>
                        <td>${coffee.materialAmount }</td>
                        
               </tr>
               </c:if>
               </c:forEach>
               
               <tr class="table_button" align="right">
                  <td colspan="2">
                     <button class="refuse" onclick="choose(this);" value="거절">거절</button>
                     <button class="accept" onclick="choose(this);" value="승인">승인</button>
                  </td>
               </tr>
            </tbody>
            </c:forEach>   
            </table>            
         </div>
      </div>                        
      </div>
   </div>

    <script>
   
   
      
      $('.open').click(function(){
       var is_display =  $(this).parent().parent().next().css('display');
        
         if(is_display == 'table-row-group'){
            $(this).parent().parent().next().css('display','none');
         }else if(is_display == 'none'){
            $(this).parent().parent().next().css('display','table-row-group');
          }
      });
    

      
      

      function choose(bt){
         var store_num = $(bt).parent().parent().parent().prev().children().eq(1).children().children('.hidden_num').val();
         var chkVal = $(bt).parent().parent().prev().children().eq(3).text();
         var btn = $(bt).val();
         console.log(chkVal);
         if(confirm(btn + "하시겠습니까?")){
            if(chkVal !=""){
               location.href='delivery_yesorno.ow?store_num=' + store_num + '&btn=' + btn;
               alert(btn+"되었습니다.");               
               return true;
            }else if(chkVal ==""){
               alert("처리할 발주내역이 없습니다.");
               return false;
            }            
         }else{
            return false;
         }
      }
      
      


   </script>               
      
</body>
</html>